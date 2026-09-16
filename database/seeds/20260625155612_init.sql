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
    ) ON CONFLICT (name) DO NOTHING;
INSERT INTO users (
        name,
        sub,
        email,
        email_verified,
        is_admin,
        is_public_servant
    )
VALUES (
        'Carlos Arena',
        '021196',
        'carlostata.ca@gmail.com',
        1,
        1,
        1
    ),
    (
        'Roberto Zambrana',
        '010119191',
        'roberto.zambrana@gmail.com',
        1,
        1,
        1
    ),
    (
        'Fabián Tito',
        '010119192',
        'fabiantito@gmail.com',
        1,
        1,
        1
    ),
    (
        'Jorge León',
        '010119193',
        'jorge.leon@gmail.com',
        1,
        1,
        1
    ),
    (
        'Jorge Nava',
        '0101191933',
        'janava@gmail.com',
        1,
        1,
        1
    ) ON CONFLICT (sub) DO NOTHING;
-- +goose Down
SELECT 'down SQL query';