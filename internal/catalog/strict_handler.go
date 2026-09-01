package catalog

import (
	"context"

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
	return ok && h.users.HasRole(ctx, user.UserId(p.ID), user.ADMIN)
}

func (h *StrictCatalogHandlerV1) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	filter := TramiteFilter{Status: new(Published)}
	if h.isAdmin(ctx) {
		filter.Status = nil
		if request.Params.Status != nil {
			status := TramiteStatus(*request.Params.Status)
			filter.Status = &status
		}
	}
	tramites, err := h.service.ListWithFilter(ctx, filter)
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
	if request.Body.Status != nil {
		return oapi.UpdateTramite400ApplicationProblemPlusJSONResponse{BadRequestApplicationProblemPlusJSONResponse: oapi.NewBadRequestResponse("use las operaciones publicar o archivar para cambiar el estado")}, nil
	}
	var validationErrors []oapi.ErrorDetail
	if request.Body.Status != nil {
		if !request.Body.Status.Valid() {
			validationErrors = append(validationErrors, oapi.ErrorDetail{
				Detail:  "Estado de trámite inválido",
				Pointer: "#/status",
			})
		}
	}
	if len(validationErrors) > 0 {
		return oapi.UpdateTramite422ApplicationProblemPlusJSONResponse{ValidationErrorApplicationProblemPlusJSONResponse: oapi.NewValidationErrorResponse("", validationErrors)}, nil
	}
	t, m := TramiteFromUpdateRequest(request.Body)
	updated, err := h.service.Update(ctx, TramiteID(request.Id), t, m)
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
