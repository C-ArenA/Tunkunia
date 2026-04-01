#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/acrostiche:0.7.0": acr
== Gestión del Proyecto
=== Metodología o Marco de Trabajo
La metodología de este proyecto adopta un enfoque híbrido, tomando como base la metodología #acr("RUP") para mantener una estructura clara que favorezca la planificación y documentación mediante las fases del ciclo de vida del desarrollo de software y las disciplinas establecidas por dicho marco, pero además se adoptan enfoques ágiles para lograr iteraciones rápidas y una forma prescriptiva sobre cómo llevar a cabo cada paso del proyecto a partir de historias de usuario y tareas definidas en un backlog.

Este enfoque híbrido no sólo busca flexibilidad e iteraciones rápidas, sino que también trata de alinearse con los objetivos del proyecto de grado, brindando una metodología que pueda aplicarse eventualmente en entornos de código abierto colaborativos, tomando ejemplos de proyectos exitosos en la comunidad de software libre.

==== Objetivos

Los siguientes son los objetivos principales que la metodología utilizada debe seguir para su creación y ejecución en base a la naturaleza del proyecto.

- Conseguir iteraciones cortas y entregas (releases) frecuentes.
- Ser amigable con potenciales colaboradores.
- Fomentar la creación y constante actualización de los distintos artefactos del proyecto.
- Seguir cada fase del proceso o ciclo de vida del software de forma ordenada.
- Permitir cierto nivel de planificación, a pesar de la incertidumbre inherente a proyectos de software.
- Definir roles y responsabilidades claras del postulante, el tutor y potenciales colaboradores.
- Establecer una comunicación efectiva con el tutor del proyecto.
- Tomar en cuenta que el desarrollo inicial es realizado por un único desarrollador (el postulante).
- Usar herramientas colaborativas para la gestión del proyecto.
- Usar herramientas de control de versiones y gestión de código fuente tanto para el desarrollo como para la documentación.

==== Participación y Roles de los distintos actores del proyecto

Los distintos roles propuestos y sus responsabilidades toman inspiración de metodologías de desarrollo y términos de la industria que fueron presentados en el marco teórico. Sin embargo, se enmarcan y limitan por el Reglamento de Proyecto de Grado de la carrera de Ingeniería Electrónica de la UMSA.

===== Proponente del Proyecto y el papel del perfil de proyecto
Siendo Tunkunia un proyecto de desarrollo tecnológico que busca implementar un sistema que se plantea como solución a un problema institucional específico, respondiendo a una necesidad potencial justificada en la definición de este documento y su perfil asociado se considera al autor de la propuesta como el principal interesado en la ejecución del proyecto y los objetivos y alcances del perfil la principal fuente de verdad que, en la práctica, actuará como el stakeholder principal.

===== Tutor de Proyecto
El tutor del proyecto será considerado un stakeholder técnico que trabaja de cerca con el dueño de producto que, como veremos más adelante, es el estudiante.
De este modo, este último reportará avances y presentará dudas para que el tutor lo guíe en el objetivo de lograr un trabajo de calidad. El tutor tendrá el mayor involucramiento en el proyecto sólo detrás del proponente.

===== Docente de la Asignatura para la Mención

Este stakeholder tendrá principalmente la tarea de evaluación del desarrollo del proyecto, para lo cual se le reportarán informes de forma periódica, mismos que deben pasar por el filtro del tutor. Sus sugerencias serán evaluadas por los principales stakeholders.

===== Dueño de Producto

El dueño del producto, que se encarga de gestionar el proyecto y buscar priorizar tareas, será el estudiante que propone el proyecto. Este será responsable del éxito o fracaso del proyecto y seguirá la guía del perfil de proyecto y del tutor. Además, tendrá que entender las necesidades del proyecto de forma completa.

===== Desarrolladores

====== Único Desarrollador
Siendo este un proyecto desarrollado por sólo una persona, el trabajo de desarrollo de los distintos artefactos es el mismo estudiante, quien deberá asignar distintos momentos de su tiempo a cumplir sus diferentes roles de desarrollo.

====== Pareja de Programación
Con la modernización del trabajo de codificación, este proyecto contempla el uso de la programación en parejas tomando a agentes de inteligencia artificial como revisores de código y generadores de _boilerplate_.

====== Colaboradores Potenciales
Al ser un proyecto de código abierto, se podrán recibir de forma eventual propuestas de mejora en código por terceros. Estos colaboradores deberán seguir los procedimientos comunes de la industria y sus propuestas deberán ser revisadas por el dueño del producto antes de ser aceptadas.

==== Ciclo de Vida del Proyecto

El ciclo de vida de este proyecto, que en adelante llamamos proceso del software en atención a la literatura sobre ingeniería de software y al hecho de que este proyecto está principalmente influenciado por esta disciplina, tomará de manera importante el proceso definido por la metodología #acr("RUP"). Esto quiere decir que se tomará la concepción bidimensional de fases y disciplinas.

Como se vio en el marco teórico del proyecto, se tomarán en cuenta cuatro fases, mismas que deben priorizar ciertos objetivos y guiar el enfoque de las tareas realizadas durante las mismas. Esto, por supuesto, no se debe confundir con metodologías de cascada y no se deben confundir tampoco estas fases con las distintas etapas del proceso del software.

