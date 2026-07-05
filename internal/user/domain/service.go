package domain

import (
	"context"
	"fmt"
)

type Repo interface {
	SaveUser(ctx context.Context, u User) (*User, error)
	UserWithRoleExists(ctx context.Context, role RoleName) (bool, error)
}

type Service struct {
	r Repo
}

func NewService(r Repo) *Service {
	return &Service{
		r: r,
	}
}

func (s *Service) CreateFirstAdmin(ctx context.Context, email Email) (*User, error) {
	adminExists, err := s.r.UserWithRoleExists(ctx, ADMIN)
	if err != nil {
		return nil, fmt.Errorf("No se pudo verificar si ya existe un administrador: %w", err)
	}
	if adminExists {
		return nil, ErrAdminAlreadyExists
	}

	adminUser := User{
		Email: email,
		Roles: []RoleName{ADMIN},
	}

	createdUser, err := s.r.SaveUser(ctx, adminUser)
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar usuario administrador correctamente: %w", err)
	}
	return createdUser, nil
}
