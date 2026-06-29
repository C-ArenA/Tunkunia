package config

type Config struct {
	Host          string `env:"HOST"`
	Port          string `env:"PORT"`
	Env           string `env:"ENV"`
	GooseDriver   string `env:"GOOSE_DRIVER"`
	GooseDbString string `env:"GOOSE_DBSTRING"`
	JWTKey        string `env:"JWT_KEY"`
}
