package cases

import (
	"context"
	"database/sql"
	"testing"

	"github.com/C-ArenA/Tunkunia/database"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/petrunia"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	_ "modernc.org/sqlite"
)

func TestCitizenAndServantExecuteWorkflow(t *testing.T) {
	ctx := context.Background()
	db := testDB(t)
	catalogService := catalog.NewService(catalog.NewRepo(db, sqlc.New()))
	tramiteID := insertFixture(t, db)
	_, err := catalogService.SaveDraftProcedure(ctx, catalog.TramiteID(tramiteID), citizenServantNet())
	require.NoError(t, err)
	_, err = catalogService.PublishProcedure(ctx, catalog.TramiteID(tramiteID))
	require.NoError(t, err)
	service := NewService(db, catalogService)

	item, err := service.Start(ctx, tramiteID, 1)
	require.NoError(t, err)
	assert.Equal(t, int64(1), item.Revision)
	require.Len(t, item.AvailableTasks, 1)
	assert.Equal(t, petrunia.NodeID("submit"), item.AvailableTasks[0].TransitionID)

	item, err = service.Fire(ctx, item.ID, "submit", item.Revision, 1)
	require.NoError(t, err)
	assert.Equal(t, petrunia.Marking{"waiting": 1}, item.Marking)
	assert.Empty(t, item.AvailableTasks, "unassigned servant tasks are not citizen actions")

	unassigned, err := service.ListUnassigned(ctx)
	require.NoError(t, err)
	require.Len(t, unassigned, 1)
	item, err = service.Claim(ctx, item.ID, 2)
	require.NoError(t, err)
	_, err = service.Claim(ctx, item.ID, 3)
	assert.ErrorIs(t, err, ErrAlreadyClaimed)
	require.Len(t, item.AvailableTasks, 1)
	assert.Equal(t, petrunia.NodeID("approve"), item.AvailableTasks[0].TransitionID)

	notifications, err := service.ListNotifications(ctx, 2)
	require.NoError(t, err)
	require.Len(t, notifications, 1)
	item, err = service.Fire(ctx, item.ID, "approve", item.Revision, 2)
	require.NoError(t, err)
	assert.Equal(t, StatusCompleted, item.Status)
	assert.True(t, petrunia.IsFinal(item.Definition, item.Marking))
	require.Len(t, item.History, 2)
}

func TestFireRejectsWrongActorAndStaleRevision(t *testing.T) {
	ctx := context.Background()
	db := testDB(t)
	catalogService := catalog.NewService(catalog.NewRepo(db, sqlc.New()))
	tramiteID := insertFixture(t, db)
	_, err := catalogService.SaveDraftProcedure(ctx, catalog.TramiteID(tramiteID), citizenServantNet())
	require.NoError(t, err)
	_, err = catalogService.PublishProcedure(ctx, catalog.TramiteID(tramiteID))
	require.NoError(t, err)
	service := NewService(db, catalogService)
	item, err := service.Start(ctx, tramiteID, 1)
	require.NoError(t, err)
	_, err = service.Fire(ctx, item.ID, "submit", item.Revision, 2)
	assert.ErrorIs(t, err, ErrForbidden)
	_, err = service.Fire(ctx, item.ID, "submit", item.Revision+1, 1)
	assert.ErrorIs(t, err, ErrConflict)
}

func testDB(t *testing.T) *sql.DB {
	t.Helper()
	db, err := sql.Open("sqlite", ":memory:")
	require.NoError(t, err)
	db.SetMaxOpenConns(1)
	require.NoError(t, database.Migrate(t.Context(), db))
	t.Cleanup(func() { db.Close() })
	return db
}

func insertFixture(t *testing.T, db *sql.DB) int64 {
	t.Helper()
	_, err := db.Exec(`INSERT INTO users(id,name,sub,email,email_verified) VALUES
		(1,'Ciudadana','citizen-sub','citizen@example.com',1),
		(2,'Servidor','servant-sub','servant@example.com',1),
		(3,'Otra servidora','servant-sub-2','servant2@example.com',1)`)
	require.NoError(t, err)
	result, err := db.Exec(`INSERT INTO tramites(name,description,type) VALUES('Licencia','Prueba','Otro')`)
	require.NoError(t, err)
	id, err := result.LastInsertId()
	require.NoError(t, err)
	return id
}

func citizenServantNet() petrunia.Net {
	return petrunia.Net{
		Places: []petrunia.Place{{ID: "start"}, {ID: "waiting"}, {ID: "end"}},
		Transitions: []petrunia.Transition{
			{ID: "submit", Label: "Enviar solicitud", Role: petrunia.RoleCitizen},
			{ID: "approve", Label: "Aprobar solicitud", Role: petrunia.RoleServant},
		},
		Arcs: []petrunia.Arc{
			{From: "start", To: "submit"}, {From: "submit", To: "waiting"},
			{From: "waiting", To: "approve"}, {From: "approve", To: "end"},
		},
		InitialPlaceID: "start", FinalPlaceID: "end",
	}
}
