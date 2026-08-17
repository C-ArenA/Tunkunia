package public

import (
	_ "embed"
	"html/template"
	"net/http"

	"github.com/C-ArenA/Tunkunia/internal/catalog"
	"github.com/go-chi/chi/v5"
)

//go:embed home.html
var homeHtml string

type Institution struct {
	Name        string
	Description string
	Tramites    []catalog.Tramite
}

func RegisterRoutes(r *chi.Mux, cs *catalog.Service) {
	tmpl := template.Must(template.New("home").Parse(homeHtml))
	r.Get("/docs/home", func(w http.ResponseWriter, r *http.Request) {
		t, err := cs.List(r.Context())
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
		if err := tmpl.Execute(w, Institution{
			Name:        "Ministerio de la Verdad",
			Description: "Sistema de Trámites Tunkunia para el ministerio de la verdad",
			Tramites:    t,
		}); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	})
}
