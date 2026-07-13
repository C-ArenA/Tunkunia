package authn

import (
	"testing"

	"github.com/C-ArenA/Tunkunia/config"
)

func TestJwtGeneration(t *testing.T) {
	t.Setenv("ENV", "test")
	cfg, err := config.Load()
	if err != nil {
		t.Fatal(err)
	}
	jwtstr, err := generateJWT(cfg.JWTSecret)
	t.Log(jwtstr)
}
