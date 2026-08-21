package config

import (
	"os"
	"testing"
)

func TestConfig(t *testing.T) {
	oldPort, oldPortExists := os.LookupEnv("PORT")
	defer func() {
		if oldPortExists {
			os.Setenv("PORT", oldPort)
		} else {
			os.Unsetenv("PORT")
		}
	}()
	os.Setenv("PORT", ":8081")
	t.Setenv("JWT_SECRET", "test-secret")

	c, err := Load()
	t.Log(c)
	if err != nil {
		t.Errorf("Expected no error after loading env, got %v", err)
	}
	if c.Host != "http://127.0.0.1" {
		t.Errorf("Expected default Host to be 'http://127.0.0.1', got '%s'", c.Host)
	}
	if c.Port != ":8081" {
		t.Errorf("Expected Port to be ':8081', got '%s'", c.Port)
	}
	if c.AppURL != "https://localhost:8443" {
		t.Errorf("Expected AppURL to be 'https://localhost:8443', got '%s'", c.AppURL)
	}
}
