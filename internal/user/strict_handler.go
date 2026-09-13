package user

import (
	"context"
	"database/sql"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
)

type repository interface {
	Get(context.Context, int64) (oapi.User, error)
	List(context.Context) ([]oapi.User, error)
	UpdateAccess(context.Context, int64, bool, bool) (oapi.User, error)
}

type StrictUserHandlerV1 struct {
	repo    repository
	service *Service
}

func NewStrictUserHandlerV1(repo repository, service *Service) *StrictUserHandlerV1 {
	return &StrictUserHandlerV1{repo: repo, service: service}
}

func (h *StrictUserHandlerV1) principal(ctx context.Context) (*authn.Principal, bool) {
	p, ok := authn.FromAuthContext(ctx)
	return p, ok && p.Type == authn.UserPrincipal
}

func (h *StrictUserHandlerV1) isAdmin(ctx context.Context) (bool, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return false, nil
	}
	return h.service.IsAdmin(ctx, int64(p.ID))
}

func (h *StrictUserHandlerV1) GetMe(ctx context.Context, _ oapi.GetMeRequestObject) (oapi.GetMeResponseObject, error) {
	p, ok := h.principal(ctx)
	if !ok {
		return oapi.GetMe401ApplicationProblemPlusJSONResponse{UnauthorizedApplicationProblemPlusJSONResponse: oapi.NewUnauthorizedResponse("No se pudo verificar la identidad del usuario")}, nil
	}

	u, err := h.repo.Get(ctx, int64(p.ID))
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.GetMe404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("Usuario no encontrado")}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.GetMe200JSONResponse(u), nil
}

func (h *StrictUserHandlerV1) ListUsers(ctx context.Context, _ oapi.ListUsersRequestObject) (oapi.ListUsersResponseObject, error) {
	admin, accessErr := h.isAdmin(ctx)
	if accessErr != nil {
		return nil, accessErr
	}
	if !admin {
		return oapi.ListUsers403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	items, err := h.repo.List(ctx)
	if err != nil {
		return nil, err
	}
	return oapi.ListUsers200JSONResponse(items), nil
}

func (h *StrictUserHandlerV1) UpdateUserAccess(ctx context.Context, request oapi.UpdateUserAccessRequestObject) (oapi.UpdateUserAccessResponseObject, error) {
	admin, accessErr := h.isAdmin(ctx)
	if accessErr != nil {
		return nil, accessErr
	}
	if !admin {
		return oapi.UpdateUserAccess403ApplicationProblemPlusJSONResponse{ForbiddenApplicationProblemPlusJSONResponse: oapi.NewForbiddenResponse("se requiere administración")}, nil
	}
	item, err := h.repo.UpdateAccess(
		ctx,
		request.Id,
		request.Body.IsAdmin,
		request.Body.IsPublicServant,
	)
	if errors.Is(err, sql.ErrNoRows) {
		return oapi.UpdateUserAccess404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse(err.Error())}, nil
	}
	if err != nil {
		return nil, err
	}
	return oapi.UpdateUserAccess200JSONResponse(item), nil
}
