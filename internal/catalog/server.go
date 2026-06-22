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
	tramites, err := s.service.List(ctx)
	if err != nil {
		errResponse := oapi.ListTramites500ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("La consulta a la base de datos falló")
		return errResponse, nil
	}
	response := make([]oapi.Tramite, len(tramites))
	for i, t := range tramites {
		response[i] = oapi.Tramite{
			Id:   int(t.ID),
			Name: t.Name,
		}
	}
	return oapi.ListTramites200JSONResponse{
		Data: response,
	}, nil
}

// CreateTramite implements [oapi.StrictServerInterface].
func (s *Server) CreateTramite(ctx context.Context, request oapi.CreateTramiteRequestObject) (oapi.CreateTramiteResponseObject, error) {
	t, err := s.service.Create(ctx, Tramite{
		Name: request.Body.Name,
	})

	if err != nil {
		errResponse := oapi.CreateTramite400ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("No se puede crear un trámite con los datos proporcionados")
		return errResponse, nil
	}

	return oapi.CreateTramite201JSONResponse{
		Id:   int(t.ID),
		Name: t.Name,
	}, nil
}

// GetTramite implements [oapi.StrictServerInterface].
func (s *Server) GetTramite(ctx context.Context, request oapi.GetTramiteRequestObject) (oapi.GetTramiteResponseObject, error) {
	t, err := s.service.Get(ctx, TramiteID(request.Id))

	if err != nil {
		errResponse := oapi.GetTramite404ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("Trámite inexistente")
		errResponse.Status = new(int32(404))
		errResponse.Detail = new(err.Error())
		return errResponse, nil
	}

	return oapi.GetTramite200JSONResponse{
		Id:   int(t.ID),
		Name: t.Name,
	}, nil
}

// UpdateTramite implements [oapi.StrictServerInterface].
func (s *Server) UpdateTramite(ctx context.Context, request oapi.UpdateTramiteRequestObject) (oapi.UpdateTramiteResponseObject, error) {
	var t Tramite
	var m TramiteUpdateMask
	validationErrors := []oapi.ErrorDetail{}

	if request.Body.Name != nil {
		m.Name = true
		t.Name = *request.Body.Name
	}
	if request.Body.Description != nil {
		m.Description = true
		t.Description = *request.Body.Description
	}
	if request.Body.ProcedureDescription != nil {
		m.ProcedureDescription = true
		pdValue, err := request.Body.ProcedureDescription.Get()
		if err == nil {
			t.ProcedureDescription = &pdValue
		}
	}
	if request.Body.Status != nil {
		if !request.Body.Status.Valid() {
			validationErrors = append(validationErrors, oapi.ErrorDetail{
				Detail:  "Estado de trámite inválido",
				Pointer: "#/status",
			})
		}
		m.Status = true
		t.Status = string(*request.Body.Status)
	}
	if request.Body.Type != nil {
		m.Type = true
		t.Type = *request.Body.Type
	}

	if len(validationErrors) > 0 {
		valErrResponse := oapi.UpdateTramite422ApplicationProblemPlusJSONResponse{}
		valErrResponse.Title = new("Error de validación")
		valErrResponse.Errors = &validationErrors
		valErrResponse.Status = new(int32(422))
		return valErrResponse, nil
	}

	updated, err := s.service.Update(ctx, TramiteID(request.Id), t, m)
	if err != nil {
		return oapi.UpdateTramite400ApplicationProblemPlusJSONResponse{
			BadRequestApplicationProblemPlusJSONResponse: oapi.BadRequestApplicationProblemPlusJSONResponse{
				Title: new("Solicitud errónea"),
			}}, nil

	}

	return oapi.UpdateTramite200JSONResponse{
		Id:                   int(updated.ID),
		Name:                 updated.Name,
		Description:          &updated.Description,
		ProcedureDescription: updated.ProcedureDescription,
		Status:               new(oapi.TramiteStatus(updated.Status)),
		Type:                 &updated.Type,
	}, nil
}

// DeleteTramite implements [oapi.StrictServerInterface].
func (s *Server) DeleteTramite(ctx context.Context, request oapi.DeleteTramiteRequestObject) (oapi.DeleteTramiteResponseObject, error) {
	err := s.service.Delete(ctx, TramiteID(request.Id))
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
