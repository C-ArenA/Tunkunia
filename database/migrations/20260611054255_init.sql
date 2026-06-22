-- +goose Up
CREATE TABLE tramites (
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    procedure_description TEXT,
    type TEXT NOT NULL DEFAULT '',
    status TEXT NOT NULL DEFAULT 'draft',
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;
INSERT INTO tramites (id, name, description, procedure_description)
VALUES (
        1,
        'Trámite de Ejemplo',
        'Este es un trámite de ejemplo para demostrar la estructura de la tabla.',
        '1. Reunir documentos\n2. Completar formulario\n3. Presentar solicitud'
    );
-- +goose Down
DROP TABLE tramites