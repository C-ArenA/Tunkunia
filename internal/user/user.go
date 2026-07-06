package user

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/user/domain"
	"github.com/C-ArenA/Tunkunia/internal/user/store"
)

func InitModule(db *sql.DB) *domain.Service {
	repo := store.NewRepo(db)
	service := domain.NewService(repo)
	return service
}
