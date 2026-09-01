package catalog

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"time"

	"github.com/C-ArenA/Tunkunia/petrunia"
)

var (
	ErrNoPublishedProcedure = errors.New("el trámite no tiene un procedimiento publicado")
	ErrInvalidProcedure     = errors.New("el procedimiento no es válido")
)

type ProcedureVersion struct {
	ID            int64
	TramiteID     TramiteID
	VersionNumber *int
	Status        string
	Definition    petrunia.Net
	CreatedAt     time.Time
	UpdatedAt     time.Time
	PublishedAt   *time.Time
}

type ProcedureValidationError struct {
	Violations []petrunia.Violation
}

func (e *ProcedureValidationError) Error() string { return ErrInvalidProcedure.Error() }
func (e *ProcedureValidationError) Unwrap() error { return ErrInvalidProcedure }

func (s *Service) GetPublishedProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error) {
	return s.repo.GetPublishedProcedure(ctx, id)
}

func (s *Service) GetDraftProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error) {
	return s.repo.GetDraftProcedure(ctx, id)
}

func (s *Service) SaveDraftProcedure(ctx context.Context, id TramiteID, net petrunia.Net) (*ProcedureVersion, error) {
	return s.repo.SaveDraftProcedure(ctx, id, net)
}

func (s *Service) PublishProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error) {
	draft, err := s.repo.GetDraftProcedure(ctx, id)
	if err != nil {
		return nil, err
	}
	if violations := petrunia.ValidateWorkflow(draft.Definition, petrunia.ValidationOptions{MaxReachableMarkings: 10_000}); len(violations) > 0 {
		return nil, &ProcedureValidationError{Violations: violations}
	}
	return s.repo.PublishProcedure(ctx, id)
}

func (s *Service) Archive(ctx context.Context, id TramiteID) error {
	return s.repo.Archive(ctx, id)
}

func scanProcedure(scanner interface{ Scan(...any) error }) (*ProcedureVersion, error) {
	var version ProcedureVersion
	var definition string
	var versionNumber sql.NullInt64
	var createdAt, updatedAt string
	var publishedAt sql.NullString
	if err := scanner.Scan(&version.ID, &version.TramiteID, &versionNumber, &version.Status, &definition, &createdAt, &updatedAt, &publishedAt); err != nil {
		return nil, err
	}
	if versionNumber.Valid {
		n := int(versionNumber.Int64)
		version.VersionNumber = &n
	}
	if err := json.Unmarshal([]byte(definition), &version.Definition); err != nil {
		return nil, fmt.Errorf("decodificar procedimiento: %w", err)
	}
	version.CreatedAt, _ = time.Parse(time.RFC3339, createdAt)
	version.UpdatedAt, _ = time.Parse(time.RFC3339, updatedAt)
	if publishedAt.Valid {
		t, _ := time.Parse(time.RFC3339, publishedAt.String)
		version.PublishedAt = &t
	}
	return &version, nil
}
