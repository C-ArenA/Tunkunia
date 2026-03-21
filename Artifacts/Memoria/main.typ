#import "shared/umsa-electronics-engineering-template/lib.typ": memoria
#import "shared/constants.typ": projectTitle, studentName, tutorName
#import "shared/acronyms.typ": acronyms

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName),
  dedication: include "content/preamble/dedication.typ",
  acknowledgements: include "content/preamble/acknowledgements.typ",
  abstract: include "content/preamble/abstract.typ",
  acronyms: acronyms,
  font: "Lekton Nerd Font",
)

= Fundamentos del Proyecto
#include "content/foundation/project_definition.typ"
#include "content/foundation/theoretical_framework.typ"
#include "content/foundation/reference_framework.typ"

= Proceso del Software
#include "content/process/communication.typ"
#include "content/process/methodology.typ"
#include "content/process/planning.typ"
#include "content/process/requirements.typ"
#include "content/process/analysis.typ"
#include "content/process/design.typ"
#include "content/process/implementation.typ"
#include "content/process/testing.typ"
#include "content/process/deployment.typ"
#include "content/process/documentation.typ"

= Resolución del Proyecto
#include "content/resolution/use.typ"
#include "content/resolution/conclusions.typ"
#include "content/resolution/recommendations.typ"

#pagebreak(weak: true)
#bibliography("main.bib", title: "Bibliografía y Referencias")
