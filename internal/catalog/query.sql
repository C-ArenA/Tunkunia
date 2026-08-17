-- name: CreateTramite :one
INSERT INTO tramites (name, description, procedure_description, type) -- status has its default value set in the database
VALUES (?, ?, ?, ?)
RETURNING *;
-- name: GetTramite :one
SELECT *
FROM tramites
WHERE id = ?
LIMIT 1;
-- name: DeleteTramite :execrows
DELETE FROM tramites
WHERE id = ?;
