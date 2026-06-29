package domain

import (
	"context"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

type Repo interface {
	CreateRole(ctx context.Context, r Role) (*Role, error)
	GetRole(ctx context.Context, id RoleID) (*Role, error)
	ListRoles(ctx context.Context) ([]Role, error)
	UpdateRole(ctx context.Context, id RoleID, r Role, m RoleMask) (*Role, error)
	DeleteRole(ctx context.Context, id RoleID) error

	ListPermissions(ctx context.Context) ([]Permission, error)
	GetRolePermissions(ctx context.Context, roleID RoleID) ([]Permission, error)
	SetRolePermissions(ctx context.Context, roleID RoleID, permissionIDs []PermissionID) error

	GetUserRoles(ctx context.Context, userID domain.UserID) ([]Role, error)
	SetUserRoles(ctx context.Context, userID domain.UserID, roleIDs []RoleID) error

	UserHasPermission(ctx context.Context, userID domain.UserID, resource, action string) (bool, error)
}

type Service struct {
	repo Repo
}

func NewService(repo Repo) *Service {
	return &Service{repo: repo}
}

func (s *Service) CreateRole(ctx context.Context, name, description string) (*Role, error) {
	now := time.Now().UTC()
	role := Role{
		Name:        name,
		Description: description,
		CreatedAt:   now,
		UpdatedAt:   now,
	}
	return s.repo.CreateRole(ctx, role)
}

func (s *Service) GetRole(ctx context.Context, id RoleID) (*Role, error) {
	return s.repo.GetRole(ctx, id)
}

func (s *Service) ListRoles(ctx context.Context) ([]Role, error) {
	return s.repo.ListRoles(ctx)
}

func (s *Service) UpdateRole(ctx context.Context, id RoleID, r Role, m RoleMask) (*Role, error) {
	m.UpdatedAt = true
	r.UpdatedAt = time.Now().UTC()
	return s.repo.UpdateRole(ctx, id, r, m)
}

func (s *Service) DeleteRole(ctx context.Context, id RoleID) error {
	return s.repo.DeleteRole(ctx, id)
}

func (s *Service) ListPermissions(ctx context.Context) ([]Permission, error) {
	return s.repo.ListPermissions(ctx)
}

func (s *Service) GetRolePermissions(ctx context.Context, roleID RoleID) ([]Permission, error) {
	return s.repo.GetRolePermissions(ctx, roleID)
}

func (s *Service) SetRolePermissions(ctx context.Context, roleID RoleID, permissionIDs []PermissionID) error {
	return s.repo.SetRolePermissions(ctx, roleID, permissionIDs)
}

func (s *Service) GetUserRoles(ctx context.Context, userID domain.UserID) ([]Role, error) {
	return s.repo.GetUserRoles(ctx, userID)
}

func (s *Service) SetUserRoles(ctx context.Context, userID domain.UserID, roleIDs []RoleID) error {
	return s.repo.SetUserRoles(ctx, userID, roleIDs)
}

func (s *Service) UserHasPermission(ctx context.Context, userID domain.UserID, resource, action string) (bool, error) {
	return s.repo.UserHasPermission(ctx, userID, resource, action)
}
