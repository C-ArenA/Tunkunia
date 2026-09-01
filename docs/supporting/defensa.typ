#import "@preview/touying:0.7.1": *
#import themes.metropolis: *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#let ink = rgb("#152126")
#let paper = rgb("#f4f1e8")
#let teal = rgb("#008c8c")
#let violet = rgb("#6f56a6")
#let violet-title = rgb("#b58cff")
#let amber = rgb("#d79024")
#let coral = rgb("#c9574f")
#let mist = rgb("#e4e1d9")
#let muted = rgb("#5d696d")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: [Tunkunia · Proyecto de grado],
  header-right: none,
  config-colors(
    primary: teal,
    primary-light: rgb("#a7d4d0"),
    secondary: ink,
    neutral-lightest: paper,
    neutral-dark: muted,
    neutral-darkest: ink,
  ),
  config-info(
    title: [Tunkunia],
    author: [Ernesto Carlos Arena Alarcon],
    institution: [Universidad Mayor de San Andrés],
  ),
)

#set text(font: "Lekton Nerd Font Propo", size: 20pt, fill: ink)
#set par(leading: 0.62em)
#set list(marker: [#text(fill: teal)[•]], indent: 1.15em, body-indent: .45em)
#show strong: set text(weight: "bold", fill: ink)

#let t(body, size: 32pt) = text(size: size, weight: "bold", body)
#let big(body, fill: ink, size: 38pt) = text(
  size: size,
  weight: "bold",
  fill: fill,
  body,
)
#let label(body, fill: teal) = text(
  size: 14pt,
  weight: "bold",
  fill: fill,
  tracking: .08em,
  upper(body),
)
#let source(body) = align(right, text(size: 9pt, fill: muted, body))
#let hint(body) = text(size: 13pt, fill: muted, style: "italic", body)
#let caption(body) = text(size: 12pt, fill: muted, body)

#let panel(body, fill: white, stroke: mist, inset: 12pt, radius: 4pt) = box(
  width: 100%,
  fill: fill,
  stroke: .7pt + stroke,
  radius: radius,
  inset: inset,
  body,
)

#let imgcard(path, cap: none, width: 100%, height: auto, fill: white) = panel(
  fill: fill,
  inset: 8pt,
  stack(
    dir: ttb,
    spacing: 5pt,
    image(path, width: width, height: height, fit: "contain"),
    if cap != none { caption(cap) },
  ),
)

#let keyword(body, fill: teal, size: 23pt) = box(
  inset: (x: 9pt, y: 5pt),
  radius: 3pt,
  fill: fill.lighten(85%),
  text(fill: fill.darken(20%), size: size, weight: "bold", body),
)

#let technology-logos = grid(
  columns: (1fr,) * 7,
  gutter: 20pt,
  align: center + horizon,
  image("/assets/logos/go.svg", height: 29pt),
  image("/assets/logos/vue.svg", height: 27pt),
  image("/assets/logos/dex.png", height: 29pt),
  image("/assets/logos/nuxt.svg", height: 27pt),
  image("/assets/logos/caddy.svg", height: 28pt),
  image("/assets/logos/sqlite.svg", height: 27pt),
  image("/assets/logos/openapi.svg", height: 28pt),
)

