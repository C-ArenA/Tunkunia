package catalog

import (
	"context"
	"database/sql"
	"errors"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
)

type CatalogRepo struct {
	db      *sql.DB
	queries *sqlc.Queries
}

func NewRepo(db *sql.DB, q *sqlc.Queries) *CatalogRepo {
	return &CatalogRepo{
		db:      db,
		queries: q,
	}
}

// List implements [Repo].
func (r *CatalogRepo) List(ctx context.Context, status *TramiteStatus) ([]Tramite, error) {
	var (
		dest []sqlc.Tramite
		err  error
	)
	if status == nil {
		dest, err = r.queries.ListTramites(ctx, r.db)
	} else {
		dest, err = r.queries.ListTramitesByStatus(ctx, r.db, string(*status))
	}
	if err != nil {
		return nil, err
	}
	tramites := make([]Tramite, len(dest))
	for i, t := range dest {
		dT, err := TramiteFromSqlc(t)
		if err != nil {
			return nil, err
		}
		tramites[i] = dT
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t Tramite) (*Tramite, error) {
	sqlcT := TramiteToSqlc(t)

	newT, err := r.queries.CreateTramite(ctx, r.db, sqlc.CreateTramiteParams{
		Name:                 sqlcT.Name,
		Description:          sqlcT.Description,
		ProcedureDescription: sqlcT.ProcedureDescription,
		Type:                 sqlcT.Type,
	})

	if err != nil {
		return nil, err
	}

	dT, err := TramiteFromSqlc(newT)
	if err != nil {
		return nil, err
	}
	return &dT, nil
}

// Delete implements [Repo].
func (r *CatalogRepo) Delete(ctx context.Context, id TramiteID) error {
	rows, err := r.queries.DeleteTramite(ctx, r.db, int64(id))
	if err != nil {
		return err
	}
	if rows == 0 {
		return ErrNotFound
	}
	return nil
}

// Get implements [Repo].
func (r *CatalogRepo) Get(ctx context.Context, id TramiteID) (*Tramite, error) {
	t, err := r.queries.GetTramite(ctx, r.db, int64(id))
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}

	dT, err := TramiteFromSqlc(t)
	if err != nil {
		return nil, err
	}
	return &dT, nil
}

// Update implements [Repo].
func (r *CatalogRepo) Update(ctx context.Context, id TramiteID, t Tramite) (*Tramite, error) {
	dest, err := r.queries.UpdateTramite(ctx, r.db, sqlc.UpdateTramiteParams{
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 string(t.Type),
		ID:                   int64(id),
	})
	if errors.Is(err, sql.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}
	dT, err := TramiteFromSqlc(dest)
	if err != nil {
		return nil, err
	}
	return &dT, nil
}
