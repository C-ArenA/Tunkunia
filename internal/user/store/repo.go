package store

import (
	"context"
	"database/sql"

	"github.com/C-ArenA/Tunkunia/internal/user/domain"
)

func NewRepo(db *sql.DB) *Repo {
	return &Repo{
		db: db,
	}
}

var _ domain.Repo = (*Repo)(nil)

type Repo struct {
	db *sql.DB
}

// GetRoleByName implements [domain.Repo].
func (r *Repo) GetRoleByName(ctx context.Context, name domain.RoleName) (*domain.Role, error) {
	q := New(r.db)
	role, err := q.GetRoleByName(ctx, string(name))
	if err != nil {
		return nil, err
	}
	return &domain.Role{
		ID:   int(role.ID),
		Name: domain.RoleName(role.Name),
	}, nil
}

// HasAdmin implements [domain.Repo].
func (r *Repo) HasAdmin(ctx context.Context) (bool, error) {
	q := New(r.db)
	return q.UserWithRoleExists(ctx, string(domain.ADMIN))
}

// SaveUser implements [domain.Repo].
func (r *Repo) SaveUser(ctx context.Context, u domain.User) (*domain.User, error) {
	q := New(r.db)

	cU, err := q.UpsertUser(ctx, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, err
	}

	for _, r := range u.Roles {
		q.AssignRoleToUser(ctx, AssignRoleToUserParams{
			UserID: cU.ID,
			Name:   string(r.Name),
		})
	}

	userRoles, err := q.GetUserRoles(ctx, cU.ID)
	if err != nil {
		return nil, err
	}

	dU := cU.ToDomain()
	dU.Roles = make([]*domain.Role, len(userRoles))
	for i, cR := range userRoles {
		dU.Roles[i] = &domain.Role{
			ID:   int(cR.ID),
			Name: domain.RoleName(cR.Name),
		}
	}

	return &dU, nil
}
