-- +goose Up

CREATE TABLE notifications (
    id INTEGER PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users (id),
    case_id INTEGER NOT NULL REFERENCES cases (id),
    task_id INTEGER NOT NULL REFERENCES case_tasks (id),
    type TEXT NOT NULL CHECK (type = 'action_enabled'),
    title TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    read_at TEXT,
    UNIQUE (user_id, task_id, type)
) STRICT;

CREATE INDEX notifications_user
    ON notifications (user_id, read_at, created_at);

-- +goose Down

DROP TABLE IF EXISTS notifications;
