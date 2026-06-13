package main

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	_ "modernc.org/sqlite"
)

type Config struct {
	Port string `json:"port"`
	Env  string `json:"env"`
}

func main() {
	// Configs
	config := Config{Port: ":8080", Env: "development"}

	// Database
	_ = initDB()

	// Modules Wiring
	catalogRepo := catalog.NewMemStore()
	catalogService := catalog.NewService(catalogRepo)

	// HTTP
	r := chi.NewRouter()
	r.Use(CorsMiddleware(), middleware.Logger)
	registerApiV1Routes(r, NewApiV1Server(), catalog.NewServer(catalogService))

	listenAndServe(r, config.Port)
}

func initDB() *sql.DB {
	db, err := sql.Open("sqlite", "./database/tunkunia.db")
	if err != nil {
		panic(err)
	}
	if err := database.Migrate(db, "sqlite3"); err != nil {
		panic(err)
	}
	return db
}
