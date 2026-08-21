package user

import "errors"

var (
	ErrAdminAlreadyExists = errors.New("Ya existe un usuario administrador")
	ErrInvalidEmail       = errors.New("Correo inválido")
	ErrFailedMapping      = errors.New("No se pudo mapear valores entre capas")
)
