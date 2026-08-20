#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, register-glossary

#let with-glossary(glossary, body) = {
  if glossary.len() == 0 {
    body
  } else {
    show: make-glossary
    register-glossary(glossary)
    body
  }
}

#let appendix-numbering(..numbers) = numbering(
  "A.1.1",
  ..numbers.pos().slice(1),
)

#let appendix-heading(it) = {
  if it.level == 2 {
    pagebreak(weak: true)
    align(center)[
      #upper()[Anexo #context numbering("A", counter(heading).get().at(1))]
      #linebreak()
      #upper(it.body)
    ]
  } else {
    it
  }
}

#let render-appendices(appendices) = {
  heading(level: 1, numbering: none)[Anexos]
  counter(heading).update(0)
  set heading(offset: 1, numbering: appendix-numbering)
  show heading.where(level: 2): appendix-heading
  appendices
}

#let backmatter(
  bibliography: none,
  glossary: (),
  appendices: none,
) = {
  set page(numbering: "1")
  if bibliography != none or glossary.len() > 0 or appendices != none {
    pagebreak()
    set heading(numbering: none)

    if bibliography != none { bibliography }
    if glossary.len() > 0 {
      pagebreak(weak: true)
      heading(level: 1, numbering: none)[Glosario]
      print-glossary(glossary, show-all: true)
    }
    if appendices != none {
      pagebreak(weak: true)
      render-appendices(appendices)
    }
  }
}
