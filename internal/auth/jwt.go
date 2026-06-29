package auth

import (
	"net/http"
	"strings"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

func JWTMiddleware(svc *domain.Service) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				next.ServeHTTP(w, r)
				return
			}

			parts := strings.SplitN(authHeader, " ", 2)
			if len(parts) != 2 || !strings.EqualFold(parts[0], "bearer") {
				next.ServeHTTP(w, r)
				return
			}

			user, err := svc.ValidateToken(parts[1])
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}

			fullUser, err := svc.GetUser(r.Context(), user.ID)
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}

			ctx := domain.WithUser(r.Context(), fullUser)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}
