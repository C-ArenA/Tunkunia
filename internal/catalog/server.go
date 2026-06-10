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

// GetCatalogHealth implements [oapi.StrictServerInterface].
func (s *Server) GetCatalogHealth(ctx context.Context, request oapi.GetCatalogHealthRequestObject) (oapi.GetCatalogHealthResponseObject, error) {
	if s.service == nil {
		return oapi.GetCatalogHealth503JSONResponse{
			Status:    oapi.DOWN,
			Timestamp: time.Now().UTC(),
		}, nil
	}
	return oapi.GetCatalogHealth200JSONResponse{
		Status:    oapi.UP,
		Timestamp: time.Now().UTC(),
	}, nil
}

// ListTramites implements [oapi.StrictServerInterface].
func (s *Server) ListTramites(ctx context.Context, request oapi.ListTramitesRequestObject) (oapi.ListTramitesResponseObject, error) {
	tramites := s.service.repo.List()
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
	t := Tramite{
		Name: request.Body.Name,
	}
	t, err := s.service.Create(t)

	if err != nil {
		return oapi.CreateTramite400ApplicationProblemPlusJSONResponse{
			BadRequestApplicationProblemPlusJSONResponse: oapi.BadRequestApplicationProblemPlusJSONResponse{
				Title: new("No se puede crear un trámite con los datos proporcionados"),
			},
		}, nil
	}

	return oapi.CreateTramite201JSONResponse{
		Id:   t.ID,
		Name: t.Name,
	}, nil
}

// GetTramite implements [oapi.StrictServerInterface].
func (s *Server) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	tramiteId := request.Id
	t, err := s.service.repo.Get(tramiteId)

	if err != nil {
		return oapi.GetTramite404ApplicationProblemPlusJSONResponse{
			NotFoundApplicationProblemPlusJSONResponse: oapi.NotFoundApplicationProblemPlusJSONResponse{
				Title:  new("No se puede eliminar trámite inexistente"),
				Status: new(int32(404)),
				Detail: new(err.Error()),
			},
		}, nil
	}

	return oapi.GetTramite200JSONResponse{
		Id:   t.ID,
		Name: t.Name,
	}, nil
}

// UpdateTramite implements [oapi.StrictServerInterface].
func (s *Server) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	tramiteId := request.Id
	t, err := s.service.Update(tramiteId, TramiteUpdatePayload{
		Name: request.Body.Name,
	})
	if err != nil {
		return oapi.UpdateTramite400ApplicationProblemPlusJSONResponse{
			BadRequestApplicationProblemPlusJSONResponse: oapi.BadRequestApplicationProblemPlusJSONResponse{
				Title: new("Solicitud errónea"),
			}}, nil

	}
	return oapi.UpdateTramite200JSONResponse{
		Id:   t.ID,
		Name: t.Name,
	}, nil
}

// DeleteTramite implements [oapi.StrictServerInterface].
func (s *Server) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	tramiteId := request.Id
	err := s.service.repo.Delete(tramiteId)
	if err != nil {
		return oapi.DeleteTramite404ApplicationProblemPlusJSONResponse{
			NotFoundApplicationProblemPlusJSONResponse: oapi.NotFoundApplicationProblemPlusJSONResponse{
				Title:  new("No se puede eliminar trámite inexistente"),
				Status: new(int32(404)),
				Detail: new(err.Error()),
			},
		}, nil
	}

	return oapi.DeleteTramite204Response{}, nil
}

func (s *Server) RegisterRoutes(r *chi.Mux) {
	oapiServer := oapi.NewStrictHandler(s, nil)
	oapi.HandlerFromMux(oapiServer, r)
}
