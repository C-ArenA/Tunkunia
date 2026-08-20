#let chapter-counter = counter("chapter-counter")

#let heading-numbering(..numbers) = {
  let numbers = numbers.pos()
  if numbers.len() == 1 {
    "Parte " + numbering("I", ..numbers)
  } else if numbers.len() == 2 {
    (
      "Capítulo " + numbering("1", chapter-counter.get().first() + 1) + linebreak()
    )
  } else {
    numbering("1.1.1", ..chapter-counter.get(), ..numbers.slice(2))
  }
}

#let render-chapter-heading(it) = {
  pagebreak(weak: true)
  chapter-counter.step()
  it
  linebreak()
}

#let render-part-heading(it) = {
  if it.numbering == none {
    align(center, it)
    v(1em)
  } else {
    page(numbering: none)[
      #v(1fr)
      #align(center)[
        #set text(size: 25pt)
        #set par(justify: false)
        #smallcaps()[Parte #str(counter(heading).get().first())]\
        #upper(it.body)
      ]
      #v(2fr)
    ]
  }
}

#let main-heading-style(body) = {
  set heading(numbering: heading-numbering)
  show heading.where(level: 2): set align(center)
  show heading.where(level: 2): set text(size: 1.4em)
  show heading.where(level: 3): set text(size: 1.2em)
  show heading.where(level: 1): set heading(supplement: "Parte")
  show heading.where(level: 1): render-part-heading
  show heading.where(level: 2): render-chapter-heading
  show selector.or(heading.where(level: 1), heading.where(level: 2)): smallcaps
  body
}

#let mainmatter(body) = {
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)
  main-heading-style(body)
}
