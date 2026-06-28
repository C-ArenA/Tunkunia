package api

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
)

type StrictApiHandler struct {
	service *domain.Service
}

func NewStrictApiHandler(service *domain.Service) *StrictApiHandler {
	return &StrictApiHandler{service: service}
}

// ListTramites implements [StrictServerInterface].
func (h *StrictApiHandler) ListTramites(ctx context.Context, request ListTramitesRequestObject) (ListTramitesResponseObject, error) {
	tramites, err := h.service.List(ctx)
	if err != nil {
		return ListTramites500ApplicationProblemPlusJSONResponse{api.NewInternalErrorResponse(err.Error())}, nil
	}
	response := make([]TramiteBase, len(tramites))
	for i, t := range tramites {
		response[i] = NewTramiteBaseFromDomain(t)
	}
	return ListTramites200JSONResponse{
		Data: response,
	}, nil
}

// CreateTramite implements [StrictServerInterface].
func (h *StrictApiHandler) CreateTramite(ctx context.Context, request CreateTramiteRequestObject) (CreateTramiteResponseObject, error) {
	t, err := h.service.Create(ctx, request.Body.toDomain())

	if err != nil {
		return CreateTramite400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	return CreateTramite201JSONResponse(NewTramiteFromDomain(*t)), nil
}

// GetTramite implements [StrictServerInterface].
func (h *StrictApiHandler) GetTramite(ctx context.Context, request GetTramiteRequestObject) (GetTramiteResponseObject, error) {
	t, err := h.service.Get(ctx, domain.TramiteID(request.Id))

	if err != nil {
		return GetTramite404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
	}

	return GetTramite200JSONResponse(NewTramiteFromDomain(*t)), nil
}

// UpdateTramite implements [StrictServerInterface].
func (h *StrictApiHandler) UpdateTramite(ctx context.Context, request UpdateTramiteRequestObject) (UpdateTramiteResponseObject, error) {
	validationErrors := []api.ErrorDetail{}
	if request.Body.Status != nil {
		if !request.Body.Status.Valid() {
			validationErrors = append(validationErrors, api.ErrorDetail{
				Detail:  "Estado de trámite inválido",
				Pointer: "#/status",
			})
		}
	}

	if len(validationErrors) > 0 {
		return UpdateTramite422ApplicationProblemPlusJSONResponse{api.NewValidationErrorResponse("", validationErrors)}, nil
	}

	t, m := request.Body.toDomain()
	updated, err := h.service.Update(ctx, domain.TramiteID(request.Id), t, m)
	if err != nil {
		return UpdateTramite400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	return UpdateTramite200JSONResponse(NewTramiteFromDomain(*updated)), nil
}

// DeleteTramite implements [StrictServerInterface].
func (h *StrictApiHandler) DeleteTramite(ctx context.Context, request DeleteTramiteRequestObject) (DeleteTramiteResponseObject, error) {
	err := h.service.Delete(ctx, domain.TramiteID(request.Id))
	if err != nil {
		return DeleteTramite404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
	}

	return DeleteTramite204Response{}, nil
}
