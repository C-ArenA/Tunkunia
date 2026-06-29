package api

import rbacdomain "github.com/C-ArenA/Tunkunia/internal/rbac/domain"

func NewRoleFromDomain(r rbacdomain.Role) Role {
	return Role{
		Id:          int64(r.ID),
		Name:        r.Name,
		Description: &r.Description,
		CreatedAt:   r.CreatedAt,
		UpdatedAt:   r.UpdatedAt,
	}
}

func NewPermissionFromDomain(p rbacdomain.Permission) Permission {
	return Permission{
		Id:          int64(p.ID),
		Resource:    p.Resource,
		Action:      p.Action,
		Description: &p.Description,
	}
}

func (c *RoleCreate) toDomain() (string, string) {
	desc := ""
	if c.Description != nil {
		desc = *c.Description
	}
	return c.Name, desc
}

func (u *RoleUpdate) toDomain() (rbacdomain.Role, rbacdomain.RoleMask) {
	var r rbacdomain.Role
	var m rbacdomain.RoleMask

	if u.Name != nil {
		m.Name = true
		r.Name = *u.Name
	}
	if u.Description != nil {
		m.Description = true
		r.Description = *u.Description
	}

	return r, m
}
