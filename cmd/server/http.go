package main

import (
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/rs/cors"
)

func CorsMiddleware() func(http.Handler) http.Handler {
	return cors.New(cors.Options{
		AllowedOrigins:   []string{"http://localhost:*", "https://tunkunia.com"},
		AllowedMethods:   []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodPatch, http.MethodDelete},
		AllowedHeaders:   []string{"*"},
		AllowCredentials: true,
		Debug:            true,
	}).Handler
}

func listRoutes(r *chi.Mux) {
	chi.Walk(r, func(method, route string, handler http.Handler, middlewares ...func(http.Handler) http.Handler) error {
		log.Printf("[%s]:\t'%s'\thas %d middlewares\n", method, route, len(middlewares))
		return nil
	})
}

func listenAndServe(r *chi.Mux, port string) {
	log.Println("🌄 Starting TUNKUNIA Server on port:", port)
	log.Fatal(http.ListenAndServe(port, r))
}
