= Planteamiento del Problema

El desarrollo de trámites en sistemas gubernamentales enfrenta desafíos significativos debido a la falta de herramientas reutilizables y estándares modulares.

La ubicuidad del trámite en distintos espacios del estado y la cantidad de los mismos implican el desarrollo de características o funcionalidades similares en muchos proyectos de software de la administración pública. 

Si bien existen varios productos de gestión de flujos de trabajo (WFMS), como se vio en el apartado de situación actual, debe tomarse en cuenta que estos no son reutilizables en sistemas independientes, suelen ser de código cerrado y propietario, están estrechamente relacionados con otros productos comerciales (Como ERPs) y no son específicos a los trámites.

// TODO: Bolivia tiene normativa y lineamientos específicos para la gestión de trámites, que deben ser considerados

// TODO: Una ventanilla única no se integra de manera consistente con las distintas necesidades de las oficinas de gobierno.

Además, dada la conexión de los trámites con el modelo del negocio de las distintas instituciones, se requiere la capacidad de integrar estas funcionalidades en algún tipo de módulo o servicio que sea aprovechable y que además permita la interoperabilidad.

La falta de un elemento reutilizable para el manejo de estos procesos administrativos, dificulta la adopción del trámite digital, manteniendo los problemas del trámite tradicional como los que se listan a continuación:

- Corrupción en la administración pública
- Distancias recorridas para la realización de trámites
- Tiempos de ejecución del trámite elevados
- Costos para el ciudadano en la realización del trámite
- Susceptibilidad a errores humanos
- Baja eficiencia en el uso de los recursos
- Uso de papel y otros recursos físicos
- Falta de trazabilidad y seguimiento del trámite
- Falta de transparencia en la gestión del trámite
- Falta de información sobre los requisitos del trámite

También conlleva a muchas desventajas directas: //TODO: Añadir las ventajas del software reutilizable de Sommerville 

- Violación del principio DRY (Don't Repeat Yourself) o, como se conoce en términos coloquiales, reinvención de la rueda.
- Baja atención al detalle sobre el módulo de trámite, ofuscado en medio de sistemas más grandes, a pesar de su importancia.
- Tiempos de desarrollo mayores. Esto para el aparato estatal es impensable, ya que la mayoría de sus licitaciones piden desarrollos en tiempo récord y ante la falta de módulos reutilizables, los proyectos corren peligro de fracasar por cumplimiento de plazos.
- Costos elevados de desarrollo.
- Dificultad innecesaria en proyectos pequeños. La funcionalidad del trámite debería ser básica y aplicable fácilmente en proyectos pequeños, pero al no existir herramientas, la gestión de trámites puede terminar implicando un proyecto de mayor envergadura.
- Fricción en la digitalización de trámites. La dificultad de hacer buen software y el costo del mismo pueden complicar su adopción.
- Mayor susceptibilidad a desarrollos fallidos. Se sabe que en distintos países los desarrollos de software para instancias gubernamentales acaban en fracaso, entre otros motivos, por falta de entendimiento en la entidad pública que tiene problemas comunicando sus necesidades y ausencia de modelado de procesos comunes.
- Falta de características esenciales. Al no prestarle atención específica a un módulo de software muchas veces se ignoran funcionalidades que podrían beneficiar a los usuarios, como por ejemplo, en este caso, métodos digitales de validación de documentos usando inteligencia artificial.
- Falta de modularidad y violación del principio SRP (Single Responsibility Principle), primer componente del principio SOLID.
- Dificultad en el mantenimiento del software. Al tener la funcionalidad del trámite estrechamente relacionada con el resto del sistema, el mantenimiento se dificulta.
- Mala documentación. El código no modularizado raras veces cuenta con buena documentación que pueda facilitar el futuro mantenimiento del software. A menudo, por ejemplo, las librerías de software cuentan con documentación útil que implica fácil adopción de tecnologías por una mayor cantidad de desarrolladores.

== Abordaje al Problema

Estas desventajas se pueden atacar implementando un módulo que, buscando cumplir con normativa boliviana y atendiendo a la necesidad de la sociedad, sea de tipo FOSS. Dicho módulo enfrentaría funcionalidades comunes a los distintos procesos de trámite, considerando su definición, ejecución, registro, y control, permitiendo en general su correcta gestión y seguimiento.

== Desafíos

Sin embargo, la realización de módulos de software acarrea varios desafíos, entre ellos académicos. A continuación se listan algunos:

- Modelado del trámite: Al querer atacar en específico estos procesos administrativos, se deben inicialmente modelar, partiendo de las características comunes a cada trámite, usando herramientas disponibles como las redes de Petri, las máquinas de estado finitas, diagramas de actividad UML, entre otras. Esto implica la exploración y estudio de dichas herramientas de modelado.
- Elección de tipo de módulo: Se debe realizar un análisis para decidir la manera en la que se facilitará el módulo a los usuarios del mismo y contemplar el alcance del mismo, de acuerdo a un análisis de arquitectura de software.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un módulo FOSS existen ciertas particularidades, ya que éste será utilizado por muchos otros proyectos que confiarán en el mismo y puede enriquecerse de participaciones futuras de la comunidad.
- Arquitectura de Software: Este es un tema poco estudiado durante el transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto, debido a que es crucial para la elaboración de un producto de software robusto y de calidad.
- Documentación: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia. Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla.
- Know-how FOSS: Se cuenta con muy poco conocimiento del desarrollo de software libre en el contexto local y mucho menos de sistemas con éxito. Se debe documentar bien el proceso para inspirar proyectos futuros en la región.
- Control de versiones: Cualquier proyecto de software moderno requiere el uso de sistemas de versionado, pero en un proyecto de código abierto esto es especialmente importante para permitir colaboraciones externas y evolución constante.
- Buenas prácticas de desarrollo y uso de patrones de diseño: Para tener una buena implementación existen recomendaciones y patrones que pueden ser empleados, además de experiencias compartidas en internet por distintos desarrolladores. Las mismas pueden potenciar un proyecto y son importantes de estudiar.
- Interoperabilidad: Se debe pensar en cómo interactuará el módulo con los sistemas que lo empleen, lo cual no necesariamente es trivial y requiere el estudio de estándares como ser REST, JWT y OpenAPI.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su diseño y que no hagan algo distinto @myersArtSoftwareTesting2012. Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.
- Escalabilidad y Robustez: Una pieza de software reutilizable debe garantizar robustez y posibilidad de escalar a los usuarios de la misma. Las estrategias para enfrentar dichos requerimientos demandan un estudio y análisis adicional, probablemente, el uso de microservicios.
- Flexibilidad: Es difícil poder predecir que un sistema contemple todos los posibles casos de uso existentes alrededor del trámite. Por esto mismo el desarrollo debe estar orientado a la flexibilidad, a que los usuarios del código puedan modificarlo a sus necesidades.
- Los sistemas que no piensan en el usuario no son útiles: La carrera de Ingeniería Electrónica en su mención de sistemas contempla aspectos más cercanos al "bajo nivel" de las computadoras. Si bien este proyecto contempla temas de modelado de sistemas, infraestructura, arquitectura e ingeniería de software, también requiere la consideración de factores muy lejanos a la materia, como la experiencia de usuario y, probablemente, las interfaces de usuario.
- Infraestructura y despliegue: La realización de pruebas del módulo requiere que se aprendan técnicas de despliegue de aplicaciones, como administración de VPSs o manejo de contenedores. Además, esto se debe documentar para que los usuarios sepan cómo hacer el despliegue y la instalación correspondiente.