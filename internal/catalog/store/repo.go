package store

import (
	"context"
	"database/sql"
	"errors"
	"time"

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
func (r *CatalogRepo) List(ctx context.Context, f domain.TramiteFilter, s domain.TramiteSort) ([]domain.Tramite, error) {
	q := ListTramitesQuery(f, s)
	var dest []TramiteJet

	err := q.QueryContext(ctx, r.db, &dest)
	if err != nil {
		return nil, err
	}
	tramites := make([]domain.Tramite, len(dest))
	for i, t := range dest {
		dT, err := t.toDomain()
		if err != nil {
			return nil, err
		}
		tramites[i] = dT
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t domain.Tramite) (*domain.Tramite, error) {
	sqlcT := NewTramiteFromDomain(t)

	newT, err := r.queries.CreateTramite(ctx, CreateTramiteParams{
		Name:                 sqlcT.Name,
		Description:          sqlcT.Description,
		ProcedureDescription: sqlcT.ProcedureDescription,
		Type:                 sqlcT.Type,
	})

	if err != nil {
		return nil, err
	}

	dT, err := newT.toDomain()
	if err != nil {
		return nil, err
	}
	return &dT, nil
}

// Delete implements [Repo].
func (r *CatalogRepo) Delete(ctx context.Context, id domain.TramiteID) error {
	rows, err := r.queries.DeleteTramite(ctx, int64(id))
	if err != nil {
		return err
	}
	if rows == 0 {
		return domain.ErrNotFound
	}
	return nil
}

// Get implements [Repo].
func (r *CatalogRepo) Get(ctx context.Context, id domain.TramiteID) (*domain.Tramite, error) {
	t, err := r.queries.GetTramite(ctx, int64(id))
	if errors.Is(err, sql.ErrNoRows) {
		return nil, domain.ErrNotFound
	}
	if err != nil {
		return nil, err
	}

	dT, err := t.toDomain()
	if err != nil {
		return nil, err
	}
	return &dT, nil
}

// Update implements [Repo].
func (r *CatalogRepo) Update(ctx context.Context, id domain.TramiteID, t domain.Tramite, m domain.TramiteMask) (*domain.Tramite, error) {
	m.UpdatedAt = true
	t.UpdatedAt = time.Now().UTC()

	stmt := table.Tramites.
		UPDATE(JetColumnListFromTramiteMask(m)).
		MODEL(NewTramiteJetFromDomain(t)).
		WHERE(table.Tramites.ID.EQ(Int(int64(id)))).
		RETURNING(table.Tramites.AllColumns)

	var dest TramiteJet
	err := stmt.QueryContext(ctx, r.db, &dest)
	if errors.Is(err, qrm.ErrNoRows) {
		return nil, domain.ErrNotFound
	}
	if err != nil {
		return nil, err
	}

	dT, err := dest.toDomain()
	if err != nil {
		return nil, err
	}
	return &dT, nil
}
