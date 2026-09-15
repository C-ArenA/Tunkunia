package catalog

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"

	"github.com/C-ArenA/Tunkunia/petrunia"
)

const procedureColumns = `id, tramite_id, version_number, status, net, created_at, updated_at, published_at`

func (r *CatalogRepo) GetPublishedProcedure(ctx context.Context, id int64) (*Procedure, error) {
	row := r.db.QueryRowContext(ctx, `
		SELECT p.id, p.tramite_id, p.version_number, p.status, p.net,
		       p.created_at, p.updated_at, p.published_at
		FROM tramites t JOIN procedures p ON p.id = t.current_procedure_id
		WHERE t.id = ? AND t.status = 'published'`, id)
	procedure, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNoPublishedProcedure
	}
	return procedure, err
}

func (r *CatalogRepo) GetDraftProcedure(ctx context.Context, id int64) (*Procedure, error) {
	row := r.db.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedures WHERE tramite_id = ? AND status = 'draft'`, id)
	procedure, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	return procedure, err
}

func (r *CatalogRepo) SaveDraftProcedure(ctx context.Context, id int64, net petrunia.Net) (*Procedure, error) {
	netJSON, err := json.Marshal(net)
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
		INSERT INTO procedures (tramite_id, status, net)
		VALUES (?, 'draft', ?)
		ON CONFLICT(tramite_id) WHERE status = 'draft'
		DO UPDATE SET net = excluded.net, updated_at = CURRENT_TIMESTAMP`, id, string(netJSON))
	if err != nil {
		return nil, fmt.Errorf("guardar borrador: %w", err)
	}
	row := tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedures WHERE tramite_id = ? AND status = 'draft'`, id)
	procedure, err := scanProcedure(row)
	if err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return procedure, nil
}

func (r *CatalogRepo) PublishProcedure(ctx context.Context, id int64, validate func(petrunia.Net) error) (*Procedure, error) {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	row := tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedures WHERE tramite_id = ? AND status = 'draft'`, id)
	draft, err := scanProcedure(row)
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	if validate != nil {
		if err := validate(draft.Net); err != nil {
			return nil, err
		}
	}
	draftID := draft.ID
	var next int
	if err := tx.QueryRowContext(ctx, `SELECT COALESCE(MAX(version_number), 0) + 1 FROM procedures WHERE tramite_id = ?`, id).Scan(&next); err != nil {
		return nil, err
	}
	if _, err := tx.ExecContext(ctx, `UPDATE procedures SET status='published', version_number=?, published_at=CURRENT_TIMESTAMP, updated_at=CURRENT_TIMESTAMP WHERE id=?`, next, draftID); err != nil {
		return nil, err
	}
	result, err := tx.ExecContext(ctx, `UPDATE tramites SET status='published', current_procedure_id=?, updated_at=CURRENT_TIMESTAMP WHERE id=?`, draftID, id)
	if err != nil {
		return nil, err
	}
	if rows, _ := result.RowsAffected(); rows == 0 {
		return nil, ErrNotFound
	}
	row = tx.QueryRowContext(ctx, `SELECT `+procedureColumns+` FROM procedures WHERE id = ?`, draftID)
	procedure, err := scanProcedure(row)
	if err != nil {
		return nil, err
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return procedure, nil
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

func scanProcedure(scanner interface{ Scan(...any) error }) (*Procedure, error) {
	var procedure Procedure
	var net string
	var versionNumber sql.NullInt64
	var createdAt, updatedAt string
	var publishedAt sql.NullString
	if err := scanner.Scan(&procedure.ID, &procedure.TramiteID, &versionNumber, &procedure.Status, &net, &createdAt, &updatedAt, &publishedAt); err != nil {
		return nil, err
	}
	if versionNumber.Valid {
		n := int(versionNumber.Int64)
		procedure.VersionNumber = &n
	}
	if err := json.Unmarshal([]byte(net), &procedure.Net); err != nil {
		return nil, fmt.Errorf("decodificar procedimiento: %w", err)
	}
	procedure.CreatedAt = parseTimestamp(createdAt)
	procedure.UpdatedAt = parseTimestamp(updatedAt)
	if publishedAt.Valid {
		t := parseTimestamp(publishedAt.String)
		procedure.PublishedAt = &t
	}
	return &procedure, nil
}
