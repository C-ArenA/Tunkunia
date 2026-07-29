package authn

// I used this resources to understand oidc and its implementation
// https://eli.thegreenplace.net/2023/sign-in-with-github-in-go/
// https://www.youtube.com/watch?v=996OiexHze0

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"net/http"
	"net/url"
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

// TODO: https://opncd.ai/share/qhynJNOf
type OIDCHandler struct {
	oauth2Config    oauth2.Config
	oidcVerifier    *oidc.IDTokenVerifier
	userService     *user.Service
	jwtAuth         *JWTAuth
	firstAdminEmail user.Email
}

func NewOIDCHandler(ctx context.Context, cfg *config.Config, us *user.Service, ja *JWTAuth) (*OIDCHandler, error) {
	oidcProvider, err := oidc.NewProvider(ctx, cfg.OidcURL)
	if err != nil {
		return nil, err
	}

	redirectURL, err := url.JoinPath(cfg.AppURL, cfg.Route.OidcCallback)
	if err != nil {
		return nil, fmt.Errorf("failed to construct redirect URL: %w", err)
	}
	parsedURL, err := url.Parse(redirectURL)
	if err != nil || !parsedURL.IsAbs() {
		return nil, fmt.Errorf("invalid redirect URL. It needs to be an absolute URL: %w", err)
	}

	return &OIDCHandler{
		oauth2Config: oauth2.Config{
			ClientID:     cfg.OidcClientID,
			ClientSecret: cfg.OidcSecret,
			Endpoint:     oidcProvider.Endpoint(),
			RedirectURL:  parsedURL.String(),
			Scopes:       []string{oidc.ScopeOpenID, oidc.ScopeEmail, oidc.ScopeProfile},
		},
		oidcVerifier:    oidcProvider.Verifier(&oidc.Config{ClientID: cfg.OidcClientID}),
		userService:     us,
		jwtAuth:         ja,
		firstAdminEmail: cfg.FirstAdminEmail,
	}, nil
}

func (h *OIDCHandler) loginRedirect(w http.ResponseWriter, r *http.Request) {
	state := b64EncodedBytes(16)
	http.SetCookie(w, NewCookie(oidcStateCookieName, state, WithDuration(10*time.Minute)))
	http.Redirect(w, r, h.oauth2Config.AuthCodeURL(state), http.StatusFound)
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
	t, err := h.oauth2Config.Exchange(ctx, code)
	if err != nil {
		return nil, err
	}
	rawIdToken, ok := t.Extra("id_token").(string)
	if !ok {
		return nil, fmt.Errorf("missing id_token in token response")
	}
	oidcToken, err := h.oidcVerifier.Verify(ctx, rawIdToken)
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

func (h *OIDCHandler) Handler(loginRoute, callbackRoute string) http.Handler {
	r := chi.NewRouter()
	r.Use(RequireNonAuthenticatedOrRedirect)
	r.Get(loginRoute, h.loginRedirect)
	r.Get(callbackRoute, h.callback)
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
