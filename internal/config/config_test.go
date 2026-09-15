package config

import (
	"testing"
)

func TestConfig(t *testing.T) {
	t.Setenv("PORT", ":8081")
	t.Setenv("APP_URL", "https://localhost:8443")
	t.Setenv("DEMO", "true")
	t.Setenv("OIDC_URL", "http://127.0.0.1:5556/dex")
	t.Setenv("OIDC_CLIENT_ID", "tunkunia")
	t.Setenv("OIDC_SECRET", "test-secret")
	t.Setenv("FIRST_ADMIN_EMAIL", "admin@example.com")
	t.Setenv("GOOSE_DBSTRING", "./database/tunkunia.db")

	c, err := Load()
	t.Log(c)
	if err != nil {
		t.Errorf("Expected no error after loading env, got %v", err)
		return
	}
	if c.Port != ":8081" {
		t.Errorf("Expected Port to be ':8081', got '%s'", c.Port)
	}
	if c.AppURL != "https://localhost:8443" {
		t.Errorf("Expected AppURL to be 'https://localhost:8443', got '%s'", c.AppURL)
	}
	if !c.Demo {
		t.Error("Expected Demo to be true")
	}
}
