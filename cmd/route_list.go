/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/spf13/cobra"
)

func NewRouteListCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "routeList",
		Short: "Lista todas las rutas del servidor",
		Run: func(cmd *cobra.Command, args []string) {
			ctx := context.Background()
			_, r, _ := initServer(ctx)
			chi.Walk(r, func(method, route string, handler http.Handler, middlewares ...func(http.Handler) http.Handler) error {
				log.Printf("[%s]:\t'%s'\thas %d middlewares\n", method, route, len(middlewares))
				return nil
			})
		},
	}
}
