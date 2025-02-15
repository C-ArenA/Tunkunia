#import "conf.typ": conf, appendix
#import "cover.typ"

#show: conf.with(
  title: [_TUNKUNIA_: Desarrollo de un módulo reutilizable de gestión y seguimiento de flujos de trámite\ Caso de Estudio: Trámites del _SIAI_],
)

// ----------------------- COMIENZA DOCUMENTO ------------------

// CONTENIDO
#include "typsections/introduction.typ"
#include "typsections/background.typ"
#include "typsections/current_situation.typ"
#include "typsections/problem_statement.typ"
#include "typsections/objective.typ"
#include "typsections/justification.typ"
#include "typsections/scope_and_limitations.typ"
#include "typsections/proposed_solution.typ"
#include "typsections/tentative_budget.typ"
#include "typsections/syllabus.typ"
#include "typsections/schedule.typ"

// BIBLIOGRAFÍA
#bibliography("main.bib", title: "Bibliografía y Referencias")

// ANEXOS
#appendix[
  #include "typsections/draft.typ"
]
