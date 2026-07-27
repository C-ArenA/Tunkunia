package config

import (
	"fmt"
	"log"
	"os"

	"github.com/caarlos0/env/v11"
	"github.com/joho/godotenv"
)

type RoutesConfig struct {
	OidcRedirect string `env:"OIDC_REDIRECT" envDefault:"/login"`
	OidcCallback string `env:"OIDC_CALLBACK" envDefault:"/callback"`
	ApiV1        string `env:"API_V1" envDefault:"/api/v1"`
}

type Config struct {
	AppName       string       `env:"APP_NAME" envDefault:"Tunkunia"`
	AppURL        string       `env:"APP_URL" envDefault:"https://tunkunia.localhost"`
	Host          string       `env:"HOST" envDefault:"http://127.0.0.1"`
	Port          string       `env:"PORT" envDefault:":8080"`
	DevNuxtPort   string       `env:"DEV_NUXT_PORT" envDefault:":3000"`
	Env           string       `env:"ENV" envDefault:"dev"`
	GooseDriver   string       `env:"GOOSE_DRIVER" envDefault:"sqlite3"`
	GooseDbString string       `env:"GOOSE_DBSTRING" envDefault:"./database/tunkunia.db"`
	JWTSecret     string       `env:"JWT_SECRET,notEmpty"`
	OidcURL       string       `env:"OIDC_URL" envDefault:"http://127.0.0.1:5556/dex"`
	OidcClientID  string       `env:"OIDC_CLIENT_ID" envDefault:"tunkunia"`
	OidcSecret    string       `env:"OIDC_SECRET" envDefault:"ZXhhbXBsZS1hcHAtc2VjcmV0"`
	Route         RoutesConfig `envPrefix:"ROUTE_"`
}

func Load() (*Config, error) {
	environment := "dev"
	if v, ok := os.LookupEnv("ENV"); ok {
		environment = v
	}
	_ = godotenv.Load()
	_ = godotenv.Load(".env." + environment)

	c := &Config{}
	if err := env.Parse(c); err != nil {
		return nil, fmt.Errorf("No se pudo cargar la configuración del entorno: %w", err)
	}
	log.Printf("Configuración cargada:\n%+v\n", *c)
	return c, nil
}
