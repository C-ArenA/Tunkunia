#import "conf.typ": conf, appendix

#show: conf.with(
  title: [_Tunkunia_: Subsistema reutilizable de software libre para la gestión de flujos de trámite orientado al gobierno electrónico en Bolivia],
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
// BIBLIOGRAFÍA
#bibliography("main.bib", title: "Bibliografía y Referencias")
