package domain

import "errors"

type TramiteID int64

type Tramite struct {
	ID                   TramiteID
	Name                 string
	Description          string
	ProcedureDescription *string
	Type                 string
	Status               string
	LegalFramework       []string
	CreatedAt            string
	UpdatedAt            string
}

type TramiteMask struct {
	ID                   bool
	Name                 bool
	Description          bool
	ProcedureDescription bool
	Type                 bool
	Status               bool
	LegalFramework       bool
	CreatedAt            bool
	UpdatedAt            bool
}

var ErrNotFound = errors.New("Elemento no encontrado")
