#import "/shared/acronyms.typ": acronyms
#import "/shared/theme/lib.typ": perfil
#import "/shared/metadata.typ": damName, projectTitle, studentName, tutorName

#show: perfil.with(
  title: projectTitle,
  authors: (
    "Postulante: " + studentName,
    "Asesor: " + tutorName,
    "D.A.M.: " + damName,
  ),
  date: datetime(day: 21, month: 5, year: 2025),
  acronyms: acronyms,
)

// CONTENIDO
#include "content/introduction.typ"
#include "content/background.typ"
#include "content/current_situation.typ"
#include "content/problem_statement.typ"
#include "content/objective.typ"
#include "content/justification.typ"
#include "content/scope_and_limitations.typ"
#include "content/proposed_solution.typ"
#include "content/syllabus.typ"
#include "content/schedule.typ"

#bibliography("/shared/references.bib")
