package user

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/cast"
)

func NewSqliteStore(db *sql.DB, q *sqlc.Queries) *sqliteStore {
	return &sqliteStore{
		db: db,
		q:  &Queries{q},
	}
}

var _ Repo = (*sqliteStore)(nil)

type sqliteStore struct {
	db *sql.DB
	q  *Queries
}

func (s *sqliteStore) GetUserById(ctx context.Context, id UserId) (*User, error) {
	user, err := s.q.GetUserById(ctx, s.db, int64(id))
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener usuario con id '%d': %w", int(id), err)
	}

	roles, err := s.q.GetUserRoles(ctx, s.db, user.ID)
	if err != nil {
		return nil, fmt.Errorf("No se pudieron obtener roles para el usuario '%d': %w", int(id), err)
	}

	return new(ToDomainUser(user, roles)), nil
}

// GetUserByEmail implements [Repo].
func (s *sqliteStore) GetUserByEmail(ctx context.Context, email Email) (*User, error) {
	user, err := s.q.GetUserByEmail(ctx, s.db, string(email))
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener usuario con correo '%s': %w", email, err)
	}

	roles, err := s.q.GetUserRoles(ctx, s.db, user.ID)
	if err != nil {
		return nil, fmt.Errorf("No se pudieron obtener roles para el usuario '%s': %w", email, err)
	}

	return new(ToDomainUser(user, roles)), nil
}

// IsRoleInUse implements [Repo].
func (s *sqliteStore) IsRoleInUse(ctx context.Context, role RoleName) (bool, error) {
	return s.q.IsRoleInUse(ctx, s.db, string(role))
}

// SaveUser implements [domain.Repo].
func (s *sqliteStore) SaveUser(ctx context.Context, u User) (*User, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	savedUser, err := s.q.UpsertUser(ctx, tx, NewUserUpsertParamsFromDomain(u))
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con correo '%s': %w", u.Email, err)
	}

	roleAssignments := make([]sqlc.AssignRoleToUserParams, len(u.Roles))
	for i, role := range u.Roles {
		roleAssignments[i] = sqlc.AssignRoleToUserParams{UserID: savedUser.ID, Role: string(role)}
	}

	if err = s.q.RemoveUserRoles(ctx, tx, int64(savedUser.ID)); err != nil {
		return nil, fmt.Errorf("No pudo quitarse roles antiguos para repoblar roles actuales: %w", err)
	}
	savedRoles, err := s.q.AssignManyRolesToUser(ctx, tx, roleAssignments)
	if err != nil {
		return nil, fmt.Errorf("No pudo asignarse roles al usuario con correo '%s': %w", savedUser.Email, err)
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return new(ToDomainUser(savedUser, savedRoles)), nil
}

func (s *sqliteStore) UpsertUserBySub(ctx context.Context, u User) (*User, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	savedUser, err := s.q.UpsertUserBySub(ctx, tx, sqlc.UpsertUserBySubParams{
		Name:          u.Name,
		Sub:           u.Sub,
		Email:         string(u.Email),
		EmailVerified: cast.BoolToSqlite(u.EmailVerified),
	})
	if err != nil {
		return nil, fmt.Errorf("No se pudo guardar el usuario con sub '%s': %w", u.Sub, err)
	}

	var roles []string
	if savedUser.CreatedAt != savedUser.UpdatedAt {
		roles, err = s.q.GetUserRoles(ctx, s.db, savedUser.ID)
		if err != nil {
			return nil, fmt.Errorf("No se pudieron obtener roles para el usuario '%s': %w", savedUser.Email, err)
		}
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return new(ToDomainUser(savedUser, roles)), nil
}

func (s *sqliteStore) AssignRoleToUser(ctx context.Context, userId UserId, role RoleName) error {
	return s.q.AssignRoleToUser(ctx, s.db, sqlc.AssignRoleToUserParams{
		UserID: int64(userId),
		Role:   string(role),
	})
}

func (s *sqliteStore) ListUsers(ctx context.Context) ([]User, error) {
	rows, err := s.db.QueryContext(ctx, `SELECT id FROM users ORDER BY name, id`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var ids []UserId
	for rows.Next() {
		var id UserId
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	users := make([]User, 0, len(ids))
	for _, id := range ids {
		u, err := s.GetUserById(ctx, id)
		if err != nil {
			return nil, err
		}
		users = append(users, *u)
	}
	return users, nil
}

func (s *sqliteStore) ReplaceRoles(ctx context.Context, userId UserId, roles []RoleName) (*User, error) {
	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()
	var exists int
	if err := tx.QueryRowContext(ctx, `SELECT EXISTS(SELECT 1 FROM users WHERE id=?)`, userId).Scan(&exists); err != nil {
		return nil, err
	}
	if exists == 0 {
		return nil, sql.ErrNoRows
	}
	if _, err := tx.ExecContext(ctx, `DELETE FROM user_roles WHERE user_id=?`, userId); err != nil {
		return nil, err
	}
	for _, role := range roles {
		if role != ADMIN && role != SERVANT {
			return nil, fmt.Errorf("rol global inválido: %s", role)
		}
		if _, err := tx.ExecContext(ctx, `INSERT INTO user_roles(user_id,role) VALUES(?,?)`, userId, role); err != nil {
			return nil, err
		}
	}
	if err := tx.Commit(); err != nil {
		return nil, err
	}
	return s.GetUserById(ctx, userId)
}
