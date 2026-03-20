#let global(doc) = {
  set page(
    paper: "us-letter",
    margin: (x: 3cm, y: 1in),
    number-align: center,
  )

  set text(lang: "es", region: "bo", size: 11pt, font: "Lekton Nerd Font")

  set par(first-line-indent: (amount: 1em, all: true), justify: true)
  set outline(title: "Índice General")
  set outline.entry(fill: repeat()[.~~])
  set quote(block: true)
  set heading(numbering: "1.")

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
