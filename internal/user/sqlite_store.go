package user

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
)

func NewSqliteStore(db *sql.DB, q *sqlc.Queries) *sqliteStore {
	return &sqliteStore{
		db: db,
		q:  &Queries{q},
	}
}

var _ Repo = (*sqliteStore)(nil)

type sqliteStore struct {
	db *sql.DB
	q  *Queries
}

// HasAdmin implements [domain.Repo].
func (s *sqliteStore) UserWithRoleExists(ctx context.Context, role RoleName) (bool, error) {
	return s.q.UserWithRoleExists(ctx, s.db, string(role))
}

// SaveUser implements [domain.Repo].
func (s *sqliteStore) SaveUser(ctx context.Context, u User) (*User, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	savedUser, err := s.q.UpsertUser(ctx, tx, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con correo '%s': %w", u.Email, err)
	}

	roleAssignments := make([]sqlc.AssignRoleToUserParams, len(u.Roles))
	for i, role := range u.Roles {
		roleAssignments[i] = sqlc.AssignRoleToUserParams{UserID: savedUser.ID, Role: string(role)}
	}

	if err = s.q.RemoveUserRoles(ctx, tx, int64(savedUser.ID)); err != nil {
		return nil, fmt.Errorf("No pudo quitarse roles antiguos para repoblar roles actuales: %w", err)
	}
	savedRoles, err := s.q.AssignManyRolesToUser(ctx, tx, roleAssignments)
	if err != nil {
		return nil, fmt.Errorf("No pudo asignarse roles al usuario con correo '%s': %w", savedUser.Email, err)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return new(ToDomainUser(savedUser, savedRoles)), nil
}
