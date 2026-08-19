#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/acrostiche:0.7.0": acr
== Marco Teórico

=== Metodologías en Gestión de Proyectos

Un análisis etimológico de la palabra metodología, que proviene del griego μέθοδος y está conformado por tres partes: "meta" que significa "más allá", "hodos" que significa "camino" y el sufijo "-logía" que se refiere a "estudio", nos da a entender inicialmente que método es el camino del camino, es decir, cómo se logra lo que se quiere lograr y metodología es el análisis realizado sobre el mismo. Evidentemente, el significado de la palabra es más complejo y de acuerdo al diccionario puede indicar un conjunto de métodos que se siguen en una investigación científica o doctrinal @asaleDiccionarioLenguaEspanola, siendo ésta una definición influenciada por la epistemología y su carácter investigativo para generar nuevo conocimiento, sin reflejar necesariamente y de forma directa su uso en un proyecto de ingeniería.

#figure(
  diagram(
    spacing: (8mm, 10mm),
    node-stroke: luma(80%),
    node((2, -1), [*Políticas*], name: <p>),
    node((2, 0), [*Decisiones*], name: <dec>),
    node((4, 0), [*Control\ de calidad\ y costos*], name: <con>),
    node((0, 1), [*Investigación\ Científica*], name: <ic>),
    node((1, 1), [*Investigación\ Tecnológica*], name: <it>),
    node((2, 1), [*Desarrollo*], name: <dev>),
    node((3, 1), [*Producción\ o Práctica*], name: <pra>),
    node((4, 1), [*Productos*], name: <pro>),

    edge(<p>, "->", <dec>),
    edge(<dec>, "->", <con>),
    edge(<dec>, "l,d", "->"),
    edge(<dec>, "d", "->"),
    edge(<con>, "d", "->"),
    edge(<ic>, "r", "<->"),
    edge(<ic>, "d,r,r,r,r,u", "<->"),
    edge(<it>, "->", <dev>),
    edge(<dev>, "->", <pra>),
    edge(<pra>, "->", <pro>),
  ),
  caption: [Diagrama de flujo del proceso tecnológico\ Elaboración propia a partir de Epistemología de Mario Bunge@bungeEpistemologiaCursoActualizacion2002],
  placement: auto,
)<fig:bungflow>

Ahora bien, si analizamos cómo estructura Bunge@bungeEpistemologiaCursoActualizacion2002 el proceso tecnológico en la @fig:bungflow y prestamos atención a las actividades de investigación podemos vislumbrar que existen similitudes importantes entre un proyecto, particularmente uno de desarrollo de software, y una investigación tecnológica que no sólo tiene como meta la verdad que sea útil a alguien sino que además cuenta con un ciclo de seis etapas que, para facilitar la visualización de similitudes, a continuación se agrupan de acuerdo al proceso del software de Sommerville@sommervilleSoftwareEngineering2016[p.~44]:

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

Si bien esto nos brinda cierta flexibilidad en el uso del término metodología, conviene buscar definiciones adicionales o alternativas que le den a los proyectos un papel más protagónico, como la que se presenta en la guía del cuerpo de conocimiento sobre gestión de proyectos, que indica que una metodología es un sistema de prácticas, técnicas, procedimientos y reglas usado por aquellos que trabajan en una disciplina@projectmanagementinstituteStandardProjectManagement2021[p.~69]. Esta definición es consistente con la acepción técnica del término en la literatura anglosajona y es la que se tomará principalmente en el desarrollo de este proyecto.

Cabe señalar que, contar con una metodología en gestión de proyectos no es sólo un paso más a seguir, y es que a menudo ayuda a lograr los objetivos del proyecto@nicholasProjectManagementEngineering2021[p.~9-10] porque atiende las siguientes actividades relevantes:

+ Identificar las tareas a realizar en un proyecto
+ Identificar los recursos necesarios
+ Establecer prioridades
+ Crear cronogramas
+ Controlar y monitorear la calidad de los artefactos producidos y su rendimiento
+ Medir el rendimiento del proyecto

