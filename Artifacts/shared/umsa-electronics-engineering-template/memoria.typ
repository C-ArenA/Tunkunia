#import "@preview/acrostiche:0.7.0": init-acronyms, print-index
#import "global.typ": global
#import "structure.typ": partChapter
#import "cover.typ": makeCover
#let memoria(
  title: "Mi Lindo Proyecto de Grado",
  date: datetime.today(),
  authors: ("Yo", "Tú"),
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
  acronyms: none,
  doc,
) = {
  show: global
  show: partChapter
  set document(
    description: "Proyecto de Grado",
    title: title,
    author: authors,
    date: date,
  )
  makeCover()

  set page(numbering: "i")
  if copyright != none {
    pagebreak()
    copyright
  }

  if dedication != none {
    pagebreak()
    align(right)[
      #v(1fr)
      #heading(level: 3, numbering: none, outlined: false)[Dedicatoria]
      #dedication
      #v(1fr)
    ]
  }
  if acknowledgements != none {
    pagebreak()
    align(right)[
      #v(1fr)
      #heading(level: 3, numbering: none, outlined: false)[Agradecimientos]
      #acknowledgements
      #v(1fr)
    ]
  }
  if abstract != none {
    pagebreak()
    align(center)[
      #heading(level: 3, numbering: none, outlined: false)[Abstract]
      #abstract
    ]
  }
  if acronyms != none {
    init-acronyms(acronyms)
  }

  pagebreak()
  outline()
  pagebreak()

  show outline.entry.where(level: 1): set outline.entry(fill: repeat()[.~~])
  outline(
    title: "Índice de Figuras",
    target: figure.where(kind: image),
  )

  pagebreak(weak: true)
  print-index(
    outlined: true,
    title: "Nomenclatura, Símbolos, Acrónimos y Abreviaciones",
    sorted: "up",
    row-gutter: 1.5em,
  )
  set page(numbering: "1")
  show heading.where(level: 1): set heading(supplement: "Parte")
  doc
}
