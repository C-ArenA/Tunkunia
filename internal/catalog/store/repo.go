package store

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
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
func (r *CatalogRepo) List(ctx context.Context) ([]domain.Tramite, error) {
	q := SELECT(table.Tramites.ID, table.Tramites.Name).
		FROM(table.Tramites)

	var dest []model.Tramites

	err := q.QueryContext(ctx, r.db, &dest)
	if err != nil {
		return nil, err
	}
	tramites := make([]domain.Tramite, len(dest))
	for i, t := range dest {
		tramites[i] = domain.Tramite{
			ID:   domain.TramiteID(t.ID),
			Name: t.Name,
		}
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t domain.Tramite) (*domain.Tramite, error) {
	newT, err := r.queries.CreateTramite(ctx, t.Name)

	if err != nil {
		return nil, err
	}

	return &domain.Tramite{
		ID:   domain.TramiteID(newT.ID),
		Name: newT.Name,
	}, nil
}

// Delete implements [Repo].
func (r *CatalogRepo) Delete(ctx context.Context, id domain.TramiteID) error {
	err := r.queries.DeleteTramite(ctx, int64(id))
	if err != nil {
		return err
	}
	return nil
}

// Get implements [Repo].
func (r *CatalogRepo) Get(ctx context.Context, id domain.TramiteID) (*domain.Tramite, error) {
	t, err := r.queries.GetTramite(ctx, int64(id))
	if err != nil {
		return nil, err
	}
	return &domain.Tramite{
		ID:   domain.TramiteID(t.ID),
		Name: t.Name,
	}, nil
}

// Update implements [Repo].
func (r *CatalogRepo) Update(ctx context.Context, id domain.TramiteID, t domain.Tramite, m domain.TramiteUpdateMask) (*domain.Tramite, error) {
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
		return nil, domain.ErrNotFound
	}

	if err != nil {
		return nil, err
	}

	return &domain.Tramite{
		ID:          domain.TramiteID(dest.ID),
		Name:        dest.Name,
		Description: dest.Description,
	}, nil
}
