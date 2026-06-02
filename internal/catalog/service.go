package catalog

type Repo interface {
	GetAll() []Tramite
	Create(t Tramite) Tramite
}

type Service struct {
	repo Repo
}

func NewService(repo Repo) *Service {
	return &Service{
		repo: repo,
	}
}

func (s *Service) GetAll() []Tramite {
	return s.repo.GetAll()
}

func (s *Service) Create(t Tramite) (Tramite, error) {
	// validation, enrichment, business rules go here
	return s.repo.Create(t), nil
}
