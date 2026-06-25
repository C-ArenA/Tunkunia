package database

import (
	"context"
	"database/sql"
	"embed"
	"io/fs"
	"os"

	"github.com/pressly/goose/v3"
)

//go:embed migrations/*.sql
var embedMigrations embed.FS

const defaultDialect = goose.DialectSQLite3

func getDialect() goose.Dialect {
	dialect := os.Getenv("GOOSE_DRIVER")
	if dialect == "" {
		return defaultDialect
	}
	return goose.Dialect(dialect)
}

func Migrate(ctx context.Context, db *sql.DB) error {
	migrationsFS, err := fs.Sub(embedMigrations, "migrations")
	if err != nil {
		return err
	}

	provider, err := goose.NewProvider(
		getDialect(),
		db,
		migrationsFS,
	)
	if err != nil {
		return err
	}

	_, err = provider.Up(ctx)
	return err
}

//go:embed seeds/*.sql
var embedSeeds embed.FS

// Not meant to be used in production
func Seed(ctx context.Context, db *sql.DB) error {
	os.Getenv("GOOSE_DRIVER")
	seedsFS, err := fs.Sub(embedSeeds, "seeds")
	if err != nil {
		return err
	}

	provider, err := goose.NewProvider(
		getDialect(),
		db,
		seedsFS,
		goose.WithDisableVersioning(true),
	)
	if err != nil {
		return err
	}

	_, err = provider.Up(ctx)
	return err
}
