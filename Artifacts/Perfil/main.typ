#import "@preview/acrostiche:0.7.0": init-acronyms
#import "../shared/acronyms.typ": acronyms
#import "../shared/umsa-electronics-engineering-template/lib.typ": appendix, conf, includeAcronyms, makeCover
#import "../shared/constants.typ": authors, projectTitle

#set document(
  description: "Perfil de Proyecto de Grado",
  title: projectTitle,
  author: authors,
  date: datetime(day: 21, month: 5, year: 2025),
  keywords: ("Tunkunia", "Trámites", "Gobierno Electrónico", "Software Libre", "Sistema"),
)

#show: conf
#init-acronyms(acronyms)

// PORTADA
#makeCover()
#set page(numbering: "1")
#outline()
#includeAcronyms()

// CONTENIDO
#include "sections/introduction.typ"
#include "sections/background.typ"
#include "sections/current_situation.typ"
#include "sections/problem_statement.typ"
#include "sections/objective.typ"
#include "sections/justification.typ"
#include "sections/scope_and_limitations.typ"
#include "sections/proposed_solution.typ"
#include "sections/syllabus.typ"
#include "sections/schedule.typ"

// BIBLIOGRAFÍA
#bibliography("main.bib", title: "Bibliografía y Referencias")
