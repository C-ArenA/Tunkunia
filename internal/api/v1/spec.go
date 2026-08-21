package v1

import (
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/go-chi/chi/v5"
)

const htmlContent = `
<!doctype html>
<html>
 <head>
   <title>API Reference</title>
   <meta charset="utf-8" />
   <meta
     name="viewport"
     content="width=device-width, initial-scale=1" />
 </head>
 <body>
   <div id="app"></div>
   <!-- Load the Script -->
   <script src="https://cdn.jsdelivr.net/npm/@scalar/api-reference"></script>
   <!-- Initialize the API Reference -->
   <script>
     Scalar.createApiReference('#app', {
       // The URL of the OpenAPI/Swagger document
       url: '/docs/v1',
     })
   </script>
 </body>
</html>
`

func ScalarUI(w http.ResponseWriter, _ *http.Request) {
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write([]byte(htmlContent))
}

func GetSpecs(w http.ResponseWriter, _ *http.Request) {
	specs, err := oapi.GetSpecJSON()
	if err != nil {
		http.Error(w, "No se pudo obtener el JSON del spec openapi: "+err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, _ = w.Write(specs)
}

func RegisterSpecsRoutes(r *chi.Mux, devMode bool) {
	if devMode {
		r.Get("/docs/scalar", ScalarUI)
	}
	r.Get("/docs/v1", GetSpecs)
}
