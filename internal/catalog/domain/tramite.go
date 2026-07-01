package domain

import (
	"github.com/C-ArenA/Tunkunia/internal/audit"
)

type TramiteID int64

type TramiteField string

const (
	TramiteFieldName      TramiteField = "name"
	TramiteFieldCreatedAt TramiteField = "created_at"
	TramiteFieldUpdatedAt TramiteField = "updated_at"
	TramiteFieldStatus    TramiteField = "status"
	TramiteFieldType      TramiteField = "type"
)

func (f TramiteField) IsValid() bool {
	switch f {
	case TramiteFieldName, TramiteFieldCreatedAt, TramiteFieldUpdatedAt, TramiteFieldStatus, TramiteFieldType:
		return true
	default:
		return false
	}
}

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
	ProcedureDescription string
	Type                 TramiteType
	Status               TramiteStatus
	LegalFramework       []string
	audit.Metadata
}

type TramiteMask struct {
	ID                   bool
	Name                 bool
	Description          bool
	ProcedureDescription bool
	Type                 bool
	Status               bool
	LegalFramework       bool
	audit.MetadataMask
}

type TramiteFilter struct {
	Status *TramiteStatus
	Type   *TramiteType
}

type TramiteSort struct {
	Field  TramiteField
	IsDesc bool
}

type TramitePaginator struct {
	Limit         int
	StartingAfter *TramiteID
	EndingBefore  *TramiteID
}
