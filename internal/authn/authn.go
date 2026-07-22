package authn

import (
	"context"

	"github.com/C-ArenA/Tunkunia/internal/user"
)

type UserService interface {
	// SaveUser creates a new user if it doesn't exist or updates it if it already exists
	SaveUser(ctx context.Context, u user.User) (*user.User, error)
}

type OIDCClaims struct {
	Subject       string
	Email         string
	EmailVerified bool
	Name          string
}

type AuthService struct {
	userService UserService
	jwtService  *JWTService
}

func NewAuthService(us UserService, js *JWTService) *AuthService {
	return &AuthService{
		userService: us,
		jwtService:  js,
	}
}

// LoginWithOIDC takes what was returned by the OIDC provider and generates a JWT token using the JWTService
// If the user doesn't exist internally it creates one
func (a *AuthService) LoginWithOIDC(ctx context.Context, claims *OIDCClaims) (string, error) {
	u := user.User{
		Sub:           claims.Subject,
		Email:         user.Email(claims.Email),
		EmailVerified: claims.EmailVerified,
		Name:          claims.Name,
	}

	createdUser, err := a.userService.SaveUser(ctx, u)
	if err != nil {
		return "", err
	}

	return a.jwtService.IssueUserToken(int(createdUser.ID))
}
