-- name: GetInstitution :one
SELECT *
FROM institution
WHERE id = 1;

-- name: UpdateInstitution :one
UPDATE institution
SET name = ?,
    acronym = ?,
    description = ?,
    logo_url = ?,
    email = ?,
    phone = ?,
    address = ?,
    website = ?,
    primary_color = ?,
    accent_color = ?,
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1
RETURNING *;
