#import "@preview/touying:0.7.1": *
#import themes.metropolis: *
#import "@preview/timeliney:0.4.0"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Tunkunia],
    subtitle: [Informe 1],
    author: [Ernesto Carlos Arena Alarcon],
    date: datetime.today(),
    institution: [Universidad Mayor de San Andrés],
    contact: [ecarena\@umsa.bo],
    logo: emoji.clipboard,
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

= Puntos a Tratar <touying:hidden>

#outline(title: none, indent: 1em, depth: 1)

= Metodología del Proyecto

---

== Definición

PMBOK y Confección

- Características del Proyecto
- Objetivos de la Metodología

== Modificaciones sobre RUP
- Actores Principales Definidos
- Fases orientadas a la priorización
- Artefactos evolutivos (Todos)
- Viajar Liviano
- Diagramas modernos y flexibles
- Gestión atómica de tareas definida (Qué hago ahora)
- Iteraciones Cortas
- Pair Programming

== Artefactos Iniciales

No es una lista completa\*
#figure(
  table(
    columns: (2fr, 4fr, 1fr, 1fr, 1fr, 1fr),
    align: (center + horizon),
    fill: (x, y) => {
      if y == 0 {
        return rgb(230, 230, 230)
      }
    },
    inset: (.3em, .6em),
    table.header(
      "Disciplina",
      "Artefacto",
      "Inicio",
      "Elaboración",
      "Construcción",
      "Transición",
    ),
    table.cell(rowspan: 2)[Gestión del\ Proyecto],
    [Metodología], table.cell(colspan: 3, fill: rgb(200, 250, 150))[], [],
    [Cronograma del Proyecto],
    table.cell(colspan: 4, fill: rgb(200, 250, 150))[],
    table.cell(rowspan: 3)[Modelado del\ Negocio],
    [Perfil de Proyecto], table.cell(fill: rgb(200, 250, 150))[], [], [], [],
    [Lista de Trámites Modelados],
    [],
    table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
    [Lista de Procedimientos],
    [],
    table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
  ),
  placement: auto,
)<table:artifacts1>
#figure(
  table(
    columns: (2fr, 4fr, 1fr, 1fr, 1fr, 1fr),
    align: (center + horizon),
    fill: (x, y) => {
      if y == 0 {
        return rgb(230, 230, 230)
      }
    },
    inset: (.3em, .6em),
    table.header(
      "Disciplina",
      "Artefacto",
      "Inicio",
      "Elaboración",
      "Construcción",
      "Transición",
    ),

    table.cell(rowspan: 3)[Requerimientos],
    [Backlog de Historias de Usuario],
    table.cell(colspan: 4, fill: rgb(200, 250, 150))[],
    [Modelo de Casos de Uso],
    [],
    table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
    [Glosario], [], table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
    table.cell(rowspan: 2)[Análisis y Diseño],
    [Modelo de Diseño], [], table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
    [Arquitectura], [], table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
    table.cell(rowspan: 1)[Entorno],
    [Selección de Tecnologías],
    [],
    table.cell(colspan: 3, fill: rgb(200, 250, 150))[],
  ),
  placement: auto,
)<table:artifacts>





= Cronograma

---
#timeliney.timeline(
  show-grid: true,
  spacing: 5pt,
  box-milestones: false,
  {
    import timeliney: *

    headerline(group(([*Semanas 2026*], 20)))
    headerline(group(
      ("Marzo", 3),
      ("Abril", 5),
      ("Mayo", 4),
      ("Junio", 4),
      ("Julio", 4),
    ))
    headerline(group(..range(11, 31).map(n => text(size: 9pt)[#str(n)])))

    let iterStyle = (stroke: 3pt + gray)
    task([*Inicio*], (0, 6), style: (stroke: 8pt + gray))
    task(
      "i1.1 - i1.6",
      ..range(0, 6).map(i => (i + 0.1, i + 0.9)),
      style: iterStyle,
    )
    task([*Elaboración*], (6, 8), style: (stroke: 8pt + gray))
    task(
      "i2.7 - i2.8",
      ..range(6, 8).map(i => (i + 0.1, i + 0.9)),
      style: iterStyle,
    )
    task([*Construcción*], (8, 16), style: (stroke: 8pt + gray))
    task(
      "i3.9 - i3.16",
      ..range(8, 16).map(i => (i + 0.1, i + 0.9)),
      style: iterStyle,
    )
    task([*Transición*], (16, 20), style: (stroke: 8pt + gray))
    task(
      "i4.17 - i4.20",
      ..range(16, 20).map(i => (i + 0.1, i + 0.9)),
      style: iterStyle,
    )

    milestone(style: (stroke: (dash: "dashed")), at: 6, align(
      center,
    )[*Informe 1*])
    milestone(style: (stroke: (dash: "dashed")), at: 8, align(
      center,
    )[*Informe 2*])
    milestone(style: (stroke: (dash: "dashed")), at: 12, align(
      center,
    )[*Informe 3*])
    milestone(style: (stroke: (dash: "dashed")), at: 16, spacing: 23pt, align(
      center,
    )[*Informe 4*])
    milestone(style: (stroke: (dash: "dashed")), at: 20, align(
      center,
    )[*Informe 5*])
  },
)
= Modelado del Trámite

---

== Metodología
#columns(2)[
  === Fuentes
  - RASIM
  - gob.bo
  - Normativa

  === Selección

  - Roseth
  - Otros

  #figure(
    include "/assets/figures/vanderaals3dwf.typ",
  )<fig:vanderaals3dwf>
]

---

== Resultados Parciales
#figure(
  image("/assets/figures/ci_wfnet.png"),
)<fig:ex1>

= Backlog Inicial
#figure(
  diagram(
    spacing: (18mm, 10mm),
    node-stroke: luma(80%),
    node((1.5, 0), [*Tunkunia*\ Trámites], name: <t>),
    node((0, 1), [*Definición*], name: <d>),
    node((1, 1), [*Ejecución*], name: <e>),
    node((2, 1), [*Registro*], name: <r>),
    node((3, 1), [*Control*], name: <c>),
    node((2.5, 2), [*Seguimiento*], name: <s>),
    node((3.5, 2), [*Reporte*], name: <re>),

    edge(<t>, <d>),
    edge(<t>, <e>),
    edge(<t>, <r>),
    edge(<t>, <c>),
    edge(<c>, <s>),
    edge(<c>, <re>),
  ),
  caption: [Funciones a grandes rasgos de Tunkunia],
  placement: auto,
)<fig:modfun>


---

= Primer Prototipo

---

- Tecnologías
- Monorepositorio
- Entorno de Desarrollo
- Servidor
- Frontend
- Sitio de Documentación
- Artefactos con Control de Cambios
- Ya es *Software Libre*

= Retroalimentación

---

= Consultas

---

#focus-slide[
  Gracias!
]
