#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, mmd-fig

== Marco Teórico

=== Flujos de Trabajo

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

- *Redes de Petri:* una de las técnicas de modelado más antiguas en las ciencias de la computación.
  Inspiró aspectos del lenguaje UML, tiene diversas variantes y está definida formal y matemáticamente, lo que permite analizar los sistemas modelados @reisigUnderstandingPetriNets2013.
  También se denominan _place/transition nets_ porque están formadas por lugares, representados por círculos, y transiciones, representadas por rectángulos, constituyendo un lenguaje matemático y una forma de representar sistemas distribuidos discretos @simonStateMachinesPetri.
  Algunos autores defienden que esta técnica es capaz de modelar procesos @vanderaalstAPPLICATIONPETRINETS1998, como en la @fig:petricomplaints.

Existe una gran cantidad de lenguajes, herramientas y técnicas para modelar sistemas de software y procesos.
La elección depende de la naturaleza del sistema y de los beneficios de cada alternativa, aunque un mismo sistema puede modelarse mediante distintos lenguajes.

=== Redes de Petri
==== Fundamentos
==== Redes de Petri con Colores
==== Redes de Petri con Tiempo

=== Aplicación de Redes de Petri al Modelado de Procesos

=== El Proceso de la Ingeniería de Software
==== Ingeniería de Requerimientos
==== Arquitectura de software y modularidad

Una ingeniería de software efectiva requiere diseñar la arquitectura del software, práctica que siempre se lleva a cabo de forma implícita al desarrollar, pero que conviene aplicar de forma fundamentada.
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

==== Diseño de Software
==== Construcción del Software
===== Breve repaso de Tecnologías y Técnicas


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
==== OIDC
==== REST API
==== OpenAPI

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
