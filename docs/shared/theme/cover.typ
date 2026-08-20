// UMSA Electronics Engineering - Cover Page Template
#import "@preview/icu-datetime:0.2.0": fmt

#let makeCover() = {
  let college = "Universidad Mayor de San Andrés"
  let faculty = "Facultad de Ingeniería"
  let degree = "Carrera de Ingeniería Electrónica"
  page(numbering: none, margin: (x: 3cm, y: 1in))[#align(center)[
      #set par(justify: false)
      #text(upper([#college\ #faculty\ #degree]), size: 12pt, weight: "medium")
      #v(2cm)

      #image("umsa.png", width: 20%) #v(0.5cm)
      #context {
        text(17.28pt)[#smallcaps(document.description)]
        v(0.5cm)
        text(14.4pt)[#upper(document.title)]
        v(1fr)
        for author in document.author {
          upper(author)
          v(0.5cm)
        }
        v(1fr)

        [La Paz, #fmt(document.date, locale: "es", length: "long")]
      }
    ]
  ]
}
