#import "/shared/theme/lib.typ": memoria
#import "/shared/metadata.typ": (
  projectTitle, rightsNotice, studentName, tutorName,
)
#import "/shared/acronyms.typ": acronyms
#import "/shared/glossary.typ": glossary

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName),
  copyright: rightsNotice,
  dedication: include "preamble/dedication.typ",
  acknowledgements: include "preamble/acknowledgements.typ",
  abstract: include "preamble/abstract.typ",
  acronyms: acronyms,
  bibliography: bibliography("/shared/references.bib"),
  glossary: glossary,
  appendices: [
    #include "appendices/configuration-management.typ"
    #include "appendices/project-schedule.typ"
  ],
  font: "New Computer Modern",
)

#include "01-presentation/00-introduction.typ"
#[
  #set heading(offset: 1)
  #include "01-presentation/01-background.typ"
  #include "01-presentation/02-current-situation.typ"
  #include "01-presentation/03-project-definition.typ"
]

= Fundamentos e Investigación
#include "02-foundations-research/01-reference-framework.typ"
#include "02-foundations-research/02-theoretical-framework.typ"

== Investigación sobre el modelado de trámites

#[
  #set heading(offset: 2)
  #include "02-foundations-research/03-tram-research.typ"
]

= Proceso de Ingeniería de Software
#include "03-process/01-development-methodology.typ"
#include "03-process/02-requirements.typ"
#include "03-process/03-architecture.typ"
#include "03-process/04-design.typ"
#include "03-process/05-prototype-implementation.typ"

= Etapa Conclusiva
#include "04-conclusion/01-validation-results.typ"
#include "04-conclusion/02-conclusions-recommendations.typ"
