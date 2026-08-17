package catalog

import (
	"github.com/C-ArenA/Tunkunia/database/jet/table"
	. "github.com/go-jet/jet/v2/sqlite"
)

func ListTramitesQuery(f TramiteFilter, s TramiteSort) SelectStatement {
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
		case TramiteFieldName:
			sortCol = t.Name
		case TramiteFieldCreatedAt:
			sortCol = t.CreatedAt
		case TramiteFieldType:
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
