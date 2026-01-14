#import "@preview/acrostiche:0.7.0": init-acronyms
#import "sections/acronyms.typ": acronyms
#import "conf.typ": appendix, conf, includeAcronyms
#import "../shared/umsa-electronics-engineering-cover/lib.typ": makeCover

#set document(
  description: "Perfil de Proyecto de Grado",
  title: [_Tunkunia_: Subsistema reutilizable de software libre para la gestión de flujos de trámite orientado al gobierno electrónico en Bolivia],
  author: (
    "Postulante: Ernesto Carlos Arena Alarcon",
    "Asesor: Jorge Antonio Nava Amador",
    "D.A.M.: Jorge Mario León Gómez",
  ),
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
