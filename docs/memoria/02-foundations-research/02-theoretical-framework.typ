#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, mmd-fig, typ-fig

== Marco Teórico

=== Flujos de Trabajo

Es importante definir para entender la naturaleza de este trabajo lo que es un flujo de trabajo. Al ser un concepto elemental en el proyecto se extrae su definición como una traducción del glosario del grupo WFMC@WorkflowManagementCoalition:

#quote()[
  Un flujo de trabajo es la secuencia de tareas, pasos y decisiones que deben seguirse para completar un proceso específico. Puede entenderse como un conjunto de instrucciones que describen cómo debe llevarse a cabo un proceso, incluyendo el orden en que deben completarse las tareas, quién es responsable de realizar cada una de ellas y qué debe suceder a continuación en función del resultado de cada tarea.

  Los flujos de trabajo pueden utilizarse para automatizar una amplia variedad de procesos de negocio, como la facturación, el procesamiento de pedidos, la gestión de recursos humanos y la gestión de proyectos. El objetivo de un flujo de trabajo es garantizar que las tareas se completen en el orden correcto y por las personas adecuadas, así como asegurar que el proceso sea eficiente y preciso.
]
=== Sistemas de gestión de flujos de trabajo y procesos<section:wfms>

Un @WFMS contempla, de forma general, el manejo de flujos de trabajo.
De forma similar, y a veces usado indistintamente con WFM, existe el término BPM (_Business Process Management_), que de modo más amplio es el arte y la ciencia de supervisar cómo el trabajo es realizado dentro de una organización.

Toda organización, incluido el aparato gubernamental, debe manejar *procesos* @dumasFundamentalsBusinessProcess2013, siendo los trámites ejemplos típicos.
Por esto, tanto los WFMS como BPM tienen relevancia en los sistemas de software.

Existe una organización dedicada a estandarizar los WFMS y BPM, fundada el año 1993 y llamada "Workflow Management Coalition" (WfMC) @WorkflowManagementCoalition.
Esta organización define a los WFMS de la siguiente manera:

#quote(attribution: [Workflow Management Coalition])[
  A workflow management system (WMS) is a software application that is designed to help organizations automate and manage their business processes.
  A WMS allows an organization to define and implement a workflow #sym.dash.em\a series of tasks, steps, and decisions#sym.dash.em that need to be followed to complete a specific process.
  The system can then be used to track the progress of the workflow, manage the flow of information and documents, and ensure that tasks are completed in the correct order and by the right people.

  A WMS can be used to automate a wide range of business processes, such as invoicing, order fulfillment, human resources, and project management.
  It can also be used to integrate different systems, such as email, calendar, and customer relationship management (CRM) software.
  WMS allows you to streamline the process and make it more efficient, reduce errors and delays, and give you real-time visibility into the status of your processes, also it's common to have a built-in reporting and analytics tools to measure the performance of the process.
]

#img-fig(
  "/assets/figures/wfms_history.png",
  [WFMS desde una perspectiva histórica],
  <fig:wfms_history>,
  source: [The Application of Petri Nets to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)

La necesidad de manejar flujos de trabajo es frecuente en muchos sistemas, por lo que ciertos autores creen que debe ser un módulo tan importante como el sistema de gestión de bases de datos, como se aproxima mediante la @fig:wfms_history.
De forma general y sintética, el propósito principal de los WFMS es apoyar la definición, ejecución, registro y control de procesos @vanderaalstAPPLICATIONPETRINETS1998, algo que puede guiar la implementación de un sistema específico para trámites administrativos.



=== Modelado de procesos<section:modeling>

Los trámites son *procesos*.
Existen varios lenguajes que permiten representarlos gráficamente y que, de forma general, consisten mínimamente en conjuntos de nodos de dos tipos: actividad y control @dumasFundamentalsBusinessProcess2013.

#img-fig(
  "/assets/figures/bpmn.png",
  [Ejemplo de un diagrama BPMN],
  <fig:bpmn>,
  source: [Business Process Model and Notation (BPMN) Version 2.0.2 @bpmn202],
  width: 60%,
  placement: auto,
)

