package cmd

import (
	"errors"
	"fmt"
	"log"
	"os"

	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/joho/godotenv"
	"github.com/spf13/cobra"
)

func NewApiKeyGenerateCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "apiKeyGenerate",
		Short: "Generar llave secreta para la API",
		Run:   apiKeyGenerate,
	}
}

func apiKeyGenerate(cmd *cobra.Command, args []string) {
	envFile := ".env"
	keyName := "JWT_SECRET"

	env, err := godotenv.Read(envFile)
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		log.Fatalf("Error al leer archivo existente %s: %v", envFile, err)
	}

	env[keyName] = authn.NewSecretKey()

	if err := godotenv.Write(env, envFile); err != nil {
		log.Fatalf("Error al guardar archivo %s: %v", envFile, err)
	}
	fmt.Println("✅ Llave HS256 generada y guardada!")
}
