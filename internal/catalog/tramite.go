package catalog

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

type TramiteUpdateMask struct {
	Name                 bool
	Description          bool
	ProcedureDescription bool
	Type                 bool
	Status               bool
}

var ErrNotFound = errors.New("Elemento no encontrado")
