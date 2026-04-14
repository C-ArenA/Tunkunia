#import "@preview/timeliney:0.4.0"
#import "@preview/acrostiche:0.7.0": *
= Cronograma

El cronograma de trabajo de un proyecto de desarrollo de software que sigue una metodología iterativa como la que se expone en @sec:meth no puede definirse en detalle a priori. Sin embargo, al tomar como base la metodología #acr("RUP"), se puede aproximar un cronograma de trabajo a partir de sus fases, en conjunto con los tiempos de realización de los diferentes artefactos como se observa en la @table:artifacts. De este modo, la @fig:gantt presenta el cronograma general del proyecto tomando en cuenta las fases, las iteraciones y los informes de acuerdo al Reglamento de Proyecto de Grado. Las iteraciones seguirán el flujo de la @fig:rupiter.

#figure(
  caption: [Diagrama de Gantt del proyecto Tunkunia\ Fuente: Elaboración propia],
  timeliney.timeline(
    show-grid: true,
    spacing: 5pt,
    box-milestones: false,
    {
      import timeliney: *

      headerline(group(([*Semanas 2026*], 20)))
      headerline(group(("Marzo", 3), ("Abril", 5), ("Mayo", 4), ("Junio", 4), ("Julio", 4)))
      headerline(group(..range(20).map(n => text(size: 9pt)[w#str(n + 11)])))

      task([*Inicio*], (0, 6), style: (stroke: 8pt + gray))
      task("i1.1 - i1.6", (0.1, 0.9), (1.1, 1.9), (2.1, 2.9), (3.1, 3.9), (4.1, 4.9), (5.1, 5.9), style: (
        stroke: 3pt + gray,
      ))
      task([*Elaboración*], (6, 8), style: (stroke: 8pt + gray))
      task("i2.7 - i2.8", (6.1, 6.9), (7.1, 7.9), style: (
        stroke: 3pt + gray,
      ))
      task([*Construcción*], (8, 16), style: (stroke: 8pt + gray))
      task(
        "i3.9 - i3.16",
        (8.1, 8.9),
        (9.1, 9.9),
        (10.1, 10.9),
        (11.1, 11.9),
        (12.1, 12.9),
        (13.1, 13.9),
        (14.1, 14.9),
        (15.1, 15.9),
        style: (
          stroke: 3pt + gray,
        ),
      )
      task([*Transición*], (16, 20), style: (stroke: 8pt + gray))
      task("i4.17 - i4.20", (16.1, 16.9), (17.1, 17.9), (18.1, 18.9), (19.1, 19.9), style: (
        stroke: 3pt + gray,
      ))
      milestone(style: (stroke: (dash: "dashed")), at: 6, align(center)[*Informe 1*])
      milestone(style: (stroke: (dash: "dashed")), at: 8, align(center)[*Informe 2*])
      milestone(style: (stroke: (dash: "dashed")), at: 12, align(center)[*Informe 3*])
      milestone(style: (stroke: (dash: "dashed")), at: 16, spacing: 23pt, align(center)[*Informe 4*])
      milestone(style: (stroke: (dash: "dashed")), at: 20, align(center)[*Informe 5*])
    },
  ),
)<fig:gantt>

