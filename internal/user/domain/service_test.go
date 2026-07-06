package domain

import (
	"context"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type mockRepo struct {
	mock.Mock
}

// UserWithRoleExists implements [Repo].
func (m *mockRepo) UserWithRoleExists(ctx context.Context, role RoleName) (bool, error) {
	args := m.Called(ctx, role)
	return args.Bool(0), args.Error(1)
}

// SaveUser implements [Repo].
func (m *mockRepo) SaveUser(ctx context.Context, u User) (*User, error) {
	args := m.Called(ctx, u)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*User), args.Error(1)
}

func TestFirstAdminCreation(t *testing.T) {
	r := new(mockRepo)
	validEmail := "hola@hola.com"
	expectedUser := User{
		ID:            1,
		Email:         Email(validEmail),
		Sub:           "",
		EmailVerified: false,
		Roles:         []RoleName{ADMIN},
		CreatedAt:     time.Now().UTC(),
	}

	r.On("UserWithRoleExists", mock.Anything, mock.Anything).Return(false, nil)
	r.On("SaveUser", mock.Anything, mock.Anything).Return(&expectedUser, nil)

	s := NewService(r)
	u, err := s.CreateFirstAdmin(t.Context(), Email(validEmail))
	assert.Nil(t, err, "Creación de usuario debió ser exitosa")
	assert.Equal(t, u.Email, validEmail, "Correo de usuario creado y correo del entorno deben coincidir")
	assert.Contains(t, u.Roles, ADMIN, "Nuevo usuario debe tener rol %s", ADMIN)
	assert.InDelta(t, u.CreatedAt.Unix(), expectedUser.CreatedAt.Unix(), 1)
}
