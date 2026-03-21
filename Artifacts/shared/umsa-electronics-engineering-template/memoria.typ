#import "@preview/acrostiche:0.7.0": init-acronyms, print-index
#import "global.typ": global
#import "structure.typ": partChapter
#import "cover.typ": makeCover
#import "utils.typ": includeAcronyms

#let memoria(
  title: "Mi Lindo Proyecto de Grado",
  date: datetime.today(),
  authors: ("Yo", "Tú"),
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
  acronyms: (),
  font: "New Computer Modern",
  doc,
) = {
  set document(
    description: "Proyecto de Grado",
    title: title,
    author: authors,
    date: date,
  )
  init-acronyms(acronyms)
  show: global
  show: partChapter
  set text(font: font)
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

  outline(title: "Índice General")

  show outline.entry.where(level: 1): set outline.entry(fill: repeat()[.~~])
  outline(
    title: "Índice de Figuras",
    target: figure.where(kind: image),
  )

  if acronyms.len() > 0 {
    pagebreak(weak: true)
    includeAcronyms()
  }

  set page(numbering: "1")
  show heading.where(level: 1): set heading(supplement: "Parte")
  doc
}
