#import "@preview/timeliney:0.4.0"
#import "/shared/theme/lib.typ": typ-fig

= Cronograma

El cronograma de trabajo de un proyecto de desarrollo de software que sigue una metodología iterativa como la que se expone en @sec:meth no puede definirse en detalle a priori. Sin embargo, al tomar como base la metodología @RUP, se puede aproximar un cronograma de trabajo a partir de sus fases, en conjunto con los tiempos de realización de los diferentes artefactos como se observa en la @table:artifacts. De este modo, la @fig:gantt presenta el cronograma general del proyecto tomando en cuenta las fases, las iteraciones y los informes de acuerdo al Reglamento de Proyecto de Grado. Las iteraciones seguirán el flujo de la @fig:rupiter.

#typ-fig(
  include "gantt.typ",
  [Diagrama de Gantt del proyecto Tunkunia],
  <fig:gantt>,
)
