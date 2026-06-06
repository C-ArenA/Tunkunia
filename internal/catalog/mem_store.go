package catalog

import "sync"

type MemStore struct {
	mu       sync.RWMutex
	tramites []Tramite
}

func NewMemStore() *MemStore {
	return &MemStore{
		tramites: []Tramite{
			{
				ID:   1,
				Name: "Cédula de Identidad",
			},
		},
	}
}

func (s *MemStore) GetAll() []Tramite {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.tramites
}

func (s *MemStore) Create(t Tramite) Tramite {
	s.mu.Lock()
	defer s.mu.Unlock()
	t.ID = len(s.tramites) + 1
	s.tramites = append(s.tramites, t)
	return t
}
