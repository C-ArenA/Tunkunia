package store

import (
	"database/sql"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
	"github.com/go-jet/jet/v2/sqlite"
)

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
		Type:                 t.Type,
		Status:               t.Status,
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
	}
	return TramiteJet{tramiteJet}
}

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

// toDomain maps the go-jet generated database model to the core domain entity.
func (t TramiteJet) toDomain() domain.Tramite {
	return domain.Tramite{
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

// toDomain maps the sqlc generated database model to the core domain entity.
func (t Tramite) toDomain() domain.Tramite {
	var procedureDesc *string
	if t.ProcedureDescription.Valid {
		procedureDesc = &t.ProcedureDescription.String
	}

	return domain.Tramite{
		ID:                   domain.TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: procedureDesc,
		Type:                 t.Type,
		Status:               t.Status,
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
	}
}

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
		Type:                 t.Type,
		Status:               t.Status,
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
	}
}
