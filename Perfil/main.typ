#import "cover.typ"
#import "typsections/introduction.typ"
#import "typsections/background.typ"
#import "typsections/current_situation.typ"
#import "typsections/problem_statement.typ"
#import "typsections/objective.typ"
#import "typsections/justification.typ"
#import "typsections/scope_and_limitations.typ"
#import "typsections/proposed_solution.typ"
#import "typsections/tentative_budget.typ"
#import "typsections/syllabus.typ"
#import "typsections/schedule.typ"
#import "typsections/draft.typ"

// Define entorno de apéndices
#let appendix(body) = {
  set heading(numbering: "A.", supplement: [Apéndice])
  pagebreak()
  counter(heading).update(0)
  set page(numbering: "i")
  body
}

// ---------------- CONFIGURACIONES --------------------
#set page(
  paper: "us-letter",
  margin: (x: 3cm, y: 1in),
  number-align: center,
)

#set text(lang: "es", region: "bo", size: 11pt, font: "New Computer Modern")

// Configuración de headings
#set heading(numbering: "1.")
#show heading: it => {
  set align(left)
  set text(weight: "regular")
  if it.level == 1 {
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

// ----------------------- COMIENZA DOCUMENTO ------------------

#cover
#pagebreak()
#outline(indent: auto, fill: repeat()[.~~])
#pagebreak()

#set par(first-line-indent: 1em, spacing: 0.75em, justify: true)
#set page(numbering: "1")

// CONTENIDO

#introduction
#background
#current_situation
#problem_statement
#objective
#justification
#scope_and_limitations
#proposed_solution
#syllabus
#schedule
#tentative_budget

// ANEXOS

#bibliography("main.bib", title: "Bibliografía y Referencias")

#show: appendix

#draft
