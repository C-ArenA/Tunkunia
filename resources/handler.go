package resources

import (
	"embed"
	"io/fs"
	"net/http"

	"github.com/C-ArenA/Tunkunia/resources/components"
	"github.com/a-h/templ"
	"github.com/go-chi/chi/v5"
)

//go:embed static
var staticEmbeddedFS embed.FS

func RegisterRoutes(r *chi.Mux) {
	r.Get("/", templ.Handler(components.Home(components.Institution{
		Name:        "Ministerio de la verdadera",
		Description: "Lo que sea por lelelelera",
	})).ServeHTTP)

	staticFS, _ := fs.Sub(staticEmbeddedFS, "static")
	fileServer := http.FileServerFS(staticFS)
	r.Handle("/static/*", http.StripPrefix("/static", fileServer))
}
