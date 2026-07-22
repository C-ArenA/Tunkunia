package authn

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/C-ArenA/Tunkunia/internal/api/v1/oapi"
	"github.com/lestrrat-go/jwx/v4/jwa"
	"github.com/lestrrat-go/jwx/v4/jwk"
	"github.com/lestrrat-go/jwx/v4/jwt"
)

const (
	authHeader = "Authorization"
	authCookie = "jwt"
)

var (
	ErrMalformedJWT   = errors.New("malformed JWT token")
	ErrInvalidSubject = errors.New("invalid token subject")
)

func NewSecretKey() string {
	secretBytes := make([]byte, 32)
	rand.Read(secretBytes)
	return base64.RawURLEncoding.EncodeToString(secretBytes)
}

func UnmarshalSecretKey(encodedKey string) (jwk.Key, error) {
	keyData, err := base64.RawURLEncoding.DecodeString(encodedKey)
	if err != nil {
		return nil, err
	}
	key, err := jwk.Import[jwk.Key](keyData)
	if err != nil {
		return nil, err
	}
	if err := key.Set(jwk.AlgorithmKey, jwa.HS256()); err != nil {
		return nil, err
	}
	return key, nil
}

type JWTService struct {
	keyOption jwt.SignEncryptParseOption
}

func NewJWTService(base64urlKey string) *JWTService {
	if base64urlKey == "" {
		return nil
	}
	key, err := UnmarshalSecretKey(base64urlKey)
	if err != nil {
		return nil
	}
	alg, ok := key.Algorithm()
	if !ok {
		return nil
	}
	return &JWTService{
		keyOption: jwt.WithKey(alg, key),
	}
}

func (ja *JWTService) IssueUserToken(userID int) (string, error) {
	token, err := jwt.NewBuilder().
		Issuer("Tunkunia").
		Expiration(time.Now().Add(24 * time.Hour)).
		Subject(strconv.Itoa(userID)).
		Build()
	if err != nil {
		return "", fmt.Errorf("No se pudo crear token: %w", err)
	}

	signed, err := jwt.Sign(token, ja.keyOption)
	if err != nil {
		return "", fmt.Errorf("No se pudo firmar token: %w", err)
	}

	return string(signed), nil
}

func Authenticate(j *JWTService) func(http.Handler) http.Handler {
	if j == nil {
		panic("authn: Authenticate called with nil *JWTService")
	}
	keyOption := j.keyOption
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			token, err := jwt.ParseHeader(r.Header, authHeader, keyOption)
			if err != nil {
				token, err = jwt.ParseCookie(r, authCookie, keyOption)
			}
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}
			p, err := PrincipalFromUserToken(token)
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}
			ctx := NewAuthContext(r.Context(), p)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

func RequireAuthenticated(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		_, requiresAuthentication := oapi.BearerAuthScopesFromContext(r.Context())
		_, isAuthenticated := FromAuthContext(r.Context())
		if requiresAuthentication && !isAuthenticated {
			oapi.Error(w, oapi.NewForbiddenResponse("Requires authenticated user"), http.StatusUnauthorized)
			return
		}
		next.ServeHTTP(w, r)
	})
}

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
