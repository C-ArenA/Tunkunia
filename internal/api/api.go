package api

import (
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/rs/cors"
)

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./openapi.yaml

func ModuleInit(m *chi.Mux) {
	strictApiHandler := NewStrictApiHandler()
	oApiServer := NewStrictHandler(strictApiHandler, nil)
	HandlerFromMuxWithBaseURL(oApiServer, m, "/api/v1")
}

func CorsMiddleware() func(http.Handler) http.Handler {
	return cors.New(cors.Options{
		AllowedOrigins:   []string{"http://localhost:*", "https://tunkunia.com"},
		AllowedMethods:   []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodPatch, http.MethodDelete},
		AllowedHeaders:   []string{"*"},
		AllowCredentials: true,
		Debug:            true,
	}).Handler
}
