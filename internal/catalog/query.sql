-- name: CreateTramite :one
INSERT INTO tramites (name, description, procedure_description, type) -- status has its default value set in the database
VALUES (?, ?, ?, ?)
RETURNING *;
-- name: GetTramite :one
SELECT *
FROM tramites
WHERE id = ?
LIMIT 1;

-- name: ListTramites :many
SELECT *
FROM tramites
ORDER BY name, id;

-- name: ListTramitesByStatus :many
SELECT *
FROM tramites
WHERE status = ?
ORDER BY name, id;

-- name: UpdateTramite :one
UPDATE tramites
SET name = ?,
    description = ?,
    procedure_description = ?,
    type = ?,
    updated_at = CURRENT_TIMESTAMP
WHERE id = ?
RETURNING *;

-- name: DeleteTramite :execrows
DELETE FROM tramites
WHERE id = ?;
