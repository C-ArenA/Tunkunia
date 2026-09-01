# Tunkunia

Tunkunia es un digitalizador de trámites, un sistema abierto y reutilizable para definir, ejecutar y dar
seguimiento a flujos de *trámites* en instituciones públicas bolivianas. El
proyecto busca ofrecer un núcleo configurable que pueda adoptarse en distintas
instituciones sin desarrollar una aplicación independiente para cada
procedimiento.

> **Estado del proyecto:** prototipo funcional evolutivo. La API, la interfaz y
> el modelo de datos todavía pueden cambiar antes de la primera versión estable.

## Características principales

- Catálogo público y configurable de trámites.
- Definición y representación de procedimientos mediante redes de Petri.
- Inicio, ejecución y seguimiento de casos.
- Áreas diferenciadas para ciudadanía, servidores públicos y administración.
- Autenticación federada mediante OpenID Connect (OIDC).
- API HTTP especificada con OpenAPI.
- Persistencia local con SQLite.
- Aplicación web adaptable a distintos dispositivos.

## Arquitectura y tecnologías

Tunkunia es un monolito modular con arquitectura cliente-servidor. El servidor
está escrito en Go y organiza sus capacidades de negocio en módulos internos;
la interfaz es una aplicación Nuxt que consume la API HTTP. En desarrollo,
Caddy proporciona un origen HTTPS único y Dex simula un proveedor OIDC externo.

Tecnologías principales:

- Go 1.26, Chi, Cobra y oapi-codegen.
- SQLite, Goose, SQLC y Jet.
- Nuxt 4, Vue 3, TypeScript y Nuxt UI.
- pnpm para el espacio de trabajo de JavaScript.
- Caddy como proxy inverso local.
- Dex como proveedor OIDC de desarrollo.
- Task para automatizar las operaciones habituales.

## Instalación para desarrollo

### 1. Requisitos

Instala las siguientes herramientas:

