#import "conf.typ": conf, appendix

// TODO: Revisar documento en busca de inconsistencias respecto al uso de la palabra módulo en contra de la palabra subsistema y revisar el cambio de enfoque del título y cómo afecta al resto del documento
#show: conf.with(
  title: [_Tunkunia_: Subsistema reutilizable de software libre para la gestión de flujos de trámite en gobiernos electrónicos],
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
// #include "sections/tentative_budget.typ"
#include "sections/syllabus.typ"
// TODO: Añadir Metodología
// TODO: Solucionar el cronograma
//#include "sections/schedule.typ"
// TODO Considerar el volver a subir la bibliografía al repositorio remoto ahora que en Zotero tengo pineados los citation keys
// BIBLIOGRAFÍA
#bibliography("main.bib", title: "Bibliografía y Referencias")

// ANEXOS
#appendix[
  #include "sections/glossary.typ"
]