#let technology-table = table(
  columns: (1.15fr, 1.55fr, 2.5fr),
  align: (left + horizon, left + horizon, left + horizon),
  inset: (x: 7pt, y: 5pt),
  stroke: .5pt + mist,
  fill: (x, y) => if y == 0 { ink } else if calc.odd(y) { rgb("#ebe8df") },
  table.header(
    text(fill: white, weight: "bold")[Área],
    text(fill: white, weight: "bold")[Tecnologías],
    text(fill: white, weight: "bold")[Responsabilidad],
  ),
  [Servidor], [Go 1.26 · Chi 5], [Composición, negocio y transporte HTTP],
  [CLI], [Cobra 1.10], [Arranque y operaciones administrativas],
  [Persistencia],
  [SQLite · Goose · SQLC · Jet],
  [Migraciones y acceso tipado a datos],

  [Contrato],
  [OpenAPI 3.1 · oapi-codegen],
  [Especificación, validación y tipos],

  [Aplicación web],
  [Nuxt 4 · Vue 3 · TypeScript],
  [SPA para los distintos actores],

  [Interfaz], [Nuxt UI 4 · Tailwind CSS 4], [Componentes y diseño responsivo],
  [Cliente HTTP],
  [Hey API · Pinia Colada],
  [Cliente generado, consultas y caché],

  [Identidad], [OIDC · Dex · JWT], [Identidad federada simulada y sesión local],
  [Proxy], [Caddy], [Origen HTTPS único],
)

// 1 · Portada
#focus-slide[
  #set text(fill: paper)
  #align(left + horizon)[
    #text(size: 54pt, weight: "bold", fill: teal)[Tunkunia]
    #v(6pt)
    #text(size: 28pt, weight: "bold")[
      #text(fill: violet-title)[Subsistema reutilizable] de #text(fill: coral)[software libre]
      para la gestión de #text(fill: teal.lighten(10%))[flujos de trámite]
      orientado al #text(fill: amber)[gobierno electrónico]
      en #text(fill: coral.lighten(15%))[Bolivia]
    ]
    #v(15pt)
    #line(length: 55%, stroke: 2pt + teal)
    #v(9pt)
    #text(size: 15pt, fill: paper.darken(15%))[Ernesto Carlos Arena Alarcon]
    #linebreak()
    #text(
      size: 14pt,
      fill: paper.darken(20%),
    )[Universidad Mayor de San Andrés · 2026]
  ]
]

// 2 · Antecedentes
#slide(
  title: t[Una experiencia concreta reveló un patrón repetido],
  align: top,
)[
  #grid(
    columns: (1.25fr, .75fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/background.png",
      cap: [Del trámite tradicional a las funcionalidades comunes],
      height: 180pt,
    ),
    imgcard(
      "/assets/figures/convenio_umsa_agetic.png",
      cap: [Convenio de co-creación digital entre universidades y AGETIC],
      height: 180pt,
    ),
  )
  #v(5pt)
  #align(center)[#big(
    size: 27pt,
  )[Los mismos mecanismos aparecían una y otra vez.]]
  #source[Fuentes: memoria del proyecto; AGETIC.]
]

// 3 · Internet en Bolivia
#slide(
  title: t[Bolivia ya tiene una base digital para migrar más trámites],
  align: top,
)[
  #grid(
    columns: (1.5fr, .5fr),
    gutter: 20pt,
    imgcard(
      "/assets/figures/internet_use_bolivia.png",
      cap: [Usuarios de Internet en Bolivia y su crecimiento],
      height: 270pt,
    ),
    align(center + horizon)[
      #big(fill: teal, size: 52pt)[70,2 %]
      #v(6pt)
      #text(size: 20pt)[de la población boliviana usaba Internet en 2023]
      #v(14pt)
      #hint[La transición debe conservar un puente con la atención presencial.]
    ],
  )
  #source[Fuente: Unión Internacional de Telecomunicaciones, según la memoria.]
]

// 4 · Camunda y PocketBase
#slide(
  title: t[Hay motores y sistemas configurables, pero no el subsistema buscado],
  align: top,
)[
  #grid(
    columns: (1.35fr, .65fr),
    gutter: 20pt,
    imgcard(
      "/assets/figures/camunda_modeler.png",
      cap: [Camunda: modelado BPMN ejecutable y orquestación],
      height: 215pt,
    ),
    [
      #set text(size: 17pt)
      #stack(
        dir: ttb,
        spacing: 12pt,
        label(fill: violet)[PocketBase],
        big(fill: violet, size: 30pt)[backend configurable],
        [Un sistema especializado que permite desplegar funcionalidad mediante configuración y conservar interfaces para extensiones.],
        line(length: 100%, stroke: 1pt + mist),
        text(size: 18pt, weight: "bold", fill: coral)[Brecha],
        [Especialización en trámites + integración + software libre + contexto boliviano.],
      )
    ],
  )
  #source[Camunda: documentación oficial. PocketBase: caracterización incluida en la memoria.]
]