==== Diagramas de flujo
Quizá uno de los lenguajes más antiguos para describir procesos.
En su forma básica emplea rectángulos para representar actividades y rombos o diamantes para representar puntos de decisión.

==== Diagramas de actividad UML (Unified Modeling Language):
UML es un lenguaje ampliamente utilizado para representar sistemas de software.
Sus diagramas de actividad permiten representar gráficamente procesos de negocio a través de distintas organizaciones.
==== EPC (Event-driven Process Chain):
Técnica gráfica de modelado de procesos ampliamente utilizada en la industria y compatible con muchas herramientas.
Se parece a los diagramas de flujo, pero trata a los eventos como ciudadanos de primera clase.
==== Familia IDEF (Integration Definition):
Conjunto de métodos y técnicas gráficas creado por la fuerza aérea estadounidense y basado en el manejo de escenarios.
IDEF3 provee un mecanismo para recolectar y documentar procesos @IDEF3ProcessDescription.
==== BPMN (Business Process Model and Notation)
Estándar gráfico de modelado de procesos.
Su última versión es BPMN 2.0.2 y fue publicada como estándar del Object Management Group (OMG) el año 2014.
Las actividades se representan mediante rectángulos redondeados, los nodos de control o _gateways_ mediante diamantes y los nodos se conectan mediante arcos, como en el proceso colaborativo de la @fig:bpmn.

Además, existen otros lenguajes de modelado de sistemas menos comunes para describir procesos, pero útiles porque reflejan la naturaleza paso a paso de los trámites.

#img-fig(
  "/assets/figures/statediagramex.png",
  [Ejemplo de una máquina de estados],
  <fig:statediagramex>,
  width: 50%,
  placement: auto,
)

#img-fig(
  "/assets/figures/petricomplaints.png",
  [Red de Petri de un proceso de queja],
  <fig:petricomplaints>,
  source: [The Application Of Petri Nets to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  width: 70%,
  placement: auto,
)

==== Máquinas de estado en el modelado de procesos
Aunque no suelen mencionarse como lenguaje para modelar gráficamente procesos administrativos, pueden cumplir este propósito (ver @fig:statediagramex).
Una máquina de estados es un conjunto de cinco elementos $M=(S,I,O,v,w)$, donde $S$ representa la colección de estados de $M$; $I$, el alfabeto de entradas; $O$, el alfabeto de salidas; $v:S x I->S$, la función del siguiente estado; y $w:S x I->O$, la función de salida @grimaldiDiscreteCombinatorialMathematics1998.


Existe una gran cantidad de lenguajes, herramientas y técnicas para modelar sistemas de software y procesos.
La elección depende de la naturaleza del sistema y de los beneficios de cada alternativa, aunque un mismo sistema puede modelarse mediante distintos lenguajes.

=== Redes de Petri
Aunque son también un lenguaje útil para modelar procesos, se presentan en una sección independiente dada la importancia que acaban teniendo en el desarrollo de este proyecto.

Las Redes de Petri una de las técnicas de modelado más antiguas en las ciencias de la computación.
Inspiró aspectos del lenguaje UML, tiene diversas variantes y está definida formal y matemáticamente, lo que permite analizar los sistemas modelados @reisigUnderstandingPetriNets2013.
También se denominan _place/transition nets_ porque están formadas por lugares, representados por círculos, y transiciones, representadas por rectángulos, constituyendo un lenguaje matemático y una forma de representar sistemas distribuidos discretos @simonStateMachinesPetri.
==== Definición

Existen varias formas de definir formalmente una Red de Petri estándar. Algunas definiciones usan un enfoque más de matrices y otras un enfoque de funciones. Las diferencias son mínimas, pero pueden ofrecer variedad a la hora de traducir el modelo matemático en código.

Una *Red de Petri* (red $P\/T$) se define@giraultPetriNetsSystems2001 mediante la tupla

