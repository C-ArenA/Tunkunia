package api

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/internal/api"
	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

type StrictApiHandler struct {
	service *domain.Service
}

func NewStrictApiHandler(service *domain.Service) *StrictApiHandler {
	return &StrictApiHandler{service: service}
}

func (h *StrictApiHandler) RegisterUser(ctx context.Context, request RegisterUserRequestObject) (RegisterUserResponseObject, error) {
	email, password, name := request.Body.toDomain()

	user, err := h.service.Register(ctx, email, password, name)
	if err != nil {
		if errors.Is(err, domain.ErrEmailAlreadyExists) {
			return RegisterUser409ApplicationProblemPlusJSONResponse(api.ProblemDetails{
				Title:  "El email ya está registrado",
				Status: 409,
				Detail: err.Error(),
			}), nil
		}
		return RegisterUser400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	token, _, err := h.service.Login(ctx, email, password)
	if err != nil {
		return RegisterUser400ApplicationProblemPlusJSONResponse{api.NewBadRequestResponse(err.Error())}, nil
	}

	return RegisterUser201JSONResponse(NewAuthResponseFromDomain(token, *user)), nil
}

func (h *StrictApiHandler) LoginUser(ctx context.Context, request LoginUserRequestObject) (LoginUserResponseObject, error) {
	email, password := request.Body.toDomain()

	token, user, err := h.service.Login(ctx, email, password)
	if err != nil {
		return LoginUser401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	return LoginUser200JSONResponse(NewAuthResponseFromDomain(token, *user)), nil
}

func (h *StrictApiHandler) GetCurrentUser(ctx context.Context, request GetCurrentUserRequestObject) (GetCurrentUserResponseObject, error) {
	authUser := domain.UserFromContext(ctx)
	if authUser == nil {
		return GetCurrentUser401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse("No autenticado")}, nil
	}

	user, err := h.service.GetUser(ctx, authUser.ID)
	if err != nil {
		return GetCurrentUser401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	return GetCurrentUser200JSONResponse(NewUserFromDomain(*user)), nil
}

func (h *StrictApiHandler) ListUsers(ctx context.Context, request ListUsersRequestObject) (ListUsersResponseObject, error) {
	users, err := h.service.ListUsers(ctx)
	if err != nil {
		return ListUsers401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	response := make([]User, len(users))
	for i, u := range users {
		response[i] = NewUserFromDomain(u)
	}

	return ListUsers200JSONResponse(response), nil
}

func (h *StrictApiHandler) GetUser(ctx context.Context, request GetUserRequestObject) (GetUserResponseObject, error) {
	user, err := h.service.GetUser(ctx, domain.UserID(request.Id))
	if err != nil {
		if errors.Is(err, domain.ErrNotFound) {
			return GetUser404ApplicationProblemPlusJSONResponse{api.NewNotFoundResponse(err.Error())}, nil
		}
		return GetUser401ApplicationProblemPlusJSONResponse{api.NewUnauthorizedResponse(err.Error())}, nil
	}

	return GetUser200JSONResponse(NewUserFromDomain(*user)), nil
}
