package store

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-jet/jet/v2/qrm"
	. "github.com/go-jet/jet/v2/sqlite"
)

type CatalogRepo struct {
	db      *sql.DB
	queries *Queries
}

func NewRepo(db *sql.DB) *CatalogRepo {
	return &CatalogRepo{
		db:      db,
		queries: New(db),
	}
}

// List implements [Repo].
func (r *CatalogRepo) List(ctx context.Context) ([]catalog.Tramite, error) {
	q := SELECT(table.Tramites.ID, table.Tramites.Name).
		FROM(table.Tramites)

	var dest []model.Tramites

	err := q.QueryContext(ctx, r.db, &dest)
	if err != nil {
		return nil, err
	}
	tramites := make([]catalog.Tramite, len(dest))
	for i, t := range dest {
		tramites[i] = catalog.Tramite{
			ID:   catalog.TramiteID(t.ID),
			Name: t.Name,
		}
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t catalog.Tramite) (*catalog.Tramite, error) {
	newT, err := r.queries.CreateTramite(ctx, t.Name)

	if err != nil {
		return nil, err
	}

	return &catalog.Tramite{
		ID:   catalog.TramiteID(newT.ID),
		Name: newT.Name,
	}, nil
}

// Delete implements [Repo].
func (r *CatalogRepo) Delete(ctx context.Context, id catalog.TramiteID) error {
	err := r.queries.DeleteTramite(ctx, int64(id))
	if err != nil {
		return err
	}
	return nil
}

// Get implements [Repo].
func (r *CatalogRepo) Get(ctx context.Context, id catalog.TramiteID) (*catalog.Tramite, error) {
	t, err := r.queries.GetTramite(ctx, int64(id))
	if err != nil {
		return nil, err
	}
	return &catalog.Tramite{
		ID:   catalog.TramiteID(t.ID),
		Name: t.Name,
	}, nil
}

// Update implements [Repo].
func (r *CatalogRepo) Update(ctx context.Context, id catalog.TramiteID, t catalog.Tramite, m catalog.TramiteUpdateMask) (*catalog.Tramite, error) {
	cols := ColumnList{}
	updateModel := model.Tramites{}

	if m.Name {
		cols = append(cols, table.Tramites.Name)
		updateModel.Name = t.Name
	}
	if m.Description {
		cols = append(cols, table.Tramites.Description)
		updateModel.Description = t.Description
	}
	if m.ProcedureDescription {
		cols = append(cols, table.Tramites.ProcedureDescription)
		updateModel.ProcedureDescription = t.ProcedureDescription
	}
	cols = append(cols, table.Tramites.UpdatedAt)
	updateModel.UpdatedAt = time.Now().UTC().Format(time.RFC3339)

	stmt := table.Tramites.UPDATE(cols).MODEL(updateModel).
		WHERE(table.Tramites.ID.EQ(Int(int64(id)))).
		RETURNING(table.Tramites.AllColumns)

	var dest model.Tramites
	err := stmt.QueryContext(ctx, r.db, &dest)

	if errors.Is(err, qrm.ErrNoRows) {
		return nil, catalog.ErrNotFound
	}

	if err != nil {
		return nil, err
	}

	return &catalog.Tramite{
		ID:          catalog.TramiteID(dest.ID),
		Name:        dest.Name,
		Description: dest.Description,
	}, nil
}
