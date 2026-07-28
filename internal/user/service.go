package user

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
)

type Repo interface {
	SaveUser(ctx context.Context, u User) (*User, error)
	UpsertUserBySub(ctx context.Context, u User) (*User, error)
	GetUserByEmail(ctx context.Context, email Email) (*User, error)
	IsRoleInUse(ctx context.Context, role RoleName) (bool, error)
	AssignRoleToUser(ctx context.Context, userId UserId, role RoleName) error
}

type Service struct {
	r Repo
}

func NewService(db *sql.DB, q *sqlc.Queries) *Service {
	return &Service{
		r: NewSqliteStore(db, q),
	}
}

func (s *Service) SaveUser(ctx context.Context, u User) (*User, error) {
	return s.r.SaveUser(ctx, u)
}

func (s *Service) GetUserByEmail(ctx context.Context, email Email) (*User, error) {
	return s.r.GetUserByEmail(ctx, email)
}

func (s *Service) CreateFirstAdmin(ctx context.Context, email Email) (*User, error) {
	adminExists, err := s.r.IsRoleInUse(ctx, ADMIN)
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

func (s *Service) Login(ctx context.Context, u User, isFirstAdmin bool) (*User, error) {
	loggedInUser, err := s.r.UpsertUserBySub(ctx, u)
	if err != nil {
		return nil, fmt.Errorf("UpsertUserBySub failed: %w", err)
	}
	isNewUser := loggedInUser.CreatedAt.Equal(loggedInUser.UpdatedAt)
	if isNewUser && isFirstAdmin {
		err := s.r.AssignRoleToUser(ctx, loggedInUser.ID, ADMIN)
		if err != nil {
			return loggedInUser, fmt.Errorf("No se pudo asignar rol de administrador: %w", err)
		}
	}
	return loggedInUser, nil
}
