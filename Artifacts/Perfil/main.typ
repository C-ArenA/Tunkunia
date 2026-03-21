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

#bibliography("main.bib")
