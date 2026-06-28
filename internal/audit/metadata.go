package audit

import "time"

type Metadata struct {
	CreatedBy int
	UpdatedBy int
	CreatedAt time.Time
	UpdatedAt time.Time
}

type MetadataMask struct {
	CreatedBy bool
	UpdatedBy bool
	CreatedAt bool
	UpdatedAt bool
}
