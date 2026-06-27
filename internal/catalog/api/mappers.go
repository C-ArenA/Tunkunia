package api

import (
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
)

// NewTramiteFromDomain maps the domain entity to the API response model.
func NewTramiteFromDomain(t domain.Tramite) Tramite {
	return Tramite{
		Id:                   int64(t.ID),
		Name:                 t.Name,
		Description:          t.Description,
		ProcedureDescription: t.ProcedureDescription,
		Status:               TramiteStatus(t.Status),
		Type:                 t.Type,
		CreatedAt:            t.CreatedAt,
		UpdatedAt:            t.UpdatedAt,
	}
}

// NewTramiteBaseFromDomain maps the domain entity to the base API response model of Tramite.
func NewTramiteBaseFromDomain(t domain.Tramite) TramiteBase {
	return TramiteBase{
		Id:          int64(t.ID),
		Name:        t.Name,
		Description: t.Description,
	}
}

func (tc *TramiteCreate) toDomain() domain.Tramite {
	t := domain.Tramite{
		Name:                 tc.Name,
		ProcedureDescription: tc.ProcedureDescription,
	}
	if tc.Description != nil {
		t.Description = *tc.Description
	}
	if tc.Type != nil {
		t.Type = *tc.Type
	}
	return t
}

func (tu *TramiteUpdate) toDomain() (domain.Tramite, domain.TramiteMask) {
	var t domain.Tramite
	var m domain.TramiteMask

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
		pdValue, err := tu.ProcedureDescription.Get()
		if err == nil {
			t.ProcedureDescription = &pdValue
		}
	}
	if tu.Status != nil {
		m.Status = true
		t.Status = domain.TramiteStatus(*tu.Status)
	}
	if tu.Type != nil {
		m.Type = true
		t.Type = *tu.Type
	}

	return t, m
}
