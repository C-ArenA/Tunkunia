package user

import (
	"context"
	"fmt"
)

type identity struct {
	id      int64
	isAdmin bool
}

type identityRepository interface {
	UpsertUserBySub(ctx context.Context, subject, email, name string, emailVerified bool) (identity, error)
	GetAccess(ctx context.Context, id int64) (isAdmin, isPublicServant bool, err error)
	SetAdmin(ctx context.Context, id int64, isAdmin bool) error
}

type Service struct {
	repo            identityRepository
	firstAdminEmail Email
}

func NewService(repo identityRepository, firstAdminEmail Email) *Service {
	return &Service{repo: repo, firstAdminEmail: firstAdminEmail}
}

func (s *Service) IsAdmin(ctx context.Context, id int64) (bool, error) {
	isAdmin, _, err := s.repo.GetAccess(ctx, id)
	return isAdmin, err
}

func (s *Service) IsPublicServant(ctx context.Context, id int64) (bool, error) {
	_, isPublicServant, err := s.repo.GetAccess(ctx, id)
	return isPublicServant, err
}

// FindOrRegister persists an externally authenticated user and returns the
// local ID needed by the authentication layer. Bootstrap administration is a
// user policy, so it is applied here rather than in authn.
func (s *Service) FindOrRegister(ctx context.Context, subject, email, name string, emailVerified bool) (int, error) {
	domainEmail, err := NewEmail(email)
	if err != nil {
		return 0, fmt.Errorf("invalid user email: %w", err)
	}

	loggedInUser, err := s.repo.UpsertUserBySub(ctx, subject, string(domainEmail), name, emailVerified)
	if err != nil {
		return 0, fmt.Errorf("UpsertUserBySub failed: %w", err)
	}
	if emailVerified && domainEmail == s.firstAdminEmail && !loggedInUser.isAdmin {
		if err := s.repo.SetAdmin(ctx, loggedInUser.id, true); err != nil {
			return 0, fmt.Errorf("No se pudo conceder acceso de administrador: %w", err)
		}
	}
	return int(loggedInUser.id), nil
}
