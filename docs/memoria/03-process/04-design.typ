#import "/shared/theme/lib.typ": img-fig

// Continuación del capítulo «Arquitectura y diseño del software».

=== Diseño de trámites y casos

Un *trámite* reúne la información pública que aparece en el catálogo y una o
varias versiones de su proceso. Cada versión comprende cuatro elementos: una red
de Petri, la definición de los recursos que intervienen, el esquema del
expediente y los metadatos que determinan cómo se presenta y controla cada lugar
o transición. Mientras permanece como borrador puede editarse y validarse; al
publicarse se vuelve inmutable. El archivado impide iniciar casos nuevos, pero no
altera aquellos que ya se encuentran vinculados a la versión.

La red se inspira en la aplicación de redes de Petri a la gestión de flujos
@vanderaalstAPPLICATIONPETRINETS1998. Los lugares representan situaciones del
procedimiento y las transiciones, acciones que permiten avanzar. Un caso posee
su propio marcado y su color identifica todos los tokens que le pertenecen; los
datos administrativos no viajan dentro del token, sino que permanecen en el
expediente. Así, Petrunia se limita a decidir si una transición está habilitada y
a calcular el marcado resultante, mientras Tunkunia resuelve autorización,
entrada de datos y trazabilidad.

#img-fig(
  "/assets/figures/tunkunia-domain-model.svg",
  [Relación entre la definición del trámite y el caso],
  <fig:tunkunia-domain-model>,
  width: 100%,
)

Los recursos de la definición son responsabilidades abstractas, no cuentas de
usuario. Al iniciar un caso, la persona iniciadora ocupa el recurso ciudadano y
los demás recursos se asignan mediante usuarios o grupos configurados. Estas
asignaciones pueden modificarse con autorización y quedan auditadas. Ciudadano y
servidor público son, por tanto, papeles contextuales: una misma identidad puede
ocupar uno u otro en casos diferentes. Los roles globales de administrador y
participante son independientes de estas asignaciones.

La interacción con toda transición ordinaria sigue un único patrón. La pantalla
muestra el estado vigente del expediente, un campo de entrada y un botón de
envío. En el prototipo el campo es textual; su metadato permitirá incorporar
posteriormente variantes numéricas, documentales u otras sin alterar la
semántica del disparo. Cuando la transición representa una consulta externa, el
cliente simulado únicamente precarga ese campo. El participante debe revisar el
dato y pulsar el botón para ejecutar la acción; ninguna transición ordinaria se
dispara por el solo hecho de estar habilitada.

La ejecución descrita en la @fig:tunkunia-case-action-sequence comprueba cuatro
condiciones antes de modificar el caso: la versión presentada por el cliente
debe seguir vigente para ese caso, la transición debe estar habilitada por el
marcado, la entrada debe ser válida y la persona debe ocupar un recurso
autorizado. Un administrador puede omitir la última condición únicamente como
acción de emergencia, proporcionando una justificación. El mecanismo no permite
disparar una transición inhabilitada ni omitir las validaciones, y registra de
forma explícita el uso de la excepción.

#img-fig(
  "/assets/figures/tunkunia-case-action-sequence.svg",
  [Secuencia de ejecución de una acción de trámite],
  <fig:tunkunia-case-action-sequence>,
  width: 100%,
)

Lugares y transiciones habilitadas pueden declarar un plazo y un lugar sumidero
de la misma red. Al vencer, un trabajador interno elimina todos los tokens del
color del caso y coloca uno en el sumidero configurado. Esta operación es
idempotente, afecta únicamente al caso correspondiente y genera una actuación de
auditoría. El trabajador busca vencimientos al arrancar y después de forma
periódica, de modo que una interrupción de la instancia retrasa la aplicación de
la regla, pero no la pierde.

Para resolver acciones simultáneas, cada caso mantiene una versión de
concurrencia. La ejecución vuelve a comprobar esa versión y el marcado dentro de
la transacción; si otro participante modificó antes el caso, la operación se
rechaza y la interfaz debe recargar el estado. El nuevo marcado, el estado del
expediente, la actuación histórica, la auditoría y el aviso interno se confirman
como una unidad. De este modo no se informa una transición que finalmente no
ocurrió.

=== Información, seguridad e interoperabilidad

La instancia utiliza una sola base SQLite, aunque cada módulo es propietario de
sus tablas y solo ofrece acceso a ellas por medio de sus repositorios. El
expediente combina dos representaciones complementarias: un estado estructurado
vigente, validado contra el esquema de la versión, y una secuencia inmutable de
actuaciones con la entrada, salida, actor y fecha. La primera facilita la consulta
y la segunda permite explicar cómo se alcanzó ese estado. Auditoría añade una
vista transversal con entidad, operación, resultado, identidad y momento de las
acciones administrativas u operativas relevantes.

