#let render-table-figure(it) = {
  v(1.5em)
  if it.caption != none {
    upper(it.caption.supplement)
    [ ]
    it.caption.counter.display()
    linebreak()
    smallcaps(it.caption.body)
  }
  it.body
}

#let global(font, body) = {
  // Page and typography.
  set page(
    paper: "us-letter",
    margin: (top: 4cm, bottom: 1in, left: 4cm, right: 2.5cm),
    number-align: center,
  )
  set text(font: font, lang: "es", region: "bo", size: 12pt)
  set par(first-line-indent: (amount: 1em, all: true), justify: true)
  show heading: set text(weight: "semibold", hyphenate: false)
  show heading: set par(justify: false)
  show heading: set block(below: 1.5em)

  // General document flow.
  set quote(block: true)
  set bibliography(title: "Bibliografía y Referencias")
  show list: set block(inset: (top: 1em, bottom: 1em))

  // Figures and tables.
  show figure.where(kind: image): set block(inset: (top: 1em, bottom: 1em))
  show figure.where(kind: table): set block(breakable: true)
  show figure.where(kind: table): set figure.caption(separator: linebreak())
  show figure.where(kind: table): set text(size: 11pt)
  show figure.where(kind: table): render-table-figure

  body
}
