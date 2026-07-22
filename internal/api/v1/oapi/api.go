package oapi

import (
	"context"
	"encoding/json"
	"net/http"
)

//go:generate redocly bundle ./../openapi.yaml --output ./bundled.openapi.yaml
//go:generate go tool oapi-codegen -config ./oapi.cfg.yaml ./bundled.openapi.yaml
//go:generate go tool oapi-codegen -config ./models.oapi.cfg.yaml ./bundled.openapi.yaml
//go:generate rm -f ./bundled.openapi.yaml

func NewNotFoundResponse(detail string) NotFoundApplicationProblemPlusJSONResponse {
	return NotFoundApplicationProblemPlusJSONResponse{
		Title:  "Recurso no encontrado",
		Status: int32(404),
		Detail: detail,
	}
}

func NewInternalErrorResponse(detail string) InternalErrorApplicationProblemPlusJSONResponse {
	return InternalErrorApplicationProblemPlusJSONResponse{
		Title:  "Falla interna",
		Status: int32(500),
		Detail: detail,
	}
}

func NewBadRequestResponse(detail string) BadRequestApplicationProblemPlusJSONResponse {
	return BadRequestApplicationProblemPlusJSONResponse{
		Title:  "Solicitud errónea",
		Status: int32(400),
		Detail: detail,
	}
}

func NewValidationErrorResponse(detail string, errDetails []ErrorDetail) ValidationErrorApplicationProblemPlusJSONResponse {
	return ValidationErrorApplicationProblemPlusJSONResponse{
		Title:  "Datos inválidos",
		Status: int32(422),
		Detail: detail,
		Errors: errDetails,
	}
}

func NewUnauthorizedResponse(detail string) UnauthorizedApplicationProblemPlusJSONResponse {
	return UnauthorizedApplicationProblemPlusJSONResponse{
		Title:  "No autorizado",
		Status: int32(401),
		Detail: detail,
	}
}

func NewForbiddenResponse(detail string) ForbiddenApplicationProblemPlusJSONResponse {
	return ForbiddenApplicationProblemPlusJSONResponse{
		Title:  "Prohibido",
		Status: int32(403),
		Detail: detail,
	}
}

func Error(w http.ResponseWriter, errorResponse any, code int) {
	h := w.Header()
	h.Set("Content-Type", "application/problem+json")
	h.Set("X-Content-Type-Options", "nosniff")
	w.WriteHeader(code)
	if err := json.NewEncoder(w).Encode(errorResponse); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

func BearerAuthScopesFromContext(ctx context.Context) ([]string, bool) {
	bas, ok := ctx.Value(BearerAuthScopes).([]string)
	return bas, ok
}