$cal(N) = chevron P, T, bold("Pre"), bold("Post") chevron.r$

donde:

- $P$ es un conjunto finito de *lugares*.
- $T$ es un conjunto finito de *transiciones*, disjunto de $P$ ($P inter T = nothing$).
- $bold("Pre"), bold("Post") in NN^(abs(P) times abs(T))$ son,
  respectivamente, las matrices de *preincidencia* y *postincidencia*
  de $cal(N)$.

La matriz

$bold(C) = bold("Post") - bold("Pre")$

se denomina *matriz de incidencia* de $cal(N)$.

Un *marcado* de una red $P\/T$

$cal(N) = chevron.l P, T, bold("Pre"), bold("Post") chevron.r$

es un vector $bold(m) in NN^(abs(P))$.

La red $cal(N)$ junto con un marcado $bold(m)_0$, denominado
*marcado inicial*, constituye un *sistema de red $P\/T$*,

$cal(S) = chevron.l cal(N), bold(m)_0 chevron.r$

o, equivalentemente,

$cal(S) = chevron.l P, T, bold("Pre"), bold("Post"), bold(m)_0 chevron.r$.

Una transición $t in T$ está *habilitada* en un marcado $bold(m)$ si

==== Redes de Petri con Colores
Una extensión a las redes de petri son los colores, que son atributos asignados a los tokens de una red para poder distinguir entre ellos. En otras palabras, son tokens con tipo.

==== Redes de Petri con Tiempo
Las redes de Petri convencionales no tienen una idea del tiempo. Esta extensión permite aplicar duración a los distintos elementos de una red, como pueden ser las transiciones, los lugares o incluso los tokens.
=== Aplicación de Redes de Petri al Modelado de Procesos
Algunos autores defienden que esta técnica es capaz de modelar procesos @vanderaalstAPPLICATIONPETRINETS1998, como en la @fig:petricomplaints. Aunque otros presentan críticas importantes.

Las Redes de Petri fueron ampliamente exploradas en cuanto a sus posibles aplicaciones, una de ellas es su aplicación en sistemas de gestión de flujos de trabajo. El autor que mejor definió esta aplicación es Van Der Aalst, cuyo trabajo es quizás el que más influenció la solución de este proyecto.

Van Der Aalst define a los flujos de trabajo en 3 dimensiones (@fig:vanderaals3dwf) y a partir de ello presenta una relación de elementos de un flujo de trabajo con los elementos de una Red de Petri.

#typ-fig(
  include "/assets/figures/vanderaals3dwf.typ",
  [Abstracción en tres dimensiones de los flujos de trabajo según Van der Aalst],
  <fig:vanderaals3dwf>,
)

No se pretende describir todo el trabajo de Van Der Aalst en este documento, pero es importante destacar algunas de sus definiciones más importantes:

- Un caso es una ejecución o instancia de un proceso. Es decir, un proceso definido puede tener varios casos asociados.
- Los recursos son los participantes del flujo de trabajo, aunque él evita asociarlos con las Redes de Petri, pero no niega la posibilidad.
- Las Redes de Petri de un flujo de trabajo deben comenzar y terminar en una sola plaza o lugar, a esta Red se la define como WorkFlow net: Una red de Petri $P\N = (P,T,F)$ es una red WF si y sólo si:
  + $P\N$ tiene dos lugares especiales: $i$ y $o$, El lugar $i$ es un lugar fuente: $bullet i = nothing$. El lugar $o$ es un lugar sumidero: $o bullet = nothing$.
  + Si añadimos una transición $t*$ a $P\N$ conectando $o$ con $i$, la red resultante es fuertemente conectada. Es decir, hay un camino dirigido entre cualquier par de nodos.
- Un caso puede mapearse a un color en una red de petri de color.Esto permite que una misma red tenga a todos los casos evolucionando dentro de su estructura.
- Extensión de Redes de Petri con jerarquías: Una red puede contener sub-redes. Esto es especialmente útil más adelante cuando se busque compactar una parte de un proceso en una sola transición.
=== El Proceso de la Ingeniería de Software
==== Ingeniería de Requerimientos

