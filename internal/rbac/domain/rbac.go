package domain

import (
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

type RoleID int64
type PermissionID int64

type Role struct {
	ID          RoleID
	Name        string
	Description string
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

type RoleMask struct {
	ID          bool
	Name        bool
	Description bool
	CreatedAt   bool
	UpdatedAt   bool
}

type Permission struct {
	ID          PermissionID
	Resource    string
	Action      string
	Description string
}

type UserRole struct {
	UserID domain.UserID
	RoleID RoleID
}

var ErrNotFound = errors.New("Elemento no encontrado")
