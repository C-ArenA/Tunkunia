#import "shared/acronyms.typ": acronyms
#import "shared/umsa-electronics-engineering-template/lib.typ": perfil
#import "shared/constants.typ": damName, projectTitle, studentName, tutorName

#show: perfil.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Asesor: " + tutorName, "D.A.M.: " + damName),
  date: datetime(day: 21, month: 5, year: 2025),
  acronyms: acronyms,
)

// CONTENIDO
#include "Perfil/sections/introduction.typ"
#include "Perfil/sections/background.typ"
#include "Perfil/sections/current_situation.typ"
#include "Perfil/sections/problem_statement.typ"
#include "Perfil/sections/objective.typ"
#include "Perfil/sections/justification.typ"
#include "Perfil/sections/scope_and_limitations.typ"
#include "Perfil/sections/proposed_solution.typ"
#include "Perfil/sections/syllabus.typ"
#include "Perfil/sections/schedule.typ"

#bibliography("main.bib")
