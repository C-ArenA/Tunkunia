package api

import (
	"context"
	"net/http"

	"github.com/rs/cors"
)

func CorsMiddleware(appURL string) func(http.Handler) http.Handler {
	return cors.New(cors.Options{
		AllowedOrigins:   []string{appURL},
		AllowedMethods:   []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodPatch, http.MethodDelete},
		AllowedHeaders:   []string{"*"},
		AllowCredentials: true,
		Debug:            true,
	}).Handler
}

func ConfigMiddleware(demo bool) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			ctx := NewDemoContext(r.Context(), demo)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

type contextKey string

var (
	demoCtxKey contextKey = "demo"
)

func NewDemoContext(ctx context.Context, demo bool) context.Context {
	return context.WithValue(ctx, demoCtxKey, demo)
}

func FromDemoContext(ctx context.Context) bool {
	demo, ok := ctx.Value(demoCtxKey).(bool)
	if !ok {
		return false
	}
	return demo
}
