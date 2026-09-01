#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, typ-fig

== Validación y resultados

=== Alcance de la validación

El prototipo implementa una sola acción de prueba que consiste en la simple ejecución de transiciones habilitadas.
No existen transiciones de interoperabilidad en el prototipo y se remplazan con transiciones ejecutadas de forma automatizada.
Se valida la capacidad de aplicar el modelado del trámite diseñado en Tunkunia para distintos trámites.

Se consideran el Registro Ambiental Industrial, la cédula de identidad por
primera vez y la adscripción al Sistema Único de Salud.
La solicitud de patente
de invención se conserva como referencia para el diseño, pero se excluye de esta
etapa porque su representación exigiría interpretar aspectos operativos no
descritos con suficiente detalle y abarcar una cantidad de excepciones que
excede el alcance del prototipo.

Cada caso se expresa mediante una red de flujo de trabajo (WFNet) con un único lugar de
inicio y uno de terminación.
Los círculos representan lugares o situaciones; los
rectángulos, transiciones ejecutables; y las flechas, la relación de flujo.
El
recorrido satisfactorio indica la secuencia de disparos y el lugar que conserva
el token después de cada acción.
Los datos y documentos producidos se mantienen
en el expediente y no se codifican dentro del token.

=== Casos preparados para validación

==== Registro Ambiental Industrial

El modelo de la @fig:rai_pnet representa el recorrido ordinario de una
unidad industrial cuya información es suficiente para que la instancia
ambiental municipal determine una categoría.
Las reglas técnicas de
clasificación se registran como transiciones, aunque esto podría hacerse de otra manera, se considera que esta representación es más informativa para el ciudadano.

#img-fig(
  "../../assets/figures/rai_pnet.png",
  [Trámite RAI Modelado],
  <fig:rai_pnet>,
)

El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Iniciar], [Representante Legal], [1],
    [1], [Presentar formulario RAI], [Representante legal], [2],
    [2], [Observar], [Servidor municipal], [1],
    [3], [Presentar formulario RAI], [Representante legal], [2],
    [4], [Asignar categoría 4], [Servidor municipal], [3],
    [5], [Registrar], [Servidor municipal], [o],
  ),
  caption: [Recorrido satisfactorio previsto para el RAI],
)<table:validation-rai-path>

Al concluir, el expediente debe conservar el formulario presentado, la
categoría, la información que fundamentó la decisión, la notificación y las
actuaciones de cada participante.

==== Cédula de identidad por primera vez

La @fig:ci_pnet limita el caso satisfactorio a una persona cuyos
datos coinciden con SERECI.
Las variantes para menores, personas naturalizadas,
nacidos en el exterior y saneamiento de datos deberán configurarse como caminos
adicionales cuando se cuente con suficiente información operativa.

#img-fig(
  "/assets/figures/ci_pnet.png",
  [Trámite de Cédula de Identidad Modelado],
  <fig:ci_pnet>,
)


El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Comenzar], [Ciudadano], [1],
    [1], [Elegir Opción Padre], [Ciudadano], [3],
    [2], [Obtener Certificado de Nacimiento], [Interoperabilidad], [4],
    [3], [Verificar Datos: Valid], [Servidor del SEGIP], [5],
    [4], [Verificar Niño: Hay Niño], [Servidor del SEGIP], [6],
    [5], [Emitir y entregar cédula], [Servidor del SEGIP], [o],
  ),
  caption: [Recorrido satisfactorio previsto para la cédula de identidad],
)<table:validation-identity-path>

Al concluir, el expediente debe conservar la solicitud, las referencias a la
documentación presentada, el resultado de la consulta externa, el número
asignado y la constancia de entrega.

==== Adscripción al Sistema Único de Salud

La @fig:sus_pnet representa a una persona identificada, no afiliada a un
ente gestor de la Seguridad Social de Corto Plazo y atendida por el
establecimiento de primer nivel que le corresponde.
El modelo admite que la
captura sea manual o informatizada sin convertir cada canal en un trámite
diferente.

#img-fig(
  "../../assets/figures/sus_pnet.png",
  [Trámite adscripción al SUS Modelado],
  <fig:sus_pnet>,
)

El recorrido satisfactorio previsto es el siguiente:

#figure(
  table(
    columns: (.45fr, 1.7fr, 1.3fr, 1.8fr),
    align: (center + horizon, left + horizon, left + horizon, left + horizon),
    fill: (x, y) => if y == 0 { rgb(230, 230, 230) },
    inset: (.35em, .45em),
    table.header([Paso], [Transición], [Responsable], [Lugar resultante]),
    [0], [Iniciar], [Ciudadano], [P2],
    [1], [Entregar Factura de Luz], [Ciudadano], [P3],
    [2], [Obtener Dato de Afiliación], [Interoperabilidad], [P4],
    [3], [Verificar datos válidos], [Personal de salud], [P5],
    [4], [Registrar adscripción], [Personal de salud], [o],
  ),
  caption: [Recorrido satisfactorio previsto para la adscripción al SUS],
)<table:validation-sus-path>

Al concluir, el expediente debe conservar los datos del formulario, el canal de
registro empleado, el resultado de la verificación y el establecimiento al que
la persona quedó adscrita.

=== Resultados de la Validación

Se pudo demostrar que distintos trámites pueden ser modelados en Redes de Petri y configurados en un sistema reutilizable.
La manera en que se modelan estos procesos es variada, pero el conjunto de posibles acciones y los elementos añadidos a las redes de Petri como asociación de recursos a transiciones permite contar con las herramientas necesarias para modelar distintos trámites.

Es cierto que las redes de Petri por si solas no son amigables al usuario, pero su ejecución de forma interactiva es sencilla y transmite al ciudadano la información necesaria sobre el proceso.
Las capturas de pantalla presentadas en este documento no demuestran el potencial en experiencia de usuario de las Redes de Petri que resulta de su simplicidad.

Si bien el prototipo no implementa todos los tipos de acciones necesarios en un trámite, en su estado actual ya permite validar su proceso y el cómo interactúan los distintos actores con el subsistema reutilizable.