La ingeniería de requerimientos es un paso fundamental no sólo por ser de los primeros en el ciclo de vida del software en distintas concepciones del proceso del software, sino también porque ayuda a definir los aspectos sólidos e inmutables de un sistema en tanto el propósito del mismo no cambie.

Es importante en un proyecto de software poder definir de forma correcta elementos que guíen las etapas posteriores. Los requerimientos garantizan que se puedan dar cambios en el diseño sin comprometer el propósito del sistema, en tanto se respeten los requerimientos.

La ingeniería de requerimientos nos ayuda a manipular los requerimientos de forma sistematizada. Los requerimientos, por su lado son condiciones necesarias para resolver un problema o lograr un objetivo y las condiciones que debe tener un sistema para satisfacer un contrato o definición. También le llamamos requerimiento a la representación documentada de un requerimiento@ingenoSoftwareArchitectsHandbook2018.

==== Arquitectura de software y modularidad

Una ingeniería de software efectiva requiere diseñar la arquitectura del software, práctica que muchas veces se puede llevar a cabo de forma implícita al desarrollar, pero que conviene aplicar de forma fundamentada.
Primero, reconocer paradigmas comunes permite entender relaciones de alto nivel entre sistemas y construir sistemas nuevos como variaciones de sistemas antiguos.
Segundo, conseguir una arquitectura correcta suele ser crucial para el éxito del diseño, mientras que hacerlo incorrectamente puede llevar a resultados desastrosos.
Tercero, comprender las arquitecturas permite elegir de manera fundamentada entre alternativas de diseño.
Cuarto, una representación arquitectónica suele ser esencial para analizar y describir propiedades de alto nivel de un sistema complejo @garlanIntroductionSoftwareArchitecture1994.
La representación y el diseño explícitos de la arquitectura se han vuelto temas dominantes en la ingeniería de software @pressmanSoftwareEngineeringPractitioner2010.

La modularidad es un principio de organización importante para sistemas compuestos por varias piezas.
Es un término general para denotar grupos relacionados de código @richardsFundamentalsSoftwareArchitecture2020.
Este agrupamiento se relaciona con la reutilización y con la organización de un sistema para facilitar su mantenimiento y evolución.

Muchos patrones y estilos de arquitectura buscan modularidad en algún sentido.
Entre ellos se encuentran la arquitectura en capas, la arquitectura orientada a servicios (@SOA), la arquitectura basada en microservicios, la arquitectura de eventos y la arquitectura hexagonal.
Cada estilo tiene características, ventajas y desventajas propias, pero todos buscan facilitar el mantenimiento y la evolución del software.

#img-fig(
  "/assets/figures/micro_topo.png",
  [Topología del estilo de arquitectura de microservicios],
  <fig:micro_topo>,
  source: [Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  width: 60%,
  placement: auto,
)

#img-fig(
  "/assets/figures/soa_topo.png",
  [Topología del estilo de arquitectura @SOA],
  <fig:soa_topo>,
  source: [Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  width: 60%,
  placement: auto,
)

- *La arquitectura por capas* es un estándar de facto para muchas aplicaciones, principalmente por su simplicidad, familiaridad y bajos costos.
  También es una forma natural de desarrollar aplicaciones siguiendo la ley de Conway de reflejar la estructura de una organización en el diseño de un producto.
  La @fig:siai_architecture_style muestra una topología común de este tipo.
- *La arquitectura de microservicios* se basa en pequeños servicios totalmente independientes que pueden comunicarse entre sí para garantizar un alto desacoplamiento.
  Es compleja y requiere independencia incluso en las bases de datos, como puede verse en la @fig:micro_topo.
- *La arquitectura orientada a servicios (SOA)* es un estilo pragmático y flexible que, si bien se basa en servicios independientes, no tiene el mismo nivel de complejidad que los microservicios y otras arquitecturas distribuidas (ver @fig:soa_topo).
  Se volvió popular en muchas aplicaciones relacionadas con empresas.

