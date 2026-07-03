package database

import (
	"context"
	"database/sql"
)

type Transactor interface {
	With(context.Context, func(*sql.Tx) error) error
}
type SqliteTransactor struct {
	db *sql.DB
}

func NewSqliteTransactor(db *sql.DB) Transactor {
	return &SqliteTransactor{
		db: db,
	}
}
func (t *SqliteTransactor) With(ctx context.Context, fn func(*sql.Tx) error) error {
	tx, err := t.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}

	defer tx.Rollback()

	if err := fn(tx); err != nil {
		return err
	}

	return tx.Commit()
}
