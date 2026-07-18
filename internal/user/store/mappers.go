package store

import (
	"github.com/C-ArenA/Tunkunia/database/sqlc"
	"github.com/C-ArenA/Tunkunia/internal/cast"
	"github.com/C-ArenA/Tunkunia/internal/user/domain"
)

func NewUserFromDomain(dU domain.User) sqlc.User {
	return sqlc.User{
		ID:            int64(dU.ID),
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         string(dU.Email),
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
		CreatedAt:     cast.TimeToSqlite(dU.CreatedAt),
	}
}

func ToDomainUser(u sqlc.User, r []string) domain.User {
	dRoles := make([]domain.RoleName, len(r))
	for i, role := range r {
		dRoles[i] = domain.RoleName(role)
	}
	return domain.User{
		ID:            domain.UserId(u.ID),
		Name:          u.Name,
		Sub:           u.Sub,
		Email:         domain.Email(u.Email),
		EmailVerified: cast.SqliteToBool(u.EmailVerified),
		CreatedAt:     cast.SqliteToTimeForced(u.CreatedAt),
		Roles:         dRoles,
	}
}

func NewUserUpsertParamsFromDomain(dU domain.User) sqlc.UpsertUserParams {
	return sqlc.UpsertUserParams{
		Name:          dU.Name,
		Sub:           dU.Sub,
		Email:         string(dU.Email),
		EmailVerified: cast.BoolToSqlite(dU.EmailVerified),
	}
}
