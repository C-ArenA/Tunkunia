package main

//go:generate go tool sqlc generate
//go:generate go tool jet -source=sqlite -dsn=./database/tunkunia.db -path=./database/jet
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
