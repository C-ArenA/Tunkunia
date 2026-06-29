package api

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
	rbacdomain "github.com/C-ArenA/Tunkunia/internal/rbac/domain"
)

type StrictApiHandler struct {
	service *rbacdomain.Service
}

func NewStrictApiHandler(service *rbacdomain.Service) *StrictApiHandler {
	return &StrictApiHandler{service: service}
}

func (h *StrictApiHandler) ListRoles(ctx context.Context, request ListRolesRequestObject) (ListRolesResponseObject, error) {
	roles, err := h.service.ListRoles(ctx)
	if err != nil {
		return ListRoles401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Role, len(roles))
	for i, r := range roles {
		response[i] = NewRoleFromDomain(r)
	}

	return ListRoles200JSONResponse(response), nil
}

func (h *StrictApiHandler) CreateRole(ctx context.Context, request CreateRoleRequestObject) (CreateRoleResponseObject, error) {
	name, desc := request.Body.toDomain()

	role, err := h.service.CreateRole(ctx, name, desc)
	if err != nil {
		return CreateRole400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	return CreateRole201JSONResponse(NewRoleFromDomain(*role)), nil
}

func (h *StrictApiHandler) GetRole(ctx context.Context, request GetRoleRequestObject) (GetRoleResponseObject, error) {
	role, err := h.service.GetRole(ctx, rbacdomain.RoleID(request.Id))
	if err != nil {
		return GetRole404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
	}

	return GetRole200JSONResponse(NewRoleFromDomain(*role)), nil
}

func (h *StrictApiHandler) UpdateRole(ctx context.Context, request UpdateRoleRequestObject) (UpdateRoleResponseObject, error) {
	r, m := request.Body.toDomain()
	role, err := h.service.UpdateRole(ctx, rbacdomain.RoleID(request.Id), r, m)
	if err != nil {
		return UpdateRole404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
	}

	return UpdateRole200JSONResponse(NewRoleFromDomain(*role)), nil
}

func (h *StrictApiHandler) DeleteRole(ctx context.Context, request DeleteRoleRequestObject) (DeleteRoleResponseObject, error) {
	err := h.service.DeleteRole(ctx, rbacdomain.RoleID(request.Id))
	if err != nil {
		return DeleteRole404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
	}

	return DeleteRole204Response{}, nil
}

func (h *StrictApiHandler) ListPermissions(ctx context.Context, request ListPermissionsRequestObject) (ListPermissionsResponseObject, error) {
	perms, err := h.service.ListPermissions(ctx)
	if err != nil {
		return ListPermissions401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Permission, len(perms))
	for i, p := range perms {
		response[i] = NewPermissionFromDomain(p)
	}

	return ListPermissions200JSONResponse(response), nil
}

func (h *StrictApiHandler) GetRolePermissions(ctx context.Context, request GetRolePermissionsRequestObject) (GetRolePermissionsResponseObject, error) {
	perms, err := h.service.GetRolePermissions(ctx, rbacdomain.RoleID(request.Id))
	if err != nil {
		return GetRolePermissions401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Permission, len(perms))
	for i, p := range perms {
		response[i] = NewPermissionFromDomain(p)
	}

	return GetRolePermissions200JSONResponse(response), nil
}

func (h *StrictApiHandler) SetRolePermissions(ctx context.Context, request SetRolePermissionsRequestObject) (SetRolePermissionsResponseObject, error) {
	permIDs := make([]rbacdomain.PermissionID, len(request.Body.PermissionIds))
	for i, pid := range request.Body.PermissionIds {
		permIDs[i] = rbacdomain.PermissionID(pid)
	}

	err := h.service.SetRolePermissions(ctx, rbacdomain.RoleID(request.Id), permIDs)
	if err != nil {
		return SetRolePermissions400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	perms, err := h.service.GetRolePermissions(ctx, rbacdomain.RoleID(request.Id))
	if err != nil {
		return SetRolePermissions401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Permission, len(perms))
	for i, p := range perms {
		response[i] = NewPermissionFromDomain(p)
	}

	return SetRolePermissions200JSONResponse(response), nil
}

func (h *StrictApiHandler) GetUserRoles(ctx context.Context, request GetUserRolesRequestObject) (GetUserRolesResponseObject, error) {
	roles, err := h.service.GetUserRoles(ctx, domain.UserID(request.Id))
	if err != nil {
		return GetUserRoles401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Role, len(roles))
	for i, r := range roles {
		response[i] = NewRoleFromDomain(r)
	}

	return GetUserRoles200JSONResponse(response), nil
}

func (h *StrictApiHandler) SetUserRoles(ctx context.Context, request SetUserRolesRequestObject) (SetUserRolesResponseObject, error) {
	roleIDs := make([]rbacdomain.RoleID, len(request.Body.RoleIds))
	for i, rid := range request.Body.RoleIds {
		roleIDs[i] = rbacdomain.RoleID(rid)
	}

	err := h.service.SetUserRoles(ctx, domain.UserID(request.Id), roleIDs)
	if err != nil {
		return SetUserRoles400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	roles, err := h.service.GetUserRoles(ctx, domain.UserID(request.Id))
	if err != nil {
		return SetUserRoles401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]Role, len(roles))
	for i, r := range roles {
		response[i] = NewRoleFromDomain(r)
	}

	return SetUserRoles200JSONResponse(response), nil
}
