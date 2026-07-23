package authn

import (
	"fmt"
	"net/http"

	"github.com/coreos/go-oidc/v3/oidc"
	"golang.org/x/oauth2"
)

type OIDCHandler struct {
	oauth2Config oauth2.Config
	oidcVerifier *oidc.IDTokenVerifier
}

func NewOIDCHandler(cfg oauth2.Config, v *oidc.IDTokenVerifier) *OIDCHandler {
	return &OIDCHandler{
		oauth2Config: cfg,
		oidcVerifier: v,
	}
}

func (h *OIDCHandler) LoginRedirect(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, h.oauth2Config.AuthCodeURL("estado de prueba"), http.StatusFound)
}

func (h *OIDCHandler) Callback(w http.ResponseWriter, r *http.Request) {
	code := r.URL.Query().Get("code")
	fmt.Fprintln(w, code)
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

	fmt.Fprintln(w, idToken)
	oidcToken, err := h.oidcVerifier.Verify(r.Context(), idToken)
	if err != nil {
		fmt.Fprintf(w, "No se pudo verificar id_token: %s\n", err.Error())
		return
	}
	fmt.Fprintln(w, "ID Token correcto para sub: ", oidcToken.Subject)
}
