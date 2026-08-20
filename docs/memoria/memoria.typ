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
  font: "STIX Two Text",
)

= Presentación del Proyecto
#include "01-presentation/00-introduction.typ"
#include "01-presentation/01-background.typ"
#include "01-presentation/02-current-situation.typ"
#include "01-presentation/03-project-definition.typ"

= Fundamentos e Investigación
#include "02-foundations-research/01-reference-framework.typ"
#include "02-foundations-research/02-theoretical-framework.typ"

== Investigación sobre el modelado de trámites

#[
  #set heading(offset: 2)
  #include "02-foundations-research/03-tram-research.typ"
]

= Definición y Diseño del Sistema
#include "03-definition-design/01-development-methodology.typ"
#include "03-definition-design/02-requirements-analysis.typ"
#include "03-definition-design/03-architecture-design.typ"

= Construcción y Evaluación del Prototipo
#include "04-construction-evaluation/01-prototype-implementation.typ"
#include "04-construction-evaluation/02-validation-results.typ"

= Cierre del Proyecto
#include "05-conclusion/01-conclusions-recommendations.typ"

= Anexos
#include "appendices/configuration-management.typ"
#include "appendices/project-schedule.typ"

#pagebreak(weak: true)
#bibliography("/shared/references.bib", title: "Bibliografía y Referencias")
