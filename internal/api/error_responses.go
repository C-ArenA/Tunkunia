package api

import "github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"

func NewNotFoundResponse(detail string) oapi.NotFoundApplicationProblemPlusJSONResponse {
	return oapi.NotFoundApplicationProblemPlusJSONResponse{
		Title:  "Recurso no encontrado",
		Status: int32(404),
		Detail: detail,
	}
}

func NewInternalErrorResponse(detail string) oapi.InternalErrorApplicationProblemPlusJSONResponse {
	return oapi.InternalErrorApplicationProblemPlusJSONResponse{
		Title:  "Falla interna",
		Status: int32(500),
		Detail: detail,
	}
}

func NewBadRequestResponse(detail string) oapi.BadRequestApplicationProblemPlusJSONResponse {
	return oapi.BadRequestApplicationProblemPlusJSONResponse{
		Title:  "Solicitud errónea",
		Status: int32(400),
		Detail: detail,
	}
}

func NewValidationErrorResponse(detail string, errDetails []oapi.ErrorDetail) oapi.ValidationErrorApplicationProblemPlusJSONResponse {
	return oapi.ValidationErrorApplicationProblemPlusJSONResponse{
		Title:  "Datos inválidos",
		Status: int32(422),
		Detail: detail,
		Errors: errDetails,
	}
}

func NewUnauthorizedResponse(detail string) oapi.UnauthorizedApplicationProblemPlusJSONResponse {
	return oapi.UnauthorizedApplicationProblemPlusJSONResponse{
		Title:  "No autorizado",
		Status: int32(401),
		Detail: detail,
	}
}

func NewForbiddenResponse(detail string) oapi.ForbiddenApplicationProblemPlusJSONResponse {
	return oapi.ForbiddenApplicationProblemPlusJSONResponse{
		Title:  "Prohibido",
		Status: int32(403),
		Detail: detail,
	}
}
