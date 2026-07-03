-- name: UpsertUser :one
INSERT INTO users (name, sub, email, email_verified)
VALUES (?, ?, ?, ?) ON CONFLICT(email) DO
UPDATE
SET sub = excluded.sub,
    name = excluded.name,
    email_verified = excluded.email_verified
RETURNING *;
-- name: AssignRoleToUser :exec
INSERT INTO user_roles (user_id, role_id)
SELECT ?,
    id
FROM roles
WHERE name = ? ON CONFLICT DO NOTHING;
-- name: GetUserRoles :many
SELECT id,
    name
FROM roles
    LEFT JOIN user_roles ON roles.id = user_roles.role_id
WHERE user_roles.user_id = ?;
-- name: GetRoleByName :one
SELECT id,
    name
FROM roles
WHERE name = ?;
-- name: UserWithRoleExists :one
SELECT EXISTS(
        SELECT 1
        FROM user_roles
            LEFT JOIN roles
        WHERE roles.name = ?
    );