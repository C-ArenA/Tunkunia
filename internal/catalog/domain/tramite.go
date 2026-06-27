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

type Tramite struct {
	ID                   TramiteID
	Name                 string
	Description          string
	ProcedureDescription *string
	Type                 string
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
