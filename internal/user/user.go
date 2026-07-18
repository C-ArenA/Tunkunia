package user

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/user/domain"
	"github.com/C-ArenA/Tunkunia/internal/user/store"
)

func InitModule(db *sql.DB, q *sqlc.Queries) *domain.Service {
	repo := store.NewRepo(db, q)
	service := domain.NewService(repo)
	return service
}
