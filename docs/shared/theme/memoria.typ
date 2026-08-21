#import "@preview/glossy:0.9.2": init-glossary
#import "backmatter.typ": backmatter
#import "frontmatter.typ": frontmatter
#import "global.typ": global
#import "mainmatter.typ": mainmatter

#let with-group(terms, group) = {
  let grouped = (:)
  for (key, value) in terms {
    let entry = if type(value) == str {
      (short: key, long: value)
    } else {
      value
    }
    entry.insert("group", group)
    grouped.insert(key, entry)
  }
  grouped
}

#let with-terminology(acronyms, glossary, body) = {
  if acronyms.len() == 0 and glossary.len() == 0 {
    body
  } else {
    show: init-glossary.with(acronyms + with-group(glossary, "glossary"))
    body
  }
}

#let memoria(
  title: none,
  authors: none,
  date: datetime.today(),
  copyright: none,
  dedication: none,
  acknowledgements: none,
  abstract: none,
  acronyms: (:),
  bibliography: none,
  glossary: (:),
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
  show: global.with(font)
  show: with-terminology.with(acronyms, glossary)

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
