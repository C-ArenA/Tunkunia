package cmd

import (
	"encoding/json/jsontext"
	"encoding/json/v2"

	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/spf13/cobra"
)

func NewInspectConfigCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "inspectConfig",
		Short: "Muestra la configuración actual del servidor",
		RunE: func(cmd *cobra.Command, args []string) error {
			cfg, err := config.Load()
			if err != nil {
				return err
			}
			b, err := json.Marshal(cfg, jsontext.WithIndent("  "))
			if err != nil {
				return err
			}
			cmd.Println(string(b))
			return nil
		},
	}
}
