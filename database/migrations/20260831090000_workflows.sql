-- +goose Up
CREATE TABLE procedure_versions (
    id INTEGER PRIMARY KEY NOT NULL,
    tramite_id INTEGER NOT NULL REFERENCES tramites(id),
    version_number INTEGER,
    status TEXT NOT NULL CHECK (status IN ('draft', 'published')),
    definition TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TEXT,
    UNIQUE (tramite_id, version_number)
) STRICT;

CREATE UNIQUE INDEX procedure_versions_one_draft
ON procedure_versions(tramite_id) WHERE status = 'draft';

ALTER TABLE tramites ADD COLUMN current_version_id INTEGER REFERENCES procedure_versions(id);

-- A previously published row has no persisted procedure: make it non-startable
-- until an administrator saves and publishes a verified definition.
UPDATE tramites SET status = 'draft' WHERE status = 'published';

CREATE TABLE cases (
    id INTEGER PRIMARY KEY NOT NULL,
    tramite_id INTEGER NOT NULL REFERENCES tramites(id),
    procedure_version_id INTEGER NOT NULL REFERENCES procedure_versions(id),
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed')),
    revision INTEGER NOT NULL DEFAULT 1,
    marking TEXT NOT NULL,
    initiated_by INTEGER NOT NULL REFERENCES users(id),
    started_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TEXT
) STRICT;

CREATE TABLE case_participants (
    case_id INTEGER NOT NULL REFERENCES cases(id),
    role TEXT NOT NULL CHECK (role IN ('citizen', 'servant')),
    user_id INTEGER NOT NULL REFERENCES users(id),
    assigned_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (case_id, role)
) STRICT;

CREATE INDEX case_participants_user ON case_participants(user_id, case_id);

CREATE TABLE case_tasks (
    id INTEGER PRIMARY KEY NOT NULL,
    case_id INTEGER NOT NULL REFERENCES cases(id),
    transition_id TEXT NOT NULL,
    transition_label TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('citizen', 'servant')),
    assignee_id INTEGER REFERENCES users(id),
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'cancelled')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    finished_at TEXT
) STRICT;

CREATE UNIQUE INDEX case_tasks_one_pending_transition
ON case_tasks(case_id, transition_id) WHERE status = 'pending';
CREATE INDEX case_tasks_assignee ON case_tasks(assignee_id, status, created_at);

CREATE TABLE case_actions (
    id INTEGER PRIMARY KEY NOT NULL,
    case_id INTEGER NOT NULL REFERENCES cases(id),
    task_id INTEGER NOT NULL REFERENCES case_tasks(id),
    transition_id TEXT NOT NULL,
    transition_label TEXT NOT NULL,
    actor_id INTEGER NOT NULL REFERENCES users(id),
    revision_before INTEGER NOT NULL,
    marking_before TEXT NOT NULL,
    marking_after TEXT NOT NULL,
    occurred_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE INDEX case_actions_case ON case_actions(case_id, occurred_at, id);

CREATE TABLE notifications (
    id INTEGER PRIMARY KEY NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id),
    case_id INTEGER NOT NULL REFERENCES cases(id),
    task_id INTEGER NOT NULL REFERENCES case_tasks(id),
    type TEXT NOT NULL CHECK (type = 'action_enabled'),
    title TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    read_at TEXT,
    UNIQUE (user_id, task_id, type)
) STRICT;

CREATE INDEX notifications_user ON notifications(user_id, read_at, created_at);

-- +goose Down
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS case_actions;
DROP TABLE IF EXISTS case_tasks;
DROP TABLE IF EXISTS case_participants;
DROP TABLE IF EXISTS cases;
DROP INDEX IF EXISTS procedure_versions_one_draft;
DROP TABLE IF EXISTS procedure_versions;
