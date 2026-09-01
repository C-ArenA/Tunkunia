#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": typ-fig

== Metodología y gestión del desarrollo<sec:meth>

#include "01-development-methodology/01-approach.typ"

=== Proceso de desarrollo aplicado

Para atacar el objetivo principal de este proyecto, se requiere una metodología que logre alinearse con el mismo y tome como experiencia enfoques ya existentes, pero considerando sus características únicas que, entre otras son:

- El gestor del proyecto y el equipo de desarrollo son la misma única persona
- El proyecto vive dentro de un entorno académico que involucra etapas de evaluación constante
- Existe un tiempo máximo asignado al proyecto
- Se requiere tener un cronograma y considerar sus posibles actualizaciones
- El proyecto, de acuerdo a su objetivo principal, es mayormente sobre desarrollo de software
- El problema que el proyecto busca resolver no tiene clientes inmediatos, pero sí está delimitado por documentos, normativa y necesidades evidentes descritas en sus antecedentes
- El proyecto se desarrollará desde cero y debe tener potencial para evolucionar de forma colaborativa como proyecto de código abierto

De este modo, el objetivo principal de esta metodología es el de definir los lineamientos, procedimientos, métodos, reglas, procesos o ciclos de vida, herramientas y artefactos necesarios para llevar a cabo de forma exitosa el proyecto tomando en cuenta sus características particulares.

Podemos traducir estas características en objetivos claros que se desean seguir para definir la metodología del proyecto:

+ Mantener únicamente los artefactos que aporten al desarrollo, de modo que el esfuerzo se concentre en el producto, siguiendo el principio 1 de modelado de Pressman
+ Brindar flexibilidad en los procedimientos, pero respetando un marco claro
+ Considerar generación de informes periódicos o constantes para ser evaluados
+ Realizar iteraciones cortas y frecuentes
+ Usar herramientas que permitan gestionar tareas y ajustar el cronograma de forma flexible y constante
+ Fomentar la actualización continua de los artefactos seleccionados mientras resulten útiles para el proyecto
+ Basarse en prácticas y metodologías propias de la disciplina de la ingeniería de software
+ Dar protagonismo al perfil de este proyecto, normativa actual e información sobre trámites emitida por el estado boliviano
+ Priorizar prácticas modernas y ser considerar evolución futura en un entorno colaborativo

Siguiendo estos objetivos, se propone la utilización de una metodología híbrida y holística que se basa principalmente en la metodología RUP, propia del desarrollo de software, pero sufriendo algunos ajustes influenciados por metodologías ágiles y la experiencia del autor para lograr alinearse con las necesidades únicas de este proyecto, pero sin perder el rigor necesario para un proyecto en entorno académico.
Estos ajustes a partir de RUP pueden resumirse en la siguiente lista:

- *Actores Principales Definidos*: En RUP se maneja el concepto de workers, pero no se definen roles a grandes rasgos del proyecto como se haría en SCRUM o incluso XP.
  Esta metodología define a los mismos en tres grupos: Dictador Benevolente, Tutor y Evaluador.
- *Fases orientadas a la priorización*: En RUP se tienen objetivos para cada fase, en esta metodología se mantienen, pero se entienden más como una guía de priorización de tareas, donde cada fase obligará al gestor del proyecto a priorizar las tareas que obedezcan al objetivo de la fase.
- *Artefactos evolutivos*: Los documentos y modelos seleccionados se elaboran progresivamente y pueden actualizarse mientras aporten valor al proyecto, sin considerarse cerrados al concluir una fase.
- *Viajar liviano*: Se reduce el conjunto amplio de artefactos propuesto por RUP a aquellos necesarios para orientar el desarrollo, comunicar decisiones y conservar la trazabilidad, evitando documentación redundante.
- *Diagramas modernos y flexibles*: Si bien se seguirá usando UML, sólo se hará cuando esto aporte al desarrollo del proyecto y además se usarán modelos de diagramación modernos como C4, que se adapta mejor al desarrollo moderno de software.
- *Gestión atómica de tareas definida*: Para poder tener control de las tareas a realizar y responder a la pregunta de "Qué hago ahora", se definen los procedimientos de gestión de tareas con un enfoque agile, usando el concepto de backlog y un tablero Kanban, así como la priorización inmediata propia de XP.
- *Iteraciones Cortas*: Las iteraciones, como en XP, se realizarán de forma semanal para buscar evoluciones rápidas.
- *Pair Programming*: Se incluye el uso de herramientas de inteligencia artificial como una pareja de programación para generación de boilerplate y revisión de código.

