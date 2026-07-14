package authn

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"net/http"
	"time"

	"github.com/lestrrat-go/jwx/v4/jwa"
	"github.com/lestrrat-go/jwx/v4/jwk"
	"github.com/lestrrat-go/jwx/v4/jwt"
)

func CreateSecretKey() string {
	secretBytes := make([]byte, 32)
	rand.Read(secretBytes)
	return base64.RawURLEncoding.EncodeToString(secretBytes)
}

type JWTAuth struct {
	keyOption jwt.SignEncryptParseOption
}

func NewJWTAuth(base64urlKey string) *JWTAuth {
	key, err := getJWKKey(base64urlKey)
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

func (ja *JWTAuth) Issue() (string, error) {
	tok, err := jwt.NewBuilder().
		Issuer("Tunkunia").
		Expiration(time.Now().Add(24*time.Hour)).
		Claim("wtvr", "wtvr").
		Build()
	if err != nil {
		return "", fmt.Errorf("No se pudo crear token: %w", err)
	}

	signed, err := jwt.Sign(tok, ja.keyOption)
	if err != nil {
		return "", fmt.Errorf("No se pudo firmar token: %w", err)
	}

	return string(signed), nil
}

type contextKey string

const (
	TokenCtxKey contextKey = "token"
)

func (ja *JWTAuth) ParseMiddleware() func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			token, err := jwt.ParseHeader(r.Header, "Authorization", ja.keyOption)
			if err != nil {
				token, err = jwt.ParseCookie(r, "jwt", ja.keyOption)
			}
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}
			ctx := r.Context()
			ctx = context.WithValue(ctx, TokenCtxKey, token)
			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

func getJWKKey(encodedKey string) (jwk.Key, error) {
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
