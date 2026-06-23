package catalog

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
	controller := api.NewController(service)
	router := api.NewRouter(controller)
	router.RegisterRoutes(m)
	return service
}
