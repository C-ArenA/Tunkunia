-- +goose Up
INSERT INTO tramites (name, description, procedure_description)
VALUES (
        'Trámite de Ejemplo',
        'Este es un trámite de ejemplo para demostrar la estructura de la tabla.',
        '1. Reunir documentos\n2. Completar formulario\n3. Presentar solicitud'
    ),
    (
        'Trámite de Prueba',
        'Este es otro trámite de prueba para fines de demostración.',
        '1. Revisar requisitos\n2. Llenar formulario\n3. Enviar solicitud'
    );
-- +goose Down
SELECT 'down SQL query';