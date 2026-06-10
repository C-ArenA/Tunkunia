package catalog

import (
	"context"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/catalog/oapi"
	"github.com/go-chi/chi/v5"
)

type Server struct {
	service *Service
}

func NewServer(service *Service) *Server {
	return &Server{service: service}
}

// GetHealth implements [oapi.StrictServerInterface].
func (s *Server) GetHealth(ctx context.Context, request oapi.GetHealthRequestObject) (oapi.GetHealthResponseObject, error) {
	if s.service == nil {
		return oapi.GetHealth503JSONResponse{
			Status:    oapi.DOWN,
			Timestamp: time.Now().UTC(),
		}, nil
	}
	return oapi.GetHealth200JSONResponse{
		Status:    oapi.UP,
		Timestamp: time.Now().UTC(),
	}, nil
}

// ListTramites implements [oapi.StrictServerInterface].
func (s *Server) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	tramites := s.service.GetAll()
	response := make([]oapi.Tramite, len(tramites))
	for i, t := range tramites {
		response[i] = oapi.Tramite{
			Id:   t.ID,
			Name: t.Name,
		}
	}
	return oapi.ListTramites200JSONResponse{
		Data: response,
	}, nil
}

// CreateTramite implements [oapi.StrictServerInterface].
func (s *Server) CreateTramite(ctx context.Context, request oapi.CreateTramiteRequestObject) (oapi.CreateTramiteResponseObject, error) {
	panic("unimplemented")
}

// GetTramite implements [oapi.StrictServerInterface].
func (s *Server) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	panic("unimplemented")
}

// UpdateTramite implements [oapi.StrictServerInterface].
func (s *Server) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	panic("unimplemented")
}

// DeleteTramite implements [oapi.StrictServerInterface].
func (s *Server) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	panic("unimplemented")
}

func (s *Server) RegisterRoutes(r *chi.Mux) {
	oapiServer := oapi.NewStrictHandler(s, nil)
	oapi.HandlerFromMux(oapiServer, r)
}
