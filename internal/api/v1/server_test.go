package v1

import (
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestOpenAPIRequestValidatorSecurity(t *testing.T) {
	tests := []struct {
		name       string
		method     string
		path       string
		token      string
		wantStatus int
	}{
		{name: "public route", method: http.MethodGet, path: "/health", wantStatus: http.StatusNoContent},
		{name: "anonymous route", method: http.MethodGet, path: "/tramites", wantStatus: http.StatusNoContent},
		{name: "optional authentication", method: http.MethodGet, path: "/tramites/1", wantStatus: http.StatusNoContent},
		{name: "required authentication", method: http.MethodGet, path: "/me", wantStatus: http.StatusUnauthorized},
		{name: "required delete authentication", method: http.MethodDelete, path: "/tramites/1", wantStatus: http.StatusUnauthorized},
		{name: "invalid required authentication", method: http.MethodGet, path: "/me", token: "invalid", wantStatus: http.StatusUnauthorized},
		{name: "invalid optional authentication", method: http.MethodGet, path: "/tramites/1", token: "invalid", wantStatus: http.StatusNoContent},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			jwtAuth := authn.NewJWTAuth(authn.NewSecretKey())
			handler := authenticatedValidator(t, jwtAuth, http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				w.WriteHeader(http.StatusNoContent)
			}))

			req := httptest.NewRequest(tt.method, tt.path, nil)
			if tt.token != "" {
				req.Header.Set("Authorization", "Bearer "+tt.token)
			}
			res := httptest.NewRecorder()
			handler.ServeHTTP(res, req)

			assert.Equal(t, tt.wantStatus, res.Code)
			if tt.wantStatus == http.StatusUnauthorized {
				assert.Equal(t, "application/problem+json", res.Header().Get("Content-Type"))
				var problem map[string]any
				require.NoError(t, json.Unmarshal(res.Body.Bytes(), &problem))
				assert.Equal(t, float64(http.StatusUnauthorized), problem["status"])
			}
		})
	}
}

func TestOpenAPIRequestValidatorAcceptsHeaderAndCookieJWT(t *testing.T) {
	jwtAuth := authn.NewJWTAuth(authn.NewSecretKey())
	token, err := jwtAuth.IssueUserToken(42)
	require.NoError(t, err)

	for _, transport := range []string{"header", "cookie"} {
		t.Run(transport, func(t *testing.T) {
			handler := authenticatedValidator(t, jwtAuth, http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				principal, ok := authn.FromAuthContext(r.Context())
				require.True(t, ok)
				assert.Equal(t, 42, principal.ID)
				w.WriteHeader(http.StatusNoContent)
			}))

			req := httptest.NewRequest(http.MethodGet, "/me", nil)
			if transport == "header" {
				req.Header.Set("Authorization", "Bearer "+token)
			} else {
				req.AddCookie(&http.Cookie{Name: "jwt", Value: token})
			}
			res := httptest.NewRecorder()
			handler.ServeHTTP(res, req)

			assert.Equal(t, http.StatusNoContent, res.Code)
		})
	}
}

func TestOpenAPIRequestValidatorKeepsOptionalPrincipal(t *testing.T) {
	jwtAuth := authn.NewJWTAuth(authn.NewSecretKey())
	token, err := jwtAuth.IssueUserToken(42)
	require.NoError(t, err)

	handler := authenticatedValidator(t, jwtAuth, http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		principal, ok := authn.FromAuthContext(r.Context())
		require.True(t, ok)
		assert.Equal(t, 42, principal.ID)
		w.WriteHeader(http.StatusNoContent)
	}))
	req := httptest.NewRequest(http.MethodGet, "/tramites", nil)
	req.Header.Set("Authorization", "Bearer "+token)
	res := httptest.NewRecorder()

	handler.ServeHTTP(res, req)

	assert.Equal(t, http.StatusNoContent, res.Code)
}

func TestOpenAPIRequestValidatorValidatesRequestsAndPreservesBody(t *testing.T) {
	jwtAuth := authn.NewJWTAuth(authn.NewSecretKey())
	token, err := jwtAuth.IssueUserToken(42)
	require.NoError(t, err)

	t.Run("invalid query", func(t *testing.T) {
		handler := authenticatedValidator(t, jwtAuth, http.HandlerFunc(func(http.ResponseWriter, *http.Request) {
			t.Fatal("invalid request reached handler")
		}))
		res := httptest.NewRecorder()
		handler.ServeHTTP(res, httptest.NewRequest(http.MethodGet, "/tramites?limit=invalid", nil))

		assert.Equal(t, http.StatusBadRequest, res.Code)
		assert.Equal(t, "application/problem+json", res.Header().Get("Content-Type"))
	})

	t.Run("valid body remains readable", func(t *testing.T) {
		const body = `{"name":"Licencia"}`
		handler := authenticatedValidator(t, jwtAuth, http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			got, readErr := io.ReadAll(r.Body)
			require.NoError(t, readErr)
			assert.JSONEq(t, body, string(got))
			w.WriteHeader(http.StatusNoContent)
		}))
		req := httptest.NewRequest(http.MethodPost, "/tramites", strings.NewReader(body))
		req.Header.Set("Authorization", "Bearer "+token)
		req.Header.Set("Content-Type", "application/json")
		res := httptest.NewRecorder()

		handler.ServeHTTP(res, req)

		assert.Equal(t, http.StatusNoContent, res.Code)
	})
}

func authenticatedValidator(t *testing.T, jwtAuth *authn.JWTAuth, next http.Handler) http.Handler {
	t.Helper()
	validator, err := validationMiddleware("/api/v1")
	require.NoError(t, err)
	return authn.Authenticate(jwtAuth)(validator(next))
}
