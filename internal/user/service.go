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
	SetAdmin(ctx context.Context, userId UserId, isAdmin bool) error
	ListUsers(ctx context.Context) ([]User, error)
	UpdateAccess(ctx context.Context, userId UserId, isAdmin, isPublicServant bool) (*User, error)
}

type Service struct {
	r               Repo
	firstAdminEmail Email
}

func NewService(db *sql.DB, q *sqlc.Queries, firstAdminEmail Email) *Service {
	return &Service{
		r:               NewSqliteStore(db, q),
		firstAdminEmail: firstAdminEmail,
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

// FindOrRegister persists an externally authenticated user and returns the
// local ID needed by the authentication layer. Bootstrap administration is a
// user policy, so it is applied here rather than in authn.
func (s *Service) FindOrRegister(ctx context.Context, subject, email, name string, emailVerified bool) (int, error) {
	domainEmail, err := NewEmail(email)
	if err != nil {
		return 0, fmt.Errorf("invalid user email: %w", err)
	}

	u := User{
		Sub:           subject,
		Email:         domainEmail,
		EmailVerified: emailVerified,
		Name:          name,
	}
	loggedInUser, err := s.r.UpsertUserBySub(ctx, u)
	if err != nil {
		return 0, fmt.Errorf("UpsertUserBySub failed: %w", err)
	}
	if emailVerified && domainEmail == s.firstAdminEmail && !loggedInUser.IsAdmin {
		err := s.r.SetAdmin(ctx, loggedInUser.ID, true)
		if err != nil {
			return 0, fmt.Errorf("No se pudo conceder acceso de administrador: %w", err)
		}
	}
	return int(loggedInUser.ID), nil
}
