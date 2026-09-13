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
	service, repo := newTestService(t)
	saved, err := repo.UpsertUserBySub(t.Context(), "citizen-sub", "citizen@example.com", "Ciudadana", true)
	require.NoError(t, err)
	assert.False(t, saved.isAdmin)

	updated, err := repo.UpdateAccess(t.Context(), saved.id, true, true)
	require.NoError(t, err)
	assert.True(t, updated.IsAdmin)
	assert.True(t, updated.IsPublicServant)
	isAdmin, err := service.IsAdmin(t.Context(), saved.id)
	require.NoError(t, err)
	assert.True(t, isAdmin)
	isServant, err := service.IsPublicServant(t.Context(), saved.id)
	require.NoError(t, err)
	assert.True(t, isServant)

	_, err = repo.UpdateAccess(t.Context(), 999, false, false)
	assert.ErrorIs(t, err, sql.ErrNoRows)
}

func TestFindOrRegisterBootstrapsConfiguredAdmin(t *testing.T) {
	service, repo := newTestService(t)

	id, err := service.FindOrRegister(t.Context(), "admin-sub", "admin@example.com", "Administradora", false)
	require.NoError(t, err)
	created, err := repo.Get(t.Context(), int64(id))
	require.NoError(t, err)
	assert.False(t, created.IsAdmin)

	id, err = service.FindOrRegister(t.Context(), "admin-sub", "admin@example.com", "Administradora", true)
	require.NoError(t, err)
	assert.Equal(t, created.Id, int64(id))
	loggedIn, err := repo.Get(t.Context(), int64(id))
	require.NoError(t, err)
	assert.True(t, loggedIn.IsAdmin)

	other, err := repo.UpsertUserBySub(t.Context(), "other-admin-sub", "other-admin@example.com", "Otra administradora", true)
	require.NoError(t, err)
	require.NoError(t, repo.SetAdmin(t.Context(), other.id, true))

	_, err = repo.UpdateAccess(t.Context(), int64(id), false, false)
	require.NoError(t, err)
	_, err = service.FindOrRegister(t.Context(), "admin-sub", "admin@example.com", "Administradora", true)
	require.NoError(t, err)
	loggedIn, err = repo.Get(t.Context(), int64(id))
	require.NoError(t, err)
	assert.True(t, loggedIn.IsAdmin, "configured bootstrap user should be promoted even when another admin exists")
}

func newTestService(t *testing.T) (*Service, *sqliteRepository) {
	t.Helper()
	db, err := sql.Open("sqlite", ":memory:")
	require.NoError(t, err)
	t.Cleanup(func() { db.Close() })
	require.NoError(t, database.Migrate(t.Context(), db))
	repo := NewSQLiteRepository(db, sqlc.New())
	return NewService(repo, "admin@example.com"), repo
}