// 5 · Ecosistema
#slide(
  title: t[El ecosistema revisado resuelve partes aisladas del problema],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 28pt,
    [
      #label[Sistemas y tecnologías]
      #v(6pt)
      #set text(size: 17pt)
      - SIAI — antecedente directo
      - R2 Docuo — seguimiento documental
      - Odoo — modularidad y workflows
      - COSA / CONE — redes de Petri
      - Insite CRM — editor visual
      - POTyS y OTTO — servicios públicos
      - Stateflow — máquinas de estado
      - Temporal — ejecución durable
      - n8n — automatización e integración
    ],
    [
      #label(fill: violet)[Trabajos académicos]
      #v(6pt)
      #set text(size: 17pt)
      - UMSA: control de trámites y Máquinas de Turing
      - Cayaltí: módulo reutilizable e interoperable
      - Colegio profesional: sistema web con SCRUM
      - URP: trámite documental con pruebas
      - Huancayo: reducción del tiempo de atención
      - Ancash: puente digital–presencial
      - Fuerzas Armadas: integración de firma digital
    ],
  )
  #v(7pt)
  #align(center)[#big(
    size: 28pt,
  )[No se encontró una solución que reuniera todas las características.]]
]

// 6 · Normativa
#slide(
  title: t[La solución debe responder a una red normativa boliviana],
  align: top,
)[
  #imgcard(
    "/assets/figures/bolivia_norms.png",
    cap: [Documentos normativos de gobierno electrónico y sus relaciones principales],
    height: 305pt,
  )
  #source[Elaboración del proyecto a partir de la normativa citada en la memoria.]
]

// 7 · Problema
#focus-slide[
  #set text(fill: paper)
  #align(center + horizon)[
    #label(fill: amber)[Problema principal]
    #v(16pt)
    #text(
      size: 52pt,
      weight: "bold",
    )[Desarrollos repetidos de lo mismo en cuanto a trámites]
    #v(24pt)
    #text(
      size: 18pt,
      fill: paper.darken(20%),
    )[tiempo · costo · mantenimiento · fragmentación · baja estandarización]
  ]
]

// 8 · Objetivo
#slide(title: t[Objetivo general], align: top)[
  #v(8pt)
  #panel(
    fill: white,
    inset: 20pt,
    [#set text(size: 23pt)
      #set par(leading: .72em)
      *Implementar*, como producto mínimo viable, un
      #text(
        fill: violet,
        weight: "bold",
      )[subsistema reutilizable de software libre]
      especializado en la gestión de #text(fill: teal, weight: "bold")[flujos de trámite]
      que, mediante técnicas de modelado, represente los aspectos *comunes* del trámite
      y pueda ser adoptado por #text(fill: amber, weight: "bold")[distintas instituciones públicas bolivianas]
      mediante adaptación o configuración mínima y siguiendo los lineamientos nacionales de gobierno electrónico.
    ],
  )
  #v(16pt)
  #align(center)[
    #keyword[MVP] #h(8pt)
    #keyword(fill: violet)[configurable] #h(8pt)
    #keyword[formal] #h(8pt)
    #keyword(fill: coral)[FOSS]
  ]
]

