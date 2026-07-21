package catalog

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/go-jet/jet/v2/qrm"
	. "github.com/go-jet/jet/v2/sqlite"
)

type CatalogRepo struct {
	db      *sql.DB
	queries sqlc.Querier
}

func NewRepo(db *sql.DB, q sqlc.Querier) *CatalogRepo {
	return &CatalogRepo{
		db:      db,
		queries: q,
	}
}

// List implements [Repo].
func (r *CatalogRepo) List(ctx context.Context, f TramiteFilter, s TramiteSort) ([]Tramite, error) {
	q := ListTramitesQuery(f, s)
	var dest []model.Tramites

	err := q.QueryContext(ctx, r.db, &dest)
	if err != nil {
		return nil, err
	}
	tramites := make([]Tramite, len(dest))
	for i, t := range dest {
		dT, err := FromJetTramite(t)
		if err != nil {
			return nil, err
		}
		tramites[i] = dT
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t Tramite) (*Tramite, error) {
	sqlcT := SqlcTramiteFromDomain(t)

	newT, err := r.queries.CreateTramite(ctx, r.db, sqlc.CreateTramiteParams{
		Name:                 sqlcT.Name,
		Description:          sqlcT.Description,
		ProcedureDescription: sqlcT.ProcedureDescription,
		Type:                 sqlcT.Type,
	})

	if err != nil {
		return nil, err
	}

	dT, err := fromSqlcTramite(newT)
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

	dT, err := fromSqlcTramite(t)
	if err != nil {
		return nil, err
	}
	return &dT, nil
}

// Update implements [Repo].
func (r *CatalogRepo) Update(ctx context.Context, id TramiteID, t Tramite, m TramiteMask) (*Tramite, error) {
	m.UpdatedAt = true
	t.UpdatedAt = time.Now().UTC()

	stmt := table.Tramites.
		UPDATE(JetColumnListFromTramiteMask(m)).
		MODEL(JetTramiteFromDomain(t)).
		WHERE(table.Tramites.ID.EQ(Int(int64(id)))).
		RETURNING(table.Tramites.AllColumns)

	var dest model.Tramites
	err := stmt.QueryContext(ctx, r.db, &dest)
	if errors.Is(err, qrm.ErrNoRows) {
		return nil, ErrNotFound
	}
	if err != nil {
		return nil, err
	}

	dT, err := FromJetTramite(dest)
	if err != nil {
		return nil, err
	}
	return &dT, nil
}
