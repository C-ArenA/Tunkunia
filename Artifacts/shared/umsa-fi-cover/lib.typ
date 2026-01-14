// UMSA - Cover Page Template
#import "@preview/icu-datetime:0.2.0": fmt

#let college = "Universidad Mayor de San Andrés"

#let makeCover(
  documentTitle: none,
  documentType: "Perfil de Proyecto de Grado",
  student: "Ernesto Carlos Arena Alarcon",
  tutor: "Jorge Antonio Nava Amador",
  professor: "Jorge Mario León Gómez",
  degree: "Ingeniería Electrónica",
  faculty: "Facultad de Ingeniería",
  date: datetime.today()
) = {
  page()[#align(center)[
      #set par(justify: false)
      #text(upper([#college - #faculty\ #degree]), size: 10pt, weight: "bold")
      #v(2cm)

      #image("./umsa.png", width: 20%) #v(0.5cm)
      #text(17.28pt)[#smallcaps(documentType)] #v(0.5cm)
      #text(14.4pt)[#smallcaps(documentTitle)]

      #v(1fr)

      #upper([Postulante: #student]) #v(0.5cm)
      #upper([Asesor: #tutor]) #v(0.5cm)
      #upper([D.A.M.: #professor])
      #v(1fr)

      La Paz, #fmt(date, locale: "es", length: "long")
    ]
  ]
}