// 9 · Constelación conceptual
#slide(title: t[Conceptos que sostienen la propuesta], align: top)[
  #align(center + horizon)[
    #stack(
      dir: ttb,
      spacing: 16pt,
      align(center)[#keyword(size: 30pt)[workflow] #h(14pt) #keyword(
          fill: violet,
        )[WFMS] #h(14pt) #keyword(fill: amber)[BPM]],
      align(center)[#keyword(fill: amber)[modelado de procesos] #h(
          12pt,
        ) #keyword(size: 31pt)[redes de Petri]],
      align(center)[#keyword(fill: violet)[requisitos] #h(
          12pt,
        ) #keyword[arquitectura] #h(12pt) #keyword(fill: coral)[modularidad]],
      align(center)[#keyword[interoperabilidad] #h(12pt) #keyword(
          fill: amber,
        )[REST] #h(12pt) #keyword(fill: violet)[OpenAPI]],
      align(center)[#keyword(fill: violet)[reutilización] #h(12pt) #keyword(
          fill: coral,
        )[software libre]],
    )
  ]
]

// 10 · Herramientas de modelado
#slide(title: t[Un trámite puede modelarse de distintas maneras], align: top)[
  #set text(size: 16pt)
  #v(3pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    row-gutter: 10pt,
    panel(
      [#label[Diagrama de flujo]#v(5pt)#linebreak()Actividades y decisiones],
    ),
    panel(
      [#label(fill: violet)[Actividad UML]#v(5pt)#linebreak()Procesos entre actores],
    ),
    panel(
      [#label(fill: amber)[EPC]#v(5pt)#linebreak()Eventos como elementos centrales],
    ),

    panel(
      [#label(fill: coral)[IDEF3]#v(5pt)#linebreak()Escenarios y descripción de procesos],
    ),
    panel([#label[BPMN]#v(5pt)#linebreak()Notación amplia y estandarizada]),
    panel(
      [#label(fill: violet)[Máquinas de estado]#v(5pt)#linebreak()Estados y cambios de una entidad],
    ),
  )
  #v(8pt)
  #align(center)[#big(
    fill: teal,
    size: 24pt,
  )[Redes de Petri: pocos elementos + semántica formal ejecutable]]
]

// 11 · Definición de Petri
#slide(
  title: t[Las redes de Petri hacen explícitos el estado y las acciones habilitadas],
  align: top,
)[
  #grid(
    columns: (.8fr, 1.2fr),
    gutter: 20pt,
    [
      #label[Definición]
      #v(8pt)
      #align(center)[#text(
        size: 27pt,
        weight: "bold",
      )[$cal(N) = chevron.l P, T, "Pre", "Post" chevron.r$]]
      #v(12pt)
      - $P$: lugares
      - $T$: transiciones
      - *tokens*: recursos o condiciones
      - *marcado*: estado actual
      #v(10pt)
      #hint[Una transición está habilitada cuando el marcado satisface sus precondiciones.]
    ],
    imgcard(
      "/assets/figures/petricomplaints.png",
      cap: [Red de Petri de un proceso de queja],
      height: 270pt,
    ),
  )
  #source[Figura: Van der Aalst, The Application of Petri Nets to Workflow Management.]
]

