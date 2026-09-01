#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": typ-fig

== Validación y resultados

=== Alcance provisional de la validación

Se consideran el Registro Ambiental Industrial, la cédula de identidad por
primera vez y la adscripción al Sistema Único de Salud. La solicitud de patente
de invención se conserva como referencia para el diseño, pero se excluye de esta
etapa porque su representación exigiría interpretar aspectos operativos no
descritos con suficiente detalle y abarcar una cantidad de excepciones que
excede el alcance del prototipo.

Cada caso se expresa mediante una red de flujo de trabajo (WFNet) con un único lugar de
inicio y uno de terminación. Los círculos representan lugares o situaciones; los
rectángulos, transiciones ejecutables; y las flechas, la relación de flujo. El
recorrido satisfactorio indica la secuencia de disparos y el lugar que conserva
el token después de cada acción. Los datos y documentos producidos se mantienen
en el expediente y no se codifican dentro del token.

=== Casos preparados para validación

==== Registro Ambiental Industrial

El modelo de la @fig:validation-rai representa el recorrido ordinario de una
unidad industrial cuya información es suficiente para que la instancia
ambiental municipal determine una categoría. Las reglas técnicas de
clasificación se registran como datos y condiciones de la transición, no como
estructura propia del motor.

#typ-fig(
  diagram(
    spacing: (8mm, 12mm),
    node-stroke: luma(70%),
    node((0, 0), [Inicio], name: <rai-start>, shape: circle),
    edge("->"),
    node((1, 0), [Presentar\ formulario], name: <rai-submit>),
    edge("->"),
    node((2, 0), [Solicitud\ recibida], name: <rai-received>, shape: circle),
    edge("->"),
    node((3, 0), [Revisar\ información], name: <rai-review>),
    edge("->"),
    node((4, 0), [Información\ revisada], name: <rai-reviewed>, shape: circle),
    edge("->", bend: 30deg),
    node((4, 1), [Asignar\ categoría], name: <rai-classify>),
    edge("->"),
    node((3, 1), [Categoría\ asignada], name: <rai-classified>, shape: circle),
    edge("->"),
    node((2, 1), [Notificar\ resultado], name: <rai-notify>),
    edge("->"),
    node((1, 1), [Fin], name: <rai-end>, shape: circle),
  ),
  [Red de Petri preparada para el Registro Ambiental Industrial],
  <fig:validation-rai>,
)

El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Marcado inicial], [Sistema], [Inicio],
    [1], [Presentar formulario], [Representante legal], [Solicitud recibida],
    [2], [Revisar información], [Servidor municipal], [Información revisada],
    [3], [Asignar categoría], [Servidor municipal], [Categoría asignada],
    [4], [Notificar resultado], [Servidor municipal], [Fin],
  ),
  caption: [Recorrido satisfactorio previsto para el RAI],
)<table:validation-rai-path>

Al concluir, el expediente debe conservar el formulario presentado, la
categoría, la información que fundamentó la decisión, la notificación y las
actuaciones de cada participante.

==== Cédula de identidad por primera vez

La @fig:validation-identity limita el caso satisfactorio a una persona cuyos
datos coinciden con SERECI. Las variantes para menores, personas naturalizadas,
nacidos en el exterior y saneamiento de datos deberán configurarse como caminos
adicionales cuando se cuente con suficiente información operativa.

#typ-fig(
  diagram(
    spacing: (8mm, 12mm),
    node-stroke: luma(70%),
    node((0, 0), [Inicio], name: <ci-start>, shape: circle),
    edge("->"),
    node((1, 0), [Presentar\ solicitud], name: <ci-submit>),
    edge("->"),
    node((2, 0), [Solicitud\ recibida], name: <ci-received>, shape: circle),
    edge("->"),
    node((3, 0), [Verificar\ con SERECI], name: <ci-check>),
    edge("->"),
    node((4, 0), [Datos\ verificados], name: <ci-verified>, shape: circle),
    edge("->", bend: 30deg),
    node((4, 1), [Registrar identidad\ y asignar número], name: <ci-register>),
    edge("->"),
    node((3, 1), [Identidad\ registrada], name: <ci-registered>, shape: circle),
    edge("->"),
    node((2, 1), [Emitir y entregar\ cédula], name: <ci-issue>),
    edge("->"),
    node((1, 1), [Fin], name: <ci-end>, shape: circle),
  ),
  [Red de Petri preparada para la emisión inicial de la cédula de identidad],
  <fig:validation-identity>,
)

El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Marcado inicial], [Sistema], [Inicio],
    [1], [Presentar solicitud], [Solicitante], [Solicitud recibida],
    [2], [Verificar con SERECI], [Servidor del SEGIP], [Datos verificados],
    [3], [Registrar identidad y asignar número], [Servidor del SEGIP], [Identidad registrada],

    [4], [Emitir y entregar cédula], [Servidor del SEGIP], [Fin],
  ),
  caption: [Recorrido satisfactorio previsto para la cédula de identidad],
)<table:validation-identity-path>

Al concluir, el expediente debe conservar la solicitud, las referencias a la
documentación presentada, el resultado de la consulta externa, el número
asignado y la constancia de entrega.

==== Adscripción al Sistema Único de Salud

La @fig:validation-sus representa a una persona identificada, no afiliada a un
ente gestor de la Seguridad Social de Corto Plazo y atendida por el
establecimiento de primer nivel que le corresponde. El modelo admite que la
captura sea manual o informatizada sin convertir cada canal en un trámite
diferente.

#typ-fig(
  diagram(
    spacing: (8mm, 12mm),
    node-stroke: luma(70%),
    node((0, 0), [Inicio], name: <sus-start>, shape: circle),
    edge("->"),
    node((1, 0), [Solicitar\ adscripción], name: <sus-submit>),
    edge("->"),
    node((2, 0), [Solicitud\ recibida], name: <sus-received>, shape: circle),
    edge("->"),
    node((3, 0), [Verificar identidad\ y cobertura], name: <sus-check>),
    edge("->"),
    node((4, 0), [Persona\ habilitada], name: <sus-eligible>, shape: circle),
    edge("->", bend: 30deg),
    node((4, 1), [Registrar\ datos], name: <sus-register>),
    edge("->"),
    node((3, 1), [Registro\ incorporado], name: <sus-recorded>, shape: circle),
    edge("->"),
    node((2, 1), [Confirmar\ adscripción], name: <sus-confirm>),
    edge("->"),
    node((1, 1), [Fin], name: <sus-end>, shape: circle),
  ),
  [Red de Petri preparada para la adscripción al Sistema Único de Salud],
  <fig:validation-sus>,
)

El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Marcado inicial], [Sistema], [Inicio],
    [1], [Solicitar adscripción], [Persona beneficiaria], [Solicitud recibida],
    [2], [Verificar identidad y cobertura], [Personal de salud], [Persona habilitada],

    [3], [Registrar datos], [Personal de salud], [Registro incorporado],
    [4], [Confirmar adscripción], [Personal de salud], [Fin],
  ),
  caption: [Recorrido satisfactorio previsto para la adscripción al SUS],
)<table:validation-sus-path>

Al concluir, el expediente debe conservar los datos del formulario, el canal de
registro empleado, el resultado de la verificación y el establecimiento al que
la persona quedó adscrita.
