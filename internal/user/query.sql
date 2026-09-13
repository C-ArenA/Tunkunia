-- name: GetUserByEmail :one
SELECT *
FROM users
WHERE
  email = ?;

-- name: GetUserById :one
SELECT *
FROM users
WHERE
  id = ?;

-- name: UpsertUser :one
INSERT INTO users(name, sub, email, email_verified, is_admin, is_public_servant)
VALUES (?, ?, ?, ?, ?, ?)
ON CONFLICT (email) DO UPDATE
SET
  sub = excluded.sub,
  name = excluded.name,
  email_verified = excluded.email_verified,
  is_admin = excluded.is_admin,
  is_public_servant = excluded.is_public_servant,
  updated_at = CURRENT_TIMESTAMP
RETURNING *;

-- name: UpsertUserBySub :one
INSERT INTO users(name, sub, email, email_verified)
VALUES (?, ?, ?, ?)
ON CONFLICT DO UPDATE
SET
  email = excluded.email,
  name = excluded.name,
  email_verified = excluded.email_verified,
  updated_at = CURRENT_TIMESTAMP
RETURNING *;

-- name: ListUsers :many
SELECT *
FROM users
ORDER BY name, id;

-- name: AdminExists :one
SELECT EXISTS (
  SELECT 1
  FROM users
  WHERE is_admin = 1
);

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