// 12 · Van der Aalst
#slide(
  title: t[Van der Aalst conecta el modelo formal con el workflow],
  align: top,
)[
  #grid(
    columns: (1.25fr, .75fr),
    gutter: 24pt,
    panel(
      fill: white,
      inset: 12pt,
      align(center)[#box(
        height: 265pt,
        include "/assets/figures/vanderaals3dwf.typ",
      )],
    ),
    stack(
      dir: ttb,
      spacing: 13pt,
      [#label[Caso]#linebreak()Instancia de un proceso.],
      [#label(fill: violet)[Recurso]#linebreak()Participante responsable.],
      [#label(fill: amber)[WF-net]#linebreak()Un único lugar de inicio y uno de término.],
      [#label(fill: coral)[Color]#linebreak()Identidad de cada caso dentro de la red.],
      [#label[Jerarquía]#linebreak()Transiciones que pueden contener subredes.],
    ),
  )
  #source[Fuente: Van der Aalst, según la memoria.]
]

// 13 · Ingeniería de software
#slide(
  title: t[La ingeniería de software convierte el modelo en un producto mantenible],
  align: top,
)[
  #grid(
    columns: (1.3fr, .7fr),
    gutter: 20pt,
    panel(
      fill: ink,
      inset: 10pt,
      stack(
        dir: ttb,
        spacing: 5pt,
        image(
          "/assets/figures/proceso_sommerville_white.png",
          height: 255pt,
          fit: "contain",
        ),
        text(fill: paper, size: 12pt)[Proceso del software según Sommerville],
      ),
    ),
    grid(
      columns: (1fr,),
      row-gutter: 8pt,
      imgcard(
        "/assets/figures/siai_architecture_style.png",
        cap: [Capas],
        height: 72pt,
      ),
      imgcard("/assets/figures/soa_topo.png", cap: [SOA], height: 72pt),
      imgcard(
        "/assets/figures/hex_original.png",
        cap: [Hexagonal],
        height: 72pt,
      ),
    ),
  )
  #source[Sommerville; Richards y Ford; Cockburn, según las fuentes de la memoria.]
]

// 14 · Reutilización y FOSS
#slide(
  title: t[Reutilizar cambia desarrollo por configuración; FOSS conserva el control],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 22pt,
    [
      #label(fill: violet)[Sistema configurable especializado]
      #v(8pt)
      #text(
        size: 21pt,
        weight: "bold",
      )[Producto de un dominio que se adapta a necesidades distintas principalmente mediante configuración.]
      #v(8pt)
      #hint[Las interfaces de extensión atienden aquello que la configuración no cubre.]
      #v(8pt)
      #imgcard(
        "/assets/figures/reuse_landscape.png",
        cap: [El paisaje de la reutilización],
        height: 82pt,
      )
    ],
    [
      #label(fill: coral)[Software libre]
      #v(8pt)
      #big(fill: coral, size: 34pt)[soberanía tecnológica]
      #v(8pt)
      - ejecutar
      - estudiar
      - modificar
      - distribuir
      - mejorar
      #v(7pt)
      #text(
        size: 18pt,
        weight: "bold",
      )[El Estado conserva control sobre las aplicaciones que utiliza.]
    ],
  )
  #source[Sommerville; Free Software Foundation; Plan de Software Libre y Estándares Abiertos.]
]

// 15 · Proceso aplicado
#slide(
  title: t[El proceso de ingeniería fue iterativo y orientado a evidencia],
  align: top,
)[
  #panel(
    fill: white,
    inset: 10pt,
    align(center)[
      #diagram(
        spacing: (4mm, 10mm),
        node-stroke: luma(80%),
        node((0, 0), [Modelado\ del negocio], name: <bmod>),
        edge("-|>"),
        node((1, 0), [Requerimientos], name: <req>),
        edge("-|>"),
        node((2, 0), [Análisis\ y diseño], name: <ayd>),
        edge("-|>"),
        node((3, 0), [Implementación], name: <imp>),
        edge("-|>"),
        node((4, 0), [Pruebas]),
        edge("-|>"),
        node((5, 0), [Despliegue]),
        node((1, 1), [Gestión del\ proyecto]),
        edge(<ayd>, <bmod>, "-|>", bend: 20deg),
        edge(<imp>, <req>, "-|>", bend: -30deg),
      )
    ],
  )
  #v(14pt)
  #align(center)[
    #keyword(size: 18pt)[planificación]
    #h(6pt)#keyword(fill: violet, size: 18pt)[iteraciones cortas]
    #h(6pt)#keyword(fill: coral, size: 18pt)[pareja de programación]
    #h(6pt)#keyword(fill: amber, size: 18pt)[LLMs]
    #h(6pt)#keyword(size: 18pt)[backlog]
  ]
  #align(center)[#caption[Iteraciones basadas en metodología RUP]]
]

