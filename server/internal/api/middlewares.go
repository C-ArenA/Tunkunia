package api

import (
	"log"
	"net/http"
	"time"
)

type Middleware interface {
	apply(http.Handler) http.Handler
}

func ApplyMiddlewares(next http.Handler, middlewares []Middleware) http.Handler {
	for i := len(middlewares) - 1; i >= 0; i-- {
		next = middlewares[i].apply(next)
	}
	return next
}

type CorsMiddleware struct {
	Environment string
}

func (c CorsMiddleware) apply(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if c.Environment == "development" {
			w.Header().Set("Access-Control-Allow-Origin", "*")
			w.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
			w.Header().Set("Access-Control-Allow-Headers", "Content-Type, X-TUNKUNIA-KEY")
		}
		if r.Method == "OPTIONS" {
			return
		}
		next.ServeHTTP(w, r)
	})
}

type LoggingMiddleware struct{}

func (l LoggingMiddleware) apply(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		log.Printf("Requested: %s %s From Origin: %s", r.Method, r.URL.Path, r.Header.Get("Origin"))
		next.ServeHTTP(w, r)
		log.Printf("Handled in %s", time.Since(start))
	})
}

type AuthMiddleware struct{}

func (a AuthMiddleware) apply(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("Checking Authentication\n")
		apiKey := r.Header.Get("X-TUNKUNIA-KEY")
		if apiKey != "4354" {
			http.Error(w, "Unauthorized", http.StatusUnauthorized)
			return
		}
		next.ServeHTTP(w, r)
	})
}
