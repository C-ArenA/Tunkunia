package catalog

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

type StrictCatalogHandlerV1 struct {
	service *Service
}

func NewStrictApiHandler(service *Service) *StrictCatalogHandlerV1 {
	return &StrictCatalogHandlerV1{service: service}
}

func (h *StrictCatalogHandlerV1) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	tramites, err := h.service.List(ctx)
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
	return oapi.GetTramite200JSONResponse(TramiteToResponse(*t)), nil
}

func (h *StrictCatalogHandlerV1) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
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
	err := h.service.Delete(ctx, TramiteID(request.Id))
	if err != nil {
		return oapi.DeleteTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.DeleteTramite204Response{}, nil
}
