package api

import (
	openapi_types "github.com/oapi-codegen/runtime/types"

	"github.com/C-ArenA/Tunkunia/internal/auth/domain"
)

func NewUserFromDomain(u domain.User) User {
	return User{
		Id:        int64(u.ID),
		Email:     openapi_types.Email(u.Email),
		Name:      u.Name,
		CreatedAt: u.CreatedAt,
		UpdatedAt: u.UpdatedAt,
	}
}

func NewAuthResponseFromDomain(token string, u domain.User) AuthResponse {
	return AuthResponse{
		Token: token,
		User:  NewUserFromDomain(u),
	}
}

func (r *RegisterRequest) toDomain() (string, string, string) {
	return string(r.Email), r.Password, r.Name
}

func (r *LoginRequest) toDomain() (string, string) {
	return string(r.Email), r.Password
}
