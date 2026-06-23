package api

import "github.com/go-chi/chi/v5"

type Router struct {
	controller *Controller
}

func NewRouter(c *Controller) *Router {
	return &Router{
		controller: c,
	}
}

func (r *Router) RegisterRoutes(m *chi.Mux) {
	server := NewStrictHandler(r.controller, nil)
	HandlerFromMuxWithBaseURL(server, m, "/api/v1")
}
