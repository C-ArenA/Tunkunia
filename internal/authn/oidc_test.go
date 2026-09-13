package authn

import (
	"context"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

type userRegistryFunc func(context.Context, string, string, string, bool) (int, error)

func (f userRegistryFunc) FindOrRegister(ctx context.Context, subject, email, name string, emailVerified bool) (int, error) {
	return f(ctx, subject, email, name, emailVerified)
}

func TestOIDCHandlerPassesClaimsToUserRegistry(t *testing.T) {
	var got struct {
		subject       string
		email         string
		name          string
		emailVerified bool
	}
	h := &OIDCHandler{
		users: userRegistryFunc(func(_ context.Context, subject, email, name string, emailVerified bool) (int, error) {
			got.subject = subject
			got.email = email
			got.name = name
			got.emailVerified = emailVerified
			return 42, nil
		}),
	}

	id, err := h.getUserWithClaims(t.Context(), &oidcClaims{
		Sub:           "oidc-sub",
		Email:         "admin@example.com",
		Name:          "Administradora",
		EmailVerified: true,
	})

	require.NoError(t, err)
	assert.Equal(t, 42, id)
	assert.Equal(t, "oidc-sub", got.subject)
	assert.Equal(t, "admin@example.com", got.email)
	assert.Equal(t, "Administradora", got.name)
	assert.True(t, got.emailVerified)
}
