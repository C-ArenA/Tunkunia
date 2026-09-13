package institution

import (
	"context"
	"database/sql"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

type Repository struct {
	db *sql.DB
	q  *sqlc.Queries
}

func NewSQLiteRepository(db *sql.DB, q *sqlc.Queries) *Repository {
	return &Repository{db: db, q: q}
}

func (r *Repository) Get(ctx context.Context) (oapi.Institution, error) {
	row, err := r.q.GetInstitution(ctx, r.db)
	if err != nil {
		return oapi.Institution{}, err
	}
	return toAPI(row), nil
}

func (r *Repository) Update(ctx context.Context, value oapi.Institution) (oapi.Institution, error) {
	row, err := r.q.UpdateInstitution(ctx, r.db, sqlc.UpdateInstitutionParams{
		Name:         value.Name,
		Acronym:      value.Acronym,
		Description:  value.Description,
		LogoUrl:      value.LogoUrl,
		Email:        value.Email,
		Phone:        value.Phone,
		Address:      value.Address,
		Website:      value.Website,
		PrimaryColor: value.PrimaryColor,
		AccentColor:  value.AccentColor,
	})
	if err != nil {
		return oapi.Institution{}, err
	}
	return toAPI(row), nil
}

func toAPI(row sqlc.Institution) oapi.Institution {
	return oapi.Institution{
		Name: row.Name, Acronym: row.Acronym, Description: row.Description,
		LogoUrl: row.LogoUrl, Email: row.Email, Phone: row.Phone, Address: row.Address,
		Website: row.Website, PrimaryColor: row.PrimaryColor, AccentColor: row.AccentColor,
	}
}