Los archivos adjuntos se almacenan en un directorio de datos configurable.
SQLite conserva sus metadatos, vínculo con el expediente y ubicación controlada;
las rutas proporcionadas por el usuario nunca se utilizan directamente. La
lectura aplica las mismas reglas de participación que el resto del expediente.
El archivado conserva las referencias históricas y una futura política
institucional podrá definir retención o anonimización sin que el prototipo
realice borrados destructivos.

La autenticación sigue el flujo de código de autorización de OIDC. En el primer
ingreso se crea o actualiza una identidad local con privilegio de participante;
la función administrativa se concede de forma explícita. Después del retorno del
proveedor, el servidor establece una sesión propia mediante una cookie
`HttpOnly`, `Secure` y `SameSite`, por lo que la aplicación web no almacena
credenciales sensibles. Las páginas públicas del catálogo no requieren sesión.

La autorización combina tres niveles. El rol global habilita funciones
administrativas o de participación; la asignación del caso identifica los
recursos que ocupa la persona; y la versión del proceso declara qué recursos
pueden ejecutar cada transición. Consultar un expediente exige participar en el
caso o ejercer una función administrativa expresamente autorizada. La excepción
de emergencia no se confunde con el acceso ordinario y siempre queda justificada
y auditada.

La API HTTP se describe mediante OpenAPI 3.1 @openapi310. Las operaciones de la
aplicación utilizan la sesión y las reglas anteriores. La gestión de sistemas
externos es demostrativa: el administrador puede crear o revocar una clave y un
único endpoint dedicado verifica que esté activa antes de devolver una respuesta
ficticia. La clave no concede acceso a expedientes ni sustituye la autorización
de usuarios.

Las otras integraciones también respetan el alcance académico. Tunkunia produce
un reporte descargable con los datos necesarios para que la institución actualice
su catálogo en gob.bo, sin afirmar una sincronización directa. La acción de
consulta externa depende de una interfaz de cliente, pero el adaptador del
prototipo devuelve un dato simulado que precarga el campo de la transición. Una
implementación posterior podrá sustituir el adaptador por HTTP real sin trasladar
ese detalle a Petrunia ni a la definición del expediente.

Notificaciones conserva una bandeja interna. Se genera un aviso cuando una tarea
queda disponible para un participante y, para el ciudadano, cuando cambia el
estado de su caso. El aviso es información derivada de una actuación confirmada;
no sustituye al historial ni constituye evidencia de que la persona lo haya
leído. La entrega por correo u otros canales queda fuera del prototipo.

=== Interfaz y límites del prototipo

La SPA organiza la experiencia en tres áreas. El área pública presenta el
catálogo y el detalle de cada trámite. El área del participante reúne los casos,
la bandeja de avisos, el expediente, el mapa del marcado y la pantalla uniforme
de acción. El área administrativa contiene los datos institucionales, usuarios,
grupos y el editor de trámites. Esta separación responde a tareas distintas y no
impide que una misma identidad posea más de un rol global.

El editor gráfico permite crear lugares, transiciones y arcos; asociar recursos;
definir el campo textual; configurar plazos y seleccionar lugares sumidero. Antes
de publicar, valida al menos las referencias, la estructura de la red y la
existencia de los metadatos requeridos. La interfaz de ejecución no expone la
complejidad interna: resalta las transiciones habilitadas como acciones y explica
por qué una acción dejó de estar disponible cuando ocurre un conflicto de
concurrencia.

El diseño favorece formularios sencillos, mensajes de validación próximos al
campo, navegación por teclado y estados visibles de carga, éxito y error. Estos
criterios son especialmente importantes para ciudadanos que utilizan el sistema
de manera ocasional. No se declara conformidad completa con un estándar de
accesibilidad, pero la interfaz debe conservar semántica, foco, contraste y
adaptación a pantallas de distinto tamaño.

El prototipo no contempla multitenencia, ejecución distribuida, alta
disponibilidad, webhooks, un bus de eventos ni un registro de acciones
enchufables. Tampoco implementa colores que transporten datos ni transiciones
automáticas generales: el color identifica al caso y solo los vencimientos se
procesan sin intervención humana. Estas restricciones mantienen verificable el
núcleo elegido.

La evolución puede incorporar nuevos tipos de campo, adaptadores externos reales
y canales de notificación sin modificar la semántica de los casos. Petrunia
podría adquirir versionado independiente mientras conserve su contrato puro de
red y marcado. Estas posibilidades son direcciones de evolución, no compromisos
funcionales del prototipo ni una segunda definición de la reutilización del
producto.
