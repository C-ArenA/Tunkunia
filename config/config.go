package config

import (
	"fmt"
	"os"

	"github.com/caarlos0/env/v11"
	"github.com/joho/godotenv"
)

type Config struct {
	Host          string `env:"HOST"`
	Port          string `env:"PORT"`
	Env           string `env:"ENV"`
	GooseDriver   string `env:"GOOSE_DRIVER"`
	GooseDbString string `env:"GOOSE_DBSTRING"`
	AppName       string
}

func NewConfig() *Config {
	return &Config{
		Host:    "http://localhost",
		Port:    ":8080",
		Env:     "dev",
		AppName: "Tunkunia",
	}
}

func Load() (*Config, error) {
	environment := "dev"
	if v, ok := os.LookupEnv("ENV"); ok {
		environment = v
	}
	_ = godotenv.Load()
	_ = godotenv.Load(".env." + environment)

	c := NewConfig()
	c.Env = environment
	if err := env.Parse(c); err != nil {
		return nil, fmt.Errorf("No se pudo cargar la configuración del entorno: %w", err)
	}
	return c, nil
}
