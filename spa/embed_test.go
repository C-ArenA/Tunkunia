package spa

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestHandlerRejectsNonNavigationRequestsAndMethods(t *testing.T) {
	h := Handler()

	req := httptest.NewRequest(http.MethodGet, "/any-unknown-path", nil)
	req.Header.Set("Accept", "application/json")
	res := httptest.NewRecorder()
	h.ServeHTTP(res, req)
	if res.Code != http.StatusNotFound || strings.Contains(res.Body.String(), "<html") {
		t.Fatalf("expected ordinary 404, got %d %q", res.Code, res.Body.String())
	}

	req = httptest.NewRequest(http.MethodPost, "/app", nil)
	res = httptest.NewRecorder()
	h.ServeHTTP(res, req)
	if res.Code != http.StatusMethodNotAllowed {
		t.Fatalf("expected POST 405, got %d", res.Code)
	}
}

func TestHandlerServesAssetsAndClientRoutes(t *testing.T) {
	for _, requestPath := range []string{"/", "/app/casos", "/_nuxt/builds/latest.json"} {
		res := httptest.NewRecorder()
		req := httptest.NewRequest(http.MethodGet, requestPath, nil)
		req.Header.Set("Accept", "text/html")
		Handler().ServeHTTP(res, req)
		if res.Code != http.StatusOK {
			t.Fatalf("GET %s returned %d", requestPath, res.Code)
		}
	}
}
