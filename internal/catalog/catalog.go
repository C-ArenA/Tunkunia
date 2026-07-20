package catalog

//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./openapi.yaml

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
	"github.com/C-ArenA/Tunkunia/internal/catalog/store"
)

func ModuleInit(db *sql.DB) *domain.Service {
	repo := store.NewRepo(db)
	service := domain.NewService(repo)
	return service
}