#img-fig(
  "/assets/figures/hex_original.png",
  [Estructura básica de la arquitectura hexagonal],
  <fig:hex_original>,
  source: [Hexagonal architecture the original 2005 article by Alistair Cockburn@cockburn2005hexagonal],
)

Existen muchos más patrones y estilos de arquitectura ampliamente reconocidos que ayudan a describir el sistema de forma global. Asimismo, existen patrones que describen el sistema en un nivel inferior y que se popularizaron por inducir a un código más sencillo de mantener y son las arquitecturas con inversión de dependencias. Una de las primeras estructuras con esta naturaleza fue la arquitectura hexagonal@cockburn2005hexagonal o de puertos y adaptadores, que aísla la capa de aplicación y la vuelve ignorante de su entorno, viviendo en el centro del sistema como puede verse en la @fig:hex_original.

==== Diseño de Software

El diseño de software, que muchas veces se confunde con la arquitectura del software es una disciplina, un proceso y una etapa dentro del ciclo de vida del software que se puede ver en términos generales como aquella en la que se resuelven los problemas que presenta el software.

Su diferencia con arquitectura es algo compleja de definir, ya que existen distintos puntos de vista al respecto, pero aquí se emplea el SWEBOK que expone al diseño como una disciplina que engloba a la arquitectura en una de sus tres etapas que son:

- Diseño de la arquitectura
- Diseño de alto nivel
- Diseño interno detallado

Aún así, incluso en la fuente antes mencionada, se suele distinguir en la práctica por darle mayor prioridad a las dos últimas etapas, dejando a la arquitectura como un elemento por sí mismo, ya que esta abarca mucho.

La mentalidad en el diseño es importante para poder llegar a soluciones y puede definirse en cinco pasos:

+ Cristalizar un propósito u objetivo
+ Formular un concepto de cómo se puede lograr el propósito
+ Visualizar un mecanismo que implemente la estructura conceptual
+ Introducir una notación que exprese las capacidades del mecanismo y que invoque su uso
+ Describir el uso de esta notación en un contexto de problema específico para invocar el mecanismo y que el propósito sea logrado.

En resumen, entender un problema y plantear una solución @ingenoSoftwareArchitectsHandbook2018.

=== Metodologías en Gestión de Proyectos y Desarrollo de Software

Un análisis etimológico de la palabra metodología, que proviene del griego μέθοδος y está conformado por tres partes: "meta" que significa "más allá", "hodos" que significa "camino" y el sufijo "-logía" que se refiere a "estudio", nos da a entender inicialmente que método es el camino del camino, es decir, cómo se logra lo que se quiere lograr y metodología es el análisis realizado sobre el mismo.
Evidentemente, el significado de la palabra es más complejo y de acuerdo al diccionario puede indicar un conjunto de métodos que se siguen en una investigación científica o doctrinal @asaleDiccionarioLenguaEspanola, siendo ésta una definición influenciada por la epistemología y su carácter investigativo para generar nuevo conocimiento, sin reflejar necesariamente y de forma directa su uso en un proyecto de ingeniería.

#mmd-fig(
  "/assets/figures/bunge-technological-process.png",
  [Diagrama de flujo del proceso tecnológico],
  <fig:bungflow>,
  source: [Elaboración propia a partir de Epistemología de Mario Bunge@bungeEpistemologiaCursoActualizacion2002],
)

Ahora bien, si analizamos cómo estructura Bunge@bungeEpistemologiaCursoActualizacion2002 el proceso tecnológico en la @fig:bungflow y prestamos atención a las actividades de investigación podemos vislumbrar que existen similitudes importantes entre un proyecto, particularmente uno de desarrollo de software, y una investigación tecnológica que no sólo tiene como meta la verdad que sea útil a alguien sino que además cuenta con un ciclo de seis etapas que, para facilitar la visualización de similitudes, a continuación se agrupan de acuerdo al proceso del software de Sommerville@sommervilleSoftwareEngineering2016[p.
  ~44]:

