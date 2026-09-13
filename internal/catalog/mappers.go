package catalog

import (
	"time"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
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

func TramiteFromUpdateRequest(r *oapi.UpdateTramiteJSONRequestBody) Tramite {
	return Tramite{
		Name:                 r.Name,
		Description:          r.Description,
		ProcedureDescription: r.ProcedureDescription,
		Type:                 TramiteType(r.Type),
	}
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
		CreatedAt:            createdAt,
		UpdatedAt:            updatedAt,
	}, nil
}
