package store

import (
	"strings"
	"testing"

	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
)

func TestListTramitesQuery(t *testing.T) {
	q := ListTramitesQuery(domain.TramiteFilter{
		Status: new(domain.Published),
		Type:   new(domain.Registro),
	}, domain.TramiteSort{
		Field:  domain.TramiteFieldCreatedAt,
		IsDesc: true,
	})
	a, _ := q.Sql()
	if !strings.Contains(a, "FROM tramites") {
		t.Fatal("La query no invoca a la tabla tramites")
	}
	if !strings.Contains(a, "SELECT") {
		t.Fatal("La query no usa un SELECT")
	}
	if !strings.Contains(a, "WHERE") {
		t.Fatal("La query no aplica filtros")
	}
	if !strings.Contains(a, "ORDER BY") {
		t.Fatal("La query no aplica sorting")
	}
}
