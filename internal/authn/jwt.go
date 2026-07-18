package authn

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/lestrrat-go/jwx/v4/jwa"
	"github.com/lestrrat-go/jwx/v4/jwk"
	"github.com/lestrrat-go/jwx/v4/jwt"
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

func (ja *JWTService) Issue(sub string) (string, error) {
	token, err := jwt.NewBuilder().
		Issuer("Tunkunia").
		Expiration(time.Now().Add(24 * time.Hour)).
		Subject(sub).
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

func Verifier(j *JWTService) func(http.Handler) http.Handler {
	keyOption := j.keyOption
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			token, err := jwt.ParseHeader(r.Header, "Authorization", keyOption)
			if err != nil {
				token, err = jwt.ParseCookie(r, "jwt", keyOption)
			}
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}
			ctx := NewAuthContext(r.Context(), token)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

type contextKey string

var (
	userIdCtxKey contextKey = "userId"
	errorCtxKey  contextKey = "error"
)

func NewAuthContext(ctx context.Context, token jwt.Token) context.Context {
	if idOnSub, ok := token.Subject(); ok {
		if userId, err := strconv.Atoi(idOnSub); err == nil {
			ctx = context.WithValue(ctx, userIdCtxKey, userId)
		} else {
			ctx = context.WithValue(ctx, errorCtxKey, err)
		}
	}
	return ctx
}

func FromAuthContext(ctx context.Context) (userId int, err error) {
	userId, _ = ctx.Value(userIdCtxKey).(int)
	err, _ = ctx.Value(errorCtxKey).(error)
	return
}
