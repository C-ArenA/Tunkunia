package store

import (
	"database/sql"
	"time"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
	"github.com/go-jet/jet/v2/sqlite"
)

/* ---------------------------------
	# Mappers for the Tramite Entity
--------------------------------- */

// fromDomain maps the core domain entity to the sqlc generated database model
func NewTramiteFromDomain(t domain.Tramite) Tramite {
	var procedureDesc sql.NullString
	if t.ProcedureDescription != nil {
		procedureDesc = sql.NullString{
			String: *t.ProcedureDescription,
			Valid:  true,
		}
	}
	return Tramite{
		ID:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: procedureDesc,
		Type:                 string(t.Type),
		Status:               string(t.Status),
		CreatedAt:            t.CreatedAt.Format(time.DateTime),
		UpdatedAt:            t.UpdatedAt.Format(time.DateTime),
	}
}

// toDomain maps the sqlc generated database model to the core domain entity.
func (t Tramite) toDomain() (domain.Tramite, error) {
	var procedureDesc *string
	if t.ProcedureDescription.Valid {
		procedureDesc = &t.ProcedureDescription.String
	}

	createdAt, err := time.Parse(time.DateTime, t.CreatedAt)
	if err != nil {
		return domain.Tramite{}, err
	}
	updatedAt, err := time.Parse(time.DateTime, t.UpdatedAt)
	if err != nil {
		return domain.Tramite{}, err
	}
	return domain.Tramite{
		ID:                   domain.TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: procedureDesc,
		Type:                 domain.TramiteType(t.Type),
		Status:               domain.TramiteStatus(t.Status),
		CreatedAt:            createdAt,
		UpdatedAt:            updatedAt,
	}, nil
}

// go-jet generated Tramite wrapper to add mapping functionality
type TramiteJet struct {
	model.Tramites
}

// fromDomain maps the core domain entity to the sqlc generated database model
func NewTramiteJetFromDomain(t domain.Tramite) TramiteJet {
	tramiteJet := model.Tramites{
		ID:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 string(t.Type),
		Status:               string(t.Status),
		CreatedAt:            t.CreatedAt.Format(time.DateTime),
		UpdatedAt:            t.UpdatedAt.Format(time.DateTime),
	}
	return TramiteJet{tramiteJet}
}

// toDomain maps the go-jet generated database model to the core domain entity.
func (t TramiteJet) toDomain() (domain.Tramite, error) {
	createdAt, err := time.Parse(time.DateTime, t.CreatedAt)
	if err != nil {
		return domain.Tramite{}, err
	}
	updatedAt, err := time.Parse(time.DateTime, t.UpdatedAt)
	if err != nil {
		return domain.Tramite{}, err
	}
	return domain.Tramite{
		ID:                   domain.TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 domain.TramiteType(t.Type),
		Status:               domain.TramiteStatus(t.Status),
		CreatedAt:            createdAt,
		UpdatedAt:            updatedAt,
	}, nil
}

// generates a jet compliant column list based on a mask for the Tramite model
func JetColumnListFromTramiteMask(m domain.TramiteMask) sqlite.ColumnList {
	mappers := []struct {
		mask bool
		name sqlite.Column
	}{
		{m.ID, table.Tramites.ID},
		{m.Name, table.Tramites.Name},
		{m.Description, table.Tramites.Description},
		{m.ProcedureDescription, table.Tramites.ProcedureDescription},
		{m.Type, table.Tramites.Type},
		{m.Status, table.Tramites.Status},
		{m.CreatedAt, table.Tramites.CreatedAt},
		{m.UpdatedAt, table.Tramites.UpdatedAt},
	}

	cols := make(sqlite.ColumnList, 0, len(mappers))
	for _, mapper := range mappers {
		if mapper.mask {
			cols = append(cols, mapper.name)
		}
	}

	return cols
}
