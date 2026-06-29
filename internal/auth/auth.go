package auth

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./specs/openapi.yaml

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/auth/api"
	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
	"github.com/C-ArenA/Tunkunia/internal/auth/store"
	"github.com/go-chi/chi/v5"
)

func ModuleInit(db *sql.DB, m *chi.Mux, jwtKey []byte) *domain.Service {
	repo := store.NewRepo(db)
	svc := domain.NewService(repo, jwtKey)
	strictApiHandler := api.NewStrictApiHandler(svc)
	router := api.NewRouter(strictApiHandler)
	router.RegisterRoutes(m)
	return svc
}
