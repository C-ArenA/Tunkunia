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

func TramiteToResponse(t Tramite) oapi.Tramite {
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

func TramiteBaseToResponse(t Tramite) oapi.TramiteBase {
	return oapi.TramiteBase{
		Id:          int64(t.ID),
		Name:        t.Name,
		Description: t.Description,
	}
}

func TramiteFromCreateRequest(r *oapi.CreateTramiteJSONRequestBody) Tramite {
	t := Tramite{Name: r.Name}
	if r.Description != nil {
		t.Description = *r.Description
	}
	if r.ProcedureDescription != nil {
		t.ProcedureDescription = *r.ProcedureDescription
	}
	if r.Type != nil {
		t.Type = TramiteType(*r.Type)
	}
	return t
}

func TramiteFromUpdateRequest(r *oapi.UpdateTramiteJSONRequestBody) (Tramite, TramiteMask) {
	var t Tramite
	var m TramiteMask
	if r.Name != nil {
		m.Name = true
		t.Name = *r.Name
	}
	if r.Description != nil {
		m.Description = true
		t.Description = *r.Description
	}
	if r.ProcedureDescription != nil {
		m.ProcedureDescription = true
		t.ProcedureDescription = *r.ProcedureDescription
	}
	if r.Status != nil {
		m.Status = true
		t.Status = TramiteStatus(*r.Status)
	}
	if r.Type != nil {
		m.Type = true
		t.Type = TramiteType(*r.Type)
	}
	return t, m
}

/* ---------------------------------
	# Mappers for the Tramite Entity
--------------------------------- */

func TramiteToSqlc(t Tramite) sqlc.Tramite {
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

func TramiteFromSqlc(t sqlc.Tramite) (Tramite, error) {
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

func TramiteToJet(t Tramite) model.Tramites {
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

func TramiteFromJet(t model.Tramites) (Tramite, error) {
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

func TramiteMaskToColumns(m TramiteMask) sqlite.ColumnList {
	mappings := []struct {
		set bool
		col sqlite.Column
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

	cols := make(sqlite.ColumnList, 0, len(mappings))
	for _, mp := range mappings {
		if mp.set {
			cols = append(cols, mp.col)
		}
	}
	return cols
}
