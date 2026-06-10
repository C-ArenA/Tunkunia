package catalog

import (
	"errors"
	"slices"
	"strconv"
	"sync"
)

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

// List implements [Repo].
func (s *MemStore) List() []Tramite {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.tramites
}

// Create implements [Repo].
func (s *MemStore) Create(t Tramite) Tramite {
	s.mu.Lock()
	defer s.mu.Unlock()
	t.ID = len(s.tramites) + 1
	s.tramites = append(s.tramites, t)
	return t
}

// Get implements [Repo].
func (s *MemStore) Get(id int) (Tramite, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()
	for _, t := range s.tramites {
		if id == t.ID {
			return t, nil
		}
	}
	return Tramite{}, errors.New("No existe ningún trámite con ID " + strconv.Itoa(id))
}

// Update implements [Repo].
func (s *MemStore) Update(t Tramite) (Tramite, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	var tindex int
	var tfound bool = false
	for i, tram := range s.tramites {
		if t.ID == tram.ID {
			tindex = i
			tfound = true
		}
	}
	if tfound {
		s.tramites[tindex] = t
		return t, nil
	}
	return Tramite{}, errors.New("No existe ningún trámite con ID " + strconv.Itoa(t.ID))
}

// Delete implements [Repo].
func (s *MemStore) Delete(id int) error {
	s.mu.Lock()
	defer s.mu.Unlock()
	resultingTramitesSlice := slices.DeleteFunc(s.tramites, func(t Tramite) bool {
		return id == t.ID
	})
	if len(resultingTramitesSlice) >= len(s.tramites) {
		return errors.New("No existe ningún trámite con ID " + strconv.Itoa(id) + " para ser eliminado")
	}
	s.tramites = resultingTramitesSlice
	return nil
}
