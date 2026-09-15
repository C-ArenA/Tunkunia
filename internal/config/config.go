package config

import (
	"errors"
	"fmt"
	"os"

	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/caarlos0/env/v11"
	"github.com/joho/godotenv"
)

type RoutesConfig struct {
	OidcRedirect string `env:"OIDC_REDIRECT" envDefault:"/login"`
	OidcCallback string `env:"OIDC_CALLBACK" envDefault:"/callback"`
	ApiV1        string `env:"API_V1" envDefault:"/api/v1"`
}

type Config struct {
	AppURL          string       `env:"APP_URL,required,notEmpty"`
	Port            string       `env:"PORT" envDefault:":8080"`
	Debug           bool         `env:"DEBUG" envDefault:"false"`
	Demo            bool         `env:"DEMO" envDefault:"false"`
	DbString        string       `env:"GOOSE_DBSTRING,required,notEmpty"`
	JWTSecret       string       `env:"JWT_SECRET"`
	OidcURL         string       `env:"OIDC_URL,required"`
	OidcClientID    string       `env:"OIDC_CLIENT_ID,required"`
	OidcSecret      string       `env:"OIDC_SECRET,required"`
	FirstAdminEmail user.Email   `env:"FIRST_ADMIN_EMAIL,required,notEmpty"`
	Route           RoutesConfig `envPrefix:"ROUTE_"`
}

// Load reads .env before parsing the application configuration.
func Load() (*Config, error) {
	if err := godotenv.Load(); err != nil && !errors.Is(err, os.ErrNotExist) {
		return nil, fmt.Errorf("no se pudo leer .env: %w", err)
	}
	c := &Config{}
	if err := env.Parse(c); err != nil {
		return nil, fmt.Errorf("no se pudo cargar la configuración: %w", err)
	}
	if c.JWTSecret == "" {
		fmt.Println("No existe llave secreta para JWT. Se creará una nueva")
		JWTSecret, err := ApiKeyGenerate()
		if err != nil {
			return nil, fmt.Errorf("no se pudo generar la llave JWT: %w", err)
		}
		c.JWTSecret = JWTSecret
	}
	return c, nil
}

func ApiKeyGenerate() (string, error) {
	envFile := ".env"
	keyName := "JWT_SECRET"

	env, err := godotenv.Read(envFile)
	if err != nil && !errors.Is(err, os.ErrNotExist) {
		return "", fmt.Errorf("archivo %s existente no pudo leerse %w", envFile, err)
	}

	env[keyName] = authn.NewSecretKey()

	if err := godotenv.Write(env, envFile); err != nil {
		return "", fmt.Errorf("archivo %s no pudo guardarse %w", envFile, err)
	}
	fmt.Println("✅ Nueva llave HS256 generada y guardada!")
	return env[keyName], nil
}
