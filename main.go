/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package main

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
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}
