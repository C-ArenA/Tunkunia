package store

import (
	"github.com/C-ArenA/Tunkunia/internal/cast"
	"github.com/C-ArenA/Tunkunia/internal/user/domain"
)

func NewUserFromDomain(dU domain.User) User {
	return User{
		ID:            int64(dU.ID),
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         dU.Email,
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
		CreatedAt:     cast.TimeToSqlite(dU.CreatedAt),
	}
}
func (u *User) ToDomain() domain.User {
	return domain.User{
		ID:            int(u.ID),
		Name:          u.Name,
		Sub:           u.Sub,
		Email:         u.Email,
		EmailVerified: cast.SqliteToBool(u.EmailVerified),
		CreatedAt:     cast.SqliteToTimeForced(u.CreatedAt),
	}
}
func NewUserUpsertParamsFromDomain(dU domain.User) UpsertUserParams {
	return UpsertUserParams{
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         dU.Email,
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
	}
}
