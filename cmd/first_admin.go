package cmd

import (
	"context"
	"fmt"
	"os"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/spf13/cobra"
)

func NewFirstAdminCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "firstAdmin",
		Short: "Creación del primer usuario administrador",
		Run: func(cmd *cobra.Command, args []string) {
			ctx := context.Background()
			cfg := loadConfig()
			db := initDB(ctx, cfg.GooseDbString, cfg.Env == "dev")
			userService := user.NewService(db, sqlc.New())
			createFirstAdmin(ctx, userService)
		},
	}
}

func createFirstAdmin(ctx context.Context, userService *user.Service) {
	const skipMessage = "Saltando creación de primer usuario administrador"
	email, ok := os.LookupEnv("FIRST_ADMIN_EMAIL")
	if !ok || email == "" {
		fmt.Printf("%s: Variable de Entorno 'FIRST_ADMIN_EMAIL' indefinida\n", skipMessage)
		return
	}
	dEmail, err := user.NewEmail(email)
	if err != nil {
		fmt.Printf("%s: Variable de Entorno 'FIRST_ADMIN_EMAIL' con formato no válido\n", skipMessage)
		return
	}
	newUser, err := userService.CreateFirstAdmin(ctx, dEmail)
	if err != nil {
		fmt.Printf("%s: %v\n", skipMessage, err.Error())
		return
	}
	fmt.Printf("Primer usuario administrador creado con correo '%s' e ID '%v'. Debe ingresar usando el navegador para completar sus datos y confirmar sus permisos\n", newUser.Email, newUser.ID)
}
