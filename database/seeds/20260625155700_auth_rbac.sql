-- +goose Up
-- Seed admin user (password: admin123)
INSERT INTO users (email, password_hash, name)
VALUES ('admin@tunkunia.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'Admin')
ON CONFLICT (email) DO NOTHING;

-- Seed roles
INSERT INTO roles (name, description)
VALUES ('admin', 'Administrador del sistema con acceso completo')
ON CONFLICT (name) DO NOTHING;

INSERT INTO roles (name, description)
VALUES ('editor', 'Editor de contenido')
ON CONFLICT (name) DO NOTHING;

INSERT INTO roles (name, description)
VALUES ('viewer', 'Visor de contenido (solo lectura)')
ON CONFLICT (name) DO NOTHING;

-- Seed permissions
INSERT INTO permissions (resource, action, description)
VALUES ('catalog', 'create', 'Crear trámites')
ON CONFLICT (resource, action) DO NOTHING;

INSERT INTO permissions (resource, action, description)
VALUES ('catalog', 'read', 'Leer trámites')
ON CONFLICT (resource, action) DO NOTHING;

INSERT INTO permissions (resource, action, description)
VALUES ('catalog', 'update', 'Actualizar trámites')
ON CONFLICT (resource, action) DO NOTHING;

INSERT INTO permissions (resource, action, description)
VALUES ('catalog', 'delete', 'Eliminar trámites')
ON CONFLICT (resource, action) DO NOTHING;

INSERT INTO permissions (resource, action, description)
VALUES ('auth', 'manage', 'Gestionar usuarios')
ON CONFLICT (resource, action) DO NOTHING;

INSERT INTO permissions (resource, action, description)
VALUES ('rbac', 'manage', 'Gestionar roles y permisos')
ON CONFLICT (resource, action) DO NOTHING;

-- Assign all permissions to admin role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r, permissions p WHERE r.name = 'admin'
ON CONFLICT (role_id, permission_id) DO NOTHING;

-- Assign read-only permissions to viewer role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r, permissions p WHERE r.name = 'viewer' AND p.resource = 'catalog' AND p.action = 'read'
ON CONFLICT (role_id, permission_id) DO NOTHING;

-- Assign read/write permissions to editor role
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id FROM roles r, permissions p WHERE r.name = 'editor' AND p.resource = 'catalog' AND p.action IN ('create', 'read', 'update')
ON CONFLICT (role_id, permission_id) DO NOTHING;

-- Assign admin role to admin user
INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u, roles r WHERE u.email = 'admin@tunkunia.com' AND r.name = 'admin'
ON CONFLICT (user_id, role_id) DO NOTHING;
-- +goose Down
DELETE FROM user_roles;
DELETE FROM role_permissions;
DELETE FROM permissions;
DELETE FROM roles;
DELETE FROM users;
