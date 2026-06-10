package catalog

type Repo interface {
	List() []Tramite
	Create(t Tramite) Tramite
	Get(id int) (Tramite, error)
	Update(t Tramite) (Tramite, error)
	Delete(id int) error
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
