package authn

// I used this resources to understand oidc and its implementation
// https://eli.thegreenplace.net/2023/sign-in-with-github-in-go/
// https://www.youtube.com/watch?v=996OiexHze0

import (
	"context"
	"crypto/rand"
	"database/sql"
	"encoding/hex"
	"errors"
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

type UserService interface {
	// SaveUser creates a new user if it doesn't exist or updates it if it already exists
	SaveUser(ctx context.Context, u user.User) (*user.User, error)
	GetUserByEmail(ctx context.Context, email user.Email) (*user.User, error)
}

type oidcClaims struct {
	Sub           string `json:"sub"`
	Email         string `json:"email"`
	EmailVerified bool   `json:"email_verified"`
	Name          string `json:"name"`
}

// Highly inspired on the dex guides. DEX is being used as an oidc provider local sandbox
// https://dexidp.io/docs/guides/using-dex/

type OIDCHandler struct {
	oauth2Config oauth2.Config
	oidcVerifier *oidc.IDTokenVerifier
	userService  UserService
	jwtAuth      *JWTAuth
}

func NewOIDCHandler(ctx context.Context, cfg *config.Config, us UserService, ja *JWTAuth) (*OIDCHandler, error) {
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
			Scopes:       []string{oidc.ScopeOpenID, "email", "profile"},
		},
		oidcVerifier: oidcProvider.Verifier(&oidc.Config{ClientID: cfg.OidcClientID}),
		userService:  us,
		jwtAuth:      ja,
	}, nil
}

func (h *OIDCHandler) loginRedirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, h.oauth2Config.AuthCodeURL(newState(w)), http.StatusFound)
}

func (h *OIDCHandler) callback(w http.ResponseWriter, r *http.Request) {
	const loginRoute = "/login"
	const successRoute = "/"

	if !hasValidState(r, w) {
		http.Redirect(w, r, loginRoute+"?error=invalid_state", http.StatusSeeOther)
		return
	}

	claims, err := h.exchange(r.Context(), r.URL.Query().Get("code"))
	if err != nil {
		http.Redirect(w, r, loginRoute+"?error=no_claims", http.StatusSeeOther)
		return
	}

	u, err := h.getUserWithClaims(claims, r)
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
		return nil, fmt.Errorf("no se pudo obtener token de identidad")
	}
	oidcToken, err := h.oidcVerifier.Verify(ctx, rawIdToken)
	if err != nil {
		return nil, err
	}
	var claims = new(oidcClaims)
	if err := oidcToken.Claims(claims); err != nil {
		return nil, fmt.Errorf("no se pudo recuperar claims: %s", err.Error())
	}
	return claims, nil
}

func (h *OIDCHandler) getUserWithClaims(claims *OIDCClaims, r *http.Request) (*user.User, error) {
	email, err := user.NewEmail(claims.Email)
	if err != nil {
		return nil, fmt.Errorf("Claim has invalid email: %w", err)
	}

	u, err := h.userService.GetUserByEmail(r.Context(), email)
	if err != nil {
		if !errors.Is(err, sql.ErrNoRows) {
			return nil, fmt.Errorf("Cannot get user: %w", err)
		}
		u, err = h.userService.SaveUser(r.Context(), user.User{
			Sub:           claims.Sub,
			Email:         email,
			EmailVerified: claims.EmailVerified,
			Name:          claims.Name,
		})
		if err != nil {
			return nil, fmt.Errorf("Cannot save user: %w", err)
		}
	}
	return u, nil
}

func (h *OIDCHandler) Handler(loginRoute, callbackRoute string) http.Handler {
	r := chi.NewRouter()
	r.Use(RequireNonAuthenticatedOrRedirect)
	r.Get(loginRoute, h.loginRedirect)
	r.Get(callbackRoute, h.callback)
	return r
}

func newState(w http.ResponseWriter) string {
	b := make([]byte, 16)
	rand.Read(b)
	state := hex.EncodeToString(b)
	cookie := NewCookie("oidc_state", state, WithDuration(10*time.Minute))
	http.SetCookie(w, cookie)
	return state
}

func hasValidState(r *http.Request, w http.ResponseWriter) bool {
	c, err := r.Cookie("oidc_state")
	isValid := err == nil && c.Value != "" && c.Value == r.URL.Query().Get("state")
	http.SetCookie(w, NewCookie("oidc_state", "", WithDuration(-1*time.Second)))
	return isValid
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
