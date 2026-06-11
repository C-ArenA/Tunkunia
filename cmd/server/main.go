package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/rs/cors"
	_ "modernc.org/sqlite"
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

	db, err := sql.Open("sqlite", "./database/tunkunia.db")
	if err != nil {
		panic(err)
	}
	database.Migrate(db, "sqlite3")

	log.Println("Starting Tunkunia API server on localhost", config.Port)

	r := chi.NewRouter()
	r.Use(CorsMiddleware(), middleware.Logger)

	catalogRepo := catalog.NewMemStore()
	catalogService := catalog.NewService(catalogRepo)

	apiV1Router := chi.NewRouter()
	catalog.NewServer(catalogService).RegisterRoutes(apiV1Router)

	r.Get("/health", getHealthHandler(app))
	r.Mount("/api/v1", apiV1Router)

	chi.Walk(r, func(method, route string, handler http.Handler, middlewares ...func(http.Handler) http.Handler) error {
		log.Printf("[%s]:\t'%s'\thas %d middlewares\n", method, route, len(middlewares))
		return nil
	})

	log.Fatal(http.ListenAndServe(config.Port, r))
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
