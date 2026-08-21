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
		t.Fatal("query does not reference tramites table")
	}
	if !strings.Contains(a, "SELECT") {
		t.Fatal("query does not use SELECT")
	}
	if !strings.Contains(a, "WHERE") {
		t.Fatal("query does not apply filters")
	}
	if !strings.Contains(a, "ORDER BY") {
		t.Fatal("query does not apply sorting")
	}
}
