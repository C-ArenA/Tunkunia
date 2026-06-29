package api

import "github.com/go-chi/chi/v5"

type Router struct {
	strictApiHandler *StrictApiHandler
}

func NewRouter(h *StrictApiHandler) *Router {
	return &Router{
		strictApiHandler: h,
	}
}

func (r *Router) RegisterRoutes(m *chi.Mux) {
	oApiServer := NewStrictHandler(r.strictApiHandler, nil)
	HandlerFromMuxWithBaseURL(oApiServer, m, "/api/v1")
}
