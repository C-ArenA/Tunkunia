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
    current_procedure_id INTEGER REFERENCES procedures (id)
) STRICT;

CREATE TABLE procedures (
    id INTEGER PRIMARY KEY NOT NULL,
    tramite_id INTEGER NOT NULL REFERENCES tramites (id),
    version_number INTEGER,
    status TEXT NOT NULL CHECK (status IN ('draft', 'published')),
    net TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    published_at TEXT,
    UNIQUE (tramite_id, version_number)
) STRICT;

CREATE UNIQUE INDEX procedures_one_draft
    ON procedures (tramite_id)
    WHERE status = 'draft';

-- +goose Down

DROP INDEX IF EXISTS procedures_one_draft;
DROP TABLE IF EXISTS procedures;
DROP TABLE IF EXISTS tramites;
