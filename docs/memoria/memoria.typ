#import "/shared/theme/lib.typ": memoria
#import "/shared/metadata.typ": damName, projectTitle, rightsNotice, studentName, tutorName
#import "/shared/acronyms.typ": acronyms
#import "/shared/glossary.typ": glossary

#show: memoria.with(
  title: projectTitle,
  authors: ("Postulante: " + studentName, "Tutor: " + tutorName, "D.A.M.: " + damName),
  copyright: rightsNotice,
  dedication: include "preamble/dedication.typ",
  acknowledgements: include "preamble/acknowledgements.typ",
  abstract: include "preamble/abstract.typ",
  acronyms: acronyms,
  bibliography: bibliography("/shared/references.bib"),
  glossary: glossary,
  appendices: [
    #include "appendices/repository-readme.typ"
    #include "appendices/repository-license.typ"
    #include "appendices/technical-artifacts.typ"
    #include "appendices/openapi-excerpt.typ"
  ],
  font: "New Computer Modern",
  date: datetime(day: 26, month: 8, year: 2026),
)

#include "01-presentation/00-introduction.typ"
#include "01-presentation/01-background.typ"
#include "01-presentation/02-current-situation.typ"
#include "01-presentation/03-problem-statement.typ"
#include "01-presentation/04-objective.typ"
#include "01-presentation/05-justification.typ"
#include "01-presentation/06-scope.typ"

= Fundamentos e Investigación
#include "02-foundations-research/01-reference-framework.typ"
#include "02-foundations-research/02-theoretical-framework.typ"

= Proceso de Ingeniería de Software
#include "03-process/01-development-methodology.typ"
#include "03-process/02-requirements.typ"
#include "03-process/03-architecture.typ"
#include "03-process/04-design.typ"
#include "03-process/05-prototype-implementation.typ"

= Etapa Conclusiva
#include "04-conclusion/01-validation-results.typ"
#include "04-conclusion/02-conclusions-recommendations.typ"
