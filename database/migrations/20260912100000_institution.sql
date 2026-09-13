-- +goose Up

CREATE TABLE institution (
    id INTEGER PRIMARY KEY NOT NULL CHECK (id = 1),
    name TEXT NOT NULL,
    acronym TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    logo_url TEXT NOT NULL DEFAULT '',
    email TEXT NOT NULL DEFAULT '',
    phone TEXT NOT NULL DEFAULT '',
    address TEXT NOT NULL DEFAULT '',
    website TEXT NOT NULL DEFAULT '',
    primary_color TEXT NOT NULL DEFAULT '#087443',
    accent_color TEXT NOT NULL DEFAULT '#d3a000',
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO institution (id, name, acronym) VALUES (1, 'Tunkunia', 'T');

-- +goose Down

DROP TABLE IF EXISTS institution;
