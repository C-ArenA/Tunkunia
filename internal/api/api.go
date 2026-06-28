package api

import (
	"github.com/go-chi/chi/v5"
)

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./openapi.yaml

func ModuleInit(m *chi.Mux) {
	strictApiHandler := NewStrictApiHandler()
	oApiServer := NewStrictHandler(strictApiHandler, nil)
	HandlerFromMuxWithBaseURL(oApiServer, m, "/api/v1")
}
