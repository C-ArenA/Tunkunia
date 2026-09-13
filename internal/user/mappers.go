package user

import (
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/cast"
)

func ToDomainUser(u sqlc.User) User {
	return User{
		ID:              UserId(u.ID),
		Name:            u.Name,
		Sub:             u.Sub,
		Email:           Email(u.Email),
		EmailVerified:   cast.SqliteToBool(u.EmailVerified),
		IsAdmin:         cast.SqliteToBool(u.IsAdmin),
		IsPublicServant: cast.SqliteToBool(u.IsPublicServant),
		CreatedAt:       cast.SqliteToTimeForced(u.CreatedAt),
		UpdatedAt:       cast.SqliteToTimeForced(u.UpdatedAt),
	}
}

func NewUserUpsertParamsFromDomain(dU User) sqlc.UpsertUserParams {
	return sqlc.UpsertUserParams{
		Name:            dU.Name,
		Sub:             dU.Sub,
		Email:           string(dU.Email),
		EmailVerified:   cast.BoolToSqlite(dU.EmailVerified),
		IsAdmin:         cast.BoolToSqlite(dU.IsAdmin),
		IsPublicServant: cast.BoolToSqlite(dU.IsPublicServant),
	}
}
