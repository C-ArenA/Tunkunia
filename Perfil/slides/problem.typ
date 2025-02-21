#import "@preview/slydst:0.1.3": *
#import "@preview/timeliney:0.1.0"

#show: slides.with(
  title: [_TUNKUNIA_: Desarrollo de un módulo reutilizable de gestión y seguimiento de flujos de trámite],
  subtitle: "Caso de Estudio: Trámites del SIAI",
  date: none,
  authors: ("Ernesto Carlos Arena Alarcon",),
  layout: "medium",
  ratio: 4 / 3,
  title-color: none,
)

= Definición de la problemática

== El trámite tradicional
#v(1fr)
- Corrupción enla administración pública
- Distancias recorridas para la realización de trámites
- Tiempos de ejecución del trámite elevados
- Costos para el ciudadano en la realización del trámite
#v(1fr)

== Don't Repeat Yourself

#v(1fr)
La ubicuidad del trámite en distintos espacios gubernamentales y la cantidad de los mismos implican el desarrollo de características o funcionalidades similares en muchos sistemas de la administración pública, esto quiere decir:

- Mayores costos de desarrollo
- Tiempos de Desarrollo elevados
- Falta de robustez ante un enfoque no modular

#v(1fr)

== El trámite tiene procedimientos comunes

#v(1fr)
No existe un modelado del proceso del trámite, a pesar de que muchos de ellos tienen características comunes.
#v(1fr)

== Los sistemas de trámite no viven solos

#v(1fr)
Se requiere interoperabilidad y posibilidad de usar el sistema de trámites dentro de sistemas más grandes.
#v(1fr)

= Plan de trabajo

== Plan a corto plazo

#v(1fr)
#timeliney.timeline(
  show-grid: true,
  spacing: 10pt,
  box-milestones: false,
  {
    import timeliney: *

    headerline(group(([*Tunkunia - 2 semanas*], 3)))
    headerline(group(..range(3).map(n => text(size: 9pt)[#str(n + 1)])))

    taskgroup(
      title: [*Perfil de Proyecto*],
      {
        task(align(center)[Redactar contenido de situación actual], (0, 1), style: (stroke: 8pt + gray))
        task(
          align(center)[Añadir aproximación al modelado\ del trámite y afinar la solución propuesta],
          (2, 3),
          style: (stroke: 8pt + gray),
        )
        task(align(center)[Ajuste de los Alcances y las Justificaciones], (1, 2), style: (stroke: 8pt + gray))
      },
    )
  },
)
#v(1fr)

= Conclusiones y Compromisos

== Conclusiones

#v(1fr)
Si bien se identifica un problema y se cree que la solución a dicho problema es útil para el desarrollo de sistemas gubernamentales, no se tiene claro cómo enfocar la naturaleza open source del módulo. Percibo que para el proyecto de grado se requiere una entidad como una empresa o una institución que esté detrás del mismo y al ser open source, sería de beneficio para la comunidad.

Me encuentro abierto a pivotar el enfoque, ya que la naturaleza open source no es determinante, aunque una de mis justificaciones es social, para reducir la fricción de digitalización de trámites
#v(1fr)

== Compromisos

#v(1fr)
Quizá de forma ambiciosa, mi compromiso es concluir el perfil en las próximas 3 semanas.

Para la próxima semana tendré definido el enfoque open source del proyecto y redactaré la situación actual.
#v(1fr)


== Notas sobre la reunión

- AGETIC - Normativa sobre FOSS
- DRY: 
- Bolivia, el proceso de trámite administrativo, Ley 2341 de Abril de 2002
- Por qué no usar las otras herramientas
- Objetivos->Diseño
- Antes de requerimientos conocer el modelo de flujo ded trámites
- Para el próximo sábado 18, cerrar el perfil
- Luego tener una Presentación
