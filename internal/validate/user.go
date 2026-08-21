package validate

import "strings"

func IsValidEmail(email string) bool {
	emailCmpnts := strings.Split(email, "@")
	if len(emailCmpnts) != 2 || len(email) < 4 {
		return false
	}
	emailHostCmpnts := strings.Split(emailCmpnts[1], ".")
	if len(emailHostCmpnts) < 2 || emailHostCmpnts[0] == "" {
		return false
	}
	return true
}
