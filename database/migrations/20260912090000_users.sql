-- +goose Up

CREATE TABLE users (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL DEFAULT '',
    sub TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    email_verified INTEGER NOT NULL DEFAULT 0,
    -- Every user is a citizen; these flags grant additional system access.
    is_admin INTEGER NOT NULL DEFAULT 0 CHECK (is_admin IN (0, 1)),
    is_public_servant INTEGER NOT NULL DEFAULT 0 CHECK (is_public_servant IN (0, 1)),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

-- Fast lookup when validating the incoming JWT `sub` claim.
CREATE INDEX idx_users_sub ON users (sub);

-- +goose Down

DROP TABLE IF EXISTS users;
