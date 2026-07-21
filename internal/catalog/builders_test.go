package catalog

import (
	"strings"
	"testing"
)

func TestListTramitesQuery(t *testing.T) {
	q := ListTramitesQuery(TramiteFilter{
		Status: new(Published),
		Type:   new(Registro),
	}, TramiteSort{
		Field:  TramiteFieldCreatedAt,
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
