package user

import (
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/cast"
)

func NewUserFromDomain(dU User) sqlc.User {
	return sqlc.User{
		ID:            int64(dU.ID),
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         string(dU.Email),
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
		CreatedAt:     cast.TimeToSqlite(dU.CreatedAt),
	}
}

func ToDomainUser(u sqlc.User, r []string) User {
	dRoles := make([]RoleName, len(r))
	for i, role := range r {
		dRoles[i] = RoleName(role)
	}
	return User{
		ID:            UserId(u.ID),
		Name:          u.Name,
		Sub:           u.Sub,
		Email:         Email(u.Email),
		EmailVerified: cast.SqliteToBool(u.EmailVerified),
		CreatedAt:     cast.SqliteToTimeForced(u.CreatedAt),
		Roles:         dRoles,
	}
}

func NewUserUpsertParamsFromDomain(dU User) sqlc.UpsertUserParams {
	return sqlc.UpsertUserParams{
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         string(dU.Email),
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
	}
}
