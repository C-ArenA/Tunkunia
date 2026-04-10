#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/acrostiche:0.7.0": acr

= Solución Propuesta

#figure(
  image("/assets/tunkunia_dist.excalidraw.png", width: 100%),
  caption: [Método de distribución y uso del subsistema Tunkunia\ Fuente: Elaboración propia],
  placement: auto
)<fig:tunkunia_dist>

En función de lo establecido en secciones anteriores, principalmente en la presentación de la problemática, se observó que las distintas instituciones públicas o instancias del estado que desean digitalizar sus trámites, realizan implementaciones propias desde cero (tanto por cuenta propia, como mediante el lanzamiento de licitaciones públicas), cada una por su lado, de forma independiente, sin seguir los mismos lineamientos y estándares ni responder de forma estricta a la normativa boliviana. Además, existe una necesidad de enfrentar la digitalización de los trámites en tiempos cortos y con bajos presupuestos. Por ello, en el presente proyecto proponemos la creación de un subsistema reutilizable de software libre que contemple la funcionalidad común a cualquier trámite y responda a los lineamientos del gobierno boliviano. Este artefacto o paquete, como puede apreciarse en la @fig:tunkunia_dist, estará publicado en un repositorio de código y opcionalmente en un gestor de paquetes desde el cual podrá ser distribuido según requerimiento a las distintas instituciones del estado o entidades privadas que brinden sus servicios a las mismas, facilitando la implementación de procesos o flujos de trámite específicos mediante simple configuración y/o adaptación del código de acuerdo a un marco de trabajo.

El subsistema tendrá funcionalidad out-of-the-box simplificada para usuarios finales sin conocimiento de programación, pero además marcará una serie de lineamientos para usuarios avanzados que deseen adaptar el software a casos de trámite particulares. Por lo tanto, se podría considerar que este subsistema es a su vez un marco de trabajo de desarrollo, pero especializado en el manejo de trámites. Al ser principalmente un subsistema, el mismo contará con ciertas integraciones como la de Ciudadanía Digital, pero además ofrecerá interfaces REST API para facilitar la interoperabilidad e integración con otros subsistemas que formen parte del mismo sistema. 

#figure(
  image("/assets/framework2subsystem.png", width: 80%),
  caption: [Construcción a partir de un framework de desarrollo\ Fuente: Elaboración propia],
  placement: auto
)<fig:framework2subsystem>

Para lograr esta implementación se partirá de un framework de desarrollo web genérico, para lograr, mediante la adición de características, el framework especializado en trámites deseado (@fig:framework2subsystem). Tener un punto de partida utilizando una herramienta conocida permitirá una flexibilidad mayor por parte de quien use el subsistema, pudiendo incluso integrar características ajenas al trámite en la misma base de código, aunque eso no se contempla en este proyecto.

#figure(
  diagram(
    spacing: (18mm, 10mm),
    node-stroke: luma(80%),
    node((1.5, 0), [*Tunkunia*\ Trámites], name: <t>),
    node((0, 1), [*Definición*], name: <d>),
    node((1, 1), [*Ejecución*], name: <e>),
    node((2, 1), [*Registro*], name: <r>),
    node((3, 1), [*Control*], name: <c>),
    node((2.5, 2), [*Seguimiento*], name: <s>),
    node((3.5, 2), [*Reporte*], name: <re>),

    edge(<t>, <d>),
    edge(<t>, <e>),
    edge(<t>, <r>),
    edge(<t>, <c>),
    edge(<c>, <s>),
    edge(<c>, <re>),
  ),
  caption: [Funciones a grandes rasgos de Tunkunia],
  placement: auto,
)<fig:modfun>

Si bien la funcionalidad esperada del subsistema se detalla en la sección de alcances, podemos considerar que, tomando como inspiración lo señalado en la @section:wfms acerca de los #acr("WFMS"), la funcionalidad de este subsistema contemplará a grandes rasgos y de forma general lo señalado en la @fig:modfun. Es decir, la gestión de los flujos de trámite, desde la creación de estos procedimientos, pasando por su ejecución (trámites individuales), hasta el control de los mismos.

Las funciones anteriores obligarán a contemplar distintos tipos de roles de usuario, los cuales también serán implementados. Si bien se pretende brindar facilidades de manejos de rol al administrador del sistema, se propone inicialmente la creación de tres grandes categorías: administradores, verificadores y ciudadanos, donde los administradores se harán cargo de la gestión general de los flujos de trámite, mientras que los verificadores serán empleados públicos dedicados a la revisión de documentos y los ciudadanos serán los ejecutores de cada trámite.


Es fundamental para el éxito de este proyecto, como se sugiere en uno de los objetivos específicos, conseguir un modelado general de los aspectos comunes del proceso del trámite. Para lograr esto se emplearan técnicas y lenguajes de modelado de procesos como los listados en la @section:modeling. Incluso antes de comenzar con la implementación del proyecto, se pueden identificar ciertos patrones comunes en los trámites, como el manejo de documentos con cambios de estado, la verificación y aceptación de datos, etc. Esto podría, por ejemplo, modelarse con máquinas de estados como se muestra en la @fig:stateex. Afortunadamente, como se vio en la @fig:petricomplaints, donde se muestra una Red de Petri, también existen ejemplos de modelado de procesos que, si bien no son generalizaciones del trámite, son un buen punto de partida.

#figure(
  image("/assets/stateprocedureexample.png", width: 60%),
  caption: [Modelado simplificado del proceso de trámite\ Fuente: Elaboración propia],
  placement: bottom,
)<fig:stateex>

El modelado señalado se formulará principalmente alrededor de los distintos trámites establecidos o sugeridos por el #acr("RASIM"), debido a la experiencia existente en los mismos (Ver antecedentes). Sin embargo, para lograr cubrir una mayor cantidad de características comunes no se descarta el uso de otros casos de trámites para la consolidación del modelo general del trámite.

#figure(
  image("/assets/modulegraph.png"),
  caption: [Representación gráfica, a grandes rasgos, del módulo Tunkunia\ Fuente: Elaboración propia],
  placement: auto,
)<fig:modulegraph>

El subsistema que implementará el modelado realizado será principalmente monolítico, aunque con un claro enfoque modular y fuertemente inspirado por la arquitectura Model View Controller (MVC). La @fig:modulegraph muestra una aproximación de la estructura final del producto de este proyecto. Se puede observar que se consideran los distintos tipos de usuario, que además se busca separar, en correspondencia con la @fig:wfms_history, el núcleo de manejo de procesos de trámite en su propio módulo, y que se planea no sólo garantizar la interoperabilidad, sino además facilitar la integración out-of-the-box con Ciudadanía Digital. También se muestran ejemplos potenciales de integración con LLMs y otros subsistemas.

== Transición de lo presencial a lo digital

Es importante considerar que los trámites digitales, si bien tienen muchas ventajas, no son accesibles a todo el público, como pudo verse en la @section:adoption. Para no correr el riesgo de dejar de lado a cierta parte de la población, la solución propuesta tiene un enfoque claro: Tunkunia deberá poder funcionar con asistencia de funcionarios públicos. Es decir, el ciudadano sin acceso a internet aún podrá hacer sus trámites con ayuda en forma presencial. Este tipo de aplicación del sistema, si bien depende exclusivamente de quien lo emplee, se deberá tomar en cuenta a la hora de implementar la solución planteada.