- Especificación del Software: Definición de la funcionalidad deseada
  - Discernir el problema
  - Tratar de resolver el problema con ayuda del conocimiento disponible
  - Si falla la tentativa anterior, inventar hipótesis o técnicas (o aun sistemas hipotético-deductivos) capaces de resolver el problema
- Desarrollo del Software: Se produce el software
  - Obtener una solución (exacta o aproximada) del problema con ayuda del nuevo instrumental conceptual o material
- Validación del Software: Se debe asegurar que el software haga lo que el cliente desea
  - Poner a prueba la solución (p. ej., con ensayos de laboratorio o de campo)
- Evolución del Software: El software debe evolucionar para atender cambios de necesidades del cliente
  - Efectuar las correcciones necesarias en las hipótesis o técnicas, o incluso en la formulación misma del problema original.

Si bien esto nos brinda cierta flexibilidad en el uso del término metodología, conviene buscar definiciones adicionales o alternativas que le den a los proyectos un papel más protagónico, como la que se presenta en la guía del cuerpo de conocimiento sobre gestión de proyectos, que indica que una metodología es un sistema de prácticas, técnicas, procedimientos y reglas usado por aquellos que trabajan en una disciplina@projectmanagementinstituteStandardProjectManagement2021[p.
  ~69].
Esta definición es consistente con la acepción técnica del término en la literatura anglosajona y es la que se tomará principalmente en el desarrollo de este proyecto.

Cabe señalar que, contar con una metodología en gestión de proyectos no es sólo un paso más a seguir, y es que a menudo ayuda a lograr los objetivos del proyecto@nicholasProjectManagementEngineering2021[p.
  ~9-10] porque atiende las siguientes actividades relevantes:

+ Identificar las tareas a realizar en un proyecto
+ Identificar los recursos necesarios
+ Establecer prioridades
+ Crear cronogramas
+ Controlar y monitorear la calidad de los artefactos producidos y su rendimiento
+ Medir el rendimiento del proyecto

Entendido esto, se considera importante que estas metodologías consideren las características particulares de cada proyecto en términos de tamaño, duración y complejidad, y que evolucionen con el mismo, logrando una serie de elementos diseñados a medida@projectmanagementinstituteStandardProjectManagement2021[p.
  ~197-199], como los siguientes:

- Ciclo de vida del proyecto
- Enfoque de desarrollo
- Procesos
- Herramientas
- Participación y roles de los distintos actores
- Métodos
- Artefactos

Evidentemente, existen ya diversos marcos de trabajo o metodologías que prescriben muchos de los elementos anteriores.
En trabajos de ingeniería, por ejemplo, es común hallar metodologías de tipo cascada o waterfall, donde el desarrollo del proyecto se realiza en pasos secuenciales claramente definidos.
Sin embargo, dependiendo de la naturaleza e incertidumbre asociada al proyecto, también existen otros enfoques.

Un área que convive bastante con la incertidumbre es la ingeniería de software, donde se encuentran enfoques metodológicos que entienden un proceso no necesariamente lineal, sino también iterativo o evolutivo, como aquellos guiadas por filosofías ágiles o marcos de trabajo algo más específicos como el de @UP o @RUP.
Sin embargo, estos enfoques no necesariamente representan metodologías completas para un proyecto de software y sus autores a menudo recomiendan su adaptación y uso únicamente como referencia para definir la metodología propia de cada trabajo.

A continuación se listan algunos de estos enfoques metodológicos o marcos de trabajo que presentan relevancia en la metodología adoptada en este proyecto.

==== Proceso Unificado

