package cast

import "time"

func BoolToSqlite(b bool) int64 {
	if b {
		return 1
	}
	return 0
}

func SqliteToBool(i int64) bool {
	if i > 0 {
		return true
	}
	return false
}

func TimeToSqlite(t time.Time) string {
	return t.Format(time.DateTime)
}

func SqliteToTime(t string) (time.Time, error) {
	return time.Parse(time.DateTime, t)
}

func SqliteToTimeForced(t string) time.Time {
	cT, err := SqliteToTime(t)
	if err != nil {
		return time.Time{}
	}
	return cT
}
