#import "cover.typ": makeCover
// ---------------- CONFIGURACIONES --------------------
#let conf(doc, title: "Mi Perfil") = [
  #set page(
    paper: "us-letter",
    margin: (x: 3cm, y: 1in),
    number-align: center,
  )

  #set text(lang: "es", region: "bo", size: 11pt, font: "New Computer Modern")

  #set par(first-line-indent: 1em, justify: true)

  // Configuración de headings
  #set heading(numbering: "1.")
  #show heading: it => {
    set align(left)
    if it.level == 1 {
      set text(weight: "regular")
      align(smallcaps(it), center)
    } else {
      it
    }
    linebreak()
    v(-.7em)
  }

  // Configura el TOC
  #show outline.entry.where(level: 1): it => {
    v(1.5em, weak: true)
    smallcaps(it.body)
    box(width: 1fr, repeat()[~])
    it.page
  }

  // Quotes
  #set quote(block: true)

  // Figuras en general
  #show figure: set block(inset: (top: 1em, bottom: 2em)) 
  #show list: set block(inset: (top: 1em, bottom: 1em)) 
  
  // Figuras de Tipo Tabla
  #show figure.where(kind: table): it => {
    set block(breakable: true)
    set figure.caption(separator: linebreak())
    v(1.5em)
    text(size: 11pt)[
      #upper(it.caption.supplement) #it.caption.numbering\
      #smallcaps(it.caption.body)
      #it.body
    ]
  }

  // Comienza documento
  #makeCover(projectTitle: title)
  #set page(numbering: "1")
  #outline(indent: auto, fill: repeat()[.~~])
  #pagebreak()
  #doc
]

// Define entorno de apéndices
#let appendix(body) = {
  set heading(numbering: "A.", supplement: [Apéndice])
  pagebreak()
  counter(heading).update(0)
  set page(numbering: "i")
  body
}
