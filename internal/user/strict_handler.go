package user

import (
	"context"
	"database/sql"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
)

type StrictUserHandlerV1 struct {
	service *Service
}

func NewStrictUserHandlerV1(service *Service) *StrictUserHandlerV1 {
	return &StrictUserHandlerV1{service: service}
}

func (h *StrictUserHandlerV1) principal(ctx context.Context) (*authn.Principal, bool) {
	p, ok := authn.FromAuthContext(ctx)
	return p, ok && p.Type == authn.UserPrincipal
}

func (h *StrictUserHandlerV1) isAdmin(ctx context.Context) bool {
	p, ok := h.principal(ctx)
	return ok && h.service.IsAdmin(ctx, UserId(p.ID))
}

func (h *StrictUserHandlerV1) GetMe(ctx context.Context, _ oapi.GetMeRequestObject) (oapi.GetMeResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return oapi.GetMe401ApplicationProblemPlusJSONResponse{UnauthorizedApplicationProblemPlusJSONResponse: oapi.NewUnauthorizedResponse("No se pudo verificar la identidad del usuario")}, nil
	}

	u, err := h.service.GetUserById(ctx, UserId(p.ID))
	if err != nil {
		return oapi.GetMe404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("Usuario no encontrado")}, nil
	}
	return oapi.GetMe200JSONResponse(UserToResponse(*u)), nil
}

func (h *StrictUserHandlerV1) ListUsers(ctx context.Context, _ oapi.ListUsersRequestObject) (oapi.ListUsersResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.ListUsers403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	items, err := h.service.ListUsers(ctx)
	if err != nil {
		return nil, err
	}
	result := make(oapi.ListUsers200JSONResponse, len(items))
	for i, item := range items {
		result[i] = UserToResponse(item)
	}
	return result, nil
}

func (h *StrictUserHandlerV1) UpdateUserAccess(ctx context.Context, request oapi.UpdateUserAccessRequestObject) (oapi.UpdateUserAccessResponseObject, error) {
	if !h.isAdmin(ctx) {
		return oapi.UpdateUserAccess403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	item, err := h.service.UpdateAccess(
		ctx,
		UserId(request.Id),
		request.Body.IsAdmin,
		request.Body.IsPublicServant,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.UpdateUserAccess404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.UpdateUserAccess200JSONResponse(UserToResponse(*item)), nil
}
