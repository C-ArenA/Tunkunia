/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/C-ArenA/Tunkunia/internal/user/domain"
	"github.com/C-ArenA/Tunkunia/internal/user/store"
	"github.com/spf13/cobra"
)

func NewUserCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "user",
		Short: "Comandos que tienen que ver con el usuario",
		Run: func(cmd *cobra.Command, args []string) {
			ctx := context.Background()
			cfg := loadConfig()
			db := initDB(ctx, cfg)
			uRepo := store.NewRepo(db)
			uService := domain.NewService(uRepo)
			email, ok := os.LookupEnv("FIRST_ADMIN_EMAIL")
			if !ok {
				log.Fatalf("No existe correo definido en las variables de entorno")
			}
			newUser, err := uService.CreateFirstAdmin(ctx, email)
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(newUser)
		},
	}
}
