package api

import (
	"context"
	"time"
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

func (a *StrictApiHandler) GetHealth(ctx context.Context, request GetHealthRequestObject) (GetHealthResponseObject, error) {
	if a.Name != "Tunkunia" {
		return GetHealth503JSONResponse{
			Status:    DEGRADED,
			Timestamp: time.Now(),
		}, nil
	}
	return GetHealth200JSONResponse{
		Status:    UP,
		Timestamp: time.Now(),
	}, nil
}
