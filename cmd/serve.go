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
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/coreos/go-oidc/v3/oidc"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/spf13/cobra"
	"golang.org/x/oauth2"
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
	q := sqlc.New()

	// modules wiring
	jwtAuthn := authn.NewJWTService(cfg.JWTSecret)
	catalogService := catalog.NewService(catalog.NewRepo(db, q))
	oidcProvider, err := oidc.NewProvider(ctx, "http://127.0.0.1:5556/dex")
	if err != nil {
		panic("Couldn't create OIDC Provider")
	}
	oauth2Config := oauth2.Config{
		ClientID:     "tunkunia",
		ClientSecret: "ZXhhbXBsZS1hcHAtc2VjcmV0",
		Endpoint:     oidcProvider.Endpoint(),
		RedirectURL:  "http://127.0.0.1:8080/callback",
		Scopes:       []string{oidc.ScopeOpenID, "email"},
	}
	idTokenVerifier := oidcProvider.Verifier(&oidc.Config{ClientID: "tunkunia"})

	// HTTP
	r := chi.NewRouter()
	r.Use(api.CorsMiddleware(), middleware.Logger, authn.Authenticate(jwtAuthn))

	r.Route("/api/v1", func(r chi.Router) {
		strictHandlerV1 := api.NewStrictHandlerV1(catalogService)
		oapiServerV1 := oapi.NewStrictHandler(strictHandlerV1, nil)
		oapi.HandlerWithOptions(oapiServerV1, oapi.ChiServerOptions{
			BaseRouter:  r,
			Middlewares: []oapi.MiddlewareFunc{authn.RequireAuthenticated},
		})
	})

	oidcHandler := authn.NewOIDCHandler(oauth2Config, idTokenVerifier)
	r.Get("/login", oidcHandler.LoginRedirect)
	r.Get("/callback", oidcHandler.Callback)

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
