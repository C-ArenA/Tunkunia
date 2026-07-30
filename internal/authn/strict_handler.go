package authn

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/oapi-codegen/runtime/types"
)

type StrictHandler struct {
	userService *user.Service
}

func NewStrictHandler(us *user.Service) *StrictHandler {
	return &StrictHandler{us}
}

func (h *StrictHandler) GetMe(ctx context.Context, request oapi.GetMeRequestObject) (oapi.GetMeResponseObject, error) {
	p, ok := FromAuthContext(ctx)
	if !ok {
		return oapi.GetMe401ApplicationProblemPlusJSONResponse{UnauthorizedApplicationProblemPlusJSONResponse: oapi.NewUnauthorizedResponse("No se pudo verificar la identidad del usuario")}, nil
	}
	if p.Type == UserPrincipal {
		u, err := h.userService.GetUserById(ctx, user.UserId(p.ID))
		if err != nil {
			return oapi.GetMe404ApplicationProblemPlusJSONResponse{NotFoundApplicationProblemPlusJSONResponse: oapi.NewNotFoundResponse("Usuario no encontrado")}, nil
		}
		roles := make([]string, len(u.Roles))
		for i, r := range u.Roles {
			roles[i] = string(r)
		}
		return oapi.GetMe200JSONResponse{
			Id:            int64(u.ID),
			Email:         types.Email(u.Email),
			EmailVerified: u.EmailVerified,
			Name:          u.Name,
			Roles:         roles,
			Sub:           u.Sub,
		}, nil
	}
	return oapi.GetMe500ApplicationProblemPlusJSONResponse{InternalErrorApplicationProblemPlusJSONResponse: oapi.NewInternalErrorResponse("No implementado")}, nil
}
