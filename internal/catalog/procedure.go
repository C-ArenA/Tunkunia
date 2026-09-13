package catalog

import (
	"context"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/petrunia"
)

var (
	ErrNotFound             = errors.New("element not found")
	ErrNoPublishedProcedure = errors.New("el trámite no tiene un procedimiento publicado")
	ErrInvalidProcedure     = errors.New("el procedimiento no es válido")
)

type ProcedureVersion struct {
	ID            int64
	TramiteID     int64
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

type procedureRepository interface {
	PublishProcedure(context.Context, int64, func(petrunia.Net) error) (*ProcedureVersion, error)
}

// ProcedureService owns the only catalog behavior that is more than CRUD:
// validating a draft before publishing it.
type ProcedureService struct {
	repo procedureRepository
}

func NewProcedureService(repo procedureRepository) *ProcedureService {
	return &ProcedureService{repo: repo}
}

func (s *ProcedureService) PublishProcedure(ctx context.Context, id int64) (*ProcedureVersion, error) {
	return s.repo.PublishProcedure(ctx, id, func(net petrunia.Net) error {
		if violations := petrunia.ValidateWorkflow(net, petrunia.ValidationOptions{MaxReachableMarkings: 10_000}); len(violations) > 0 {
			return &ProcedureValidationError{Violations: violations}
		}
		return nil
	})
}
