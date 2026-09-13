-- name: GetUserById :one
SELECT *
FROM users
WHERE
  id = ?;

-- name: UpsertUserBySub :one
INSERT INTO users(name, sub, email, email_verified)
VALUES (?, ?, ?, ?)
ON CONFLICT DO UPDATE
SET
	sub = excluded.sub,
	email = excluded.email,
	name = excluded.name,
	email_verified = excluded.email_verified,
	updated_at = CURRENT_TIMESTAMP
RETURNING *;

-- name: ListUsers :many
SELECT *
FROM users
ORDER BY name, id;

-- name: SetAdmin :exec
UPDATE users
SET
  is_admin = ?,
  updated_at = CURRENT_TIMESTAMP
WHERE id = ?;

-- name: UpdateUserAccess :one
UPDATE users
SET
  is_admin = ?,
  is_public_servant = ?,
  updated_at = CURRENT_TIMESTAMP
WHERE id = ?
RETURNING *;
