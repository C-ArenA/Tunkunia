#import "@preview/timeliney:0.2.1"

= Cronograma

El cronograma de trabajo (@fig:gantt) estará fuertemente influenciado por las fases de la metodología _RUP (Rational Unified Process)_,
la cual cuenta con 4 fases y 6 actividades principales que se realizan de forma iterativa en cada una de estas fases.
La @fig:rupphases muestra cuánto de cada actividad se debe realizar en cada etapa y permite entender el cronograma presentado.

#figure(
  image("../assets/rupphases.svg", width: 70%),
  caption: [Fases del Proceso Unificado y los esfuerzos de cada actividad en las mismas],
)<fig:rupphases>

#figure(
  caption: "Diagrama de Gantt - Tunkunia",
  timeliney.timeline(
    show-grid: true,
    spacing: 10pt,
    box-milestones: false,
    {
      import timeliney: *

      headerline(group(([*Tunkunia - 25 semanas*], 25)))
      headerline(group(..range(25).map(n => text(size: 9pt)[#str(n + 1)])))

      taskgroup(
        title: [*General*],
        {
          task(align(center)[Investigación\ Preliminar], (0, 2), style: (stroke: 8pt + gray))
          task(align(center)[Redacción de\ Memoria], (3, 7), (15, 18), (21, 25), style: (stroke: 8pt + gray))
          task(align(center)[Creación de\ Documentación], (10, 15), (18, 21), style: (stroke: 8pt + gray))
        },
      )

      milestone(at: 25, align(center)[*Presentación\ Final*])

      taskgroup(
        title: align(center)[*Iteraciones\ RUP*],
        {
          task("Inception", (2, 4), style: (stroke: 8pt + gray))
          task("Elaboration", (4, 7), style: (stroke: 8pt + gray))
          task("Construction", (7, 15), style: (stroke: 8pt + gray))
          task("Transition", (15, 17), style: (stroke: 8pt + gray))
        },
      )

      taskgroup(
        title: [*Caso de\ Estudio*],
        {
          task(align(center)[Fork SIAI\ mínimo], (18, 19), style: (stroke: 8pt + gray))
          task(align(center)[Integración de\ módulo], (19, 21), style: (stroke: 8pt + gray))
        },
      )

      milestone(
        at: 17,
        style: (stroke: (dash: "dashed")),
        align(
          center,
          [
            *Major Release*\
            V1.0.0
          ],
        ),
      )
    },
  ),
)<fig:gantt>

