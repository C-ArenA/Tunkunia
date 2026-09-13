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

func NewStrictCatalogHandlerV1(service *Service, users *user.Service) *StrictCatalogHandlerV1 {
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

func (h *StrictCatalogHandlerV1) GetPublishedProcedure(ctx context.Context, request oapi.GetPublishedProcedureRequestObject) (oapi.GetPublishedProcedureResponseObject, error) {
	version, err := h.service.GetPublishedProcedure(ctx, TramiteID(request.Id))
	if err != nil {
		return oapi.GetPublishedProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetPublishedProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) GetDraftProcedure(ctx context.Context, request oapi.GetDraftProcedureRequestObject) (oapi.GetDraftProcedureResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.GetDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.service.GetDraftProcedure(ctx, TramiteID(request.Id))
	if err != nil {
		return oapi.GetDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.GetDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) SaveDraftProcedure(ctx context.Context, request oapi.SaveDraftProcedureRequestObject) (oapi.SaveDraftProcedureResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.SaveDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.service.SaveDraftProcedure(ctx, TramiteID(request.Id), ProcedureFromRequest(*request.Body))
	if err != nil {
		return oapi.SaveDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.SaveDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) PublishProcedure(ctx context.Context, request oapi.PublishProcedureRequestObject) (oapi.PublishProcedureResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.PublishProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.service.PublishProcedure(ctx, TramiteID(request.Id))
	var validation *ProcedureValidationError
	if errors.As(err, &validation) {
		violations := make([]oapi.ProcedureViolation, len(validation.Violations))
		for i, v := range validation.Violations {
			violations[i] = oapi.ProcedureViolation{Code: v.Code, Message: v.Message}
		}
		return oapi.PublishProcedure422JSONResponse{Violations: violations}, nil
	}
	if err != nil {
		return oapi.PublishProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.PublishProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) ArchiveTramite(ctx context.Context, request oapi.ArchiveTramiteRequestObject) (oapi.ArchiveTramiteResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.ArchiveTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	if err := h.service.Archive(ctx, TramiteID(request.Id)); err != nil {
		return oapi.ArchiveTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	return oapi.ArchiveTramite204Response{}, nil
}
