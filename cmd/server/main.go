package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/tramite"
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

	mux := http.NewServeMux()
	mux.HandleFunc("GET /health", getHealthHandler(app))

	tramitesStore := tramite.NewStore()
	tramite.RegisterRoutes(mux, tramitesStore)

	apiKey := "4354"
	server := &http.Server{
		Addr: config.Port,
		Handler: api.ApplyMiddlewares(mux, []api.Middleware{
			api.LoggingMiddleware,
			api.CorsMiddleware(config.Env),
			api.AuthMiddleware(apiKey),
		}),
	}

	log.Fatal(server.ListenAndServe())
}