- [Git](https://git-scm.com/).
- [Go](https://go.dev/doc/install) **1.26.3 o posterior compatible con el módulo**.
- [Node.js](https://nodejs.org/) y [pnpm](https://pnpm.io/installation)
  **11.18 o posterior dentro de la versión 11**.
- [Caddy](https://caddyserver.com/docs/install).
- [Dex](https://github.com/dexidp/dex/releases), únicamente para probar OIDC
  de forma local.

No es necesario instalar Task, Air, Goose, SQLC ni los demás programas Go de
desarrollo globalmente: el módulo los declara como herramientas y se ejecutan
mediante `go tool`.

### 2. Obtener el código

```sh
git clone https://github.com/C-ArenA/Tunkunia.git
cd Tunkunia
```

### 3. Instalar las dependencias

```sh
go mod download
pnpm install
```

### 4. Configurar el entorno

Copia la configuración de ejemplo:

```sh
cp .env.example .env
```

Los valores incluidos están preparados para el entorno local. Antes de iniciar
el sistema, reemplaza al menos `JWT_SECRET` y `OIDC_SECRET` por secretos de
desarrollo propios. `OIDC_SECRET` debe coincidir con el valor que Dex recibe
desde el mismo archivo `.env`.

La configuración completa y sus valores predeterminados se definen en
[`internal/config/config.go`](internal/config/config.go). No confirmes archivos
`.env`, bases de datos locales ni secretos en Git.

### 5. Instalar Dex localmente

Descarga un ejecutable de Dex compatible con tu sistema desde sus publicaciones
y colócalo en `bin/dex`:

```sh
mkdir -p bin
mv /ruta/al/ejecutable/dex bin/dex
chmod +x bin/dex
```

La configuración de prueba ya se encuentra en
[`dex/config.tunkunia.yaml`](dex/config.tunkunia.yaml). El directorio `bin/` se
ignora deliberadamente en Git, por lo que cada entorno debe proporcionar su
propio ejecutable.

### 6. Iniciar el entorno completo

Abre dos terminales en la raíz del repositorio.

En la primera inicia Dex y el proxy HTTPS:

```sh
go tool task dev:tools
```

En la segunda inicia el servidor Go y la aplicación Nuxt con recarga
automática:

```sh
go tool task dev:main
```

Después abre <https://localhost:8443>. Caddy genera un certificado local, por lo
que el navegador puede solicitar que confirmes su confianza la primera vez.

Servicios del entorno:

| Servicio | Dirección | Propósito |
| --- | --- | --- |
| Tunkunia mediante Caddy | `https://localhost:8443` | Punto de entrada recomendado |
| Servidor Go | `http://127.0.0.1:8080` | API y rutas del servidor |
| Nuxt | `http://localhost:3000` | Servidor de desarrollo de la SPA |
| Dex | `http://127.0.0.1:5556/dex` | Proveedor OIDC local |

El servidor crea `database/tunkunia.db`, aplica las migraciones y carga datos de
demostración automáticamente cuando `ENV=dev`.

### Ejecución parcial

También puedes iniciar componentes por separado:

```sh
go run . serve                 # servidor sin recarga automática
go tool task server:dev        # servidor con Air
pnpm --filter spa dev          # aplicación Nuxt
go tool task dex:serve         # proveedor OIDC local
go tool task dev:caddy         # proxy HTTPS
go tool task scalar:dev        # documentación interactiva de la API
```

El inicio de sesión y las *cookies* seguras se prueban mediante la dirección
HTTPS de Caddy. Acceder directamente a Nuxt o al servidor puede omitir parte de
ese flujo.

## Comprobación y construcción

### Backend

```sh
go test ./...
go build .
```

### Aplicación web

```sh
pnpm --filter spa fmt:check
pnpm --filter spa lint
pnpm --filter spa build
```

### Contrato OpenAPI y código generado

```sh
go tool task openapi:lint
go generate ./...
pnpm --filter spa openapi-ts
```

No edites manualmente los archivos generados bajo `database/sqlc/`,
`database/jet/` o `internal/api/v1/oapi/`.

### Documentación

La memoria y los documentos técnicos usan Typst. Sus instrucciones específicas
se encuentran en [`docs/README.md`](docs/README.md). Con las dependencias de
documentación instaladas, la memoria se compila mediante:

```sh
go tool task docs:build:memoria
```

## Configuración principal

| Variable | Valor local predeterminado | Descripción |
| --- | --- | --- |
| `APP_URL` | `https://localhost:8443` | Origen público de la aplicación |
| `HOST` | `http://127.0.0.1` | Dirección base del servidor |
| `PORT` | `:8080` | Puerto HTTP del servidor Go |
| `DEV_NUXT_PORT` | `:3000` | Puerto de Nuxt en desarrollo |
| `ENV` | `dev` | Entorno de ejecución |
| `GOOSE_DBSTRING` | `./database/tunkunia.db` | Ruta de la base SQLite |
| `JWT_SECRET` | Sin valor seguro predeterminado | Clave de firma de la sesión |
| `OIDC_URL` | `http://127.0.0.1:5556/dex` | Emisor OIDC |
| `OIDC_CLIENT_ID` | `tunkunia` | Identificador del cliente OIDC |
| `OIDC_SECRET` | Solo demostrativo | Secreto del cliente OIDC |
| `FIRST_ADMIN_EMAIL` | `admin@example.com` | Primer usuario con administración |

Consulta `.env.example` y `internal/config/config.go` antes de configurar un
entorno diferente. Nunca reutilices los secretos de desarrollo en producción.

## Estructura del repositorio

```text
Tunkunia/
├── cmd/          # comandos y composición del ejecutable
├── internal/     # módulos y adaptadores del servidor
├── database/     # migraciones, semillas y código de persistencia
├── specs/        # contrato OpenAPI
├── spa/          # aplicación web Nuxt
├── site/         # sitio de documentación Astro
├── docs/         # memoria y documentación técnica
├── dex/          # configuración del proveedor OIDC local
└── Taskfile.yml  # automatización del desarrollo
```

Los módulos de negocio mantienen sus tipos, servicios y persistencia
encapsulados. La composición transversal permanece en `cmd/` e `internal/api/`.

## Contribuir

Las contribuciones son bienvenidas. Antes de proponer un cambio:

1. Crea una rama enfocada en una sola mejora.
2. Añade o actualiza pruebas junto al módulo afectado.
3. Ejecuta las comprobaciones de Go y de la SPA que correspondan.
4. No incluyas secretos, bases locales ni artefactos generados fuera del flujo
   establecido.
5. Usa mensajes de commit compatibles con
   [Conventional Commits](https://www.conventionalcommits.org/), por ejemplo
   `feat:`, `fix:` o `docs:`.

Al abrir un *pull request*, describe el comportamiento modificado, enumera las
comprobaciones ejecutadas e incluye capturas para cambios visuales.

## Licencia

El software, la documentación técnica, las herramientas de construcción y las
plantillas reutilizables se distribuyen bajo la licencia MIT. Parte del
contenido literario y visual original de `docs/` está reservada y se rige por
[`docs/RIGHTS.md`](docs/RIGHTS.md). Consulta [`LICENSE`](LICENSE) para conocer el
alcance completo.
