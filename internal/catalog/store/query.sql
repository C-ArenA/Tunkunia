-- name: ListTramites :many
SELECT *
FROM tramites;
-- name: CreateTramite :one
INSERT INTO tramites (name)
VALUES (?)
RETURNING *;
-- name: GetTramite :one
SELECT *
FROM tramites
WHERE id = ?
LIMIT 1;
-- name: DeleteTramite :exec
DELETE FROM tramites
WHERE id = ?;