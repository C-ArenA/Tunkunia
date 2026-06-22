package catalog

import "context"

type Repo interface {
	List(ctx context.Context) ([]Tramite, error)
	Create(ctx context.Context, t Tramite) (*Tramite, error)
	Get(ctx context.Context, id TramiteID) (*Tramite, error)
	Update(ctx context.Context, id TramiteID, t Tramite, m TramiteUpdateMask) (*Tramite, error)
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

func (s *Service) Create(t Tramite) (Tramite, error) {
	// validation, enrichment, business rules go here
	return s.repo.Create(t), nil
}

func (s *Service) Update(id int, tu TramiteUpdatePayload) (Tramite, error) {
	t, err := s.repo.Get(id)

	if err != nil {
		return Tramite{}, err
	}

	if tu.Name != nil {
		t.Name = *tu.Name
	}

	return s.repo.Update(t)
}
