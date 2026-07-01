package store

import (
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	"github.com/C-ArenA/Tunkunia/internal/catalog/domain"
	. "github.com/go-jet/jet/v2/sqlite"
)

func ListTramitesQuery(f domain.TramiteFilter, s domain.TramiteSort) SelectStatement {
	t := table.Tramites
	filter := Bool(true)
	if f.Status != nil {
		filter = filter.AND(t.Status.EQ(String(string(*f.Status))))
	}
	if f.Type != nil {
		filter = filter.AND(t.Type.EQ(String(string(*f.Type))))
	}

	q := SELECT(t.AllColumns).FROM(t).WHERE(filter)

	if s.Field.IsValid() {
		var sortCol Column
		switch s.Field {
		case domain.TramiteFieldName:
			sortCol = t.Name
		case domain.TramiteFieldCreatedAt:
			sortCol = t.CreatedAt
		case domain.TramiteFieldType:
			sortCol = t.Type
		}

		if s.IsDesc {
			q = q.ORDER_BY(sortCol.DESC())
		} else {
			q = q.ORDER_BY(sortCol.ASC())
		}
	}
	return q
}
