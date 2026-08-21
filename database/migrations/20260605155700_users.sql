-- +goose Up
CREATE TABLE users(
  id INTEGER PRIMARY KEY NOT NULL,
  name TEXT NOT NULL DEFAULT (''),
  sub TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  email_verified INTEGER NOT NULL DEFAULT (0),
  created_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  updated_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP)
) STRICT;

-- Index for fast lookup when validating the incoming JWT 'sub' claim
CREATE INDEX idx_users_sub ON users (sub);

CREATE TABLE user_roles(
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role TEXT NOT NULL,
  PRIMARY KEY(user_id, role)
) STRICT;

-- +goose Down
DROP TABLE IF EXISTS user_roles;

DROP TABLE IF EXISTS users;
