package catalog

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/petrunia"
)

type catalogRepository interface {
	List(context.Context, *oapi.TramiteStatus) ([]oapi.TramiteBase, error)
	Create(context.Context, oapi.TramiteCreate) (oapi.Tramite, error)
	Get(context.Context, int64) (oapi.Tramite, error)
	Update(context.Context, int64, oapi.TramiteUpdate) (oapi.Tramite, error)
	Delete(context.Context, int64) error
	GetPublishedProcedure(context.Context, int64) (*Procedure, error)
	GetDraftProcedure(context.Context, int64) (*Procedure, error)
	SaveDraftProcedure(context.Context, int64, petrunia.Net) (*Procedure, error)
	Archive(context.Context, int64) error
}

type userAccess interface {
	IsAdmin(context.Context, int64) (bool, error)
}

type StrictCatalogHandlerV1 struct {
	repo    catalogRepository
	service *ProcedureService
	users   userAccess
}

func NewStrictCatalogHandlerV1(repo catalogRepository, procedures *ProcedureService, users userAccess) *StrictCatalogHandlerV1 {
	return &StrictCatalogHandlerV1{repo: repo, service: procedures, users: users}
}

func (h *StrictCatalogHandlerV1) isAdmin(ctx context.Context) (bool, error) {
	p, ok := authn.FromAuthContext(ctx)
	if !ok || p.Type != authn.UserPrincipal {
		return false, nil
	}
	return h.users.IsAdmin(ctx, int64(p.ID))
}
