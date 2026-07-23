package authn

import (
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
