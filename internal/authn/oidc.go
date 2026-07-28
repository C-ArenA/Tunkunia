package authn

// I used this resources to understand oidc and its implementation
// https://eli.thegreenplace.net/2023/sign-in-with-github-in-go/
// https://www.youtube.com/watch?v=996OiexHze0

import (
	"context"
	"crypto/rand"
	"encoding/hex"
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

type OIDCClaims struct {
	Sub           string
	Email         string
	EmailVerified bool
	Name          string
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
	if !hasValidState(r, w) {
		fmt.Fprintf(w, "El estado no es válido")
		return
	}

	code := r.URL.Query().Get("code")
	t, err := h.oauth2Config.Exchange(r.Context(), code)
	if err != nil {
		fmt.Fprintf(w, "No se pudo obtener el token asociado al código %s: %s\n", code, err.Error())
		return
	}
	idToken, ok := t.Extra("id_token").(string)
	if !ok {
		fmt.Println(w, "El proveedor no devolvió token de identidad")
		return
	}

	oidcToken, err := h.oidcVerifier.Verify(r.Context(), idToken)
	if err != nil {
		fmt.Fprintf(w, "No se pudo verificar id_token: %s\n", err.Error())
		return
	}
	var claims OIDCClaims
	if err := oidcToken.Claims(&claims); err != nil {
		fmt.Fprintf(w, "No se pudo recuperar claims: %s\n", err.Error())
		return
	}
	email, err := user.NewEmail(claims.Email)
	if err != nil {
		fmt.Fprintf(w, "El email es inválido: 400: %s\n", err.Error())
		return
	}

	actualUser, err := h.userService.GetUserByEmail(r.Context(), email)
	if err != nil {
		actualUser, err = h.userService.SaveUser(r.Context(), user.User{
			Sub:           oidcToken.Subject,
			Email:         email,
			EmailVerified: claims.EmailVerified,
			Name:          claims.Name,
		})
		if err != nil {
			fmt.Fprintln(w, "No se pudo crear usuario nuevo", err.Error())
			return
		}
	}

	loginToken, err := h.jwtAuth.IssueUserToken(int(actualUser.ID))
	if err != nil {
		fmt.Fprintf(w, "No se pudo crear token de ingreso: %s\n", err.Error())
		return
	}
	cookie := NewCookie("jwt", loginToken, WithDuration(1*time.Hour))
	http.SetCookie(w, cookie)
	http.Redirect(w, r, "/", http.StatusFound)

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
	if err != nil || c.Value == "" || c.Value != r.URL.Query().Get("state") {
		return false
	}
	cookie := NewCookie("oidc_state", "", WithDuration(-24*time.Hour))
	http.SetCookie(w, cookie)
	return true
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
