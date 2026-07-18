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

	c, err := Load()
	t.Log(c)
	if err != nil {
		t.Errorf("Expected no error after loading env, got %v", err)
	}
	if c.Host != "http://localhost" {
		t.Errorf("Expected default Host to be 'http://localhost', got '%s'", c.Host)
	}
	if c.Port != ":8081" {
		t.Errorf("Expected Port to be ':8081', got '%s'", c.Port)
	}
}
