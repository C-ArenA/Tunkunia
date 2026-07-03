-- name: UpsertUser :one
INSERT INTO users (name, sub, email, email_verified)
VALUES (?, ?, ?, ?) ON CONFLICT(email) DO
UPDATE
SET sub = excluded.sub,
    name = excluded.name,
    email_verified = excluded.email_verified
RETURNING *;
-- name: AssignRoleToUser :exec
INSERT INTO user_roles (user_id, role)
VALUES(?, ?) ON CONFLICT DO NOTHING;
-- name: GetUserRoles :many
SELECT user_roles.role
FROM users
    LEFT JOIN user_roles ON users.id = user_roles.user_id
WHERE users.id = ?;
-- name: UserWithRoleExists :one
SELECT EXISTS(
        SELECT 1
        FROM user_roles
        WHERE role = ?
    );