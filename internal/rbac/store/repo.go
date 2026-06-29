package store

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
	rbacdomain "github.com/C-ArenA/Tunkunia/internal/rbac/domain"
)

type RBACRepo struct {
	db *sql.DB
}

func NewRepo(db *sql.DB) *RBACRepo {
	return &RBACRepo{db: db}
}

func (r *RBACRepo) CreateRole(ctx context.Context, role rbacdomain.Role) (*rbacdomain.Role, error) {
	row := r.db.QueryRowContext(ctx,
		`INSERT INTO roles (name, description, created_at, updated_at)
		 VALUES (?, ?, ?, ?)
		 RETURNING id, name, description, created_at, updated_at`,
		role.Name, role.Description, role.CreatedAt.Format(time.DateTime), role.UpdatedAt.Format(time.DateTime))

	return scanRole(row)
}

func (r *RBACRepo) GetRole(ctx context.Context, id rbacdomain.RoleID) (*rbacdomain.Role, error) {
	row := r.db.QueryRowContext(ctx,
		`SELECT id, name, description, created_at, updated_at
		 FROM roles WHERE id = ?`, int64(id))

	return scanRole(row)
}

func (r *RBACRepo) ListRoles(ctx context.Context) ([]rbacdomain.Role, error) {
	rows, err := r.db.QueryContext(ctx,
		`SELECT id, name, description, created_at, updated_at
		 FROM roles ORDER BY id`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var roles []rbacdomain.Role
	for rows.Next() {
		role, err := scanRole(rows)
		if err != nil {
			return nil, err
		}
		roles = append(roles, *role)
	}
	return roles, rows.Err()
}

func (r *RBACRepo) UpdateRole(ctx context.Context, id rbacdomain.RoleID, role rbacdomain.Role, m rbacdomain.RoleMask) (*rbacdomain.Role, error) {
	query := `UPDATE roles SET `
	args := []interface{}{}
	parts := []string{}

	if m.Name {
		parts = append(parts, "name = ?")
		args = append(args, role.Name)
	}
	if m.Description {
		parts = append(parts, "description = ?")
		args = append(args, role.Description)
	}
	if m.UpdatedAt {
		parts = append(parts, "updated_at = ?")
		args = append(args, role.UpdatedAt.Format(time.DateTime))
	}

	if len(parts) == 0 {
		return r.GetRole(ctx, id)
	}

	for i, p := range parts {
		if i > 0 {
			query += ", "
		}
		query += p
	}
	query += " WHERE id = ? RETURNING id, name, description, created_at, updated_at"
	args = append(args, int64(id))

	row := r.db.QueryRowContext(ctx, query, args...)
	return scanRole(row)
}

func (r *RBACRepo) DeleteRole(ctx context.Context, id rbacdomain.RoleID) error {
	result, err := r.db.ExecContext(ctx, `DELETE FROM roles WHERE id = ?`, int64(id))
	if err != nil {
		return err
	}
	rows, _ := result.RowsAffected()
	if rows == 0 {
		return rbacdomain.ErrNotFound
	}
	return nil
}

func (r *RBACRepo) ListPermissions(ctx context.Context) ([]rbacdomain.Permission, error) {
	rows, err := r.db.QueryContext(ctx,
		`SELECT id, resource, action, description
		 FROM permissions ORDER BY resource, action`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var perms []rbacdomain.Permission
	for rows.Next() {
		var p rbacdomain.Permission
		err := rows.Scan(&p.ID, &p.Resource, &p.Action, &p.Description)
		if err != nil {
			return nil, err
		}
		perms = append(perms, p)
	}
	return perms, rows.Err()
}

func (r *RBACRepo) GetRolePermissions(ctx context.Context, roleID rbacdomain.RoleID) ([]rbacdomain.Permission, error) {
	rows, err := r.db.QueryContext(ctx,
		`SELECT p.id, p.resource, p.action, p.description
		 FROM permissions p
		 JOIN role_permissions rp ON rp.permission_id = p.id
		 WHERE rp.role_id = ?
		 ORDER BY p.resource, p.action`, int64(roleID))
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var perms []rbacdomain.Permission
	for rows.Next() {
		var p rbacdomain.Permission
		err := rows.Scan(&p.ID, &p.Resource, &p.Action, &p.Description)
		if err != nil {
			return nil, err
		}
		perms = append(perms, p)
	}
	return perms, rows.Err()
}

func (r *RBACRepo) SetRolePermissions(ctx context.Context, roleID rbacdomain.RoleID, permissionIDs []rbacdomain.PermissionID) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.ExecContext(ctx, `DELETE FROM role_permissions WHERE role_id = ?`, int64(roleID))
	if err != nil {
		return err
	}

	for _, pid := range permissionIDs {
		_, err = tx.ExecContext(ctx,
			`INSERT INTO role_permissions (role_id, permission_id) VALUES (?, ?)`,
			int64(roleID), int64(pid))
		if err != nil {
			return err
		}
	}

	return tx.Commit()
}

func (r *RBACRepo) GetUserRoles(ctx context.Context, userID domain.UserID) ([]rbacdomain.Role, error) {
	rows, err := r.db.QueryContext(ctx,
		`SELECT r.id, r.name, r.description, r.created_at, r.updated_at
		 FROM roles r
		 JOIN user_roles ur ON ur.role_id = r.id
		 WHERE ur.user_id = ?
		 ORDER BY r.id`, int64(userID))
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var roles []rbacdomain.Role
	for rows.Next() {
		role, err := scanRole(rows)
		if err != nil {
			return nil, err
		}
		roles = append(roles, *role)
	}
	return roles, rows.Err()
}

func (r *RBACRepo) SetUserRoles(ctx context.Context, userID domain.UserID, roleIDs []rbacdomain.RoleID) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	_, err = tx.ExecContext(ctx, `DELETE FROM user_roles WHERE user_id = ?`, int64(userID))
	if err != nil {
		return err
	}

	for _, rid := range roleIDs {
		_, err = tx.ExecContext(ctx,
			`INSERT INTO user_roles (user_id, role_id) VALUES (?, ?)`,
			int64(userID), int64(rid))
		if err != nil {
			return err
		}
	}

	return tx.Commit()
}

func (r *RBACRepo) UserHasPermission(ctx context.Context, userID domain.UserID, resource, action string) (bool, error) {
	var count int
	err := r.db.QueryRowContext(ctx,
		`SELECT COUNT(*)
		 FROM user_roles ur
		 JOIN role_permissions rp ON rp.role_id = ur.role_id
		 JOIN permissions p ON p.id = rp.permission_id
		 WHERE ur.user_id = ? AND p.resource = ? AND p.action = ?`,
		int64(userID), resource, action).Scan(&count)
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

type scannable interface {
	Scan(dest ...any) error
}

func scanRole(row scannable) (*rbacdomain.Role, error) {
	var r rbacdomain.Role
	var createdAt, updatedAt string

	err := row.Scan(&r.ID, &r.Name, &r.Description, &createdAt, &updatedAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, rbacdomain.ErrNotFound
		}
		return nil, err
	}

	r.CreatedAt, _ = time.Parse(time.DateTime, createdAt)
	r.UpdatedAt, _ = time.Parse(time.DateTime, updatedAt)

	return &r, nil
}
