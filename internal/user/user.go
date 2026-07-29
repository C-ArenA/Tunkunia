package user

import (
	"net/mail"
	"strings"
	"time"
)

type RoleName string

const (
	ADMIN   RoleName = "admin"
	EDITOR  RoleName = "editor"
	PLAYER  RoleName = "player"
	SERVANT RoleName = "servant"
	CITIZEN RoleName = "citizen"
)

type Email string

func (e *Email) UnmarshalText(text []byte) error {
	v, err := NewEmail(string(text))
	if err != nil {
		return err
	}
	*e = v
	return nil
}

func NewEmail(e string) (Email, error) {
	addr, err := mail.ParseAddress(e)
	if err != nil {
		return "", ErrInvalidEmail
	}
	addrParts := strings.Split(addr.Address, "@") // will always have two components after parsed
	addrDomain := addrParts[1]
	domainParts := strings.Split(addrDomain, ".")
	if len(domainParts) < 2 {
		return "", ErrInvalidEmail
	}

	return Email(addr.Address), nil
}

type UserId int
type User struct {
	ID            UserId
	Name          string
	Sub           string
	Email         Email
	EmailVerified bool
	Roles         []RoleName
	CreatedAt     time.Time
	UpdatedAt     time.Time
}
