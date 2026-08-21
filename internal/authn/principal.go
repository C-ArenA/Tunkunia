package authn

import (
	"context"
	"errors"
	"strconv"

	"github.com/lestrrat-go/jwx/v4/jwt"
)

type PrincipalType string

const (
	UserPrincipal    PrincipalType = "user"
	MachinePrincipal PrincipalType = "machine"
)

type Principal struct {
	ID   int // Can be a user_id or a client_id in case of machines
	Type PrincipalType
}

func (p Principal) IsValid() bool {
	if p.ID <= 0 {
		return false
	}
	switch p.Type {
	case UserPrincipal, MachinePrincipal:
		return true
	default:
		return false
	}
}

func PrincipalFromUserToken(token jwt.Token) (*Principal, error) {
	idOnSub, ok := token.Subject()
	if !ok {
		return nil, ErrMalformedJWT
	}
	userID, err := strconv.Atoi(idOnSub)
	if err != nil {
		return nil, errors.Join(ErrInvalidSubject, err)
	}
	return &Principal{ID: userID, Type: UserPrincipal}, nil
}

type contextKey string

var (
	principalCtxKey contextKey = "principal"
)

func NewAuthContext(ctx context.Context, p *Principal) context.Context {
	return context.WithValue(ctx, principalCtxKey, p)
}

func FromAuthContext(ctx context.Context) (*Principal, bool) {
	p, ok := ctx.Value(principalCtxKey).(*Principal)
	if !ok {
		return nil, false
	}
	return p, p.IsValid()
}