El Proceso Unificado, también conocido como @UP y adaptado por Rational Software#footnote[Por este motivo se le conoce comúnmente como RUP (Rational Unified Process)], fue popularizado por dicha empresa al ser documentado de forma detallada y desarrollado en lo que hoy conocemos como @RUP.
Es un proceso de ingeniería de software @RUPIBMRational que, de forma prescriptiva, define principios, reglas, procesos, enfoques, ciclos, actividades y artefactos.
En la práctica constituye una metodología muy usada en la industria por seguir las buenas prácticas acumuladas durante los primeros años de la disciplina y proponer un ciclo de vida iterativo e incremental, basado en la iteración y la gestión de riesgos, que se adapta mejor al desarrollo de software que uno lineal como el de la metodología _waterfall_.

Se compone de cuatro fases principales: Inicio (_Inception_), Elaboración, Construcción y Transición.
Cada fase prioriza actividades específicas del desarrollo, como la definición de requisitos, el diseño del sistema, la implementación y las pruebas.
El proceso también define disciplinas y roles.

// Los encabezados SCRUM y Kanban del borrador original no contaban con desarrollo.

=== Interoperabilidad
==== OAuth2

OAuth 2.0 es un marco de autorización que permite a una aplicación obtener acceso limitado a un servicio HTTP sin recibir las credenciales del propietario del recurso.
Para ello separa los roles de propietario del recurso, cliente, servidor de autorización y servidor de recursos; el cliente obtiene un _access token_ con un alcance y una duración determinados y lo presenta al servidor de recursos.
La especificación define distintos tipos de concesión y un mecanismo de extensión, de modo que el acceso delegado puede adaptarse a diferentes clases de cliente @hardtOAuth20Authorization2012.

==== OIDC

OpenID Connect (OIDC) es una capa de identidad construida sobre OAuth 2.0 que permite a un cliente verificar la identidad del usuario y obtener información básica de su perfil.
Introduce el _ID Token_, expresado como un JSON Web Token (JWT), y estandariza flujos, alcances, declaraciones y puntos de acceso para que proveedores y clientes de identidad interoperen @openidFoundationOpenIDConnectCore2023.
La @fig:oidc_sequence resume un flujo típico: el cliente redirige al usuario al proveedor, recibe un código de autorización, lo intercambia por tokens y emplea el token de acceso para consultar la información del usuario.

#img-fig(
  "/assets/figures/OIDC_sequence_diagram.png",
  [Secuencia de autenticación mediante OpenID Connect],
  <fig:oidc_sequence>,
  source: [Mozilla, _Web Security Guidelines_ @mozillaOIDCSequenceDiagram],
  width: 90%,
  placement: auto,
)

==== REST API

REST (_Representational State Transfer_) es un estilo arquitectónico para sistemas distribuidos basado en recursos identificables y representaciones transferidas mediante una interfaz uniforme.
Sus restricciones incluyen cliente-servidor, ausencia de estado entre solicitudes, capacidad de caché, sistema por capas, interfaz uniforme y, opcionalmente, código bajo demanda.
Una API REST aplica estas restricciones para desacoplar clientes y servidores, favorecer la evolución independiente de sus componentes y aprovechar la semántica de HTTP @fieldingArchitecturalStylesDesign2000.

==== OpenAPI

OpenAPI define un formato independiente del lenguaje para describir interfaces de API HTTP de modo que personas y herramientas puedan comprender sus capacidades sin inspeccionar el código fuente.
Un documento OpenAPI expresa, entre otros elementos, rutas, operaciones, parámetros, cuerpos, respuestas, esquemas de datos y mecanismos de seguridad; por ello puede servir como contrato para documentación, validación y generación de clientes o servidores @openapi310.

=== Reutilización de software

La reutilización de software (_software reuse_) es el uso sistemático de piezas existentes de software para construir otras nuevas, modificadas o incluso productos de software completos a partir de estas.
Las piezas pueden ser código fuente, ejecutables, guías de diseño, componentes de software libre, componentes comerciales o arquitecturas completas.
El conocimiento también es reutilizable y se refleja en patrones, procesos o arquitecturas de software @mohagheghiQualityProductivityEconomic2007.
Las piezas reutilizables pueden materializarse como bibliotecas, _frameworks_, componentes o sistemas completos (@fig:reuse_landscape).

