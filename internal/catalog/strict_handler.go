package catalog

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/user"
)

type StrictCatalogHandlerV1 struct {
	service *Service
	users   *user.Service
}

func NewStrictApiHandler(service *Service, users *user.Service) *StrictCatalogHandlerV1 {
	return &StrictCatalogHandlerV1{service: service, users: users}
}

func (h *StrictCatalogHandlerV1) isAdmin(ctx context.Context) bool {
	p, ok := authn.FromAuthContext(ctx)
	return ok && h.users.IsAdmin(ctx, user.UserId(p.ID))
}

func (h *StrictCatalogHandlerV1) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	var status *TramiteStatus
	if h.isAdmin(ctx) {
		if request.Params.Status != nil {
			value := TramiteStatus(*request.Params.Status)
			status = &value
		}
	} else {
		value := Published
		status = &value
	}
	tramites, err := h.service.List(ctx, status)
	if err != nil {
		return oapi.ListTramites500ApplicationProblemPlusJSONResponse{InternalErrorApplicationProblemPlusJSONResponse: oapi.NewInternalErrorResponse(err.Error())}, nil
	}
	response := make([]oapi.TramiteBase, len(tramites))
	for i, t := range tramites {
		response[i] = TramiteBaseToResponse(t)
	}
	return oapi.ListTramites200JSONResponse{
		Data: response,
	}, nil
}

func (h *StrictCatalogHandlerV1) CreateTramite(ctx context.Context, request oapi.CreateTramiteRequestObject) (oapi.CreateTramiteResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.CreateTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	t, err := h.service.Create(ctx, TramiteFromCreateRequest(request.Body))
	if err != nil {
		return oapi.CreateTramite400ApplicationProblemPlusJSONResponse{BadRequestApplicationProblemPlusJSONResponse: oapi.NewBadRequestResponse(err.Error())}, nil
	}
	return oapi.CreateTramite201JSONResponse(TramiteToResponse(*t)), nil
}

func (h *StrictCatalogHandlerV1) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	t, err := h.service.Get(ctx, TramiteID(request.Id))
	if err != nil {
		return oapi.GetTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if !h.isAdmin(ctx) && t.Status != Published {
		return oapi.GetTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("trámite no encontrado")}, nil
	}
	return oapi.GetTramite200JSONResponse(TramiteToResponse(*t)), nil
}

func (h *StrictCatalogHandlerV1) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.UpdateTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	t := TramiteFromUpdateRequest(request.Body)
	updated, err := h.service.Update(ctx, TramiteID(request.Id), t)
	if errors.Is(err, ErrNotFound) {
		return oapi.UpdateTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return oapi.UpdateTramite400ApplicationProblemPlusJSONResponse{BadRequestApplicationProblemPlusJSONResponse: oapi.NewBadRequestResponse(err.Error())}, nil
	}
	return oapi.UpdateTramite200JSONResponse(TramiteToResponse(*updated)), nil
}

func (h *StrictCatalogHandlerV1) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.DeleteTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	err := h.service.Delete(ctx, TramiteID(request.Id))
	if err != nil {
		return oapi.DeleteTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.DeleteTramite204Response{}, nil
}
