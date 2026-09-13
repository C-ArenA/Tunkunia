package user

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/cast"
)

func NewSqliteStore(db *sql.DB, q *sqlc.Queries) *sqliteStore {
	return &sqliteStore{
		db: db,
		q:  q,
	}
}

var _ Repo = (*sqliteStore)(nil)

type sqliteStore struct {
	db *sql.DB
	q  *sqlc.Queries
}

func (s *sqliteStore) GetUserById(ctx context.Context, id UserId) (*User, error) {
	savedUser, err := s.q.GetUserById(ctx, s.db, int64(id))
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener usuario con id '%d': %w", int(id), err)
	}

	return new(ToDomainUser(savedUser)), nil
}

func (s *sqliteStore) GetUserByEmail(ctx context.Context, email Email) (*User, error) {
	savedUser, err := s.q.GetUserByEmail(ctx, s.db, string(email))
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener usuario con correo '%s': %w", email, err)
	}

	return new(ToDomainUser(savedUser)), nil
}

func (s *sqliteStore) AdminExists(ctx context.Context) (bool, error) {
	return s.q.AdminExists(ctx, s.db)
}

func (s *sqliteStore) SaveUser(ctx context.Context, u User) (*User, error) {
	savedUser, err := s.q.UpsertUser(ctx, s.db, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con correo '%s': %w", u.Email, err)
	}

	return new(ToDomainUser(savedUser)), nil
}

func (s *sqliteStore) UpsertUserBySub(ctx context.Context, u User) (*User, error) {
	savedUser, err := s.q.UpsertUserBySub(ctx, s.db, sqlc.UpsertUserBySubParams{
		Name:          u.Name,
		Sub:           u.Sub,
		Email:         string(u.Email),
		EmailVerified: cast.BoolToSqlite(u.EmailVerified),
	})
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con sub '%s': %w", u.Sub, err)
	}

	return new(ToDomainUser(savedUser)), nil
}

func (s *sqliteStore) SetAdmin(ctx context.Context, userId UserId, isAdmin bool) error {
	return s.q.SetAdmin(ctx, s.db, sqlc.SetAdminParams{
		IsAdmin: cast.BoolToSqlite(isAdmin),
		ID:      int64(userId),
	})
}

func (s *sqliteStore) ListUsers(ctx context.Context) ([]User, error) {
	rows, err := s.q.ListUsers(ctx, s.db)
	if err != nil {
		return nil, err
	}

	users := make([]User, len(rows))
	for i, row := range rows {
		users[i] = ToDomainUser(row)
	}
	return users, nil
}

func (s *sqliteStore) UpdateAccess(ctx context.Context, userId UserId, isAdmin, isPublicServant bool) (*User, error) {
	savedUser, err := s.q.UpdateUserAccess(ctx, s.db, sqlc.UpdateUserAccessParams{
		IsAdmin:         cast.BoolToSqlite(isAdmin),
		IsPublicServant: cast.BoolToSqlite(isPublicServant),
		ID:              int64(userId),
	})
	if err != nil {
		return nil, err
	}
	return new(ToDomainUser(savedUser)), nil
}
