#import "@preview/icu-datetime:0.2.0": fmt

#let college = "Universidad Mayor de San Andrés"
#let faculty = "Facultad de Ingeniería"
#let degree = "Ingeniería Electrónica"

#let makeCover(
  projectTitle: none,
  student: "Ernesto Carlos Arena Alarcon",
  tutor: "Jorge Antonio Nava Amador",
  professor: "Jorge Mario León Gómez",
  documentType: "Perfil de Proyecto de Grado",
) = {
  page()[#align(center)[
      #set par(justify: false)
      #text(upper([#college - #faculty\ #degree]), size: 10pt, weight: "bold")
      #v(2cm)

      #image("assets/umsa.png", width: 20%) #v(0.5cm)
      #text(17.28pt)[#smallcaps(documentType)] #v(0.5cm)
      #text(14.4pt)[#smallcaps(projectTitle)]
      #v(1fr)

      #upper([Postulante: #student]) #v(0.5cm)
      #upper([Asesor: #tutor]) #v(0.5cm)
      #upper([D.A.M.: #professor])
      #v(1fr)

      #let today = datetime.today()
      La Paz, #fmt(today, locale: "es", length: "long")
    ]
  ]
}
