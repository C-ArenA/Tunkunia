package store

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/internal/user/domain"
)

func NewRepo(db *sql.DB) *Repo {
	return &Repo{
		db: db,
		q:  New(db),
	}
}

var _ domain.Repo = (*Repo)(nil)

type Repo struct {
	db *sql.DB
	q  *Queries
}

// HasAdmin implements [domain.Repo].
func (r *Repo) UserWithRoleExists(ctx context.Context, role domain.RoleName) (bool, error) {
	return r.q.UserWithRoleExists(ctx, string(role))
}

// SaveUser implements [domain.Repo].
func (r *Repo) SaveUser(ctx context.Context, u domain.User) (*domain.User, error) {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	q := r.q.WithTx(tx)

	savedUser, err := q.UpsertUser(ctx, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con correo '%s': %w", u.Email, err)
	}

	roleAssignments := make([]AssignRoleToUserParams, len(u.Roles))
	for i, role := range u.Roles {
		roleAssignments[i] = AssignRoleToUserParams{savedUser.ID, string(role)}
	}

	if err = q.RemoveUserRoles(ctx, int64(savedUser.ID)); err != nil {
		return nil, fmt.Errorf("No pudo quitarse roles antiguos para repoblar roles actuales: %w", err)
	}
	savedRoles, err := q.AssignManyRolesToUser(ctx, roleAssignments)
	if err != nil {
		return nil, fmt.Errorf("No pudo asignarse roles al usuario con correo '%s': %w", savedUser.Email, err)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return new(ToDomainUser(savedUser, savedRoles)), nil
}
