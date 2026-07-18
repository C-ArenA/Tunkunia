package store

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/user/domain"
)

func NewRepo(db *sql.DB, q *sqlc.Queries) *Repo {
	return &Repo{
		db: db,
		q:  &Queries{q},
	}
}

var _ domain.Repo = (*Repo)(nil)

type Repo struct {
	db *sql.DB
	q  *Queries
}

// HasAdmin implements [domain.Repo].
func (r *Repo) UserWithRoleExists(ctx context.Context, role domain.RoleName) (bool, error) {
	return r.q.UserWithRoleExists(ctx, r.db, string(role))
}

// SaveUser implements [domain.Repo].
func (r *Repo) SaveUser(ctx context.Context, u domain.User) (*domain.User, error) {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	savedUser, err := r.q.UpsertUser(ctx, tx, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con correo '%s': %w", u.Email, err)
	}

	roleAssignments := make([]sqlc.AssignRoleToUserParams, len(u.Roles))
	for i, role := range u.Roles {
		roleAssignments[i] = sqlc.AssignRoleToUserParams{UserID: savedUser.ID, Role: string(role)}
	}

	if err = r.q.RemoveUserRoles(ctx, tx, int64(savedUser.ID)); err != nil {
		return nil, fmt.Errorf("No pudo quitarse roles antiguos para repoblar roles actuales: %w", err)
	}
	savedRoles, err := r.q.AssignManyRolesToUser(ctx, tx, roleAssignments)
	if err != nil {
		return nil, fmt.Errorf("No pudo asignarse roles al usuario con correo '%s': %w", savedUser.Email, err)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return new(ToDomainUser(savedUser, savedRoles)), nil
}
