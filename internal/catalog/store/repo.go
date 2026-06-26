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
	q := SELECT(table.Tramites.AllColumns).FROM(table.Tramites)

	var dest []model.Tramites

	err := q.QueryContext(ctx, r.db, &dest)
	if err != nil {
		return nil, err
	}
	tramites := make([]domain.Tramite, len(dest))
	for i, t := range dest {
		tramites[i] = domain.Tramite{
			ID:                   domain.TramiteID(t.ID),
			Name:                 t.Name,
			Description:          t.Description,
			ProcedureDescription: t.ProcedureDescription,
			Type:                 t.Type,
			Status:               t.Status,
			CreatedAt:            t.CreatedAt,
			UpdatedAt:            t.UpdatedAt,
		}
	}

	return tramites, nil
}

// Create implements [Repo].
func (r *CatalogRepo) Create(ctx context.Context, t domain.Tramite) (*domain.Tramite, error) {
	var procedureDesc sql.NullString
	if t.ProcedureDescription != nil {
		procedureDesc = sql.NullString{
			String: *t.ProcedureDescription,
			Valid:  true,
		}
	}

	newT, err := r.queries.CreateTramite(ctx, CreateTramiteParams{
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: procedureDesc,
		Type:                 t.Type,
	})
	if err != nil {
		return nil, err
	}

	var retProcedureDesc *string
	if newT.ProcedureDescription.Valid {
		retProcedureDesc = &newT.ProcedureDescription.String
	}

	return &domain.Tramite{
		ID:                   domain.TramiteID(newT.ID),
		Name:                 newT.Name,
		Description:          newT.Description,
		ProcedureDescription: retProcedureDesc,
		Type:                 newT.Type,
		Status:               newT.Status,
		CreatedAt:            newT.CreatedAt,
		UpdatedAt:            newT.UpdatedAt,
	}, nil
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

	var procedureDesc *string
	if t.ProcedureDescription.Valid {
		procedureDesc = &t.ProcedureDescription.String
	}

	return &domain.Tramite{
		ID:                   domain.TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: procedureDesc,
		Type:                 t.Type,
		Status:               t.Status,
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
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
	if m.Type {
		cols = append(cols, table.Tramites.Type)
		updateModel.Type = t.Type
	}
	if m.Status {
		cols = append(cols, table.Tramites.Status)
		updateModel.Status = t.Status
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
		ID:                   domain.TramiteID(dest.ID),
		Name:                 dest.Name,
		Description:          dest.Description,
		ProcedureDescription: dest.ProcedureDescription,
		Type:                 dest.Type,
		Status:               dest.Status,
		CreatedAt:            dest.CreatedAt,
		UpdatedAt:            dest.UpdatedAt,
	}, nil
}
