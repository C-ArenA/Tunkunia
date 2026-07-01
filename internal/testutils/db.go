package testutils

import (
	"database/sql"
	"testing"

	"github.com/C-ArenA/Tunkunia/database"
	_ "modernc.org/sqlite"
)

func initDB(tb testing.TB) *sql.DB {
	tb.Helper()
	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		tb.Fatalf("No se pudo conectar con la base de datos de pruebas")
	}
	if err := database.Migrate(tb.Context(), db); err != nil {
		tb.Fatalf("No se pudo migrar la base de datos")
	}
	if err := database.Seed(tb.Context(), db); err != nil {
		tb.Fatalf("No se pudo poblar con datos de prueba a la base de datos")
	}
	tb.Cleanup(func() {
		db.Close()
	})
	return db
}
