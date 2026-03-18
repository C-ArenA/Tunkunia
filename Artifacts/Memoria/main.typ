#import "@preview/acrostiche:0.7.0": init-acronyms
#import "shared/umsa-electronics-engineering-template/lib.typ": appendix, conf, includeAcronyms, makeCover
#import "shared/constants.typ": projectTitle, studentName, tutorName
#import "shared/acronyms.typ": acronyms

#set document(
  description: "Proyecto de Grado",
  title: projectTitle,
  author: ("Postulante: " + studentName, "Tutor: " + tutorName),
  date: datetime.today(),
)

#show: conf
#init-acronyms(acronyms)

// PORTADA
#makeCover()
#set page(numbering: "i")
// Dedicatoria

// Agradecimientos

#include "./content/P1_preamble/main.typ"
// Resumen
#outline()
#includeAcronyms()

// CONTENT
#set page(numbering: "1")
#include "./content/P2_fundamentals/main.typ"
#include "./content/P3_process/main.typ"
#include "./content/P4_resolution/main.typ"

// BIBLIOGRAFÍA
#bibliography("main.bib", title: "Bibliografía y Referencias")
