package store

import (
	"context"
	"database/sql"
	"errors"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

type AuthRepo struct {
	db *sql.DB
}

func NewRepo(db *sql.DB) *AuthRepo {
	return &AuthRepo{db: db}
}

func (r *AuthRepo) Create(ctx context.Context, u domain.User) (*domain.User, error) {
	row := r.db.QueryRowContext(ctx,
		`INSERT INTO users (email, password_hash, name, created_at, updated_at)
		 VALUES (?, ?, ?, ?, ?)
		 RETURNING id, email, password_hash, name, created_at, updated_at`,
		u.Email, u.PasswordHash, u.Name, u.CreatedAt.Format(time.DateTime), u.UpdatedAt.Format(time.DateTime))

	return scanUser(row)
}

func (r *AuthRepo) GetByID(ctx context.Context, id domain.UserID) (*domain.User, error) {
	row := r.db.QueryRowContext(ctx,
		`SELECT id, email, password_hash, name, created_at, updated_at
		 FROM users WHERE id = ?`, int64(id))

	return scanUser(row)
}

func (r *AuthRepo) GetByEmail(ctx context.Context, email string) (*domain.User, error) {
	row := r.db.QueryRowContext(ctx,
		`SELECT id, email, password_hash, name, created_at, updated_at
		 FROM users WHERE email = ?`, email)

	return scanUser(row)
}

func (r *AuthRepo) List(ctx context.Context) ([]domain.User, error) {
	rows, err := r.db.QueryContext(ctx,
		`SELECT id, email, password_hash, name, created_at, updated_at
		 FROM users ORDER BY id`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []domain.User
	for rows.Next() {
		u, err := scanUser(rows)
		if err != nil {
			return nil, err
		}
		users = append(users, *u)
	}
	return users, rows.Err()
}

type scannable interface {
	Scan(dest ...any) error
}

func scanUser(row scannable) (*domain.User, error) {
	var u domain.User
	var createdAt, updatedAt string

	err := row.Scan(&u.ID, &u.Email, &u.PasswordHash, &u.Name, &createdAt, &updatedAt)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, domain.ErrNotFound
		}
		return nil, err
	}

	u.CreatedAt, _ = time.Parse(time.DateTime, createdAt)
	u.UpdatedAt, _ = time.Parse(time.DateTime, updatedAt)

	return &u, nil
}
