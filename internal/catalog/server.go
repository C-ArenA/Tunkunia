package catalog

import (
	"context"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/catalog/oapi"
)

type Server struct {
	service *Service
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

func (s *Server) RegisterRoutes(mux *http.ServeMux) {
	oapiServer := oapi.NewStrictHandler(s, nil)
	oapi.HandlerFromMux(oapiServer, mux)
}