Entendido esto, se considera importante que estas metodologías consideren las características particulares de cada proyecto en términos de tamaño, duración y complejidad, y que evolucionen con el mismo, logrando una serie de elementos diseñados a medida@projectmanagementinstituteStandardProjectManagement2021[p.~197-199], como los siguientes:

- Ciclo de vida del proyecto
- Enfoque de desarrollo
- Procesos
- Herramientas
- Participación y roles de los distintos actores
- Métodos
- Artefactos

Evidentemente, existen ya diversos marcos de trabajo o metodologías que prescriben muchos de los elementos anteriores. En trabajos de ingeniería, por ejemplo, es común hallar metodologías de tipo cascada o waterfall, donde el desarrollo del proyecto se realiza en pasos secuenciales claramente definidos. Sin embargo, dependiendo de la naturaleza e incertidumbre asociada al proyecto, también existen otros enfoques.

Un área que convive bastante con la incertidumbre es la ingeniería de software, donde se encuentran enfoques metodológicos que entienden un proceso no necesariamente lineal, sino también iterativo o evolutivo, como aquellos guiadas por filosofías ágiles o marcos de trabajo algo más específicos como el de #acr("UP") o #acr("RUP"). Sin embargo, estos enfoques no necesariamente representan metodologías completas para un proyecto de software y sus autores a menudo recomiendan su adaptación y uso únicamente como referencia para definir la metodología propia de cada trabajo.

A continuación se listan algunos de estos enfoques metodológicos o marcos de trabajo que presentan relevancia en la metodología adoptada en este proyecto.

==== Proceso Unificado

El Proceso Unificado, popularizado por Rational Software por documentarlo de forma detallada y desarrollarlo en lo que hoy conocemos como #acr("RUP"), es un proceso de ingeniería de software@RUPIBMRational que de forma prescriptiva define distintos principios, reglas, procesos, enfoques, ciclos, actividades y artefactos que constituyen en la práctica una metodología de desarrollo de software muy usada en la industria por seguir las buenas prácticas acumuladas durante los primeros años de la disciplina y proponer un ciclo de vida iterativo e incremental que se adapta mejor al desarrollo de software que uno lineal como el de la metodología waterfall.




===== Fases
===== Disciplinas
===== Roles
==== SCRUM
==== Kanban

=== Tecnologías de Desarrollo de Software
==== Lenguajes de Programación
==== Librerías y Frameworks
==== Bases de Datos
==== OAuth

=== Herramientas de Desarrollo de Software
==== Entornos de Desarrollo Integrados (IDEs)
==== Sistemas de Control de Versiones
==== Plataformas de Colaboración
==== Herramientas de Automatización
==== Clientes de API

=== Modelos Grandes de Lenguaje (LLMs)
==== Definición y Características
==== Aplicaciones y Usos
==== Desafíos y Limitaciones
==== Ética y Consideraciones Sociales

=== Sistemas de Gestión de Flujos de Trabajo
==== Definición y Funcionalidades
==== Beneficios y Desafíos

=== Ingeniería de Software
==== Modelos de Proceso Prescriptivos
===== Proceso Unificado

El proceso unificado, también conocido como UP y adaptado por Rational Sofware#footnote[Por este motivo se le conoce comúnmente como RUP (Rational Unified Process)], es un marco de trabajo para el desarrollo de software que se basa en la iteración y la gestión de riesgos.

A su vez, es un proceso de ingeniería de software que se compone de cuatro fases principales: Inicio (Inception), Elaboración, Construcción y Transición. Cada fase prioriza actividades específicas del desarrollo, como la definición de requisitos, el diseño del sistema, la implementación y las pruebas.




=== Arquitectura de Software
==== Patrones de Arquitectura
===== Patrón Repositorio
==== Estilos de Arquitectura

=== Modelado de Procesos
==== BPMN (Business Process Model and Notation)
==== UML (Unified Modeling Language)

=== Software Libre
