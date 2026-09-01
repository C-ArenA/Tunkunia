#import "source-excerpt.typ": (
  before-marker, between-markers, from-marker, source-block,
)

#let repository-file(path, body) = link(
  "https://github.com/C-ArenA/Tunkunia/blob/master/" + path,
  body,
)

= Código y configuración representativos

Este anexo presenta fragmentos de código y configuración que evidencian el
arranque del sistema y la composición de su entorno de desarrollo. Cada sección
enlaza el archivo completo disponible en el repositorio público.

== Entrypoint del ejecutable

El siguiente fragmento de #repository-file("main.go", [`main.go`]) registra los
comandos de Tunkunia y ejecuta el comando seleccionado. Se omiten las directivas
`go:generate`, relacionadas con la generación de artefactos auxiliares.

#let main-entrypoint = (
  "package main\n\n// Se omiten las directivas go:generate.\n\n"
    + from-marker(
      "technical-main.go",
      "import (",
    )
)
#source-block(main-entrypoint, lang: "go")

== Configuración del backend

Los structs definidos en
#repository-file("internal/config/config.go", [`internal/config/config.go`])
constituyen la referencia canónica de las variables admitidas y sus valores
predeterminados.

#source-block(
  between-markers(
    "technical-config.go",
    "type RoutesConfig struct {",
    "func Load()",
  ),
  lang: "go",
)

== Proxy inverso

El #repository-file("Caddyfile", [`Caddyfile`]) proporciona el origen HTTPS del
entorno local y dirige cada ruta al servidor Go o a Nuxt.

#source-block(read("technical-Caddyfile").trim(), lang: "caddyfile")

== Proveedor OIDC de desarrollo

El fragmento de
#repository-file("dex/config.tunkunia.yaml", [`dex/config.tunkunia.yaml`])
configura el emisor, el almacenamiento, los servicios y el cliente OIDC de
Tunkunia. Se omiten los usuarios estáticos y sus hashes demostrativos.

#source-block(
  before-marker("technical-dex.yaml", "staticPasswords:"),
  lang: "yaml",
)