+ Inicio: Durante esta etapa se prioriza la definición del proyecto, la investigación y el entendimiento del modelo del negocio, así como la recolección de los requisitos principales del sistema. La mayor parte de esta fase se encuentra plasmada en el perfil de proyecto.
+ Elaboración: Esta etapa prioriza la recolección de una mayor cantidad de requerimientos y un primer acercamiento al modelado del sistema usando herramientas de modelado. Se plantea la arquitectura del sistema y se va dando forma al backlog del proyecto.
+ Construcción: Esta fase prioriza la implementación del sistema en base al diseño realizado. En esta etapa tomará mucha importancia el Kanban del proyecto para hacer seguimiento a tareas y deberá tener como resultado el software desarrollado.
+ Transición: La última fase priorizará la aplicación del sistema construido para verificar su funcionamiento.

Como se puede ver, con las fases de RUP hablamos de priorización y no así de tareas específicas dentro del proceso del software, ya que en esta metodología el trabajo se realiza de forma iterativa.

Entonces, el proceso del software se podrá ver mejor reflejado en las disciplinas sobre las cuales se iterará dentro de cada fase, las cuales son nueve.

#figure(
  diagram(
    spacing: (4mm, 10mm),
    node-stroke: luma(80%),

    node((0, 0), [Modelado\ del Negocio], name: <bmod>),
    edge("-|>"),
    node((1, 0), [Requerimientos], name: <req>),
    edge("-|>"),
    node((2, 0), [Análisis\ y Diseño], name: <ayd>),
    edge("-|>"),
    node((3, 0), [Implementación], name: <imp>),
    edge("-|>"),
    node((4, 0), [Pruebas]),
    edge("-|>"),
    node((5, 0), [Despliegue]),
    node((1, 1), [Gestión del\ Proyecto]),
    node((1, 1), []),
    edge(<ayd>, <bmod>, "-|>", bend: 20deg),
    edge(<imp>, <req>, "-|>", bend: -30deg),
  ),
  caption: [Iteraciones basadas en metodología RUP\ Elaboración propia],
  placement: auto,
)<fig:rupiter>


==== Herramientas
===== Uso de LLMs en la investigación

Al haberse alimentado de todo el conocimiento humano disponible en internet, no hay duda de que los modelos de lenguaje se presentan como una tecnología valiosa para el proceso de investigación. Sin embargo, presenta características que ponen en peligro la adquisición de información relevante y confiable:

- Sesgo de origen: Los modelos de generación usan procesos estadísticos para crear los tokens que posteriormente se vuelven la respuesta que el usuario recibirá. Entonces los tokens elegidos serán los más probables de acuerdo al contexto en el que se generan y a partir de la información con la que el modelo fue entrenado. Esto implica que una respuesta esté afectada por lo que es más probable de encontrar en internet, lo cual no siempre es necesariamente correcto o puede limitar la información obtenida.
- Acceso limitado a fuentes: Los modelos de lenguaje se encuentran limitados inicialmente por su entrenamiento, la información utilizada y el momento en el que se realizó. Sin embargo, es posible conjugar el uso de modelos de lenguaje con el uso de fuentes actuales, como lo hacen la mayoría de chats, conectándose a internet, o como se puede ver en herramientas de investigación como NotebookLM.
- Pobre referenciación de fuentes: Si bien un LLM puede tener una capacidad impresionante de generar datos factualmente correctos, tiene problemas especificando el cómo sabe lo que sabe.
- Alucinaciones: Aún con la evolución de los modelos de lenguaje, incluso en los disponibles de forma gratuita, es posible que, dada su naturaleza estocástica, se puedan generar respuestas que carezcan de cualquier fundamento y las mismas pueden ser afirmadas con una seguridad autoritativa.
- System Prompts: Muchos modelos son influenciados por prompts iniciales que son desconocidos por el usuario. Estos prompts pueden limitar lo generado por el modelo o incluso acrecentar sus sesgos.

En este sentido, los modelos de lenguaje deberán ser utilizados principalmente como aproximación inicial al conocimiento y petición específica de contextos de investigación. Adicionalmente, pueden usarse herramientas especializadas como NotebookLM y modos de deep research para forzar a los modelos a usar fuentes reales en sus respuestas.

===== Uso de LLMs en la redacción
Si bien existe una evidente ventaja en el uso de modelos de lenguaje en la producción artesanal de código mediante herramientas como el autocompletado inteligente o agentes especializados y chats, en la redacción de documentos se debe tener cautela, ya que aparecen problemas importantes en el uso de inteligencia artificial:

- Detrimento de la Productividad
- Excesivo uso de lenguaje común y corporativo
- Falta de originalidad e innovación
- Dificultad referenciando fuentes

En este sentido, para la redacción de documentos el uso de modelos de lenguaje debe considerar estos aspectos:

- Usar LLMs principalmente para revisión y no así para generación
- Evitar completamente el uso de autocompletado inteligente

=== Planificación
=== Seguimiento y Control
=== Gestión de Riesgos
=== Gestión de Recursos
=== Roles y Responsabilidades
