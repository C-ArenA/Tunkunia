package authn

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestJwtGeneration(t *testing.T) {
	ja := NewJWTAuth(NewSecretKey())
	require.NotNil(t, ja)

	issuedToken, err := ja.IssueUserToken(2)
	t.Log(issuedToken)
	require.NoError(t, err)
	assert.NotEmpty(t, issuedToken)
	assert.Len(t, strings.Split(issuedToken, "."), 3)
}

func TestJwtVerification(t *testing.T) {
	s := NewJWTAuth(NewSecretKey())
	require.NotNil(t, s)
	dumbNext := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		p, ok := FromAuthContext(r.Context())
		require.True(t, ok)
		assert.Equal(t, 2, p.ID)
		assert.Equal(t, UserPrincipal, p.Type)
	})
	h := Authenticate(s)(dumbNext)
	token, err := s.IssueUserToken(2)
	require.NoError(t, err)
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	req.Header.Set("Authorization", "Bearer "+token)
	h.ServeHTTP(httptest.NewRecorder(), req)
}
