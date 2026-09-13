-- name: ListCaseSummariesByUser :many
SELECT c.id, c.tramite_id, t.name AS tramite_name, c.status, c.revision, c.started_at, c.updated_at
FROM cases c
JOIN tramites t ON t.id = c.tramite_id
JOIN case_participants cp ON cp.case_id = c.id
WHERE cp.user_id = ?
ORDER BY c.updated_at DESC;

-- name: ListUnassignedCaseSummaries :many
SELECT DISTINCT c.id, c.tramite_id, t.name AS tramite_name, c.status, c.revision, c.started_at, c.updated_at
FROM cases c
JOIN tramites t ON t.id = c.tramite_id
JOIN case_tasks ct ON ct.case_id = c.id AND ct.role = 'servant' AND ct.status = 'pending'
LEFT JOIN case_participants cp ON cp.case_id = c.id AND cp.role = 'servant'
WHERE c.status = 'active' AND cp.user_id IS NULL
ORDER BY c.started_at;

-- name: ListTasksByAssignee :many
SELECT id, case_id, transition_id, transition_label, role, assignee_id, status, created_at
FROM case_tasks
WHERE assignee_id = ? AND status = ?
ORDER BY created_at DESC;

-- name: ListNotificationsByUser :many
SELECT id, case_id, task_id, type, title, created_at, read_at
FROM notifications
WHERE user_id = ?
ORDER BY created_at DESC;

-- name: MarkNotificationRead :execrows
UPDATE notifications
SET read_at = COALESCE(read_at, CURRENT_TIMESTAMP)
WHERE id = ? AND user_id = ?;
