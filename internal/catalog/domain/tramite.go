package domain

import (
	"errors"
	"time"
)

type TramiteID int64

type TramiteStatus string

const (
	Archived  TramiteStatus = "archived"
	Draft     TramiteStatus = "draft"
	Published TramiteStatus = "published"
)

type TramiteType string

const (
	Otro          TramiteType = "Otro"
	Registro      TramiteType = "Trámite de registro"
	Certificación TramiteType = "Trámite de certificación"
	Constancia    TramiteType = "Trámite de constancia"
	Obligation    TramiteType = "Trámite para cumplir con obligaciones"
	Servicio      TramiteType = "Trámite para acceder a servicios"
	Permiso       TramiteType = "Trámite para obtener permisos"
)

type Tramite struct {
	ID                   TramiteID
	Name                 string
	Description          string
	ProcedureDescription *string
	Type                 TramiteType
	Status               TramiteStatus
	LegalFramework       []string
	CreatedAt            time.Time
	UpdatedAt            time.Time
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
