package health

import (
	"context"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
)

type StrictApiHandler struct {
	Name   string `json:"name"`
	Author string `json:"author"`
}

func NewStrictApiHandler() *StrictApiHandler {
	return &StrictApiHandler{
		Name:   "Tunkunia",
		Author: "Ernesto Carlos Arena Alarcon",
	}
}

func (a *StrictApiHandler) GetHealth(ctx context.Context, request oapi.GetHealthRequestObject) (oapi.GetHealthResponseObject, error) {
	if a.Name != "Tunkunia" {
		return oapi.GetHealth503JSONResponse{
			Status:    oapi.DEGRADED,
			Timestamp: time.Now(),
		}, nil
	}
	return oapi.GetHealth200JSONResponse{
		Status:    oapi.UP,
		Timestamp: time.Now(),
	}, nil
}
