package domain

import (
	"context"
	"errors"
	"time"
)

type UserID int64

type User struct {
	ID           UserID
	Email        string
	PasswordHash string
	Name         string
	CreatedAt    time.Time
	UpdatedAt    time.Time
}

type UserMask struct {
	ID           bool
	Email        bool
	PasswordHash bool
	Name         bool
	CreatedAt    bool
	UpdatedAt    bool
}

type contextKey string

const userContextKey contextKey = "auth.user"

func WithUser(ctx context.Context, user *User) context.Context {
	return context.WithValue(ctx, userContextKey, user)
}

func UserFromContext(ctx context.Context) *User {
	user, _ := ctx.Value(userContextKey).(*User)
	return user
}

var ErrNotFound = errors.New("Usuario no encontrado")
var ErrInvalidCredentials = errors.New("Credenciales inválidas")
var ErrEmailAlreadyExists = errors.New("El email ya está registrado")
