#import "/shared/theme/lib.typ": img-fig

== Construcción del prototipo

=== Alcance y estrategia de construcción

Este capítulo describe la construcción del prototipo funcional de Tunkunia y la
correspondencia entre sus elementos ejecutables. La exposición se concentra en
las tecnologías, el código, la integración y los artefactos obtenidos; las
decisiones estructurales se desarrollan en el capítulo de arquitectura y las
especificaciones detalladas en el capítulo de diseño.

La construcción se realizó de forma incremental. Primero se establecieron el
contrato HTTP y la persistencia del catálogo; después se incorporaron los
módulos de usuarios y autenticación; finalmente se integraron la aplicación web,
la edición de procedimientos y las vistas de seguimiento. En cada incremento se
mantuvieron ejecutables el servidor, la base de datos y el cliente, lo que
permitió comprobar la integración durante el desarrollo.

Tunkunia se implementó como un monolito modular con una aplicación web separada.
El servidor conserva los límites de las capacidades de negocio y expone una API
REST; la aplicación web consume dicho contrato y presenta interfaces públicas,
de participantes y de administración. Los servicios locales de identidad y
proxy reproducen las condiciones necesarias para ejecutar el conjunto mediante
HTTPS.

=== Tecnologías y organización del código

La selección tecnológica favoreció herramientas de software libre, contratos
abiertos y una separación clara entre dominio, transporte y persistencia. La
@table:implementation-stack resume los elementos principales empleados.

#pagebreak(weak: true)

#figure(
  table(
    columns: (1.15fr, 1.45fr, 2.4fr),
    align: (left, left, left),
    inset: (3pt, 5pt),
    table.header([Elemento], [Tecnología], [Función]),
    [Servidor],
    [Go 1.26 y Chi 5],
    [Composición, lógica de negocio y transporte HTTP.],

    [Línea de comandos],
    [Cobra 1.10],
    [Arranque del servidor y operaciones administrativas.],

    [Persistencia],
    [SQLite, Goose, SQLC y Jet],
    [Migraciones, consultas tipadas y acceso a datos.],

    [Contrato],
    [OpenAPI 3.1 y oapi-codegen],
    [Especificación, validación y tipos del servidor.],

    [Aplicación web],
    [Nuxt 4, Vue 3 y TypeScript],
    [Interfaz de página única para los distintos actores.],

    [Interfaz visual],
    [Nuxt UI 4 y Tailwind CSS 4],
    [Componentes, estilos responsivos y estados de interacción.],

    [Cliente HTTP],
    [Hey API y Pinia Colada],
    [Cliente generado, consultas y caché de datos.],

    [Identidad],
    [OIDC, Dex y JWT],
    [Autenticación federada simulada y sesión local.],

    [Proxy local],
    [Caddy],
    [Origen HTTPS único para el servidor y la aplicación web.],
  ),
  caption: [Tecnologías principales de la implementación],
  placement: auto,
)<table:implementation-stack>

El repositorio reúne en una sola unidad versionada el servidor, el cliente, las
especificaciones y la documentación. Su organización relevante se resume a
continuación; se omiten dependencias descargadas, cachés y archivos de
compilación.

```text
Tunkunia/
├── cmd/                 # comandos y arranque
├── internal/
│   ├── api/             # transporte HTTP
│   ├── authn/           # OIDC y sesión JWT
│   ├── catalog/         # catálogo de trámites
│   ├── user/            # usuarios y roles
│   └── health/          # estado operativo
├── database/
│   ├── migrations/      # evolución del esquema
│   ├── seeds/           # datos iniciales
│   ├── sqlc/            # consultas generadas
│   └── jet/             # modelo relacional
├── specs/v1/            # contrato OpenAPI
├── spa/                 # aplicación Nuxt
└── docs/                # documentación
```

Esta distribución conserva las capacidades de negocio dentro de `internal/` y
limita la composición a los puntos de entrada. Los módulos intercambian tipos o
interfaces deliberadas y no utilizan los modelos generados de la base de datos
como contratos públicos.

=== Implementación del servidor

==== Composición y módulos de negocio

