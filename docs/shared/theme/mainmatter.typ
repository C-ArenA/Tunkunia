#let chapter-counter = counter("chapter-counter")
#let part-supp = [Parte]
#let chapter-supp = [Capítulo]

#let main-heading-style(body) = {
  // Heading defaults: Subsections and so on
  set heading(numbering: (..n) => {
    let nums = n.pos()
    if nums.len() > 2 {
      numbering("1.1.1", ..chapter-counter.get(), ..nums.slice(2))
    }
  })

  // Parts specific settings and styling
  show heading.where(level: 1): set heading(supplement: part-supp, numbering: "I")
  show heading.where(level: 1): it => {
    page(numbering: none, margin: (x: 4cm, top: 1in, bottom: 2in))[
      #align(center + horizon)[
        #block()[
          #text([Parte #counter(heading).display()], weight: "medium", size: 3em)\
          #linebreak()
          #text(smallcaps(it.body), size: 1.1em, weight: "black")\
        ]
      ]
    ]
  }

  // Chapters specific settings and styling
  show heading.where(level: 2): set heading(supplement: chapter-supp, numbering: (..n) => {
    let nums = n.pos()
    numbering("1", chapter-counter.get().first() + 1)
  })
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    chapter-counter.step()
    block(below: 4.6em, width: 100%, align(center)[
      #set par(spacing: 0.9em)
      #text(size: 0.9em, weight: "thin", font: "New Computer Modern", upper()[#it.supplement #counter(
          heading,
        ).display()])\

      #text(size: 1.7em, weight: "medium", smallcaps(it.body))
    ])
  }

  // Sections specific settings and styling
  show heading.where(level: 3): set text(size: 1.2em, weight: "bold")

  body
}

#let mainmatter(body) = {
  pagebreak(weak: true)
  set page(numbering: "1")
  counter(page).update(1)
  main-heading-style(body)
}
