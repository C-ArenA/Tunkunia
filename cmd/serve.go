/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"database/sql"
	"log"
	"log/slog"
	"net/http"
	"os"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/C-ArenA/Tunkunia/internal/public"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/Marlliton/slogpretty"
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
	initLogger()
	cfg := loadConfig()

	// Database
	db := initDB(ctx, cfg.GooseDbString, cfg.Env == "dev")
	q := sqlc.New()

	// modules wiring
	userService := user.NewService(db, q)
	catalogService := catalog.NewService(catalog.NewRepo(db, q))
	jwtAuthn := authn.NewJWTAuth(cfg.JWTSecret)

	// Handlers
	strictHandlerV1 := api.NewStrictHandlerV1(catalogService, userService)

	oidcHandler, err := authn.NewOIDCHandler(ctx, cfg, userService, jwtAuthn)
	if err != nil {
		log.Fatal(err)
	}

	// HTTP
	r := chi.NewRouter()
	r.Use(api.CorsMiddleware(), middleware.Logger, authn.Authenticate(jwtAuthn))

	r.Mount(cfg.Route.ApiV1, strictHandlerV1.Handler())
	r.Mount("/", oidcHandler.Handler(cfg.Route.OidcRedirect, cfg.Route.OidcCallback))
	api.RegisterSpecsRoutes(r, cfg.Env == "dev")
	public.RegisterRoutes(r, catalogService)

	return db, r, cfg
}

func initDB(ctx context.Context, dataSourceName string, withSeeding bool) *sql.DB {
	db, err := sql.Open("sqlite", dataSourceName)
	if err != nil {
		log.Fatal(err)
	}
	if err := database.Migrate(ctx, db); err != nil {
		log.Fatal(err)
	}
	if withSeeding {
		database.Seed(ctx, db)
	}
	return db
}

func loadConfig() *config.Config {
	cfg, err := config.Load()
	if err != nil {
		log.Fatal(err)
	}
	return cfg
}

func initLogger() {
	handler := slogpretty.New(os.Stdout, &slogpretty.Options{
		Level:     slog.LevelDebug,
		Colorful:  true,
		AddSource: true,
		Multiline: true,
	})

	logger := slog.New(handler)
	slog.SetDefault(logger)
}