=== Roles

==== Cliente Potencial

En metodologías como SCRUM, se usa el rol de cliente para lograr tener una fuente de verdad acerca de las necesidades que el proyecto busca resolver.
Este cliente puede redirigir el objetivo del proyecto e incluso cambiar los requerimientos del mismo en cualquier iteración.
Además, se usa como un eje sobre el cual pivotar el propósito y los alcances del producto final.
Sin embargo, en este proyecto, el objetivo y los alcances iniciales ya se encuentran bastante bien definidos en un documento previo llamado Perfil de Proyecto y, si bien pueden realizarse algunos cambios menores sobre el mismo, estos no serán profundos y serán guiados en todo caso por la situación actual del país en cuanto a trámites, ya sea en forma de normativa vigente o comunicados oficiales y por el proponente del proyecto, en este caso, el estudiante.

==== Dictador Benevolente

En proyectos de código abierto colaborativos es común hallar el concepto de dictador benevolente, incluso el sistema operativo GNU Linux usa este enfoque que le da la última palabra a una persona, normalmente, creadora del proyecto.

En Tunkunia sólo existe un único desarrollador y gestor del proyecto que, además, haría las veces de cliente desde un marco SCRUM.
Esto sumado al objetivo de presentar este proyecto como uno de software libre, hace que laa figura del dictador benevolente sea relevante.

El dictador benevolente (Benevolent Dictator For Life) tomará decisiones técnicas y de gestión en el proyecto, pero escuchará y analizará sugerencias de los stakeholders.
Sin embargo, dado el contexto académico del proyecto, este rol debe limitarse por la normativa de la universidad y también por las exigencias del tutor y el docente de la asignatura para la mención cuando estas sean críticas.

==== Stakeholders

No es sorpresa que en un proyecto académico el principal interesado por su éxito sea el estudiante que lo propone, convirtiéndose así en el principal stakeholder, cuyo rol estará sujeto al de dictador benevolente.
Sin embargo, existen otros dos stakeholders importantes:

- *Tutor*: Es un docente de la carrera que se involucra en el desarrollo del proyecto de grado y que a su vez lo avala, convirtiéndose en un coautor del mismo, por lo que está ampliamente interesado en su correcta ejecución.
  Esto implica que *supervisará* de cerca su desarrollo, lo guiará, intervendrá de ser necesario y seguirá lo señalado en el reglamento de proyecto de grado de ETN 1040.

- *Docente de la Asignatura para la Mención*: Es el docente de la materia ETN 1040 para la mención del estudiante y que *evaluará* el desarrollo del proyecto de forma periódica como lo señalan sus funciones dentro del reglamento de proyecto de grado de ETN 1040.
  Esto implica que se le deberán presentar informes de avance de forma constante y escuchar sus evaluaciones para encaminar de mejor manera el desarrollo del proyecto.

==== Colaboradores Potenciales

En terminología de RUP, si bien en este ciclo de desarrollo que involucra a este proyecto no se trabajará con desarrolladores externos, sí se considera este rol para futuras colaboraciones y alguna de ejemplo durante este proyecto.
En este sentido, se entiende el rol de colaborador como cualquier persona que busque realizar una mejora al sistema o solucionar algún problema mediante la realización de una solicitud pull request que debe ser atendida por el dictador benevolente para ser aceptada o no.

Puede ser colaborador cualquier persona que tenga habilidades técnicas suficientes para la tarea en la cual desea colaborar y pueda realizar una solicitud de mejora mediante la plataforma que use el proyecto.

=== Ciclo de Vida
El ciclo de vida de este proyecto, que en adelante llamamos proceso del software en atención a la literatura sobre ingeniería de software y al hecho de que este proyecto está principalmente influenciado por esta disciplina, tomará de manera importante el proceso definido por la metodología @RUP.
Esto quiere decir que se tomará la concepción bidimensional de fases y disciplinas.

Como se vio en el marco teórico del proyecto, se tomarán en cuenta cuatro fases, mismas que deben priorizar ciertos objetivos y guiar el enfoque de las tareas realizadas durante las mismas.
Esto, por supuesto, no se debe confundir con metodologías de cascada y no se deben confundir tampoco estas fases con las distintas etapas del proceso del software.

+ Inicio: Durante esta etapa se prioriza la definición del proyecto, la investigación y el entendimiento del modelo del negocio, así como la recolección de los requisitos principales del sistema.
  La mayor parte de esta fase se encuentra plasmada en el perfil de proyecto.
