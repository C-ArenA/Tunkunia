-- name: GetUserByEmail :one
SELECT id, name, sub, email, email_verified, created_at, updated_at
FROM users
WHERE
  email = ?;

-- name: GetUserById :one
SELECT *
FROM users
WHERE
  id = ?;

-- name: UpsertUser :one
INSERT INTO users(name, sub, email, email_verified)
VALUES (?, ?, ?, ?)
ON CONFLICT (email) DO UPDATE
SET
  sub = excluded.sub,
  name = excluded.name,
  email_verified = excluded.email_verified
RETURNING *;

-- name: UpsertUserBySub :one
INSERT INTO users(name, sub, email, email_verified)
VALUES (?, ?, ?, ?)
ON CONFLICT (sub) DO UPDATE
SET
  email = excluded.email,
  name = excluded.name,
  email_verified = excluded.email_verified,
  updated_at = CURRENT_TIMESTAMP
RETURNING *;

-- name: AssignRoleToUser :exec
INSERT INTO user_roles(user_id, role) VALUES (?, ?) ON CONFLICT DO NOTHING;

-- name: RemoveUserRoles :exec
DELETE FROM user_roles WHERE user_id = ?;

-- name: GetUserRoles :many
SELECT role FROM user_roles WHERE user_id = ?;

-- name: IsRoleInUse :one
SELECT EXISTS (SELECT 1 FROM user_roles WHERE role = ?);
