package authn

// I used this resources to understand oidc and its implementation
// https://eli.thegreenplace.net/2023/sign-in-with-github-in-go/
// https://www.youtube.com/watch?v=996OiexHze0

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"log/slog"
	"net/http"
	"net/url"
	"sync"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/coreos/go-oidc/v3/oidc"
	"github.com/go-chi/chi/v5"
	"golang.org/x/oauth2"
)

const (
	oidcStateCookieName = "oidc_state"
)

type oidcClaims struct {
	Sub           string `json:"sub"`
	Email         string `json:"email"`
	EmailVerified bool   `json:"email_verified"`
	Name          string `json:"name"`
}

// Highly inspired on the dex guides. DEX is being used as an oidc provider local sandbox
// https://dexidp.io/docs/guides/using-dex/

type OIDCHandler struct {
	userService     *user.Service
	jwtAuth         *JWTAuth
	firstAdminEmail user.Email
	provider        *oidc.Provider
	providerURL     string
	clientID        string
	clientSecret    string
	redirectURL     string
	scopes          []string
	mu              sync.RWMutex
}

func NewOIDCHandler(ctx context.Context, cfg *config.Config, us *user.Service, ja *JWTAuth) (*OIDCHandler, error) {
	redirectURL, err := url.JoinPath(cfg.AppURL, cfg.Route.OidcCallback)
	if err != nil {
		return nil, fmt.Errorf("failed to construct redirect URL: %w", err)
	}
	parsedURL, err := url.Parse(redirectURL)
	if err != nil || !parsedURL.IsAbs() {
		return nil, fmt.Errorf("invalid redirect URL. It needs to be an absolute URL: %w", err)
	}

	return &OIDCHandler{
		userService:     us,
		jwtAuth:         ja,
		firstAdminEmail: cfg.FirstAdminEmail,
		providerURL:     cfg.OidcURL,
		clientID:        cfg.OidcClientID,
		clientSecret:    cfg.OidcSecret,
		redirectURL:     parsedURL.String(),
		scopes:          []string{oidc.ScopeOpenID, oidc.ScopeEmail, oidc.ScopeProfile},
	}, nil
}

func (h *OIDCHandler) loginRedirect(w http.ResponseWriter, r *http.Request) {
	oauth2Config, err := h.oauth2Config(r.Context())
	if err != nil {
		slog.Error("failed to get oauth2 config", "error", err)
		http.Redirect(w, r, "/?error=provider_load_failed", http.StatusSeeOther)
		return
	}

	state := b64EncodedBytes(16)
	http.SetCookie(w, NewCookie(oidcStateCookieName, state, WithDuration(10*time.Minute)))
	http.Redirect(w, r, oauth2Config.AuthCodeURL(state), http.StatusFound)
}

func (h *OIDCHandler) callback(w http.ResponseWriter, r *http.Request) {
	const loginRoute = "/login"
	const successRoute = "/"

	state, err := r.Cookie(oidcStateCookieName)
	http.SetCookie(w, NewCookie(oidcStateCookieName, "", WithDuration(-1*time.Second)))
	if err != nil || state.Value == "" || state.Value != r.URL.Query().Get("state") {
		http.Redirect(w, r, loginRoute+"?error=invalid_state", http.StatusSeeOther)
		return
	}

	claims, err := h.exchange(r.Context(), r.URL.Query().Get("code"))
	if err != nil {
		http.Redirect(w, r, loginRoute+"?error=no_claims", http.StatusSeeOther)
		return
	}

	u, err := h.getUserWithClaims(r.Context(), claims)
	if err != nil {
		http.Redirect(w, r, loginRoute+"?error=no_user", http.StatusSeeOther)
		return
	}

	loginToken, err := h.jwtAuth.IssueUserToken(int(u.ID))
	if err != nil {
		http.Redirect(w, r, loginRoute+"?error=no_token", http.StatusSeeOther)
		return
	}
	cookie := NewCookie("jwt", loginToken, WithDuration(1*time.Hour))
	http.SetCookie(w, cookie)
	http.Redirect(w, r, successRoute, http.StatusSeeOther)
}

