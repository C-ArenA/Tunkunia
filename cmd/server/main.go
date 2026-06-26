package main

import (
	"context"
	"database/sql"

	"github.com/C-ArenA/Tunkunia/config"
	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	_ "modernc.org/sqlite"
)

func main() {
	// Configs
	cfg := loadConfig()
	ctx := context.Background()

	// Database
	db := initDB(ctx, cfg)

	// HTTP
	r := chi.NewRouter()
	r.Use(CorsMiddleware(), middleware.Logger)
	registerApiV1Routes(r, NewApiV1Server())

	// Modules Wiring
	catalog.ModuleInit(db, r)

	listenAndServe(r, cfg.Port)
}

func initDB(ctx context.Context, cfg *config.Config) *sql.DB {
	db, err := sql.Open("sqlite", cfg.GooseDbString)
	if err != nil {
		panic(err)
	}
	if err := database.Migrate(ctx, db); err != nil {
		panic(err)
	}
	if cfg.Env == "dev" {
		database.Seed(ctx, db)
	}
	return db
}

func loadConfig() *config.Config {
	return config.LoadDefaultConfig()
}
