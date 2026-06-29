package rbac

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./specs/openapi.yaml

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/rbac/api"
	"github.com/C-ArenA/Tunkunia/internal/rbac/domain"
	"github.com/C-ArenA/Tunkunia/internal/rbac/store"
	"github.com/go-chi/chi/v5"
)

func ModuleInit(db *sql.DB, m *chi.Mux) *domain.Service {
	repo := store.NewRepo(db)
	svc := domain.NewService(repo)
	strictApiHandler := api.NewStrictApiHandler(svc)
	router := api.NewRouter(strictApiHandler)
	router.RegisterRoutes(m)
	return svc
}
