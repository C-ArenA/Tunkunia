package main

//go:generate go tool sqlc generate
//go:generate go tool jet -source=sqlite -dsn=./database/tunkunia.db -path=./database/jet
//go:generate pnpm exec redocly bundle ./specs/v1/openapi.yaml --output ./specs/v1.openapi.yaml
//go:generate pnpm exec redocly lint ./specs/v1.openapi.yaml
//go:generate go tool oapi-codegen -config ./internal/api/v1/oapi/oapi.cfg.yaml -o ./internal/api/v1/oapi/oapi.gen.go ./specs/v1.openapi.yaml
//go:generate go tool oapi-codegen -config ./internal/api/v1/oapi/models.cfg.yaml -o ./internal/api/v1/oapi/models.oapi.gen.go ./specs/v1.openapi.yaml

import (
	"os"

	"github.com/C-ArenA/Tunkunia/cmd"
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "Tunkunia",
	Short: "Sistema de Gestión de Flujos de Trámite",
}

func main() {
	rootCmd.AddCommand(cmd.NewServeCmd())
	rootCmd.AddCommand(cmd.NewRouteListCmd())
	rootCmd.AddCommand(cmd.NewFirstAdminCmd())
	rootCmd.AddCommand(cmd.NewApiKeyGenerateCmd())
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
