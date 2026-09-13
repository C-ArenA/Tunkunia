package catalog

import (
	"context"
	"errors"

	"github.com/C-ArenA/Tunkunia/petrunia"
)

var ErrNotFound = errors.New("element not found")

type Repo interface {
	List(ctx context.Context, status *TramiteStatus) ([]Tramite, error)
	Create(ctx context.Context, t Tramite) (*Tramite, error)
	Get(ctx context.Context, id TramiteID) (*Tramite, error)
	Update(ctx context.Context, id TramiteID, t Tramite) (*Tramite, error)
	Delete(ctx context.Context, id TramiteID) error
	GetPublishedProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error)
	GetDraftProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error)
	SaveDraftProcedure(ctx context.Context, id TramiteID, net petrunia.Net) (*ProcedureVersion, error)
	PublishProcedure(ctx context.Context, id TramiteID) (*ProcedureVersion, error)
	Archive(ctx context.Context, id TramiteID) error
}

type Service struct {
	repo Repo
}

func NewService(repo Repo) *Service {
	return &Service{repo: repo}
}

func (s *Service) List(ctx context.Context, status *TramiteStatus) ([]Tramite, error) {
	return s.repo.List(ctx, status)
}

func (s *Service) Create(ctx context.Context, t Tramite) (*Tramite, error) {
	return s.repo.Create(ctx, t)
}

func (s *Service) Get(ctx context.Context, id TramiteID) (*Tramite, error) {
	return s.repo.Get(ctx, id)
}

func (s *Service) Update(ctx context.Context, id TramiteID, t Tramite) (*Tramite, error) {
	return s.repo.Update(ctx, id, t)
}

func (s *Service) Delete(ctx context.Context, id TramiteID) error {
	return s.repo.Delete(ctx, id)
}
