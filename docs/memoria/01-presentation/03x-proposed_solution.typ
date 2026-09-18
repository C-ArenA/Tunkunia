#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, mmd-fig, typ-fig

=== Abordaje a la Solución

//Estas desventajas podrían ser atacadas implementando un módulo, componte o subsistema reutilizable que atienda las características comunes entre distintos sistemas de gestión de trámites, buscando cumplir con normativa boliviana, siendo de tipo FOSS, con capacidad de integración de funcionalidades, interoperabilidad y considerando la definición, ejecución, registro, y control de dichos procesos administrativos.


#img-fig(
  "/assets/figures/tunkunia_dist.excalidraw.png",
  [Modelo del negocio con reutilización de software],
  <fig:tunkunia_dist>,
  width: 80%,
)

En función de lo establecido en secciones anteriores, principalmente en la presentación de la problemática, se propuso inicialmente, como una posible solución, misma que se desarrolla más adelante en este documento, la creación de un sistema *reutilizable*#footnote[Existen muchos tipos de sistemas reutilizables, Sommerville@sommervilleSoftwareEngineering2016 hace un listado de los mismos. En este proyecto se entiende reutilizable como un sistema o aplicación configurable, de acuerdo al texto mencionado.] para la *gestión de trámites*, entendidos como *flujos de trabajo*, que permita su uso de forma descentralizada por parte de distintas entidades públicas (@fig:tunkunia_dist), pero compartiendo la misma base de software que aglutine no sólo funcionalidades comunes a los trámites, sino que además contemple la normativa nacional y los lineamientos más relevantes sobre gobierno electrónico en Bolivia.

#img-fig(
  "/assets/figures/modulegraph.png",
  [Arquitectura Inicial y Entorno de Tunkunia],
  <fig:modulegraph>,
)

Al ser un elemento especializado en trámites, esta pieza de software reutilizable vivirá en un entorno institucional donde podría interactuar con otros sistemas de ser necesario (Por ejemplo, con un sistema de gestión documental). Esto hace conveniente que al mismo se entienda como un *subsistema*. Una visión general de su arquitectura, reflejando aquello, puede verse en la @fig:modulegraph, muy inspirada en la @fig:wfms_history.

// TODO: Se va a alcances
//Es importante considerar que los trámites digitales, si bien tienen muchas ventajas, no son accesibles a todo el público, como pudo verse en la @section:adoption. Para no correr el riesgo de dejar de lado a cierta parte de la población, la solución propuesta tiene un enfoque claro: Tunkunia deberá poder funcionar con asistencia de funcionarios públicos. Es decir, el ciudadano sin acceso a internet aún podrá hacer sus trámites con ayuda en forma presencial. Este tipo de aplicación del sistema, si bien depende exclusivamente de quien lo emplee, se deberá tomar en cuenta a la hora de implementar la solución planteada.

==== Desafíos

Sin embargo, la realización de elementos reutilizables de software acarrea varios desafíos técnicos y académicos, particularmente en el contexto de los trámites gubernamentales.
A continuación se listan algunos de estos:

- Modelado general del trámite: Al querer atacar en específico estos procesos administrativos, pero deseando atenderlos de forma general, se deben inicialmente modelar, partiendo de las características comunes a cada trámite, usando herramientas disponibles como las redes de Petri, las máquinas de estado finitas, diagramas de actividad UML, entre otras.
  Esto implica la exploración y estudio de dichas herramientas formales de modelado, además de un conocimiento profundo de la normativa alrededor de los trámites.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un módulo FOSS existen ciertas particularidades, ya que este será utilizado por muchos otros proyectos que confiarán en el mismo y puede enriquecerse de participaciones futuras de una posible comunidad.
- Arquitectura de Software: Este es un tema poco estudiado durante el transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto, debido a que es crucial para la elaboración de un producto de software robusto y de calidad, que use patrones de diseño y emplee las mejores prácticas en conjunto con una correcta ingeniería de software.
- Documentación y Mantenimiento: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia.
  Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla.
  Además, esto debe facilitar el mantenimiento del software por terceros, tanto usuarios como contribuidores externos.
- Control de versiones y colaboración: Cualquier proyecto de software moderno requiere el uso de sistemas de versionado, pero en un proyecto de código abierto esto es especialmente importante para permitir colaboraciones externas y evolución constante.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su diseño y que no hagan algo distinto @myersArtSoftwareTesting2012.
  Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.