// 16 · BRS/StRS actores y modelo
#slide(
  title: t[Los requisitos parten del negocio y sus actores — BRS / StRS],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/bolivianInstitutions.svg",
      cap: [Panorama del negocio],
      height: 260pt,
    ),
    imgcard(
      "/assets/figures/tunkunia_dist.excalidraw.png",
      cap: [Modelo del negocio con reutilización],
      height: 260pt,
    ),
  )
]

// 17 · BRS/StRS procesos
#slide(
  title: t[La propuesta sustituye desarrollo repetido por configuración — BRS / StRS],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/business_process_old.svg",
      cap: [Proceso actual: desarrollar cada solución],
      height: 250pt,
    ),
    imgcard(
      "/assets/figures/business_process_new.svg",
      cap: [Con Tunkunia: configurar y adaptar],
      height: 250pt,
    ),
  )
  #v(8pt)
  #align(center)[#big(
    fill: teal,
    size: 30pt,
  )[desarrollo desde cero → configuración institucional]]
]

// 18 · SyRS contexto y funciones
#slide(
  title: t[El sistema se define por su contexto y cuatro funciones — SyRS],
  align: top,
)[
  #grid(
    columns: (1.35fr, .65fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/tunkunia-system-context.pdf",
      cap: [Contexto del sistema],
      height: 260pt,
    ),
    panel(
      fill: white,
      inset: 14pt,
      align(center + horizon)[
        #stack(
          dir: ttb,
          spacing: 15pt,
          big(fill: teal, size: 34pt)[Tunkunia],
          keyword(size: 19pt)[Definición],
          keyword(fill: violet, size: 19pt)[Ejecución],
          keyword(fill: amber, size: 19pt)[Registro],
          keyword(fill: coral, size: 19pt)[Control],
        )
      ],
    ),
  )
]

// 19 · SyRS usuarios
#slide(
  title: t[Una plataforma sirve a responsabilidades diferentes — SyRS],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-user-use-cases.svg",
    cap: [Casos de uso generales y jerarquía de usuarios],
    height: 305pt,
  )
]

// 20 · Arquitectura general
#slide(
  title: t[La arquitectura evoluciona hacia un monolito orientado a servicios],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/modulegraph.png",
      cap: [Arquitectura inicial y entorno],
      height: 255pt,
    ),
    imgcard(
      "/assets/figures/soa_monolith.svg",
      cap: [Arquitectura general de Tunkunia],
      height: 255pt,
    ),
  )
  #v(8pt)
  #align(center)[#keyword[un proceso] #h(9pt) #keyword(
      fill: violet,
    )[módulos por capacidad] #h(9pt) #keyword(
      fill: amber,
    )[interfaces deliberadas]]
]

// 21 · Contexto C4
#slide(
  title: t[Tunkunia se integra sin absorber competencias institucionales],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-c4-system-context.svg",
    cap: [Contexto C4 del sistema Tunkunia],
    height: 305pt,
  )
]

// 22 · Módulos
#slide(
  title: t[Los módulos separan capacidades y conservan un núcleo común],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-modules.svg",
    cap: [Módulos y dependencias principales],
    height: 305pt,
  )
]

// 23 · Despliegue
#slide(
  title: t[Cada institución despliega una instancia autocontenida],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-deployment.svg",
    cap: [Despliegue de una instancia de Tunkunia],
    height: 295pt,
  )
  #align(
    center,
  )[#hint[Un binario · un origen HTTPS · SQLite + documentos · proveedor OIDC externo]]
]

// 24 · Diseño de dominio
#slide(
  title: t[La definición versionada separa el trámite de cada caso],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-domain-model.svg",
    cap: [Relación entre la definición del trámite y el caso],
    height: 305pt,
  )
]

// 25 · Diseño de ejecución
#slide(
  title: t[Cada acción valida estado, entrada y autorización antes de avanzar],
  align: top,
)[
  #imgcard(
    "/assets/figures/tunkunia-case-action-sequence.svg",
    cap: [Secuencia de ejecución de una acción de trámite],
    height: 305pt,
  )
]