+ Elaboración: Esta etapa prioriza la recolección de una mayor cantidad de requerimientos y un primer acercamiento al modelado del sistema usando herramientas de modelado.
  Se plantea la arquitectura del sistema y se va dando forma al backlog del proyecto.
+ Construcción: Esta fase prioriza la implementación del sistema en base al diseño realizado.
  En esta etapa tomará mucha importancia el Kanban del proyecto para hacer seguimiento a tareas y deberá tener como resultado el software desarrollado.
+ Transición: La última fase priorizará la aplicación del sistema construido para verificar su funcionamiento.

Como se puede ver, con las fases de RUP hablamos de priorización y no así de tareas específicas dentro del proceso del software, ya que en esta metodología el trabajo se realiza de forma iterativa.

Entonces, el proceso del software se podrá ver mejor reflejado en las disciplinas sobre las cuales se iterará dentro de cada fase, las cuales son nueve y se muestran en la @fig:rupiter.
Se debe tomar en cuenta que estas iteraciones no se ejecutan de forma lineal y secuencial sobre las distintas disciplinas, sino que pueden realizarse tareas de cualquier tipo durante la iteración e incluso se pueden ignorar algunas disciplinas, como indica Pressman al explicar los flujos de proceso iterativos.

#typ-fig(
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
  [Iteraciones basadas en metodología RUP],
  <fig:rupiter>,
  placement: auto,
)

Ahora bien, como se hace en la metodología SCRUM, cada iteración debe tener cierto nivel de planificación, para lo cual no sólo se elegirán las tareas para cada iteración, sino que principalmente se definirá el objetivo de las mismas.
Esto quiere decir que si en media iteración se identifica que una tarea no corresponde se puede hacer el cambio respondiendo al objetivo de cada iteración.
Las iteraciones tendrán una duración de aproximadamente una semana, pero no más de dos, dependiendo de la dificultad del objetivo planteado.
Se pueden realizar iteraciones cortas si su duración es motivada por el principio de divide y vencerás.

=== Artefactos

Para este proyecto se adaptó el conjunto de artefactos propuesto por RUP a su alcance, duración y composición del equipo.
Se conservaron aquellos que apoyan la planificación, la comunicación de decisiones y la trazabilidad entre los objetivos, los requisitos, el diseño, la implementación y la validación; los que duplicaban información o no aportaban directamente al desarrollo fueron omitidos o simplificados.

Los artefactos se elaboran de manera evolutiva y con el nivel de detalle requerido en cada iteración.
Su utilización no implica que todos deban reproducirse en la memoria o en sus anexos: podrán integrarse en el cuerpo del documento, mantenerse en el repositorio o registrarse mediante las herramientas de gestión del proyecto.
Solo se incorporarán a la memoria aquellos que resulten necesarios para sustentar o comprender el trabajo realizado.

=== Método de Trabajo

- Creación del backlog

- Creación de tareas paralela

- Selección de tareas prioritarias de acuerdo a fase

- Relación de tareas con el backlog

- Clasificación en base a disciplinas de RUP

- Puesta en el kanban

=== Herramientas y Técnicas
==== Software de Gestión de Proyectos

La gestión se apoyó en el repositorio público de GitHub, un backlog y un tablero
Kanban.
El trabajo se dividió en tareas breves relacionadas con los objetivos del
proyecto y con las disciplinas de RUP; cada tarea avanzó entre estados pendientes,
en curso y concluidos.
El cronograma conservó los hitos generales, mientras el
tablero permitió ordenar el trabajo de cada iteración sin mantener artefactos de
gestión duplicados.

==== Modelos de Lenguaje
===== Uso de LLMs en la investigación

Al haberse alimentado de todo el conocimiento humano disponible en internet, no hay duda de que los modelos de lenguaje se presentan como una tecnología valiosa para el proceso de investigación.
Sin embargo, presenta características que ponen en peligro la adquisición de información relevante y confiable:

- Sesgo de origen: Los modelos de generación usan procesos estadísticos para crear los tokens que posteriormente se vuelven la respuesta que el usuario recibirá.
  Entonces los tokens elegidos serán los más probables de acuerdo al contexto en el que se generan y a partir de la información con la que el modelo fue entrenado.
  Esto implica que una respuesta esté afectada por lo que es más probable de encontrar en internet, lo cual no siempre es necesariamente correcto o puede limitar la información obtenida.
