package tramite

import (
	"encoding/json"
	"net/http"
	"sync"
)

type Tramite struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type Store struct {
	mu       sync.RWMutex
	tramites []Tramite
}

func NewStore() *Store {
	return &Store{}
}

func (s *Store) GetAll() []Tramite {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.tramites
}

func (s *Store) Create(t Tramite) Tramite {
	s.mu.Lock()
	defer s.mu.Unlock()
	t.ID = len(s.tramites) + 1
	s.tramites = append(s.tramites, t)
	return t
}

func RegisterRoutes(mux *http.ServeMux, store *Store) {
	mux.HandleFunc("POST /tramites", func(w http.ResponseWriter, r *http.Request) {
		var t Tramite
		if err := json.NewDecoder(r.Body).Decode(&t); err != nil {
			http.Error(w, "Bad request "+err.Error(), http.StatusBadRequest)
			return
		}
		defer r.Body.Close()

		t = store.Create(t)
		json.NewEncoder(w).Encode(t)
	})

	mux.HandleFunc("GET /tramites", func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(store.GetAll())
	})
}
