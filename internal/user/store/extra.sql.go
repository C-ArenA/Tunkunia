package store

import (
	"context"
	"fmt"
	"strings"
)

func assignManyRolesToUserStmtBuilder(assignments []AssignRoleToUserParams) (string, []any) {
	valueStrings := make([]string, 0, len(assignments))
	valueArgs := make([]any, 0, len(assignments)*2)
	if len(assignments) < 1 {
		return "", nil
	}

	for _, assignment := range assignments {
		valueStrings = append(valueStrings, "(?,?)")
		valueArgs = append(valueArgs, assignment.UserID)
		valueArgs = append(valueArgs, assignment.Role)
	}
	stmt := fmt.Sprintf("INSERT INTO user_roles (user_id, role) VALUES %s ON CONFLICT DO NOTHING RETURNING role", strings.Join(valueStrings, ", "))
	return stmt, valueArgs
}

func (q *Queries) AssignManyRolesToUser(ctx context.Context, arg []AssignRoleToUserParams) ([]string, error) {
	stmt, args := assignManyRolesToUserStmtBuilder(arg)
	if stmt == "" {
		return nil, nil
	}

	rows, err := q.db.QueryContext(ctx, stmt, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var createdRoles []string
	for rows.Next() {
		var createdRole string
		if err := rows.Scan(&createdRole); err != nil {
			return nil, err
		}
		createdRoles = append(createdRoles, createdRole)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return createdRoles, nil
}