// 26 · Interfaz conceptual
#slide(
  title: t[La red se convierte en una interfaz de ejecución comprensible],
  align: top,
)[
  #imgcard(
    "/assets/figures/petriAppliedToTramite-rendered.png",
    cap: [Interfaz conceptual de un trámite basado en una red de Petri],
    height: 305pt,
  )
]

// 27 · Tecnologías
#slide(
  title: t[El prototipo combina un núcleo Go con una SPA tipada],
  align: top,
)[
  #set text(size: 13.5pt)
  #technology-table
  #v(12pt)
  #technology-logos
  #v(7pt)
  #align(
    center,
  )[#hint[Un contrato OpenAPI enlaza servidor, cliente y documentación interactiva.]]
]

// 28 · Vistas generales
#slide(
  title: t[La experiencia cubre el catálogo público y el área de participantes],
  align: top,
)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    imgcard(
      "/assets/figures/imp_home.png",
      cap: [Portal público y catálogo institucional],
      height: 258pt,
    ),
    imgcard(
      "/assets/figures/imp_app.png",
      cap: [Catálogo del área de participantes],
      height: 258pt,
    ),
  )
]

// 29 · Caso
#slide(
  title: t[Un caso muestra su procedimiento y las acciones habilitadas],
  align: top,
)[
  #imgcard(
    "/assets/figures/imp_net_example.png",
    cap: [Inicio de un caso y representación de su procedimiento],
    height: 305pt,
  )
]

// 30 · Integraciones visibles
#slide(title: t[La integración queda visible y documentada], align: top)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    imgcard(
      "/assets/figures/imp_scalar_api.png",
      cap: [API interactiva],
      height: 235pt,
    ),
    imgcard(
      "/assets/figures/imp_dex.png",
      cap: [Ingreso OIDC con Dex],
      height: 235pt,
    ),
    imgcard(
      "/assets/figures/imp_cli_routes.png",
      cap: [Rutas registradas por el CLI],
      height: 235pt,
    ),
  )
  #v(9pt)
  #align(center)[#hint[Contrato · identidad · operación]]
]

// 31 · Validación RAI
#slide(title: t[Validación 1 — Registro Ambiental Industrial], align: top)[
  #imgcard(
    "/assets/figures/rai_pnet.png",
    cap: [Trámite RAI modelado],
    height: 295pt,
  )
  #align(center)[#keyword(
    size: 18pt,
  )[observación → corrección → categorización]]
]

// 32 · Validación CI
#slide(title: t[Validación 2 — Cédula de identidad], align: top)[
  #imgcard(
    "/assets/figures/ci_pnet.png",
    cap: [Trámite de cédula de identidad por primera vez],
    height: 295pt,
  )
  #align(center)[#keyword(
    fill: violet,
    size: 18pt,
  )[bifurcación → interoperabilidad → verificación]]
]

// 33 · Validación SUS
#slide(
  title: t[Validación 3 — Adscripción al Sistema Único de Salud],
  align: top,
)[
  #imgcard(
    "/assets/figures/sus_pnet.png",
    cap: [Trámite de adscripción al SUS modelado],
    height: 295pt,
  )
  #align(center)[#keyword(
    fill: amber,
    size: 18pt,
  )[consulta externa → validación → registro]]
]

// 34 · Cierre
#focus-slide[
  #set text(fill: paper)
  #align(center + horizon)[
    #text(size: 42pt, weight: "bold")[Conclusiones y Recomendaciones]
    #v(28pt)
    #text(size: 16pt, fill: paper.darken(18%))[
      modelo formal · configuración · prototipo · validación
    ]
    #v(8pt)
    #text(size: 15pt, fill: paper.darken(25%))[
      simplificar antes de digitalizar · una instancia por institución · redes de alto nivel · extensibilidad · IA soberana
    ]
  ]
]
