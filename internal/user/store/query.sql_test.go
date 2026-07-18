package store

import (
	"testing"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/stretchr/testify/assert"
)

func TestBatchRolesAssignmentQueryGenerator(t *testing.T) {
	s, a := assignManyRolesToUserStmtBuilder([]sqlc.AssignRoleToUserParams{
		{UserID: 1, Role: "admin"},
		{UserID: 1, Role: "citizen"},
	})

	assert.Equal(t, "INSERT INTO user_roles (user_id, role) VALUES (?,?), (?,?) ON CONFLICT DO NOTHING RETURNING role", s, "La query construida no es válida")
	assert.Len(t, a, 4)
	assert.Equal(t, a[1], "admin")

	s, a = assignManyRolesToUserStmtBuilder([]sqlc.AssignRoleToUserParams{})
	assert.Equal(t, "", s)
	assert.Nil(t, a)

}
