package catalog

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./openapi.yaml

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/catalog/api"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
	"github.com/C-ArenA/Tunkunia/internal/catalog/store"
	"github.com/go-chi/chi/v5"
)

func ModuleInit(db *sql.DB, m *chi.Mux) *domain.Service {
	repo := store.NewRepo(db)
	service := domain.NewService(repo)
	strictApiHandler := api.NewStrictApiHandler(service)
	oapiServer := api.NewStrictHandler(strictApiHandler, nil)
	api.HandlerFromMuxWithBaseURL(oapiServer, m, "/api/v1")
	return service
}
