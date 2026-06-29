package domain

import (
	"context"
	"errors"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

type Repo interface {
	Create(ctx context.Context, u User) (*User, error)
	GetByID(ctx context.Context, id UserID) (*User, error)
	GetByEmail(ctx context.Context, email string) (*User, error)
	List(ctx context.Context) ([]User, error)
}

type Service struct {
	repo   Repo
	jwtKey []byte
}

func NewService(repo Repo, jwtKey []byte) *Service {
	return &Service{repo: repo, jwtKey: jwtKey}
}

func (s *Service) Register(ctx context.Context, email, password, name string) (*User, error) {
	existing, _ := s.repo.GetByEmail(ctx, email)
	if existing != nil {
		return nil, ErrEmailAlreadyExists
	}

	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}

	user := User{
		Email:        email,
		PasswordHash: string(hash),
		Name:         name,
		CreatedAt:    time.Now().UTC(),
		UpdatedAt:    time.Now().UTC(),
	}

	return s.repo.Create(ctx, user)
}

func (s *Service) Login(ctx context.Context, email, password string) (string, *User, error) {
	user, err := s.repo.GetByEmail(ctx, email)
	if err != nil {
		if errors.Is(err, ErrNotFound) {
			return "", nil, ErrInvalidCredentials
		}
		return "", nil, err
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.PasswordHash), []byte(password)); err != nil {
		return "", nil, ErrInvalidCredentials
	}

	token, err := s.generateToken(user)
	if err != nil {
		return "", nil, err
	}

	return token, user, nil
}

func (s *Service) GetUser(ctx context.Context, id UserID) (*User, error) {
	return s.repo.GetByID(ctx, id)
}

func (s *Service) ListUsers(ctx context.Context) ([]User, error) {
	return s.repo.List(ctx)
}

func (s *Service) ValidateToken(tokenStr string) (*User, error) {
	token, err := jwt.Parse(tokenStr, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, jwt.ErrSignatureInvalid
		}
		return s.jwtKey, nil
	})
	if err != nil {
		return nil, err
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok || !token.Valid {
		return nil, jwt.ErrSignatureInvalid
	}

	userIDFloat, ok := claims["user_id"].(float64)
	if !ok {
		return nil, jwt.ErrSignatureInvalid
	}

	return &User{ID: UserID(userIDFloat)}, nil
}

func (s *Service) generateToken(user *User) (string, error) {
	claims := jwt.MapClaims{
		"user_id": float64(user.ID),
		"email":   user.Email,
		"name":    user.Name,
		"exp":     float64(time.Now().Add(24 * time.Hour).Unix()),
		"iat":     float64(time.Now().Unix()),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(s.jwtKey)
}
