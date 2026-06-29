package config

func LoadDefaultConfig() *Config {
	return &Config{
		Host:          "http://localhost",
		Port:          ":8080",
		Env:           "dev",
		GooseDriver:   "sqlite3",
		GooseDbString: "./database/tunkunia.db",
		JWTKey:        "super-secret-jwt-key-change-in-production",
	}
}
