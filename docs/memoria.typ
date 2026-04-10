#import "shared/umsa-electronics-engineering-template/lib.typ": memoria
#import "shared/constants.typ": projectTitle, studentName, tutorName
#import "shared/acronyms.typ": acronyms

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName),
  dedication: include "memoria/preamble/dedication.typ",
  acknowledgements: include "memoria/preamble/acknowledgements.typ",
  abstract: include "memoria/preamble/abstract.typ",
  acronyms: acronyms,
  font: "Lekton Nerd Font",
)

= Fundamentos del Proyecto
#include "memoria/foundation/project_definition.typ"
#include "memoria/foundation/theoretical_framework.typ"
#include "memoria/foundation/reference_framework.typ"

= Proceso del Software
#include "memoria/process/project_management.typ"
#include "memoria/process/configuration.typ"
#include "memoria/process/environment.typ"
#include "memoria/process/business_modeling.typ"
#include "memoria/process/requirements.typ"
#include "memoria/process/analysis_design.typ"
#include "memoria/process/implementation.typ"
#include "memoria/process/testing.typ"
#include "memoria/process/deployment.typ"

= Resolución del Proyecto
#include "memoria/resolution/use.typ"
#include "memoria/resolution/conclusions.typ"
#include "memoria/resolution/recommendations.typ"

#pagebreak(weak: true)
#bibliography("main.bib", title: "Bibliografía y Referencias")
