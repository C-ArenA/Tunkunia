package cmd

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

func NewApiKeyGenerateCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "apiKeyGenerate",
		Short: "Generar llave secreta para la API",
		Run:   apiKeyGenerate,
	}
}

func createSecretKey() string {
	secretBytes := make([]byte, 32)
	if _, err := io.ReadFull(rand.Reader, secretBytes); err != nil {
		fmt.Printf("❌ Error generating random bytes: %v\n", err)
		os.Exit(1)
	}
	return hex.EncodeToString(secretBytes)
}

func apiKeyGenerate(cmd *cobra.Command, args []string) {
	envFile := ".env"
	keyName := "JWT_SECRET"
	newLine := fmt.Sprintf("%s=\"%s\"", keyName, createSecretKey())

	originalEnvData, err := os.ReadFile(envFile)
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		log.Fatalf("❌ Error reading existing .env file: %v", err)
	}

	var content []string
	updated := false
	if len(originalEnvData) > 0 {
		content = strings.Split(string(originalEnvData), "\n")
		for i := range content {
			trimmed := strings.TrimSpace(content[i])
			if strings.HasPrefix(trimmed, keyName+"=") {
				content[i] = newLine
				updated = true
			}
		}
	}
	if !updated {
		content = append(content, newLine)
	}

	if err := os.WriteFile(envFile, []byte(strings.Join(content, "\n")), 0644); err != nil {
		log.Fatalf("❌ Error writing to %s file: %v\n", envFile, err)
	}

	fmt.Println("✅ Successfully generated HS256-compliant key!")
}
