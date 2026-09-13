package user

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	openapi_types "github.com/oapi-codegen/runtime/types"
)

type sqliteRepository struct {
	db *sql.DB
	q  *sqlc.Queries
}

func NewSQLiteRepository(db *sql.DB, q *sqlc.Queries) *sqliteRepository {
	return &sqliteRepository{db: db, q: q}
}

var _ identityRepository = (*sqliteRepository)(nil)
var _ repository = (*sqliteRepository)(nil)

func (s *sqliteRepository) Get(ctx context.Context, id int64) (oapi.User, error) {
	row, err := s.q.GetUserById(ctx, s.db, id)
	if err != nil {
		return oapi.User{}, err
	}
	return apiUser(row), nil
}

func (s *sqliteRepository) List(ctx context.Context) ([]oapi.User, error) {
	rows, err := s.q.ListUsers(ctx, s.db)
	if err != nil {
		return nil, err
	}
	result := make([]oapi.User, len(rows))
	for i, row := range rows {
		result[i] = apiUser(row)
	}
	return result, nil
}

func (s *sqliteRepository) UpdateAccess(ctx context.Context, id int64, isAdmin, isPublicServant bool) (oapi.User, error) {
	row, err := s.q.UpdateUserAccess(ctx, s.db, sqlc.UpdateUserAccessParams{
		IsAdmin: sqliteInt(isAdmin), IsPublicServant: sqliteInt(isPublicServant), ID: id,
	})
	if err != nil {
		return oapi.User{}, err
	}
	return apiUser(row), nil
}

func apiUser(row sqlc.User) oapi.User {
	return oapi.User{
		Id: row.ID, Name: row.Name, Sub: row.Sub, Email: openapi_types.Email(row.Email),
		EmailVerified: sqliteBool(row.EmailVerified), IsAdmin: sqliteBool(row.IsAdmin),
		IsPublicServant: sqliteBool(row.IsPublicServant),
	}
}

func (s *sqliteRepository) UpsertUserBySub(ctx context.Context, subject, email, name string, emailVerified bool) (identity, error) {
	row, err := s.q.UpsertUserBySub(ctx, s.db, sqlc.UpsertUserBySubParams{
		Name: name, Sub: subject, Email: email, EmailVerified: sqliteInt(emailVerified),
	})
	if err != nil {
		return identity{}, fmt.Errorf("No se pudo guardar el usuario con sub '%s': %w", subject, err)
	}
	return identity{id: row.ID, isAdmin: sqliteBool(row.IsAdmin)}, nil
}

func (s *sqliteRepository) GetAccess(ctx context.Context, id int64) (bool, bool, error) {
	row, err := s.q.GetUserById(ctx, s.db, id)
	if err != nil {
		return false, false, fmt.Errorf("No se pudo obtener usuario con id '%d': %w", id, err)
	}
	return sqliteBool(row.IsAdmin), sqliteBool(row.IsPublicServant), nil
}

func (s *sqliteRepository) SetAdmin(ctx context.Context, id int64, isAdmin bool) error {
	return s.q.SetAdmin(ctx, s.db, sqlc.SetAdminParams{IsAdmin: sqliteInt(isAdmin), ID: id})
}

func sqliteBool(value int64) bool { return value != 0 }

func sqliteInt(value bool) int64 {
	if value {
		return 1
	}
	return 0
}
