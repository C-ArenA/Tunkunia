package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

type App struct {
	Name   string `json:"name"`
	Author string `json:"author"`
}

type Config struct {
	Port string `json:"port"`
	Env  string `json:"env"`
}

func getHealthHandler(app App) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(app)
	}
}

func main() {
	app := App{Name: "Tunkunia", Author: "Carlos Arena"}
	config := Config{Port: ":8080", Env: "development"}
	log.Printf("Welcome to %s, made by %s\n", app.Name, app.Author)
	log.Println("Starting Tunkunia API server on localhost", config.Port)

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/health", getHealthHandler(app))

	apiV1Router := chi.NewRouter()

	catalogRepo := catalog.NewMemStore()
	catalogService := catalog.NewService(catalogRepo)
	catalog.NewServer(catalogService).RegisterRoutes(apiV1Router)

	r.Mount("/api/v1", apiV1Router)

	log.Fatal(http.ListenAndServe(config.Port, r))
}
