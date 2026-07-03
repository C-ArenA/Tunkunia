package domain

import "errors"

var (
	ErrAdminAlreadyExists = errors.New("Ya existe un usuario administrador")
	ErrInvalidEmail       = errors.New("Correo inválido")
)
