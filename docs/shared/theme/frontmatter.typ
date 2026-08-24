#import "@preview/glossy:0.9.2": glossary
#import "@preview/icu-datetime:0.2.0": fmt
#import "mainmatter.typ": chapter-supp

// Cover -----------------------------------------------------------------------

#let cover(title, authors, date, description: "Proyecto de Grado") = {
  page(numbering: none, margin: (x: 3cm, y: 1in))[#align(center)[
      #set par(justify: false)
      #text(
        upper([
          Universidad Mayor de San Andrés\
          Facultad de Ingeniería\
          Carrera de Ingeniería Electrónica
        ]),
        size: 12pt,
        weight: "medium",
      )
      #v(2cm)

      #image("umsa.png", width: 20%) #v(.5cm)
      #context {
        text(17.28pt)[#smallcaps(description)]
        v(.5cm)
        text(14.4pt)[#upper(title)]
        v(1fr)
        for author in authors {
          upper(author)
          v(.5cm)
        }
        v(1fr)

        [La Paz, #fmt(date, locale: "es", length: "long")]
      }
    ]
  ]
}

// Preliminary pages -----------------------------------------------------------

#let preliminary-pages(
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
) = {
  if copyright != none {
    pagebreak()
    align(center + bottom)[
      #copyright
    ]
  }
  if dedication != none {
    pagebreak()
    align(right)[
      #v(1fr)
      #heading(level: 3, numbering: none)[Dedicatoria]
      #dedication
      #v(1fr)
    ]
  }
  if acknowledgements != none {
    pagebreak()
    align(right)[
      #v(1fr)
      #heading(level: 3, numbering: none)[
        Agradecimientos
      ]
      #acknowledgements
      #v(1fr)
    ]
  }
  if abstract != none {
    pagebreak()
    align(center)[
      #heading(level: 3, numbering: none)[Abstract]
      #abstract
    ]
  }
}

// Outlines --------------------------------------------------------------------

#let outline-indent(level) = {
  if level == 0 { return 0em }
  if level == 1 { return 6em }
  6em + (level - 2) * 1em
}

#let render-part-entry(entry) = {
  if entry.element.func() != heading { return entry }
  v(1.5em, weak: true)
  if entry.prefix() == none {
    upper(link(entry.element.location(), entry.inner()))
  } else {
    upper(link(
      entry.element.location(),
      grid(
        columns: (6em, 1fr),
        [Parte *#entry.prefix()*], [#entry.inner()],
      ),
    ))
  }
}

#let render-chapter-entry(entry) = {
  if entry.element.func() != heading { return entry }
  if entry.element.supplement == chapter-supp {
    upper(link(
      entry.element.location(),
      entry.indented(none, rect(
        stroke: (bottom: .07em),
        inset: (bottom: .3em, x: 0pt, top: 0pt),
      )[
        Capítulo #entry.prefix()\
        #entry.inner()
      ]),
    ))
  } else {
    upper(link(entry.element.location(), entry.indented(entry.prefix(), [#entry.inner()])))
  }
}

#let render-section-entry(entry) = {
  if entry.prefix() == none { text(style: "italic", entry) } else { entry }
}

#let outline-style(body) = {
  set outline(indent: outline-indent)
  set outline.entry(fill: repeat()[.~~])
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 2): set outline.entry(fill: repeat()[~])
  show outline.entry.where(level: 2): set block(above: 1.5em, below: 1.5em)
  show outline.entry.where(level: 2): set text(weight: "regular")
  show outline.entry.where(level: 1): render-part-entry
  show outline.entry.where(level: 2): render-chapter-entry
  show outline.entry.where(level: 3): render-section-entry
  body
}

#let acronym-theme = (
  section: (title, body) => {
    heading(level: 3, numbering: none, title)
    body
  },
  group: (name, index, total, body) => body,
  entry: (entry, index, total) => block[
    #strong(entry.short)#entry.label
    #if entry.long != none { [ -- #entry.long] }
  ],
)

#let indexes(acronyms) = outline-style[
  #heading(level: 1, numbering: none, outlined: false)[Índice General]
  #outline(title: none)

  #pagebreak()
  #v(0pt)
  #show outline.entry.where(level: 1): set outline.entry(fill: repeat()[.~~])
  #heading(level: 3, numbering: none)[Índice de Figuras]
  #outline(title: none, target: figure.where(kind: image))

  #pagebreak()
  #v(0pt)
  #heading(level: 3, numbering: none)[Índice de Tablas]
  #outline(title: none, target: figure.where(kind: table))

  #if acronyms.len() > 0 {
    pagebreak(weak: true)
    glossary(
      title: "Acrónimos",
      theme: acronym-theme,
      ignore-case: true,
      groups: ("",),
    )
  }
]

// Front-matter lifecycle -------------------------------------------------------

#let frontmatter(
  title,
  authors,
  date,
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
  acronyms: (:),
) = {
  cover(title, authors, date)

  set page(numbering: "i")
  preliminary-pages(
    copyright: copyright,
    dedication: dedication,
    acknowledgements: acknowledgements,
    abstract: abstract,
  )

  pagebreak()
  indexes(acronyms)
}
