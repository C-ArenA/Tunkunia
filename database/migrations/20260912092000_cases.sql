-- +goose Up

CREATE TABLE cases (
    id INTEGER PRIMARY KEY NOT NULL,
    tramite_id INTEGER NOT NULL REFERENCES tramites (id),
    procedure_id INTEGER NOT NULL REFERENCES procedures (id),
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed')),
    revision INTEGER NOT NULL DEFAULT 1,
    marking TEXT NOT NULL,
    initiated_by INTEGER NOT NULL REFERENCES users (id),
    started_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TEXT
) STRICT;

CREATE TABLE case_participants (
    case_id INTEGER NOT NULL REFERENCES cases (id),
    role TEXT NOT NULL CHECK (role IN ('citizen', 'servant')),
    user_id INTEGER NOT NULL REFERENCES users (id),
    assigned_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (case_id, role)
) STRICT;

CREATE INDEX case_participants_user
    ON case_participants (user_id, case_id);

CREATE TABLE case_tasks (
    id INTEGER PRIMARY KEY NOT NULL,
    case_id INTEGER NOT NULL REFERENCES cases (id),
    transition_id TEXT NOT NULL,
    transition_label TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('citizen', 'servant')),
    assignee_id INTEGER REFERENCES users (id),
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'cancelled')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_at TEXT
) STRICT;

CREATE UNIQUE INDEX case_tasks_one_pending_transition
    ON case_tasks (case_id, transition_id)
    WHERE status = 'pending';

CREATE INDEX case_tasks_assignee
    ON case_tasks (assignee_id, status, created_at);

CREATE TABLE case_actions (
    id INTEGER PRIMARY KEY NOT NULL,
    case_id INTEGER NOT NULL REFERENCES cases (id),
    task_id INTEGER NOT NULL REFERENCES case_tasks (id),
    transition_id TEXT NOT NULL,
    transition_label TEXT NOT NULL,
    actor_id INTEGER NOT NULL REFERENCES users (id),
    revision_before INTEGER NOT NULL,
    marking_before TEXT NOT NULL,
    marking_after TEXT NOT NULL,
    occurred_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE INDEX case_actions_case
    ON case_actions (case_id, occurred_at, id);

-- +goose Down

DROP TABLE IF EXISTS case_actions;
DROP TABLE IF EXISTS case_tasks;
DROP INDEX IF EXISTS case_participants_user;
DROP TABLE IF EXISTS case_participants;
DROP TABLE IF EXISTS cases;
