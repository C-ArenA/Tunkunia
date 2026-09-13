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
	GetUserById(ctx context.Context, id UserId) (*User, error)
	AdminExists(ctx context.Context) (bool, error)
	SetAdmin(ctx context.Context, userId UserId, isAdmin bool) error
	ListUsers(ctx context.Context) ([]User, error)
	UpdateAccess(ctx context.Context, userId UserId, isAdmin, isPublicServant bool) (*User, error)
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

func (s *Service) GetUserById(ctx context.Context, id UserId) (*User, error) {
	return s.r.GetUserById(ctx, id)
}

func (s *Service) ListUsers(ctx context.Context) ([]User, error) {
	return s.r.ListUsers(ctx)
}

func (s *Service) UpdateAccess(ctx context.Context, id UserId, isAdmin, isPublicServant bool) (*User, error) {
	return s.r.UpdateAccess(ctx, id, isAdmin, isPublicServant)
}

func (s *Service) IsAdmin(ctx context.Context, id UserId) bool {
	u, err := s.r.GetUserById(ctx, id)
	return err == nil && u.IsAdmin
}

func (s *Service) IsPublicServant(ctx context.Context, id UserId) bool {
	u, err := s.r.GetUserById(ctx, id)
	return err == nil && u.IsPublicServant
}

func (s *Service) CreateFirstAdmin(ctx context.Context, email Email) (*User, error) {
	adminExists, err := s.r.AdminExists(ctx)
	if err != nil {
		return nil, fmt.Errorf("No se pudo verificar si ya existe un administrador: %w", err)
	}
	if adminExists {
		return nil, ErrAdminAlreadyExists
	}

	adminUser := User{
		Email:   email,
		IsAdmin: true,
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
		err := s.r.SetAdmin(ctx, loggedInUser.ID, true)
		if err != nil {
			return loggedInUser, fmt.Errorf("No se pudo conceder acceso de administrador: %w", err)
		}
		loggedInUser.IsAdmin = true
	}
	return loggedInUser, nil
}
