/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"database/sql"
	"log"
	"net/http"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/spf13/cobra"
	_ "modernc.org/sqlite"
)

func NewServeCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "serve",
		Short: "Inicia el servidor de Tunkunia",
		Run: func(cmd *cobra.Command, args []string) {
			ctx := context.Background()
			_, r, cfg := initServer(ctx)
			log.Println("🌄 Starting TUNKUNIA Server on port:", cfg.Port)
			log.Fatal(http.ListenAndServe(cfg.Port, r))
		},
	}
}

func initServer(ctx context.Context) (*sql.DB, *chi.Mux, *config.Config) {
	// Configs
	cfg := loadConfig()

	// Database
	db := initDB(ctx, cfg)

	jwtAuthn := authn.NewJWTService(cfg.JWTSecret)
	// HTTP
	r := chi.NewRouter()
	r.Use(api.CorsMiddleware(), middleware.Logger, authn.Verifier(jwtAuthn))

	// Modules Wiring
	catalog.ModuleInit(db, r)
	api.ModuleInit(r)

	return db, r, cfg
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
	cfg, err := config.Load()
	if err != nil {
		panic(err)
	}
	return cfg
}
