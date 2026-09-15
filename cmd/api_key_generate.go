package cmd

import (
	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/spf13/cobra"
)

func NewApiKeyGenerateCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "apiKeyGenerate",
		Short: "Generar llave secreta para la API",
		Run:   func(cmd *cobra.Command, args []string) { config.ApiKeyGenerate() },
	}
}
