/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"database/sql"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api"
	apiv1 "github.com/C-ArenA/Tunkunia/internal/api/v1"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/cases"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/C-ArenA/Tunkunia/internal/health"
	"github.com/C-ArenA/Tunkunia/internal/institution"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/C-ArenA/Tunkunia/spa"
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
		RunE: func(cmd *cobra.Command, args []string) error {
			db, r, cfg, err := initServer(cmd.Context())
			if err != nil {
				return err
			}
			defer db.Close()
			slog.Info("🌄 Tunkunia server started", "address", cfg.Port)
			return http.ListenAndServe(cfg.Port, r)
		},
	}
}

func initServer(ctx context.Context) (*sql.DB, *chi.Mux, *config.Config, error) {
	cfg, err := config.Load()
	if err != nil {
		return nil, nil, nil, err
	}
	initLogger()
	// Database
	db, err := initDB(ctx, cfg.DbString, cfg.Demo)
	if err != nil {
		return nil, nil, nil, err
	}
	q := sqlc.New()

	// modules wiring
	userRepo := user.NewSQLiteRepository(db, q)
	userService := user.NewService(userRepo, cfg.FirstAdminEmail)
	catalogRepo := catalog.NewSQLiteRepository(db, q)
	procedureService := catalog.NewProcedureService(catalogRepo)
	caseRepo := cases.NewSQLiteRepository(db, q)
	caseService := cases.NewService(caseRepo, catalogRepo)
	jwtAuthn := authn.NewJWTAuth(cfg.JWTSecret)

	// Handlers
	strictHandlerV1 := apiv1.NewStrictHandler(
		health.NewStrictHealthHandlerV1(),
		catalog.NewStrictCatalogHandlerV1(catalogRepo, procedureService, userService),
		user.NewStrictUserHandlerV1(userRepo, userService),
		cases.NewStrictCasesHandlerV1(caseService, caseRepo, userService),
		institution.NewStrictHandlerV1(institution.NewSQLiteRepository(db, q), userService),
	)

	oidcHandler, err := authn.NewOIDCHandler(ctx, authn.OIDCConfig{
		AppURL:       cfg.AppURL,
		ProviderURL:  cfg.OidcURL,
		ClientID:     cfg.OidcClientID,
		ClientSecret: cfg.OidcSecret,
		CallbackPath: cfg.Route.OidcCallback,
	}, userService, jwtAuthn)
	if err != nil {
		db.Close()
		return nil, nil, nil, err
	}

	// HTTP
	r := chi.NewRouter()
	r.Use(api.CorsMiddleware(cfg.AppURL), middleware.Logger, authn.Authenticate(jwtAuthn))

	oidcHandler.RegisterRoutes(r, cfg.Route.OidcRedirect, cfg.Route.OidcCallback)
	strictHandlerV1.RegisterRoutes(r, cfg.Route.ApiV1)
	apiv1.RegisterSpecsRoutes(r, cfg.Debug)
	r.NotFound(spa.Handler().ServeHTTP)

	return db, r, cfg, nil
}

func initDB(ctx context.Context, dataSourceName string, demo bool) (*sql.DB, error) {
	if dataSourceName != ":memory:" && !strings.HasPrefix(dataSourceName, "file:") {
		if err := os.MkdirAll(filepath.Dir(dataSourceName), 0750); err != nil {
			return nil, fmt.Errorf("no se pudo crear el directorio de datos: %w", err)
		}
	}
	db, err := sql.Open("sqlite", dataSourceName)
	if err != nil {
		return nil, fmt.Errorf("no se pudo abrir la base de datos: %w", err)
	}
	db.SetMaxOpenConns(1)
	db.SetMaxIdleConns(1)
	if _, err := db.ExecContext(ctx, "PRAGMA foreign_keys = ON; PRAGMA busy_timeout = 5000;"); err != nil {
		db.Close()
		return nil, fmt.Errorf("no se pudo configurar SQLite: %w", err)
	}
	if err := db.PingContext(ctx); err != nil {
		db.Close()
		return nil, fmt.Errorf("no se pudo conectar con la base de datos: %w", err)
	}
	if err := database.Migrate(ctx, db); err != nil {
		db.Close()
		return nil, fmt.Errorf("no se pudieron aplicar las migraciones: %w", err)
	}
	if demo {
		if err := database.Seed(ctx, db); err != nil {
			db.Close()
			return nil, fmt.Errorf("no se pudieron cargar los datos de desarrollo: %w", err)
		}
	}
	return db, nil
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
