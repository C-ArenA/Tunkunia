package v1

import (
	"context"
	"errors"
	"fmt"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/health"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/getkin/kin-openapi/openapi3filter"
	"github.com/go-chi/chi/v5"
	nethttpmiddleware "github.com/oapi-codegen/nethttp-middleware"
)

var errRequiresAuthenticatedUser = errors.New("Requires authenticated user")

var _ oapi.StrictServerInterface = (*StrictHandler)(nil)

func NewStrictHandler(catalogService *catalog.Service, userService *user.Service) *StrictHandler {
	return &StrictHandler{
		health.NewStrictApiHandler(),
		catalog.NewStrictApiHandler(catalogService),
		authn.NewStrictHandler(userService),
	}
}

type StrictHandler struct {
	*health.StrictApiHandler
	*catalog.StrictCatalogHandlerV1
	*authn.StrictHandler
}

func (h *StrictHandler) RegisterRoutes(r *chi.Mux, baseURL string) {
	r.Route(baseURL, func(r chi.Router) {
		mw, err := validationMiddleware(baseURL)
		if err != nil {
			panic(err)
		}
		r.Use(mw)
		oapi.HandlerFromMux(oapi.NewStrictHandler(h, nil), r)
	})
}

func validationMiddleware(baseURL string) (func(http.Handler) http.Handler, error) {
	spec, err := oapi.GetSpec()
	if err != nil {
		return nil, err
	}

	return nethttpmiddleware.OapiRequestValidatorWithOptions(spec, &nethttpmiddleware.Options{
		DoNotValidateServers: true,
		Prefix:               baseURL,
		Options: openapi3filter.Options{
			AuthenticationFunc: func(ctx context.Context, ai *openapi3filter.AuthenticationInput) error {
				fmt.Println("Validando autenticación")
				if _, ok := authn.FromAuthContext(ctx); !ok {
					return errRequiresAuthenticatedUser
				}
				return nil
			},
		},
		ErrorHandlerWithOpts: handleOpenAPIValidationError,
	}), nil
}

// handleOpenAPIValidationError handles OpenAPI validation errors by returning a custom HTTP error response.
func handleOpenAPIValidationError(_ context.Context, err error, w http.ResponseWriter, _ *http.Request, opts nethttpmiddleware.ErrorHandlerOpts) {
	switch opts.StatusCode {
	case http.StatusBadRequest:
		oapi.Error(w, oapi.NewBadRequestResponse(err.Error()), opts.StatusCode)
	case http.StatusUnauthorized:
		oapi.Error(w, oapi.NewUnauthorizedResponse(errRequiresAuthenticatedUser.Error()), opts.StatusCode)
	case http.StatusNotFound:
		fmt.Println("ajjaaaa")
		oapi.Error(w, oapi.NewNotFoundResponse(err.Error()), opts.StatusCode)
	default:
		http.Error(w, http.StatusText(opts.StatusCode), opts.StatusCode)
	}
}