- Acceso limitado a fuentes: Los modelos de lenguaje se encuentran limitados inicialmente por su entrenamiento, la información utilizada y el momento en el que se realizó.
  Sin embargo, es posible conjugar el uso de modelos de lenguaje con el uso de fuentes actuales, como lo hacen la mayoría de chats, conectándose a internet, o como se puede ver en herramientas de investigación como NotebookLM.
- Pobre referenciación de fuentes: Si bien un LLM puede tener una capacidad impresionante de generar datos factualmente correctos, tiene problemas especificando el cómo sabe lo que sabe.
- Alucinaciones: Aún con la evolución de los modelos de lenguaje, incluso en los disponibles de forma gratuita, es posible que, dada su naturaleza estocástica, se puedan generar respuestas que carezcan de cualquier fundamento y las mismas pueden ser afirmadas con una seguridad autoritativa.
- System Prompts: Muchos modelos son influenciados por prompts iniciales que son desconocidos por el usuario.
  Estos prompts pueden limitar lo generado por el modelo o incluso acrecentar sus sesgos.

En este sentido, los modelos de lenguaje deberán ser utilizados principalmente como aproximación inicial al conocimiento y petición específica de contextos de investigación.
Adicionalmente, pueden usarse herramientas especializadas como NotebookLM y modos de deep research para forzar a los modelos a usar fuentes reales en sus respuestas.

===== Uso de LLMs en la redacción
Si bien existe una evidente ventaja en el uso de modelos de lenguaje en la producción artesanal de código mediante herramientas como el autocompletado inteligente o agentes especializados y chats, en la redacción de documentos se debe tener cautela, ya que aparecen problemas importantes en el uso de inteligencia artificial:

- Detrimento de la Productividad
- Excesivo uso de lenguaje común y corporativo
- Falta de originalidad e innovación
- Dificultad referenciando fuentes

En este sentido, para la redacción de documentos el uso de modelos de lenguaje debe considerar estos aspectos:

- Usar LLMs principalmente para revisión y no así para generación
- Evitar completamente el uso de autocompletado inteligente

#v(1em)

==== Pareja de Programación

La programación en pareja de XP busca que dos personas trabajen sobre el mismo
problema y revisen continuamente las decisiones tomadas.
Debido a que el equipo
de desarrollo de Tunkunia estuvo compuesto por una sola persona, se utilizó la
inteligencia artificial como una pareja de programación con matices importantes:
su intervención no sustituyó el criterio ni la responsabilidad del autor.

La asistencia se concentró en la escritura de código repetitivo de soporte
(_boilerplate_), la revisión de código y la generación de elementos no críticos,
como operaciones CRUD e interfaces de usuario previamente definidas.
Las
decisiones de dominio, arquitectura, seguridad y funcionamiento del motor de
procesos permanecieron bajo control del desarrollador.
Toda propuesta generada
por inteligencia artificial fue tratada como un borrador sujeto a revisión,
pruebas y adaptación antes de incorporarse al proyecto.

#include "01-development-methodology/02-communication.typ"

=== Planificación, seguimiento y control

Al inicio de cada iteración se definió un objetivo acorde con la fase vigente y
se seleccionaron del backlog las tareas de mayor prioridad, considerando sus
dependencias y riesgos.
Durante la iteración, el tablero Kanban permitió observar
el trabajo en curso y ajustar tareas sin perder el objetivo acordado.
Al cierre
se revisaron el incremento y los artefactos producidos; las tareas pendientes se
reformularon o devolvieron al backlog.
Las observaciones del tutor y las
evaluaciones académicas alimentaron las iteraciones posteriores y, cuando fue
necesario, la actualización del cronograma.

=== Gestión de riesgos y recursos

La gestión de riesgos fue continua y ligera, adecuada a un proyecto dirigido y
desarrollado por una sola persona.
Se prestó especial atención a los riesgos de
plazo, decisiones técnicas inciertas, cambios de alcance y dependencia de
servicios externos.
Las respuestas principales fueron priorizar temprano los
prototipos de mayor incertidumbre, limitar el trabajo de cada iteración, mantener
versionado el código y la documentación, automatizar compilaciones y pruebas, y
emplear adaptadores o servicios simulados cuando una integración real no estaba
disponible.

Los recursos principales fueron el tiempo y trabajo del autor, la orientación
del tutor y del docente evaluador, el equipo local de desarrollo y herramientas
de software libre.
Como el tiempo constituyó el recurso más restrictivo, las
capacidades del prototipo se priorizaron por su relación con los objetivos y los
requerimientos, dejando las ampliaciones no esenciales para trabajo futuro.
