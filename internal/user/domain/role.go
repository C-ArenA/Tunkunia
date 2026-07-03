package domain

type RoleName string

const (
	ADMIN   RoleName = "admin"
	EDITOR  RoleName = "editor"
	PLAYER  RoleName = "player"
	SERVANT RoleName = "servant"
	CITIZEN RoleName = "citizen"
)

type Role struct {
	ID   int
	Name RoleName
}
