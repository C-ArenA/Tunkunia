package authn

// I used this resources to understand oidc and its implementation
// https://eli.thegreenplace.net/2023/sign-in-with-github-in-go/
// https://www.youtube.com/watch?v=996OiexHze0

import (
	"context"
	"fmt"
	"net/http"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/coreos/go-oidc/v3/oidc"
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
	port := cfg.Port
	if cfg.Env == "dev" {
		port = cfg.DevNuxtPort
	}

	return &OIDCHandler{
		oauth2Config: oauth2.Config{
			ClientID:     cfg.OidcClientID,
			ClientSecret: cfg.OidcSecret,
			Endpoint:     oidcProvider.Endpoint(),
			RedirectURL:  cfg.Host + port + cfg.Route.OidcCallback,
			Scopes:       []string{oidc.ScopeOpenID, "email", "profile"},
		},
		oidcVerifier: oidcProvider.Verifier(&oidc.Config{ClientID: cfg.OidcClientID}),
		userService:  us,
		jwtAuth:      ja,
	}, nil
}

func (h *OIDCHandler) LoginRedirect(w http.ResponseWriter, r *http.Request) {
	_, ok := FromAuthContext(r.Context())
	if ok {
		// User's already logged in
		http.Redirect(w, r, "/", http.StatusFound)
		return
	}
	http.Redirect(w, r, h.oauth2Config.AuthCodeURL("estado de prueba"), http.StatusFound)
}

func (h *OIDCHandler) Callback(w http.ResponseWriter, r *http.Request) {
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
		fmt.Fprintln(w, "El usuario es nuevo en Tunkunia, se creará uno")
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
	http.SetCookie(w, &http.Cookie{
		Name:     "jwt",
		Value:    loginToken,
		Expires:  time.Now().Add(1 * time.Hour),
		Secure:   true,
		HttpOnly: false,
		SameSite: http.SameSiteLaxMode,
	})
	http.Redirect(w, r, "/", http.StatusFound)
}
