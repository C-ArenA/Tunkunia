-- +goose Up
CREATE TABLE users (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL DEFAULT '',
    sub TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    email_verified INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;
-- Index for fast lookup when validating the incoming JWT 'sub' claim
CREATE INDEX idx_users_sub ON users(sub);
CREATE TABLE roles (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
) STRICT;
CREATE TABLE user_roles (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
) STRICT;
INSERT INTO roles (name)
VALUES ('admin') ON CONFLICT (name) DO NOTHING;
INSERT INTO roles (name)
VALUES ('editor') ON CONFLICT (name) DO NOTHING;
INSERT INTO roles (name)
VALUES ('citizen') ON CONFLICT (name) DO NOTHING;
INSERT INTO roles (name)
VALUES ('servant') ON CONFLICT (name) DO NOTHING;
-- +goose Down
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;