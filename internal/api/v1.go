package api

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/health"
)

var _ oapi.StrictServerInterface = (*StrictHandlerV1)(nil)

func NewStrictHandlerV1() *StrictHandlerV1 {
	return &StrictHandlerV1{
		health.NewStrictApiHandler(),
	}
}

type StrictHandlerV1 struct {
	*health.StrictApiHandler
}

// CreateTramite implements [oapi.StrictServerInterface].
func (s *StrictHandlerV1) CreateTramite(ctx context.Context, request oapi.CreateTramiteRequestObject) (oapi.CreateTramiteResponseObject, error) {
	panic("unimplemented")
}

// DeleteTramite implements [oapi.StrictServerInterface].
func (s *StrictHandlerV1) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	panic("unimplemented")
}

// GetTramite implements [oapi.StrictServerInterface].
func (s *StrictHandlerV1) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	panic("unimplemented")
}

// ListTramites implements [oapi.StrictServerInterface].
func (s *StrictHandlerV1) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	panic("unimplemented")
}

// UpdateTramite implements [oapi.StrictServerInterface].
func (s *StrictHandlerV1) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	panic("unimplemented")
}