#img-fig(
  "/assets/figures/reuse_landscape.png",
  [Reuse landscape],
  <fig:reuse_landscape>,
  source: [Sommerville, Software Engineering @sommervilleSoftwareEngineering2016],
  width: 60%,
  placement: auto,
)

Por su naturaleza de usar trabajo existente como bloques de construcción para proyectos mayores, la reutilización se relaciona con un aumento en la productividad, un posible aumento de calidad @selbyEnablingReusebasedSoftware2005 y una disminución en los costos.
Medir empíricamente estos beneficios es difícil y algunos intentos pueden no contemplar todas las variables, dada la naturaleza particular de cada proyecto.
Aun así, se han mostrado resultados positivos que indican un claro aumento de productividad al reutilizar software @basiliHowReuseInfluences1996, lo que también implicaría beneficios en tiempos y costos de desarrollo.


=== Software libre y código abierto

El software libre tiene un efecto democratizador en los gobiernos @donorfioPoliticsFreeOpen2004 y brinda soberanía sobre el código utilizado, permitiendo tener el *control de la tecnología* empleada @LibertadSoftwareSu.
De acuerdo con Richard Stallman, es necesario usar software libre en el gobierno electrónico para no pedir *permiso a un tercero* al manipular el código fuente y para que gobiernos de todo el mundo puedan *utilizar, corregir, difundir y contribuir a la mejora del software* @SoftwareLibreGobierno.

Software libre significa, a grandes rasgos, que los usuarios tienen la *libertad* de *ejecutar, copiar, distribuir, estudiar, modificar y mejorar* el software @QueEsSoftware.
Por la ambigüedad del término inglés #footnote[_free_ también puede significar "gratis"] nació _Open Source_ como otra forma de referirse a lo mismo, salvo diferencias filosóficas según Stallman @WhyOpenSource.
Posteriormente se creó el término que abarca ambos, _free software_ y _open source_: _free and open source software_ (FOSS).
Este documento los emplea casi indistintamente y prefiere *FOSS*.

Cuando Richard Stallman comenzó a trabajar como programador en el Laboratorio de Inteligencia Artificial del MIT el año 1971, pasó a formar parte por primera vez de una *comunidad* de "hackers" #footnote[El término hacker es entendido por Stallman como aquel que hace referencia a una persona inteligente y curiosa con espíritu de sagacidad imaginativa y de exploración] que *compartían software* y que, sin saberlo porque entonces la práctica era tan común que no tenía un término propio, formaban también una comunidad de "software libre" @stallmanSoftwareLibrePara.
Estas comunidades no dejaron de existir a pesar de que la industria comenzó a tratar el software como producto comercial.

El "Plan de Implementación de Software Libre y Estándares Abiertos" define al software libre del modo siguiente:

#quote(
  attribution: "Plan de Implementación de Software Libre y Estándares Abiertos",
)[
  El Software Libre se basa en una filosofía que busca que el desarrollo de la tecnología se
  oriente al bienestar de los seres humanos en términos de igualdad; que el conocimiento sea
  lo que realmente es: un bien común de la humanidad; que la cooperación sea el modelo de
  su desarrollo y que todos puedan libremente disfrutar de sus resultados, sin mellar los
  mismos derechos para los demás

  [...]

  La incorporación y uso del Software Libre y estándares abiertos, promueve valores de
  innovación, solidaridad, búsqueda del bien común y el desarrollo de los individuos y de la
  sociedad, coincidentes con los del Estado.
  A través de la implementación del Software Libre
  *se busca que el Estado adquiera y desarrolle la capacidad de controlar las aplicaciones
  informáticas que utiliza con soberanía tecnológica*.
]


// El borrador original incluía encabezados vacíos sobre lenguajes, librerías, bases de datos,
// OAuth, IDEs, control de versiones, plataformas de colaboración, automatización, clientes de
// API, patrones de arquitectura, desafíos y ética de LLMs. No se desarrollan aquí porque no
// contenían información sustantiva y las tecnologías concretas pertenecen al diseño.
