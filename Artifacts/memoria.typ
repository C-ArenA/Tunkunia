#import "shared/umsa-electronics-engineering-template/lib.typ": memoria
#import "shared/constants.typ": projectTitle, studentName, tutorName
#import "shared/acronyms.typ": acronyms

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName),
  dedication: include "Memoria/content/preamble/dedication.typ",
  acknowledgements: include "Memoria/content/preamble/acknowledgements.typ",
  abstract: include "Memoria/content/preamble/abstract.typ",
  acronyms: acronyms,
  font: "Lekton Nerd Font",
)

= Fundamentos del Proyecto
#include "Memoria/content/foundation/project_definition.typ"
#include "Memoria/content/foundation/theoretical_framework.typ"
#include "Memoria/content/foundation/reference_framework.typ"

= Proceso del Software
#include "Memoria/content/process/project_management.typ"
#include "Memoria/content/process/configuration.typ"
#include "Memoria/content/process/environment.typ"
#include "Memoria/content/process/business_modeling.typ"
#include "Memoria/content/process/requirements.typ"
#include "Memoria/content/process/analysis_design.typ"
#include "Memoria/content/process/implementation.typ"
#include "Memoria/content/process/testing.typ"
#include "Memoria/content/process/deployment.typ"

= Resolución del Proyecto
#include "Memoria/content/resolution/use.typ"
#include "Memoria/content/resolution/conclusions.typ"
#include "Memoria/content/resolution/recommendations.typ"

#pagebreak(weak: true)
#bibliography("main.bib", title: "Bibliografía y Referencias")
