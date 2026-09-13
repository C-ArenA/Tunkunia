-- +goose Up

CREATE TABLE tramites (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE,
    description TEXT NOT NULL DEFAULT '',
    procedure_description TEXT NOT NULL DEFAULT '',
    type TEXT NOT NULL DEFAULT '',
    status TEXT NOT NULL DEFAULT 'draft',
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    current_version_id INTEGER REFERENCES procedure_versions (id)
) STRICT;

CREATE TABLE procedure_versions (
    id INTEGER PRIMARY KEY NOT NULL,
    tramite_id INTEGER NOT NULL REFERENCES tramites (id),
    version_number INTEGER,
    status TEXT NOT NULL CHECK (status IN ('draft', 'published')),
    definition TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TEXT,
    UNIQUE (tramite_id, version_number)
) STRICT;

CREATE UNIQUE INDEX procedure_versions_one_draft
    ON procedure_versions (tramite_id)
    WHERE status = 'draft';

-- +goose Down

DROP INDEX IF EXISTS procedure_versions_one_draft;
DROP TABLE IF EXISTS procedure_versions;
DROP TABLE IF EXISTS tramites;
