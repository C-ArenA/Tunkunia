package domain

import (
	"context"
	"fmt"

	"github.com/C-ArenA/Tunkunia/internal/validate"
)

type Repo interface {
	SaveUser(ctx context.Context, u User) (*User, error)
	HasAdmin(ctx context.Context) (bool, error)
	GetRoleByName(ctx context.Context, name RoleName) (*Role, error)
}

type Service struct {
	r Repo
}

func NewService(r Repo) *Service {
	return &Service{
		r: r,
	}
}

func (s *Service) CreateFirstAdmin(ctx context.Context, email string) (*User, error) {
	if !validate.IsValidEmail(email) {
		return nil, ErrInvalidEmail
	}

	hasAdmin, err := s.r.HasAdmin(ctx)
	if err != nil {
		return nil, fmt.Errorf("No se pudo verificar si administrador existe: %w", err)
	}
	if hasAdmin {
		return nil, ErrAdminAlreadyExists
	}

	adminRole, err := s.r.GetRoleByName(ctx, ADMIN)
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener rol de administrador con nombre %s: %w", ADMIN, err)
	}

	adminUser := User{
		Email: email,
		Roles: []*Role{adminRole},
	}
	createdUser, err := s.r.SaveUser(ctx, adminUser)
	if err != nil {
		return nil, fmt.Errorf("No se pudo crear primer usuario administrador: %w", err)
	}
	return createdUser, nil
}