El ejecutable principal utiliza Cobra para registrar los comandos del sistema.
El comando `serve` carga la configuración, abre la base de datos, aplica las
migraciones y conecta los servicios con sus adaptadores HTTP. Sobre el enrutador
Chi se instalan, en orden, las políticas CORS, el registro de solicitudes y la
recuperación de la identidad antes de montar las rutas OIDC, la API versionada y
los recursos públicos.

El módulo `catalog` implementa la creación, consulta, modificación, publicación,
archivo y eliminación de definiciones de trámite. Su servicio depende de una
interfaz de repositorio, mientras que el adaptador SQLite traduce entre los
tipos del dominio y los modelos de persistencia. El módulo `user` mantiene la
identidad local, los roles y la asignación inicial de administración. El módulo
`authn` integra el proveedor OIDC, establece la sesión y construye el principal
que utilizan los demás manejadores. El módulo `health` aporta una comprobación
operativa independiente de las capacidades de negocio.

==== Persistencia y contrato HTTP

SQLite contiene las tablas de usuarios, roles y trámites. Goose aplica las
migraciones en el arranque y carga datos demostrativos durante el desarrollo.
Las restricciones de unicidad, claves foráneas e índices complementan las
validaciones del dominio. SQLC genera consultas tipadas para las operaciones
directas y Jet construye dinámicamente las consultas que requieren filtros,
ordenamiento o actualización selectiva.

La API se especificó en OpenAPI 3.1 mediante archivos separados para catálogo,
identidad, salud, auditoría y respuestas comunes. A partir del contrato se
generaron los tipos y las interfaces estrictas del servidor. Un _middleware_
valida cada solicitud contra la especificación antes de ejecutar el manejador y
convierte los fallos en respuestas HTTP uniformes. Los manejadores sólo realizan
la adaptación entre los objetos de transporte y los tipos pertenecientes a cada
módulo.

La versión implementada expone los recursos `/health`, `/me`, `/tramites` y
`/tramites/{id}` bajo `/api/v1`. Esta organización mantiene explícito el
versionado y permite generar el cliente de la SPA desde la misma fuente que
define al servidor.

==== Identidad y control de acceso

El inicio de sesión emplea el flujo de código de autorización de OIDC. El
servidor genera un valor aleatorio de estado, redirige al proveedor, valida la
respuesta y actualiza el usuario local a partir de los _claims_ `sub`, `email`,
`email_verified` y `name`. Después emite un JWT firmado que se conserva en una
_cookie_ segura, `HttpOnly` y `SameSite=Lax`.

Cada solicitud recupera la sesión desde la _cookie_ o desde el encabezado de
autorización. La identidad resultante se incorpora al contexto HTTP y la
validación OpenAPI rechaza las operaciones protegidas cuando no existe un
principal autenticado. En el cliente, los _middleware_ de Nuxt protegen las
rutas de participante y verifican el rol `admin` para las rutas de gestión.

=== Implementación de la aplicación web

La SPA se construyó con Nuxt en modo cliente. Tres _layouts_ separan el portal
público, el espacio de participantes y la administración. Las reglas de ruta
asignan automáticamente el _layout_ y los controles de acceso correspondientes,
mientras que Nuxt UI proporciona componentes consistentes para navegación,
formularios, tablas, alertas, esqueletos de carga y estados vacíos.

El portal público muestra la identidad de la institución, lista los trámites
disponibles y presenta su descripción y procedimiento. El área autenticada
permite buscar trámites, iniciar un caso, consultar su avance e historial y
atender tareas personales. El área administrativa reúne el catálogo, la edición
de cada trámite, la representación de su procedimiento, los usuarios y la
configuración institucional.

La integración con el servidor utiliza un cliente TypeScript generado desde la
especificación OpenAPI. Las consultas declarativas de Pinia Colada mantienen el
estado de carga, los datos y los errores, y las operaciones administrativas
invocan directamente las funciones generadas de creación, actualización y
eliminación. De este modo, el cliente y el servidor comparten las mismas formas
de datos sin duplicar manualmente el contrato.

Los procedimientos se representan mediante lugares, transiciones y arcos
dirigidos. `ProcedureEditor` permite incorporar y retirar elementos, modificar
sus etiquetas y posiciones y validar las conexiones; `ProcedureDiagram` genera
una representación SVG reutilizada en la edición, la consulta pública y el
seguimiento del caso. Los casos, tareas y datos institucionales del recorrido
demostrativo se conservan en el estado reactivo y en el almacenamiento local del
navegador, lo que mantiene los cambios entre sesiones del prototipo.

