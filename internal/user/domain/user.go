package domain

import "time"

type User struct {
	ID            int
	Name          string
	Sub           string
	Email         string
	EmailVerified bool
	Roles         []*Role
	CreatedAt     time.Time
}
