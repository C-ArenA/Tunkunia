package catalog

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

func (h *StrictCatalogHandlerV1) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	var status *oapi.TramiteStatus
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if admin {
		if request.Params.Status != nil {
			value := *request.Params.Status
			status = &value
		}
	} else {
		value := oapi.TramiteStatusPublished
		status = &value
	}
	tramites, err := h.repo.List(ctx, status)
	if err != nil {
		return oapi.ListTramites500ApplicationProblemPlusJSONResponse{InternalErrorApplicationProblemPlusJSONResponse: oapi.NewInternalErrorResponse("no se pudo listar los trámites")}, nil
	}
	return oapi.ListTramites200JSONResponse{Data: tramites}, nil
}

func (h *StrictCatalogHandlerV1) CreateTramite(ctx context.Context, request oapi.CreateTramiteRequestObject) (oapi.CreateTramiteResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.CreateTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	t, err := h.repo.Create(ctx, *request.Body)
	if err != nil {
		return nil, err
	}
	return oapi.CreateTramite201JSONResponse(t), nil
}

func (h *StrictCatalogHandlerV1) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	t, err := h.repo.Get(ctx, request.Id)
	if errors.Is(err, ErrNotFound) {
		return oapi.GetTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin && t.Status != oapi.TramiteStatusPublished {
		return oapi.GetTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("trámite no encontrado")}, nil
	}
	return oapi.GetTramite200JSONResponse(t), nil
}

func (h *StrictCatalogHandlerV1) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.UpdateTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	updated, err := h.repo.Update(ctx, request.Id, *request.Body)
	if errors.Is(err, ErrNotFound) {
		return oapi.UpdateTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.UpdateTramite200JSONResponse(updated), nil
}

func (h *StrictCatalogHandlerV1) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.DeleteTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	err = h.repo.Delete(ctx, request.Id)
	if errors.Is(err, ErrNotFound) {
		return oapi.DeleteTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.DeleteTramite204Response{}, nil
}
