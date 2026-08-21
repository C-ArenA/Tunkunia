#import "/shared/lean-canvas-generator/lib.typ": generateCanvas
#page(flipped: true)[

  = Lean Canvas
  El siguiente diagrama corresponde a una evolución del Business Model Canvas y sirve para comunicar el producto de manera rápida@mauryaRunningLeanComo2014
  #generateCanvas(
    problem: [== Problema
      + Dificultad en la digitalización de trámites
      + Repetición innecesaria y costosa de lógica similar en el desarrollo de software de digitalización de trámites
      + Falta de estandarización y atención a normativa
    ],
    customerSegments: [== Clientes
      - Ciudadanos
      - Entidades
      - Instituciones gubernamentales
    ],
    uniqueValueProposition: [== Proposición Única de Valor
      Centralizar estándares, descentralizar esfuerzos: Trámites fáciles de digitalizar],
    solution: [== Solución
      Crear un subsitema reutilizable que permita la creación, puesta en marcha y gestión de trámites de distintos tipos y ponerlo disponible para las distintas instituciones públicas del estado como un proyecto de código abierto],
  )

]

#bibliography("/shared/references.bib")
