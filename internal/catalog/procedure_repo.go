package catalog

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/C-ArenA/Tunkunia/petrunia"
)

const procedureColumns = `id, tramite_id, version_number, status, definition, created_at, updated_at, published_at`

func (r *CatalogRepo) GetPublishedProcedure(ctx context.Context, id int64) (*ProcedureVersion, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT pv.id, pv.tramite_id, pv.version_number, pv.status, pv.definition,
		       pv.created_at, pv.updated_at, pv.published_at
		FROM tramites t JOIN procedure_versions pv ON pv.id = t.current_version_id
		WHERE t.id = ? AND t.status = 'published'`, id)
	version, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNoPublishedProcedure
	}
	return version, err
}

func (r *CatalogRepo) GetDraftProcedure(ctx context.Context, id int64) (*ProcedureVersion, error) {
	row := r.db.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedure_versions WHERE tramite_id = ? AND status = 'draft'`, id)
	version, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	return version, err
}

func (r *CatalogRepo) SaveDraftProcedure(ctx context.Context, id int64, net petrunia.Net) (*ProcedureVersion, error) {
	definition, err := json.Marshal(net)
	if err != nil {
		return nil, err
	}
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	var exists int
	if err := tx.QueryRowContext(ctx, `SELECT 1 FROM tramites WHERE id = ?`, id).Scan(&exists); errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	} else if err != nil {
		return nil, err
	}
	_, err = tx.ExecContext(ctx, `
		INSERT INTO procedure_versions (tramite_id, status, definition)
		VALUES (?, 'draft', ?)
		ON CONFLICT(tramite_id) WHERE status = 'draft'
		DO UPDATE SET definition = excluded.definition, updated_at = CURRENT_TIMESTAMP`, id, string(definition))
	if err != nil {
		return nil, fmt.Errorf("guardar borrador: %w", err)
	}
	row := tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedure_versions WHERE tramite_id = ? AND status = 'draft'`, id)
	version, err := scanProcedure(row)
	if err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return version, nil
}

func (r *CatalogRepo) PublishProcedure(ctx context.Context, id int64, validate func(petrunia.Net) error) (*ProcedureVersion, error) {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	row := tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedure_versions WHERE tramite_id = ? AND status = 'draft'`, id)
	draft, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	if validate != nil {
		if err := validate(draft.Definition); err != nil {
			return nil, err
		}
	}
	draftID := draft.ID
	var next int
	if err := tx.QueryRowContext(ctx, `SELECT COALESCE(MAX(version_number), 0) + 1 FROM procedure_versions WHERE tramite_id = ?`, id).Scan(&next); err != nil {
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `UPDATE procedure_versions SET status='published', version_number=?, published_at=CURRENT_TIMESTAMP, updated_at=CURRENT_TIMESTAMP WHERE id=?`, next, draftID); err != nil {
		return nil, err
	}
	result, err := tx.ExecContext(ctx, `UPDATE tramites SET status='published', current_version_id=?, updated_at=CURRENT_TIMESTAMP WHERE id=?`, draftID, id)
	if err != nil {
		return nil, err
	}
	if rows, _ := result.RowsAffected(); rows == 0 {
		return nil, ErrNotFound
	}
	row = tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedure_versions WHERE id = ?`, draftID)
	version, err := scanProcedure(row)
	if err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return version, nil
}

func (r *CatalogRepo) Archive(ctx context.Context, id int64) error {
	result, err := r.db.ExecContext(ctx, `UPDATE tramites SET status='archived', updated_at=CURRENT_TIMESTAMP WHERE id=?`, id)
	if err != nil {
		return err
	}
	if rows, _ := result.RowsAffected(); rows == 0 {
		return ErrNotFound
	}
	return nil
}

func scanProcedure(scanner interface{ Scan(...any) error }) (*ProcedureVersion, error) {
	var version ProcedureVersion
	var definition string
	var versionNumber sql.NullInt64
	var createdAt, updatedAt string
	var publishedAt sql.NullString
	if err := scanner.Scan(&version.ID, &version.TramiteID, &versionNumber, &version.Status, &definition, &createdAt, &updatedAt, &publishedAt); err != nil {
		return nil, err
	}
	if versionNumber.Valid {
		n := int(versionNumber.Int64)
		version.VersionNumber = &n
	}
	if err := json.Unmarshal([]byte(definition), &version.Definition); err != nil {
		return nil, fmt.Errorf("decodificar procedimiento: %w", err)
	}
	version.CreatedAt = parseTimestamp(createdAt)
	version.UpdatedAt = parseTimestamp(updatedAt)
	if publishedAt.Valid {
		t := parseTimestamp(publishedAt.String)
		version.PublishedAt = &t
	}
	return &version, nil
}
