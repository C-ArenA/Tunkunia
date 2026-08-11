package authn

import (
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

type JWTAuth struct {
	keyOption jwt.SignEncryptParseOption
}

func NewJWTAuth(base64urlKey string) *JWTAuth {
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
	return &JWTAuth{
		keyOption: jwt.WithKey(alg, key),
	}
}

func (ja *JWTAuth) IssueUserToken(userID int) (string, error) {
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

func Authenticate(j *JWTAuth) func(http.Handler) http.Handler {
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
			oapi.Error(w, oapi.NewUnauthorizedResponse("Requires authenticated user"), http.StatusUnauthorized)
			return
		}
		next.ServeHTTP(w, r)
	})
}

func RequireNonAuthenticatedOrRedirect(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		_, isAuthenticated := FromAuthContext(r.Context())
		if isAuthenticated {
			http.Redirect(w, r, "/", http.StatusSeeOther)
			return
		}
		next.ServeHTTP(w, r)
	})
}
