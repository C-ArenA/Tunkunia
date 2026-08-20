#import "@preview/acrostiche:0.7.0": init-acronyms
#import "backmatter.typ": backmatter, with-glossary
#import "frontmatter.typ": frontmatter
#import "global.typ": global
#import "mainmatter.typ": mainmatter

#let memoria(
  title: none,
  authors: none,
  date: datetime.today(),
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
  acronyms: (),
  bibliography: none,
  glossary: (),
  appendices: none,
  font: "New Computer Modern",
  doc,
) = {
  assert(title != none, message: "memoria requires a title")
  assert(authors != none, message: "memoria requires authors")

  set document(
    description: "Proyecto de Grado",
    title: title,
    author: authors,
    date: date,
  )
  init-acronyms(acronyms)
  show: global.with(font)
  show: with-glossary.with(glossary)

  frontmatter(
    title,
    authors,
    date,
    copyright: copyright,
    dedication: dedication,
    acknowledgements: acknowledgements,
    abstract: abstract,
    acronyms: acronyms,
  )
  mainmatter(doc)
  backmatter(
    bibliography: bibliography,
    glossary: glossary,
    appendices: appendices,
  )
}
