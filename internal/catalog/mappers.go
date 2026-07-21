package catalog

import (
	"time"

	"github.com/C-ArenA/Tunkunia/database/jet/model"
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/audit"
	"github.com/go-jet/jet/v2/sqlite"
)

// NewTramiteFromDomain maps the domain entity to the API response model.
func NewTramiteFromDomain(t Tramite) oapi.Tramite {
	return oapi.Tramite{
		Id:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Status:               oapi.TramiteStatus(t.Status),
		Type:                 oapi.TramiteType(t.Type),
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
	}
}

// NewTramiteBaseFromDomain maps the domain entity to the base API response model of Tramite.
func NewTramiteBaseFromDomain(t Tramite) oapi.TramiteBase {
	return oapi.TramiteBase{
		Id:          int64(t.ID),
		Name:        t.Name,
		Description: t.Description,
	}
}

func CreateTramiteJSONRequestBodyToDomain(tc *oapi.CreateTramiteJSONRequestBody) Tramite {
	t := Tramite{
		Name: tc.Name,
	}
	if tc.Description != nil {
		t.Description = *tc.Description
	}
	if tc.ProcedureDescription != nil {
		t.ProcedureDescription = *tc.ProcedureDescription
	}
	if tc.Type != nil {
		t.Type = TramiteType(*tc.Type)
	}
	return t
}

func UpdateTramiteJSONRequestBodyToDomain(tu *oapi.UpdateTramiteJSONRequestBody) (Tramite, TramiteMask) {
	var t Tramite
	var m TramiteMask

	if tu.Name != nil {
		m.Name = true
		t.Name = *tu.Name
	}
	if tu.Description != nil {
		m.Description = true
		t.Description = *tu.Description
	}
	if tu.ProcedureDescription != nil {
		m.ProcedureDescription = true
		t.ProcedureDescription = *tu.ProcedureDescription
	}
	if tu.Status != nil {
		m.Status = true
		t.Status = TramiteStatus(*tu.Status)
	}
	if tu.Type != nil {
		m.Type = true
		t.Type = TramiteType(*tu.Type)
	}

	return t, m
}

/* ---------------------------------
	# Mappers for the Tramite Entity
--------------------------------- */

// fromDomain maps the core domain entity to the sqlc generated database model
func SqlcTramiteFromDomain(t Tramite) sqlc.Tramite {
	return sqlc.Tramite{
		ID:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 string(t.Type),
		Status:               string(t.Status),
		CreatedAt:            t.CreatedAt.Format(time.DateTime),
		UpdatedAt:            t.UpdatedAt.Format(time.DateTime),
	}
}

// toDomain maps the sqlc generated database model to the core domain entity.
func fromSqlcTramite(t sqlc.Tramite) (Tramite, error) {
	createdAt, err := time.Parse(time.DateTime, t.CreatedAt)
	if err != nil {
		return Tramite{}, err
	}
	updatedAt, err := time.Parse(time.DateTime, t.UpdatedAt)
	if err != nil {
		return Tramite{}, err
	}
	return Tramite{
		ID:                   TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 TramiteType(t.Type),
		Status:               TramiteStatus(t.Status),
		Metadata: audit.Metadata{
			CreatedAt: createdAt,
			UpdatedAt: updatedAt,
		},
	}, nil
}

// fromDomain maps the core domain entity to the sqlc generated database model
func JetTramiteFromDomain(t Tramite) model.Tramites {
	return model.Tramites{
		ID:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 string(t.Type),
		Status:               string(t.Status),
		CreatedAt:            t.CreatedAt.Format(time.DateTime),
		UpdatedAt:            t.UpdatedAt.Format(time.DateTime),
	}
}

// toDomain maps the go-jet generated database model to the core domain entity.
func FromJetTramite(t model.Tramites) (Tramite, error) {
	createdAt, err := time.Parse(time.DateTime, t.CreatedAt)
	if err != nil {
		return Tramite{}, err
	}
	updatedAt, err := time.Parse(time.DateTime, t.UpdatedAt)
	if err != nil {
		return Tramite{}, err
	}
	return Tramite{
		ID:                   TramiteID(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Type:                 TramiteType(t.Type),
		Status:               TramiteStatus(t.Status),
		Metadata: audit.Metadata{
			CreatedAt: createdAt,
			UpdatedAt: updatedAt,
		},
	}, nil
}

// generates a jet compliant column list based on a mask for the Tramite model
func JetColumnListFromTramiteMask(m TramiteMask) sqlite.ColumnList {
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
