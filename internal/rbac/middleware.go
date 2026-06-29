package rbac

import (
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
	rbacdomain "github.com/C-ArenA/Tunkunia/internal/rbac/domain"
)

func RequirePermission(svc *rbacdomain.Service, resource, action string) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			user := domain.UserFromContext(r.Context())
			if user == nil {
				http.Error(w, "Unauthorized", http.StatusUnauthorized)
				return
			}

			hasPerm, err := svc.UserHasPermission(r.Context(), user.ID, resource, action)
			if err != nil || !hasPerm {
				http.Error(w, "Forbidden", http.StatusForbidden)
				return
			}

			next.ServeHTTP(w, r)
		})
	}
}
