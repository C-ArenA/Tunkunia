package v1

import (
	"context"
	"log/slog"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/C-ArenA/Tunkunia/internal/authn"
	"github.com/C-ArenA/Tunkunia/internal/cases"
	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/C-ArenA/Tunkunia/internal/health"
	"github.com/C-ArenA/Tunkunia/internal/user"
	"github.com/getkin/kin-openapi/openapi3filter"
	"github.com/go-chi/chi/v5"
	nethttpmiddleware "github.com/oapi-codegen/nethttp-middleware"
)

var _ oapi.StrictServerInterface = (*StrictHandler)(nil)

func NewStrictHandler(healthHandler *health.StrictHealthHandlerV1, catalogHandler *catalog.StrictCatalogHandlerV1, userHandler *user.StrictUserHandlerV1, casesHandler *cases.StrictCasesHandlerV1) *StrictHandler {
	return &StrictHandler{
		StrictHealthHandlerV1:  healthHandler,
		StrictCatalogHandlerV1: catalogHandler,
		StrictUserHandlerV1:    userHandler,
		StrictCasesHandlerV1:   casesHandler,
	}
}

type StrictHandler struct {
	*health.StrictHealthHandlerV1
	*catalog.StrictCatalogHandlerV1
	*user.StrictUserHandlerV1
	*cases.StrictCasesHandlerV1
}

func (h *StrictHandler) RegisterRoutes(r *chi.Mux, baseURL string) {
	r.Route(baseURL, func(r chi.Router) {
		mw, err := validationMiddleware(baseURL)
		if err != nil {
			panic(err)
		}
		r.Use(mw)
		oapi.HandlerFromMux(oapi.NewStrictHandlerWithOptions(h, nil, oapi.StrictHTTPServerOptions{
			RequestErrorHandlerFunc: func(w http.ResponseWriter, _ *http.Request, err error) {
				oapi.Error(w, oapi.NewBadRequestResponse(err.Error()), http.StatusBadRequest)
			},
			ResponseErrorHandlerFunc: handleStrictResponseError,
		}), r)
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
			AuthenticationFunc: func(ctx context.Context, _ *openapi3filter.AuthenticationInput) error {
				if _, ok := authn.FromAuthContext(ctx); !ok {
					return authn.ErrRequiresAuthenticatedUser
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
		oapi.Error(w, oapi.NewUnauthorizedResponse(authn.ErrRequiresAuthenticatedUser.Error()), opts.StatusCode)
	case http.StatusNotFound:
		oapi.Error(w, oapi.NewNotFoundResponse(err.Error()), opts.StatusCode)
	default:
		http.Error(w, http.StatusText(opts.StatusCode), opts.StatusCode)
	}
}

func handleStrictResponseError(w http.ResponseWriter, _ *http.Request, err error) {
	slog.Error("request failed", "error", err)
	oapi.Error(w, oapi.NewInternalErrorResponse("falla interna del servidor"), http.StatusInternalServerError)
}