Las páginas contemplan estados de espera, error y ausencia de resultados. La
navegación se adapta a pantallas pequeñas mediante paneles y cuadrículas
responsivas; los controles emplean etiquetas, nombres accesibles e indicadores
visuales que no dependen exclusivamente del color.

=== Vistas del sistema

Las siguientes figuras presentan algunas vistas relevantes de la interfaz y de
los componentes técnicos del sistema.

#img-fig(
  "/assets/figures/imp_home.png",
  [Portal público y catálogo institucional de trámites],
  <fig:implementation-public-home>,
  width: 100%,
)

#img-fig(
  "/assets/figures/imp_app.png",
  [Catálogo de trámites del área de participantes],
  <fig:implementation-participant-catalog>,
  width: 100%,
)

#img-fig(
  "/assets/figures/imp_net_example.png",
  [Inicio de un caso y representación de su procedimiento],
  <fig:implementation-procedure-view>,
  width: 100%,
)

#img-fig(
  "/assets/figures/imp_scalar_api.png",
  [Documentación interactiva de la API HTTP],
  <fig:implementation-api-documentation>,
  width: 100%,
)

#img-fig(
  "/assets/figures/imp_dex.png",
  [Inicio de sesión mediante el proveedor OIDC],
  <fig:implementation-oidc-login>,
  width: 100%,
)

#img-fig(
  "/assets/figures/imp_cli_routes.png",
  [Rutas HTTP registradas al iniciar el servidor],
  <fig:implementation-http-routes>,
  width: 100%,
)

=== Integración, configuración y construcción

Dex actúa como proveedor OIDC del entorno controlado y permite recorrer el mismo
protocolo previsto para un servicio externo de identidad. Su configuración
registra a Tunkunia como cliente, habilita usuarios locales de prueba y expone
los puntos de autorización y emisión de tokens. Esta sustitución permite probar
el flujo sin afirmar una integración operativa con Ciudadanía Digital.

Caddy ofrece un único origen HTTPS y distribuye las solicitudes entre Nuxt y el
servidor Go. Esto permite usar _cookies_ seguras durante el desarrollo y evita
diferencias innecesarias con la terminación TLS de un despliegue. La base de
datos SQLite completa el entorno autocontenido y facilita iniciar una instancia
sin un servicio de persistencia externo.

La configuración se carga desde variables de entorno y, en desarrollo, desde
archivos `.env`. Los valores admitidos y sus predeterminados se declaran en
`internal/config/config.go`; las claves de firma y credenciales se suministran
externamente y no se incorporan al código ni a la documentación.

La generación reproducible se centraliza mediante `go generate ./...`: SQLC y
Jet producen los adaptadores de datos, Redocly agrupa y valida la especificación
OpenAPI y oapi-codegen genera el transporte del servidor. El _plugin_ de Hey API
genera el cliente TypeScript durante la construcción de la SPA. Estos artefactos
no se editan manualmente.

El conjunto puede comprobarse y construirse con las siguientes operaciones:

```sh
go test ./...
go build .
go generate ./...
pnpm --filter spa lint
pnpm --filter spa fmt:check
pnpm --filter spa build
```

Las tareas del repositorio añaden arranque con recarga automática, migración de
la base de datos, ejecución de Dex y Caddy, validación de OpenAPI y compilación
de la documentación. El resultado desplegable comprende el ejecutable Go, los
recursos construidos de la SPA, las migraciones, la especificación OpenAPI y la
configuración externa de la instancia.

=== Funcionalidad alcanzada y relación con la validación

La implementación integra un catálogo configurable, una API versionada, una
aplicación web para tres contextos de uso, autenticación federada simulada y una
representación interactiva del procedimiento. La separación modular y el uso de
contratos generados permiten sustituir adaptadores o ampliar capacidades sin
acoplar el núcleo a una institución o a un trámite específico.

El prototipo también proporciona el recorrido visual de creación, publicación,
consulta, inicio y seguimiento de trámites. Los datos demostrativos permiten
recorrer estas funciones sin utilizar información institucional real. La
ejecución de casos representativos y la evaluación de sus resultados se
presentan en el capítulo de validación.
