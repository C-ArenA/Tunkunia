package catalog

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

func (h *StrictCatalogHandlerV1) GetPublishedProcedure(ctx context.Context, request oapi.GetPublishedProcedureRequestObject) (oapi.GetPublishedProcedureResponseObject, error) {
	version, err := h.repo.GetPublishedProcedure(ctx, request.Id)
	if errors.Is(err, ErrNoPublishedProcedure) {
		return oapi.GetPublishedProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.GetPublishedProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) GetDraftProcedure(ctx context.Context, request oapi.GetDraftProcedureRequestObject) (oapi.GetDraftProcedureResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.GetDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.repo.GetDraftProcedure(ctx, request.Id)
	if errors.Is(err, ErrNotFound) {
		return oapi.GetDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.GetDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) SaveDraftProcedure(ctx context.Context, request oapi.SaveDraftProcedureRequestObject) (oapi.SaveDraftProcedureResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.SaveDraftProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.repo.SaveDraftProcedure(ctx, request.Id, ProcedureFromRequest(*request.Body))
	if errors.Is(err, ErrNotFound) {
		return oapi.SaveDraftProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.SaveDraftProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) PublishProcedure(ctx context.Context, request oapi.PublishProcedureRequestObject) (oapi.PublishProcedureResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.PublishProcedure403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	version, err := h.service.PublishProcedure(ctx, request.Id)
	var validation *ProcedureValidationError
	if errors.As(err, &validation) {
		violations := make([]oapi.ProcedureViolation, len(validation.Violations))
		for i, v := range validation.Violations {
			violations[i] = oapi.ProcedureViolation{Code: v.Code, Message: v.Message}
		}
		return oapi.PublishProcedure422JSONResponse{Violations: violations}, nil
	}
	if errors.Is(err, ErrNotFound) {
		return oapi.PublishProcedure404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.PublishProcedure200JSONResponse{ProcedureVersionJSONResponse: oapi.ProcedureVersionJSONResponse(ProcedureVersionToResponse(*version))}, nil
}

func (h *StrictCatalogHandlerV1) ArchiveTramite(ctx context.Context, request oapi.ArchiveTramiteRequestObject) (oapi.ArchiveTramiteResponseObject, error) {
	admin, err := h.isAdmin(ctx)
	if err != nil {
		return nil, err
	}
	if !admin {
		return oapi.ArchiveTramite403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	if err := h.repo.Archive(ctx, request.Id); errors.Is(err, ErrNotFound) {
		return oapi.ArchiveTramite404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	} else if err != nil {
		return nil, err
	}
	return oapi.ArchiveTramite204Response{}, nil
}