func (h *OIDCHandler) exchange(ctx context.Context, code string) (*oidcClaims, error) {
	oauth2Config, err := h.oauth2Config(ctx)
	if err != nil {
		return nil, err
	}
	t, err := oauth2Config.Exchange(ctx, code)
	if err != nil {
		return nil, err
	}
	rawIdToken, ok := t.Extra("id_token").(string)
	if !ok {
		return nil, fmt.Errorf("missing id_token in token response")
	}

	tokenVerifier, err := h.tokenVerifier(ctx)
	if err != nil {
		return nil, err
	}
	oidcToken, err := tokenVerifier.Verify(ctx, rawIdToken)
	if err != nil {
		return nil, err
	}

	var claims = new(oidcClaims)
	if err := oidcToken.Claims(claims); err != nil {
		return nil, fmt.Errorf("failed to extract claims: %w", err)
	}
	return claims, nil
}

func (h *OIDCHandler) getUserWithClaims(ctx context.Context, claims *oidcClaims) (*user.User, error) {
	email, err := user.NewEmail(claims.Email)
	if err != nil {
		return nil, fmt.Errorf("Claim has invalid email: %w", err)
	}

	return h.userService.Login(ctx, user.User{
		Sub:           claims.Sub,
		Email:         email,
		EmailVerified: claims.EmailVerified,
		Name:          claims.Name,
	}, email == h.firstAdminEmail)
}

func (h *OIDCHandler) loadProvider(ctx context.Context) error {
	h.mu.RLock()
	if h.provider != nil {
		h.mu.RUnlock()
		return nil
	}
	h.mu.RUnlock()

	h.mu.Lock()
	defer h.mu.Unlock()

	if h.provider != nil {
		return nil
	}

	provider, err := oidc.NewProvider(ctx, h.providerURL)
	if err != nil {
		return fmt.Errorf("failed to connect to OIDC provider: %w", err)
	}
	h.provider = provider
	return nil
}

func (h *OIDCHandler) oauth2Config(ctx context.Context) (oauth2.Config, error) {
	if err := h.loadProvider(ctx); err != nil {
		return oauth2.Config{}, err
	}
	return oauth2.Config{
		ClientID:     h.clientID,
		ClientSecret: h.clientSecret,
		Endpoint:     h.provider.Endpoint(),
		RedirectURL:  h.redirectURL,
		Scopes:       h.scopes,
	}, nil
}

func (h *OIDCHandler) tokenVerifier(ctx context.Context) (*oidc.IDTokenVerifier, error) {
	if err := h.loadProvider(ctx); err != nil {
		return nil, err
	}
	return h.provider.Verifier(&oidc.Config{ClientID: h.clientID}), nil
}

func (h *OIDCHandler) logout(w http.ResponseWriter, r *http.Request) {
	http.SetCookie(w, NewCookie("jwt", "", WithDuration(-1*time.Hour)))
	http.Redirect(w, r, "/", http.StatusSeeOther)
}

func (h *OIDCHandler) Handler(loginRoute, callbackRoute string) http.Handler {
	r := chi.NewRouter()
	r.Get("/oidc-logout", h.logout)
	r.Group(func(r chi.Router) {
		r.Use(RequireNonAuthenticatedOrRedirect)
		r.Get(loginRoute, h.loginRedirect)
		r.Get(callbackRoute, h.callback)
	})
	return r
}

func b64EncodedBytes(n int) string {
	b := make([]byte, n)
	rand.Read(b)
	return base64.RawURLEncoding.EncodeToString(b)
}

type CookieOption func(*http.Cookie)

func NewCookie(name, value string, opts ...CookieOption) *http.Cookie {
	c := &http.Cookie{
		Name:     name,
		Value:    value,
		Path:     "/",
		HttpOnly: true,
		SameSite: http.SameSiteLaxMode,
		Secure:   true,
	}
	for _, opt := range opts {
		opt(c)
	}
	return c
}

func WithDuration(d time.Duration) CookieOption {
	return func(c *http.Cookie) {
		c.Expires = time.Now().Add(d)
		c.MaxAge = int(d.Seconds())
	}
}
