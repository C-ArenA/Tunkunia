package user

import (
	"database/sql"
	"errors"
	"testing"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	_ "modernc.org/sqlite"
)

func TestEmailCreation(t *testing.T) {
	cases := []struct {
		inputMail     string
		expectedError error
	}{
		{"h@g", ErrInvalidEmail},
		{"hola@hola.com", nil},
		{"@hola.com", ErrInvalidEmail},
		{"", ErrInvalidEmail},
		{"c.c.c@g.g.g", nil},
		{"c..6@gmail.com", ErrInvalidEmail},
		{".carlos@gmail.com", ErrInvalidEmail},
	}
	for _, c := range cases {
		gotMail, gotError := NewEmail(c.inputMail)
		if c.expectedError == nil {
			assert.Nil(t, gotError, "correo '%s' no debería generar errores, pero genera: %v", c.inputMail, gotError)
		} else {
			assert.ErrorIs(t, gotError, c.expectedError, "Correo '%s' debería ocasionar error '%v', pero se obtuvo error %v", c.inputMail, c.expectedError, gotError)
		}

		expectedMail := Email(c.inputMail)
		if errors.Is(c.expectedError, ErrInvalidEmail) {
			expectedMail = Email("")
		}
		assert.Equal(t, expectedMail, gotMail, "Correo '%v' debe generar '%v', pero se obtuvo '%v'", c.inputMail, expectedMail, gotMail)
	}
}

func TestUserAdditionalAccessFlags(t *testing.T) {
	service := newTestService(t)
	saved, err := service.SaveUser(t.Context(), User{
		Name:  "Ciudadana",
		Sub:   "citizen-sub",
		Email: "citizen@example.com",
	})
	require.NoError(t, err)
	assert.False(t, saved.IsAdmin)
	assert.False(t, saved.IsPublicServant)

	updated, err := service.UpdateAccess(t.Context(), saved.ID, true, true)
	require.NoError(t, err)
	assert.True(t, updated.IsAdmin)
	assert.True(t, updated.IsPublicServant)
	assert.True(t, service.IsAdmin(t.Context(), saved.ID))
	assert.True(t, service.IsPublicServant(t.Context(), saved.ID))

	_, err = service.UpdateAccess(t.Context(), 999, false, false)
	assert.ErrorIs(t, err, sql.ErrNoRows)
}

func TestCreateFirstAdmin(t *testing.T) {
	service := newTestService(t)

	created, err := service.CreateFirstAdmin(t.Context(), "admin@example.com")
	require.NoError(t, err)
	assert.True(t, created.IsAdmin)
	assert.False(t, created.IsPublicServant)

	loggedIn, err := service.Login(t.Context(), User{
		Name:          "Administradora",
		Sub:           "admin-sub",
		Email:         "admin@example.com",
		EmailVerified: true,
	}, true)
	require.NoError(t, err)
	assert.Equal(t, created.ID, loggedIn.ID)
	assert.True(t, loggedIn.IsAdmin)

	_, err = service.CreateFirstAdmin(t.Context(), "another-admin@example.com")
	assert.ErrorIs(t, err, ErrAdminAlreadyExists)
}

func newTestService(t *testing.T) *Service {
	t.Helper()
	db, err := sql.Open("sqlite", ":memory:")
	require.NoError(t, err)
	t.Cleanup(func() { db.Close() })
	require.NoError(t, database.Migrate(t.Context(), db))
	return NewService(db, sqlc.New())
}
