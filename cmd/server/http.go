package main

import (
	"context"
	"log"
	"net/http"
	"time"

	"github.com/C-ArenA/Tunkunia/cmd/server/oapi"
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

func listenAndServe(r *chi.Mux, port string) {
	chi.Walk(r, func(method, route string, handler http.Handler, middlewares ...func(http.Handler) http.Handler) error {
		log.Printf("[%s]:\t'%s'\thas %d middlewares\n", method, route, len(middlewares))
		return nil
	})
	log.Println("Starting Tunkunia API server on port:", port)
	log.Fatal(http.ListenAndServe(port, r))
}

type RoutesOwner interface {
	RegisterRoutes(r *chi.Mux)
}

func registerApiV1Routes(r *chi.Mux, rowners ...RoutesOwner) {
	apiV1Router := chi.NewRouter()
	for _, rowner := range rowners {
		rowner.RegisterRoutes(apiV1Router)
	}
	r.Mount("/api/v1", apiV1Router)
}

type ApiV1Server struct {
	Name   string `json:"name"`
	Author string `json:"author"`
}

func NewApiV1Server() *ApiV1Server {
	return &ApiV1Server{
		Name:   "Tunkunia",
		Author: "Ernesto Carlos Arena Alarcon",
	}
}

func (a *ApiV1Server) GetHealth(ctx context.Context, request oapi.GetHealthRequestObject) (oapi.GetHealthResponseObject, error) {
	if a.Name != "Tunkunia" {
		return oapi.GetHealth503JSONResponse{
			Status:    oapi.DEGRADED,
			Timestamp: time.Now(),
		}, nil
	}
	return oapi.GetHealth200JSONResponse{
		Status:    oapi.UP,
		Timestamp: time.Now(),
	}, nil
}

func (a *ApiV1Server) RegisterRoutes(r *chi.Mux) {
	strictServer := oapi.NewStrictHandler(a, nil)
	oapi.HandlerFromMux(strictServer, r)
}
