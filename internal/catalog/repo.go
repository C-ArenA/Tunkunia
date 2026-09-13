package catalog

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

type CatalogRepo struct {
	db      *sql.DB
	queries *sqlc.Queries
}

func NewSQLiteRepository(db *sql.DB, q *sqlc.Queries) *CatalogRepo {
	return &CatalogRepo{db: db, queries: q}
}

func (r *CatalogRepo) List(ctx context.Context, status *oapi.TramiteStatus) ([]oapi.TramiteBase, error) {
	var rows []sqlc.Tramite
	var err error
	if status == nil {
		rows, err = r.queries.ListTramites(ctx, r.db)
	} else {
		rows, err = r.queries.ListTramitesByStatus(ctx, r.db, string(*status))
	}
	if err != nil {
		return nil, err
	}
	result := make([]oapi.TramiteBase, len(rows))
	for i, row := range rows {
		result[i] = tramiteBase(row)
	}
	return result, nil
}

func (r *CatalogRepo) Create(ctx context.Context, input oapi.TramiteCreate) (oapi.Tramite, error) {
	description, procedureDescription, tramiteType := "", "", ""
	if input.Description != nil {
		description = *input.Description
	}
	if input.ProcedureDescription != nil {
		procedureDescription = *input.ProcedureDescription
	}
	if input.Type != nil {
		tramiteType = string(*input.Type)
	}
	row, err := r.queries.CreateTramite(ctx, r.db, sqlc.CreateTramiteParams{
		Name: input.Name, Description: description, ProcedureDescription: procedureDescription, Type: tramiteType,
	})
	if err != nil {
		return oapi.Tramite{}, err
	}
	return tramite(row), nil
}

func (r *CatalogRepo) Get(ctx context.Context, id int64) (oapi.Tramite, error) {
	row, err := r.queries.GetTramite(ctx, r.db, id)
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.Tramite{}, ErrNotFound
	}
	if err != nil {
		return oapi.Tramite{}, err
	}
	return tramite(row), nil
}

func (r *CatalogRepo) Update(ctx context.Context, id int64, input oapi.TramiteUpdate) (oapi.Tramite, error) {
	row, err := r.queries.UpdateTramite(ctx, r.db, sqlc.UpdateTramiteParams{
		ID: id, Name: input.Name, Description: input.Description,
		ProcedureDescription: input.ProcedureDescription, Type: string(input.Type),
	})
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.Tramite{}, ErrNotFound
	}
	if err != nil {
		return oapi.Tramite{}, err
	}
	return tramite(row), nil
}

func (r *CatalogRepo) Delete(ctx context.Context, id int64) error {
	rows, err := r.queries.DeleteTramite(ctx, r.db, id)
	if err != nil {
		return err
	}
	if rows == 0 {
		return ErrNotFound
	}
	return nil
}

func tramite(row sqlc.Tramite) oapi.Tramite {
	return oapi.Tramite{
		Id: row.ID, Name: row.Name, Description: row.Description,
		ProcedureDescription: row.ProcedureDescription,
		Status:               oapi.TramiteStatus(row.Status), Type: oapi.TramiteType(row.Type),
		CreatedAt: parseTimestamp(row.CreatedAt), UpdatedAt: parseTimestamp(row.UpdatedAt),
	}
}

func tramiteBase(row sqlc.Tramite) oapi.TramiteBase {
	return oapi.TramiteBase{Id: row.ID, Name: row.Name, Description: row.Description}
}

func parseTimestamp(value string) time.Time {
	for _, layout := range []string{time.DateTime, time.RFC3339Nano} {
		if parsed, err := time.Parse(layout, value); err == nil {
			return parsed.UTC()
		}
	}
	return time.Time{}
}
