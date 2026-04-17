-- name: ListTramites :many
SELECT * FROM tramites ORDER BY id;

-- name: GetTramite :one
-- Add your query here
-- SELECT * FROM tramites WHERE id = ?;

-- name: CreateTramite :exec
-- Add your query here
-- INSERT INTO tramites (name) VALUES (?);

-- name: UpdateTramite :exec
-- Add your query here
-- UPDATE tramites SET name = ? WHERE id = ?;

-- name: DeleteTramite :exec
-- Add your query here
-- DELETE FROM tramites WHERE id = ?;
