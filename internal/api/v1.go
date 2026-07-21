package api

import (
	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/health"
)

var _ oapi.StrictServerInterface = (*StrictHandlerV1)(nil)

func NewStrictHandlerV1(catalogService *catalog.Service) *StrictHandlerV1 {
	return &StrictHandlerV1{
		health.NewStrictApiHandler(),
		catalog.NewStrictApiHandler(catalogService),
	}
}

type StrictHandlerV1 struct {
	*health.StrictApiHandler
	*catalog.StrictCatalogHandlerV1
}
