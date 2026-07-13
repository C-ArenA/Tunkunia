package authn

import (
	"crypto/rand"
	"encoding/base64"
	"io"
	"log"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

func CreateSecretKey() string {
	secretBytes := make([]byte, 32)
	if _, err := io.ReadFull(rand.Reader, secretBytes); err != nil {
		log.Fatalf("❌ Error generando bytes aleatorios: %v", err)
	}
	return base64.RawURLEncoding.EncodeToString(secretBytes)
}

func generateJWT(hexKey string) (string, error) {
	claims := jwt.RegisteredClaims{
		Issuer:    "Tunkunia",
		Subject:   "1",
		ExpiresAt: &jwt.NumericDate{Time: time.Now().Add(24 * time.Hour)},
	}
	t := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	key, err := base64.RawURLEncoding.DecodeString(hexKey)
	if err != nil {
		return "", err
	}
	return t.SignedString(key)
}
