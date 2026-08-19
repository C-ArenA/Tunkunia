#import "/shared/theme/lib.typ": memoria
#import "/shared/metadata.typ": projectTitle, studentName, tutorName
#import "/shared/acronyms.typ": acronyms

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName),
  dedication: include "preamble/dedication.typ",
  acknowledgements: include "preamble/acknowledgements.typ",
  abstract: include "preamble/abstract.typ",
  acronyms: acronyms,
  font: "Lekton Nerd Font",
)

= Fundamentos del Proyecto
#include "01-foundation/project_definition.typ"
#include "01-foundation/theoretical_framework.typ"
#include "01-foundation/reference_framework.typ"

== Investigación sobre el modelado de trámites

#[
  #set heading(offset: 2)
  #include "01-foundation/tram-research.typ"
]

= Proceso del Software
#include "02-software-process/project_management.typ"
#include "02-software-process/configuration.typ"
#include "02-software-process/environment.typ"
#include "02-software-process/business_modeling.typ"
#include "02-software-process/requirements.typ"
#include "02-software-process/analysis_design.typ"
#include "02-software-process/implementation.typ"
#include "02-software-process/testing.typ"
#include "02-software-process/deployment.typ"

= Resolución del Proyecto
#include "03-resolution/use.typ"
#include "03-resolution/conclusions.typ"
#include "03-resolution/recommendations.typ"

#pagebreak(weak: true)
#bibliography("/shared/references.bib", title: "Bibliografía y Referencias")
