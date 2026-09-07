#import "/shared/metadata.typ": projectTitle, studentName

#set page(
  paper: "us-letter",
  margin: (top: 2.5cm, bottom: 2.3cm, left: 2.8cm, right: 2.8cm),
)
#set text(font: "New Computer Modern", size: 11pt, lang: "es")
#set par(justify: true, leading: 0.78em)

#align(center)[
  #text(size: 15pt, weight: "bold")[ACTA DE ENTREGA DE MEMORIA]
]

#v(1.2cm)

En la ciudad de La Paz, a los siete días del mes de septiembre de dos mil
veintiséis, yo, *#studentName*, en calidad de postulante, hago entrega de un
ejemplar del borrador de memoria correspondiente al proyecto de grado titulado:

#v(0.45cm)

#align(center)[
  #block(width: 92%, inset: (x: 0.35cm, y: 0.3cm), stroke: 0.7pt)[
    #set par(justify: false)
    #upper(projectTitle)
  ]
]

#v(0.55cm)

La entrega se realiza al miembro del tribunal *Ing. Fabian Amado Tito Luque*,
quien recibe el documento para fines de revisión y emisión de observaciones#footnote[La memoria entregada tiene carácter de borrador y puede
  sufrir cambios en busca de mejorar el trabajo y atender las observaciones de los tribunales].
#v(0.55cm)

En constancia de la entrega y recepción de la memoria, firman la presente acta
las partes intervinientes en la fecha indicada.

#v(0.8cm)

#v(2.6cm)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5cm,
  align(center)[
    #line(length: 100%, stroke: 0.7pt)
    #v(0.2cm)
    *#studentName* \
    Postulante \
    Entregué conforme
  ],
  align(center)[
    #line(length: 100%, stroke: 0.7pt)
    #v(0.2cm)
    *Ing. Fabian Amado Tito Luque* \
    Miembro del tribunal \
    Recibí conforme
  ],
)
