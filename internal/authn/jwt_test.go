package authn

import (
	"strings"
	"testing"

	"github.com/C-ArenA/Tunkunia/config"
	"github.com/lestrrat-go/jwx/v4/jwa"
	"github.com/lestrrat-go/jwx/v4/jwt"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestJwtGeneration(t *testing.T) {
	t.Setenv("ENV", "test")
	cfg, err := config.Load()
	if err != nil {
		t.Fatal(err)
	}
	ja := NewJWTAuth(cfg.JWTSecret)
	require.NotNil(t, ja)

	issuedToken, err := ja.Issue()
	t.Log(issuedToken)
	require.Nil(t, err)
	assert.NotEmpty(t, issuedToken)
	assert.Len(t, strings.Split(issuedToken, "."), 3)
	tok, err := jwt.Parse([]byte(issuedToken), jwt.WithKey(jwa.HS256(), []byte("holamundo")))
	if err != nil {
		t.Logf("%T | %v", err, err)
	} else {
		t.Log(tok.Issuer())
	}

}
