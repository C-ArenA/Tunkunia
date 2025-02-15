#import "conf.typ": conf, appendix

#show: conf.with(
  title: [_TUNKUNIA_: Desarrollo de un módulo de gestión y seguimiento de flujos de trámite\ Caso de Estudio: Trámites del _SIAI_],
)

// CONTENIDO

#include "typsections/introduction.typ"
#include "typsections/background.typ"
#include "typsections/current_situation.typ"
#include "typsections/problem_statement.typ"
#include "typsections/objective.typ"
#include "typsections/justification.typ"
#include "typsections/scope_and_limitations.typ"
#include "typsections/proposed_solution.typ"
#include "typsections/syllabus.typ"
#include "typsections/schedule.typ"
#include "typsections/tentative_budget.typ"

// ANEXOS

#bibliography("main.bib", title: "Bibliografía y Referencias")

#show: appendix

#include "typsections/draft.typ"
