package database_test

import (
	"database/sql"
	"os"
	"testing"

	_ "modernc.org/sqlite"

	"github.com/C-ArenA/Tunkunia/database"
)

func setGooseDriver(t *testing.T, driver string) {
	t.Helper()
	origDriver, exists := os.LookupEnv("GOOSE_DRIVER")

	if driver == "" {
		os.Unsetenv("GOOSE_DRIVER")
	} else {
		os.Setenv("GOOSE_DRIVER", driver)
	}

	t.Cleanup(func() {
		if exists {
			os.Setenv("GOOSE_DRIVER", origDriver)
		} else {
			os.Unsetenv("GOOSE_DRIVER")
		}
	})
}

func TestMigrateAndSeed(t *testing.T) {
	// Setup environment with unset GOOSE_DRIVER to test default dialect fallback
	setGooseDriver(t, "")

	// 1. Open an in-memory SQLite database
	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		t.Fatalf("failed to open sqlite database: %v", err)
	}
	defer db.Close()

	// 2. Run Migrate using default dialect
	err = database.Migrate(t.Context(), db)
	if err != nil {
		t.Fatalf("Migrate failed: %v", err)
	}

	// 3. Verify that the 'tramites' table exists and is empty
	var count int
	err = db.QueryRow("SELECT COUNT(*) FROM tramites").Scan(&count)
	if err != nil {
		t.Fatalf("failed to query tramites table: %v", err)
	}
	if count != 0 {
		t.Errorf("expected 0 records in tramites after migration, got %d", count)
	}

	// 4. Run Seed using default dialect
	err = database.Seed(t.Context(), db)
	if err != nil {
		t.Fatalf("Seed failed: %v", err)
	}

	// 5. Verify that the seed rows exist
	err = db.QueryRow("SELECT COUNT(*) FROM tramites").Scan(&count)
	if err != nil {
		t.Fatalf("failed to query tramites table after seed: %v", err)
	}
	if count != 2 {
		t.Errorf("expected 2 records in tramites after seed, got %d", count)
	}

	// Verify the contents of the first seeded record
	var name string
	err = db.QueryRow("SELECT name FROM tramites WHERE name = 'Trámite de Ejemplo'").Scan(&name)
	if err != nil {
		t.Fatalf("failed to query seeded tramite record: %v", err)
	}
	if name != "Trámite de Ejemplo" {
		t.Errorf("expected name 'Trámite de Ejemplo', got %q", name)
	}
}

func TestMigrate_InvalidDialect(t *testing.T) {
	setGooseDriver(t, "invalid_dialect")

	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		t.Fatalf("failed to open sqlite database: %v", err)
	}
	defer db.Close()

	// Running with an invalid dialect should return an error
	err = database.Migrate(t.Context(), db)
	if err == nil {
		t.Error("expected error when migrating with invalid dialect, got nil")
	}
}

func TestSeed_InvalidDialect(t *testing.T) {
	setGooseDriver(t, "invalid_dialect")

	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		t.Fatalf("failed to open sqlite database: %v", err)
	}
	defer db.Close()

	// Running with an invalid dialect should return an error
	err = database.Seed(t.Context(), db)
	if err == nil {
		t.Error("expected error when seeding with invalid dialect, got nil")
	}
}
