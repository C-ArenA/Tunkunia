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
#include "perfil/introduction.typ"
#include "perfil/background.typ"
#include "perfil/current_situation.typ"
#include "perfil/problem_statement.typ"
#include "perfil/objective.typ"
#include "perfil/justification.typ"
#include "perfil/scope_and_limitations.typ"
#include "perfil/proposed_solution.typ"
#include "perfil/syllabus.typ"
#include "perfil/schedule.typ"

#bibliography("main.bib")
