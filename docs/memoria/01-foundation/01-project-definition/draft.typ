#let rowdesc(contenido) = {
  strong(contenido.at(0))
  linebreak()
  text(contenido.at(1), size: 6pt)
}

= Boceto del Perfil

El cuadro siguiente (@table:boceto) sigue las recomendaciones de _Escalera_ para la redacción de perfiles de proyecto @escaleraTECNICASIDCIENCIAS2006.
El mismo ayuda a identificar los aspectos principales de la propuesta de proyecto, que posteriormente se tradujeron a la redacción completa del perfil de proyecto presentado y que podrían guiar al lector del documento principal.

#figure(
  table(
    columns: (1fr, 3fr),
    align: (left, left),
    inset: (y: 10pt),
    stroke: none,
    table.hline(),
    table.header[Pregunta][Respuesta],
    table.hline(),

    rowdesc((
      "Dónde",
      [Descripción de *escenario* universitario, comercial, industrial o social donde se realiza el proyecto],
    )),

    [_En la consultora *2IES*_

      Dicha consultora presenta proyectos de software a entidades
      públicas, como fue recientemente el caso para el Ministerio de Desarrollo Productivo, con un sistema que requirió la digitalización de
      varios *trámites*],

    rowdesc((
      "Qué Asunto",
      [Descripción detallada del asunto o *problema principal* que requiere de estudio y del abordaje de solución del problema descrito],
    )),

    [_La repetición de funcionalidades inherentes al trámite, como su creación, gestión y seguimiento._

      Los sistemas gubernamentales requieren la digitalización de trámites. Se pueden identificar en muchos de ellos características comunes que la consultora 2IES reconoció a la hora de desarrollar el sistema SIAI (Sistema de Información Ambiental Industrial).

      Al existir varios trámites y procesos administrativos alrededor de documentos y su respectivo seguimiento, se vio que el código se repetía bastante para funcionalidades similares que luego implicaban una dificultad importante al necesitar cambios.

      Esta repetición puede ser mitigada modularizando la funcionalidad específica a los trámites, que se cree puede ser reutilizada para muchos de ellos. Al hablar de reutilización se suele hablar de paquetes o librerías de software de código abierto (FOSS), pero también de subsistemas completos. La modularización permite además enfocar ciertos aspectos que hacen de la pieza de código más robusta y completa.],

    rowdesc((
      "Para qué",
      [Descripción de los propósitos generales, *metas* y objetivos específicos a ser logrados en el proyecto],
    )),

    [_Implementar un módulo reutilizable de gestión y seguimiento de trámites tomando como caso de estudio a los trámites implementados por 2IES para el SIAI_

      Crear un subsistema de software de tipo FOSS para la utilización en sistemas gubernamentales que involucren trámites.

      Se usará como motor de los flujos de trámite a modelos matemáticos de estados finitos como las Redes de Petri o las máquinas de estado

      Se emplearán tecnologías modernas como la inteligencia artificial para automatizar los procesos.

      Se modelará el proceso del trámite alrededor de los documentos presentados, requisitos y revisiones.

      Se tendrá en cuenta la relación con los WFMS (Workflow Management Systems) y los BPMS (Busines Process Management System), ya que se pretende realizar una versión especializada de los mismos.

      Se implementarán trámites existentes como caso de estudio, en base a trámites definidos por el RASIM.
    ],

    rowdesc((
      "Por Qué",
      [Descripción de la pertinencia científica o tecnológica del asunto, y la *justificación* de metas que se quieren lograr una vez terminado el proyecto. Es también importante que se explique la importancia y rango de prioridad del proyecto dentro de los planes de desarrollo de una región del país],
    )),

    [_Modela los trámites, ataca ciertos problemas de la burocracia, mejora la vida de los usuarios al reducir la fricción de digitalización de procesos_

      Porque la reutilización de código reduce costos y tiempos de desarrollo.
      Porque los trámites son ubicuos en sistemas gubernamentales.
      Porque el software libre es requerido en el gobierno Boliviano.

      Se usarán modelos matemáticos como las redes de Petri y otras máquinas de estado finitas
      Se emplearán tecnologías modernas respondiendo al estado del arte respecto a Inteligencia Artificial
      Se planteará una arquitectura sólida y se ejecutarán de forma correcta los principios de la Ingeniería de Software, usando metodologías adecuadas.
      Se estudiarán los trámites desde una perspectiva objetiva y se modelarán de forma sistemática para que este proyecto pueda ser útil para futuros desarrollos.
      Se seguirán buenas prácticas de FOSS.

      Los trámites mejoran y la burocracia disminuye con el uso de las tecnologías de la información. Se corrigen problemáticas respecto a la interacción del ciudadano con el gobierno y al haber sistemas reutilizables se disminuye la fricción para la implementación de herramientas tecnológicas con este objetivo.
    ],

    rowdesc((
      "Cómo y con qué",
      [Descripción de la metodología (técnicas, procedimientos) y las herramientas que se utilizarán para realizar el estudio. Incluir también el plan de trabajo para la ejecución del estudio],
    )),

    [Se usarán una metodología híbrida ágil que tome aspectos de SCRUM y de RUP, con ciertos matices considerándose un solo desarrollador. De esta manera, tomaremos aspectos de comunicación y creación de tareas como historias de usuario desde SCRUM y la organización de etapas de desarrollo para una buena planificación con generación de documentación UML desde RUP.

      El módulo se distribuirá como un proyecto de software libre en Laravel, lo cual permitirá su utilización en proyectos monolíticos así como en arquitecturas de tipo SOA o microservicios.

      Se emplearán librerías de terceros populares en el mercado.],

    rowdesc((
      "Cuándo",
      [Descripción de las principales acciones requeridas para realizar el proyecto, incluyendo el tiempo que cada acción tomará para ser realizada],
    )),

    [Se plantea realizar el proyecto en el transcurso de 3 meses, dentro de los cuales nos apegaremos a las etapas indicadas por la metodología RUP y respondiendo a cada paso del proceso del software.],
  ),
  caption: [Boceto de Perfil],
) <table:boceto>
