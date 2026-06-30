package domain

import "context"

type Repo interface {
	List(ctx context.Context, filter TramiteFilter, sort TramiteSort) ([]Tramite, error)
	Create(ctx context.Context, t Tramite) (*Tramite, error)
	Get(ctx context.Context, id TramiteID) (*Tramite, error)
	Update(ctx context.Context, id TramiteID, t Tramite, m TramiteMask) (*Tramite, error)
	Delete(ctx context.Context, id TramiteID) error
}

type Service struct {
	repo Repo
}

func NewService(repo Repo) *Service {
	return &Service{
		repo: repo,
	}
}

func (s *Service) List(ctx context.Context) ([]Tramite, error) {
	return s.repo.List(ctx, TramiteFilter{}, TramiteSort{})
}

func (s *Service) Create(ctx context.Context, t Tramite) (*Tramite, error) {
	return s.repo.Create(ctx, t)
}

func (s *Service) Get(ctx context.Context, id TramiteID) (*Tramite, error) {
	return s.repo.Get(ctx, id)
}

func (s *Service) Update(ctx context.Context, id TramiteID, t Tramite, m TramiteMask) (*Tramite, error) {
	return s.repo.Update(ctx, id, t, m)
}

func (s *Service) Delete(ctx context.Context, id TramiteID) error {
	return s.repo.Delete(ctx, id)
}
