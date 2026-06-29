package api

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
