package api

import (
	"net/http"

	"github.com/rs/cors"
)

func CorsMiddleware(appURL string) func(http.Handler) http.Handler {
	return cors.New(cors.Options{
		AllowedOrigins:   []string{appURL},
		AllowedMethods:   []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodPatch, http.MethodDelete},
		AllowedHeaders:   []string{"*"},
		AllowCredentials: true,
		Debug:            true,
	}).Handler
}
