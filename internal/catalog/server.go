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

// PostTramite implements [oapi.StrictServerInterface].
func (s *Server) PostTramite(ctx context.Context, request oapi.PostTramiteRequestObject) (oapi.PostTramiteResponseObject, error) {
	panic("unimplemented")
}

func NewServer(service *Service) *Server {
	return &Server{service: service}
}

func (s *Server) GetTramites(ctx context.Context, request oapi.GetTramitesRequestObject) (oapi.GetTramitesResponseObject, error) {
	tramites := s.service.GetAll()
	response := make([]oapi.TramiteResponse, len(tramites))
	for i, t := range tramites {
		response[i] = oapi.TramiteResponse{
			Id:   t.ID,
			Name: t.Name,
		}
	}
	return oapi.GetTramites200JSONResponse{
		Data:  response,
		Total: len(response),
		Page:  1,
		Limit: len(response)}, nil
}

func (s *Server) RegisterRoutes(r *chi.Mux) {
	oapiServer := oapi.NewStrictHandler(s, nil)
	oapi.HandlerFromMux(oapiServer, r)
}
