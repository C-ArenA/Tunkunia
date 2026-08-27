#import "@preview/touying:0.7.1": *
#import themes.metropolis: *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(handout: true),
  config-info(
    title: [Tunkunia],
    subtitle: [Informe 2 — Requerimientos, arquitectura y diseño],
    author: [Ernesto Carlos Arena Alarcon],
    date: datetime.today(),
    institution: [Universidad Mayor de San Andrés],
    contact: [ecarena\@umsa.bo],
    logo: emoji.clipboard,
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))
#set text(size: 19pt)

#let compact-caption(body) = text(size: 13pt, fill: luma(35%), body)

#title-slide()

== El marco teórico conduce a un motor formal de trámites

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    #figure(
      image("/assets/figures/vanderaals3dwf.svg", width: 92%),
      caption: compact-caption([Tres dimensiones de un flujo de trabajo]),
    )
  ],
  [
    #figure(
      image("/assets/figures/petricomplaints.png", width: 88%),
      caption: compact-caption([Red de Petri aplicada a un proceso]),
    )
  ],
)

#align(center)[
  *Proceso* define actividades · *caso* conserva el estado · *recurso* determina quién actúa
]

== Tunkunia convierte capacidades de un WFMS en requerimientos

#figure(
  diagram(
    spacing: (23mm, 12mm),
    node-stroke: luma(78%),
    node-fill: luma(97%),
    node((1.5, 0), [*Tunkunia*], name: <t>),
    node((0, 1), [Definir], name: <d>),
    node((1, 1), [Ejecutar], name: <e>),
    node((2, 1), [Registrar], name: <r>),
    node((3, 1), [Controlar], name: <c>),
    node((0, 2), [Proceso\ versionado], name: <dv>),
    node((1, 2), [Casos y\ acciones], name: <ev>),
    node((2, 2), [Expediente\ e historial], name: <rv>),
    node((3, 2), [Estado, plazos\ y auditoría], name: <cv>),
    edge(<t>, <d>),
    edge(<t>, <e>),
    edge(<t>, <r>),
    edge(<t>, <c>),
    edge(<d>, <dv>),
    edge(<e>, <ev>),
    edge(<r>, <rv>),
    edge(<c>, <cv>),
  ),
  placement: auto,
)

#align(center)[#text(
  size: 16pt,
)[Servicios comunes: identidad · autorización · notificaciones · interoperabilidad]]

== El sistema se integra al ecosistema público boliviano

#figure(
  image("/assets/figures/tunkunia-system-context.pdf", width: 88%),
  caption: compact-caption(
    [Ciudadanos, servidores públicos, institución y plataformas externas delimitan el sistema],
  ),
)

== Los requerimientos priorizan reutilización y trazabilidad

#table(
  columns: (1.15fr, 2.4fr, 2.4fr),
  align: (left + horizon, left, left),
  fill: (_, y) => if y == 0 { rgb(230, 230, 230) },
  inset: (.45em, .6em),
  table.header([Eje], [Necesidad principal], [Criterio de solución]),
  [*Adopción*],
  [Configurar distintos trámites e instituciones],
  [Un producto; una instancia configurable por institución],

  [*Operación*],
  [Ejecutar acciones válidas y conocer el estado],
  [Proceso versionado, marcado por caso y control de concurrencia],

  [*Evidencia*],
  [Explicar quién hizo qué y cuándo],
  [Expediente, historial y auditoría de solo adición],

  [*Acceso*],
  [Atender ciudadanos y servidores con responsabilidades distintas],
  [OIDC, rol global, recurso del caso y permiso de transición],

  [*Integración*],
  [Relacionarse con gob.bo y sistemas autorizados],
  [OpenAPI y adaptadores sustituibles; simulación en el prototipo],
)

== La arquitectura equilibra simplicidad y separación

#grid(
  columns: (1fr, 1fr),
  gutter: 1.8em,
  [
    #text(size: 22pt, weight: "bold")[Aplicación configurable]

    Una instancia por institución; trámites y participantes se definen sin crear otro producto.

    #text(size: 22pt, weight: "bold")[Monolito modular]

    Un proceso y un despliegue, con dominio, servicios y persistencia encapsulados por capacidad.
  ],
  [
    #text(size: 22pt, weight: "bold")[Petrunia independiente]

    Motor Go puro: recibe red, marcado y transición; no conoce HTTP, usuarios ni expedientes.

    #text(size: 22pt, weight: "bold")[Despliegue deliberadamente simple]

    Proxy HTTPS, binario Go, SPA estática, SQLite y documentos en volumen persistente.
  ],
)

#align(center)[#text(
  size: 17pt,
  weight: "bold",
)[La corrección y trazabilidad del caso prevalecen sobre la distribución prematura.]]

== Los módulos siguen capacidades del dominio

#figure(
  image("/assets/figures/tunkunia-modules.svg", width: 92%),
  caption: compact-caption(
    [Casos coordina la ejecución sin acceder a implementaciones internas de otros módulos],
  ),
)

== El diseño separa la definición del trámite de cada caso

#figure(
  image("/assets/figures/tunkunia-domain-model.svg", width: 93%),
  caption: compact-caption(
    [Una versión publicada es inmutable; cada caso conserva marcado, expediente, asignaciones e historial],
  ),
)

== Cada acción se valida y confirma como una unidad

#figure(
  image("/assets/figures/tunkunia-case-action-sequence.svg", width: 90%),
  caption: compact-caption(
    [Versión, habilitación, entrada y autorización se comprueban antes de modificar el caso],
  ),
)

== El diseño mantiene un núcleo reutilizable y verificable

#grid(
  columns: (1fr, 1fr),
  gutter: 1.8em,
  [
    #text(size: 22pt, weight: "bold")[Núcleo común]

    - Modelado formal y versionado
    - Ejecución mediante marcado
    - Expediente e historial
    - Autorización contextual
    - Auditoría e interfaces documentadas
  ],
  [
    #text(size: 22pt, weight: "bold")[Límites del prototipo]

    - Sin multitenencia ni alta disponibilidad
    - Integraciones externas simuladas
    - Formularios y notificaciones básicos
    - Sin bus de eventos ni complementos generales
    - Evolución mediante adaptadores y tipos de campo
  ],
)

#align(center)[
  #text(
    size: 24pt,
    weight: "bold",
  )[Resultado: una base abierta para digitalizar trámites diversos sin acoplarla a un caso particular.]
]
