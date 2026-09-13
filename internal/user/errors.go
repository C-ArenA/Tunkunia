package user

import "errors"

var (
	ErrInvalidEmail  = errors.New("Correo inválido")
	ErrFailedMapping = errors.New("No se pudo mapear valores entre capas")
)
