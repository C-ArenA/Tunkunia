#let global(doc) = {
  set page(
    paper: "us-letter",
    margin: (x: 3cm, y: 1in),
    number-align: center,
  )

  set text(lang: "es", region: "bo", size: 11pt)

  set par(first-line-indent: (amount: 1em, all: true), justify: true)
  set outline.entry(fill: repeat()[.~~])
  set quote(block: true)
  set bibliography(title: "Bibliografía y Referencias")

  show outline: it => {
    pagebreak(weak: true)
    it
    pagebreak(weak: true)
  }
  show list: set block(inset: (top: 1em, bottom: 1em))
  show figure.where(kind: image): set block(inset: (top: 1em, bottom: 1em))

  // Figuras de Tipo Tabla
  show figure.where(kind: table): set block(breakable: true)
  show figure.where(kind: table): set figure.caption(separator: linebreak())
  show figure.where(kind: table): set text(size: 11pt)
  show figure.where(kind: table): it => {
    [
      #v(1.5em)
      #upper(it.caption.supplement) #it.caption.counter.display()\
      #smallcaps(it.caption.body)
      #it.body
    ]
  }
  doc
}

// Define entorno de apéndices
#let appendix(body) = {
  set heading(numbering: "A.", supplement: [Apéndice])
  pagebreak()
  counter(heading).update(0)
  set page(numbering: "I")
  body
}
