package main

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/config"
	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/catalog/store"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	_ "modernc.org/sqlite"
)

func main() {
	// Configs
	cfg := loadConfig()

	// Database
	db := initDB(cfg)

	// Modules Wiring
	catalogRepo := store.NewRepo(db)
	catalogService := catalog.NewService(catalogRepo)

	// HTTP
	r := chi.NewRouter()
	r.Use(CorsMiddleware(), middleware.Logger)
	registerApiV1Routes(r, NewApiV1Server(), catalog.NewServer(catalogService))

	listenAndServe(r, cfg.Port)
}

func initDB(cfg *config.Config) *sql.DB {
	db, err := sql.Open("sqlite", cfg.GooseDbString)
	if err != nil {
		panic(err)
	}
	if err := database.Migrate(db, cfg.GooseDriver); err != nil {
		panic(err)
	}
	return db
}

func loadConfig() *config.Config {
	return config.LoadDefaultConfig()
}
