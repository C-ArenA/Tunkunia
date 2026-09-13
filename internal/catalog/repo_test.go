package catalog

import (
	"database/sql"
	"testing"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	_ "modernc.org/sqlite"
)

func TestRepoListsByStatusAndReplacesMetadata(t *testing.T) {
	db, err := sql.Open("sqlite", ":memory:")
	require.NoError(t, err)
	db.SetMaxOpenConns(1)
	t.Cleanup(func() { db.Close() })
	require.NoError(t, database.Migrate(t.Context(), db))

	result, err := db.Exec(`
		INSERT INTO tramites (name, description, procedure_description, type, status)
		VALUES ('Borrador', 'Descripción', 'Procedimiento', 'Otro', 'draft')
	`)
	require.NoError(t, err)
	firstID, err := result.LastInsertId()
	require.NoError(t, err)
	_, err = db.Exec(`
		INSERT INTO tramites (name, description, procedure_description, type, status)
		VALUES ('Publicado', 'Descripción', 'Procedimiento', 'Otro', 'published')
	`)
	require.NoError(t, err)

	repo := NewSQLiteRepository(db, sqlc.New())
	all, err := repo.List(t.Context(), nil)
	require.NoError(t, err)
	require.Len(t, all, 2)
	assert.Equal(t, "Borrador", all[0].Name)
	assert.Equal(t, "Publicado", all[1].Name)

	published := oapi.TramiteStatusPublished
	tramites, err := repo.List(t.Context(), &published)
	require.NoError(t, err)
	require.Len(t, tramites, 1)
	assert.Equal(t, "Publicado", tramites[0].Name)

	updated, err := repo.Update(t.Context(), firstID, oapi.TramiteUpdate{
		Name:                 "Borrador actualizado",
		Description:          "Nueva descripción",
		ProcedureDescription: "Nuevo procedimiento",
		Type:                 oapi.Certification,
	})
	require.NoError(t, err)
	assert.Equal(t, "Borrador actualizado", updated.Name)
	assert.Equal(t, "Nueva descripción", updated.Description)
	assert.Equal(t, "Nuevo procedimiento", updated.ProcedureDescription)
	assert.Equal(t, oapi.Certification, updated.Type)
	assert.Equal(t, oapi.TramiteStatusDraft, updated.Status)
}
