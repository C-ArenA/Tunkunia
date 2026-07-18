package authn

import (
	"net/http"
	"net/http/httptest"
	"strconv"
	"strings"
	"testing"

	"github.com/C-ArenA/Tunkunia/internal/config"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestJwtGeneration(t *testing.T) {
	cfg := LoadTestingConfig(t)
	ja := NewJWTService(cfg.JWTSecret)
	require.NotNil(t, ja)

	issuedToken, err := ja.Issue("2")
	t.Log(issuedToken)
	require.Nil(t, err)
	assert.NotEmpty(t, issuedToken)
	assert.Len(t, strings.Split(issuedToken, "."), 3)
}

func TestJwtVerification(t *testing.T) {
	cfg := LoadTestingConfig(t)
	s := NewJWTService(cfg.JWTSecret)
	require.NotNil(t, s)
	sub := "2"
	dumbNext := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		userId, err := FromAuthContext(r.Context())
		assert.Nil(t, err)
		assert.Equal(t, sub, strconv.FormatInt(int64(userId), 10))
	})
	h := Verifier(s)(dumbNext)
	token, _ := s.Issue(sub)
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	req.Header.Set("Authorization", "Bearer "+token)
	h.ServeHTTP(http.ResponseWriter(nil), req)
}

func LoadTestingConfig(t *testing.T) *config.Config {
	t.Helper()
	t.Setenv("ENV", "test")
	cfg, err := config.Load()
	if err != nil {
		t.Fatal(err)
	}
	return cfg
}
