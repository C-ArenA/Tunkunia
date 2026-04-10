#import "@preview/acrostiche:0.7.0": init-acronyms
#import "global.typ": global
#import "structure.typ": justChapter
#import "cover.typ": makeCover
#import "utils.typ": includeAcronyms

#let perfil(
  title: "Mi Lindo Perfil de Proyecto de Grado",
  date: datetime.today(),
  authors: ("Postulante: Yo", "Asesor: Tú", "D.A.M.: Él"),
  acronyms: none,
  font: "New Computer Modern",
  doc,
) = {
  set document(
    description: "Perfil de Proyecto de Grado",
    title: title,
    author: authors,
    date: date,
  )

  show: global
  show: justChapter
  set text(font: font)

  makeCover()
  set page(numbering: "i")
  outline(title: "Índice")
  if acronyms != none {
    init-acronyms(acronyms)
    includeAcronyms()
  }

  set page(numbering: "1")
  doc
}
