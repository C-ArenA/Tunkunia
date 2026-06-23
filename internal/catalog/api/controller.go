package api

//go:generate go tool task default

import (
	"context"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
)

type Controller struct {
	service *domain.Service
}

func NewController(service *domain.Service) *Controller {
	return &Controller{service: service}
}

// GetCatalogHealth implements [StrictServerInterface].
func (c *Controller) GetCatalogHealth(ctx context.Context, request GetCatalogHealthRequestObject) (GetCatalogHealthResponseObject, error) {
	if c.service == nil {
		return GetCatalogHealth503JSONResponse{
			Status:    DOWN,
			Timestamp: time.Now().UTC(),
		}, nil
	}
	return GetCatalogHealth200JSONResponse{
		Status:    UP,
		Timestamp: time.Now().UTC(),
	}, nil
}

// ListTramites implements [StrictServerInterface].
func (c *Controller) ListTramites(ctx context.Context, request ListTramitesRequestObject) (ListTramitesResponseObject, error) {
	tramites, err := c.service.List(ctx)
	if err != nil {
		errResponse := ListTramites500ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("La consulta a la base de datos falló")
		return errResponse, nil
	}
	response := make([]Tramite, len(tramites))
	for i, t := range tramites {
		response[i] = Tramite{
			Id:   int(t.ID),
			Name: t.Name,
		}
	}
	return ListTramites200JSONResponse{
		Data: response,
	}, nil
}

// CreateTramite implements [StrictServerInterface].
func (c *Controller) CreateTramite(ctx context.Context, request CreateTramiteRequestObject) (CreateTramiteResponseObject, error) {
	t, err := c.service.Create(ctx, domain.Tramite{
		Name: request.Body.Name,
	})

	if err != nil {
		errResponse := CreateTramite400ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("No se puede crear un trámite con los datos proporcionados")
		return errResponse, nil
	}

	return CreateTramite201JSONResponse{
		Id:   int(t.ID),
		Name: t.Name,
	}, nil
}

// GetTramite implements [StrictServerInterface].
func (c *Controller) GetTramite(ctx context.Context, request GetTramiteRequestObject) (GetTramiteResponseObject, error) {
	t, err := c.service.Get(ctx, domain.TramiteID(request.Id))

	if err != nil {
		errResponse := GetTramite404ApplicationProblemPlusJSONResponse{}
		errResponse.Title = new("Trámite inexistente")
		errResponse.Status = new(int32(404))
		errResponse.Detail = new(err.Error())
		return errResponse, nil
	}

	return GetTramite200JSONResponse{
		Id:   int(t.ID),
		Name: t.Name,
	}, nil
}

// UpdateTramite implements [StrictServerInterface].
func (c *Controller) UpdateTramite(ctx context.Context, request UpdateTramiteRequestObject) (UpdateTramiteResponseObject, error) {
	var t domain.Tramite
	var m domain.TramiteUpdateMask
	validationErrors := []ErrorDetail{}

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
			validationErrors = append(validationErrors, ErrorDetail{
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
		valErrResponse := UpdateTramite422ApplicationProblemPlusJSONResponse{}
		valErrResponse.Title = new("Error de validación")
		valErrResponse.Errors = &validationErrors
		valErrResponse.Status = new(int32(422))
		return valErrResponse, nil
	}

	updated, err := c.service.Update(ctx, domain.TramiteID(request.Id), t, m)
	if err != nil {
		return UpdateTramite400ApplicationProblemPlusJSONResponse{
			BadRequestApplicationProblemPlusJSONResponse: BadRequestApplicationProblemPlusJSONResponse{
				Title: new("Solicitud errónea"),
			}}, nil

	}

	return UpdateTramite200JSONResponse{
		Id:                   int(updated.ID),
		Name:                 updated.Name,
		Description:          &updated.Description,
		ProcedureDescription: updated.ProcedureDescription,
		Status:               new(TramiteStatus(updated.Status)),
		Type:                 &updated.Type,
	}, nil
}

// DeleteTramite implements [StrictServerInterface].
func (c *Controller) DeleteTramite(ctx context.Context, request DeleteTramiteRequestObject) (DeleteTramiteResponseObject, error) {
	err := c.service.Delete(ctx, domain.TramiteID(request.Id))
	if err != nil {
		return DeleteTramite404ApplicationProblemPlusJSONResponse{
			NotFoundApplicationProblemPlusJSONResponse: NotFoundApplicationProblemPlusJSONResponse{
				Title:  new("No se puede eliminar trámite inexistente"),
				Status: new(int32(404)),
				Detail: new(err.Error()),
			},
		}, nil
	}

	return DeleteTramite204Response{}, nil
}
