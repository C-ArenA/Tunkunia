= Planteamiento del Problema<section:problem_statement>

La @section:related_work hace un repaso por algunos de los trabajos relacionados a la digitalización de trámites, haciendo evidente que existe una cantidad importante de estos procesos que se buscan digitalizar. En su mayoría, estas implementaciones comparten características similares que se estarían replicando y que se seguirán replicando en el futuro para otros trámites aún no digitalizados. Además, como pudo observarse en los antecedentes de este trabajo, la digitalización de trámites en instancias públicas del estado debe responder a los lineamientos marcados por la normativa vigente y los diferentes planes, reglamentos y recomendaciones del gobierno boliviano, aspecto que no se atiende de manera correcta.

Es decir, la ubicuidad del trámite en distintos espacios del estado y la cantidad de los mismos implican el desarrollo de características o funcionalidades similares en muchos proyectos de software de la administración pública y, a pesar de que existen varios productos de gestión de flujos de trabajo que podrían responder a la necesidad de gestionar estos procedimientos administrativos, estos no son reutilizables para su integración en otros sistemas más grandes, suelen ser de código cerrado y propietario o no son específicos a los trámites.

Además, dado que muchas veces los trámites están estrechamente relacionados con el modelo del negocio de las distintas instituciones, se requiere la capacidad de integrar funcionalidades específicas en las implementaciones realizadas, dificultando la adopción de las ventanillas únicas, mismas que, adicionalmente, no se hicieron efectivas a nivel nacional, por lo que las distintas instancias del estado aún deben desarrollar sus propios sistemas de gestión de trámites.

Los planes de implementación derivados de la Ley Nº 164 y otras normativas citadas en la @section:current_situation demandan que todos estos sistemas implementen otras características particulares como la interoperabilidad, la firma digital (u otro tipo de validación de documentos), el ingreso por Ciudadanía Digital, el seguimiento y control ciudadano, entre otras, incrementando así las similitudes entre las distintas implementaciones realizadas.

Por lo tanto, podemos indicar que el desarrollo de sistemas alrededor de los trámites en entornos gubernamentales enfrenta desafíos significativos debido a la falta de herramientas reutilizables especializadas y la falta de un modelo claro de estos procesos administrativos.

Adicionalmente, no se puede ignorar que la falta de un elemento reutilizable para el manejo de estos procesos administrativos, dificulta la adopción del trámite digital por las distintas instancias públicas, derivando en la práctica del trámite tradicional, con sus propios problemas, como los que se listan a continuación:

- Corrupción en la administración pública
- Distancias recorridas para la realización de trámites y múltiples interacciones necesarias
- Tiempos de ejecución del trámite elevados
- Costos para el ciudadano en la realización del trámite
- Susceptibilidad a errores humanos
- Baja eficiencia en el uso de los recursos
- Uso de papel y otros recursos físicos
- Falta de trazabilidad y seguimiento del trámite
- Falta de transparencia en la gestión del trámite
- Falta de información sobre los requisitos del trámite

También conlleva a muchas desventajas directas, principalmente las que nacen de no aprovechar los beneficios del software reutilizable @sommervilleSoftwareEngineering2016[pág. 439], que son:

- Violación del principio DRY (Don't Repeat Yourself) o, como se conoce en términos coloquiales, reinvención de la rueda.
- Baja atención al detalle sobre el módulo de trámite, ofuscado en medio del desarrollo de sistemas más grandes, a pesar de su importancia.
- Tiempos de desarrollo mayores. Esto para el aparato estatal es un problema, ya que la mayoría de sus licitaciones piden desarrollos en tiempo récord y ante la falta de módulos reutilizables, los proyectos corren peligro de fracasar por no cumplimiento de plazos.
- Costos y productividad. En general, a pesar de no ser siempre el caso, la reutilización de software conlleva a un aumento en la productividad y una consecuente reducción de costos. De no aplicar esta filosofía, se enfrentan costos elevados, mucho más si los sistemas de gestión de trámites se implementan múltiples veces en distintas instancias públicas.
- Fricción en la digitalización de trámites. La dificultad de hacer buen software y el costo del mismo pueden complicar su adopción.
- Mayor susceptibilidad a desarrollos fallidos. Se sabe que en distintos países los desarrollos de software para instancias gubernamentales acaban en fracaso, entre otros motivos, por falta de entendimiento en la entidad pública que tiene problemas comunicando sus necesidades y *ausencia de modelado de procesos comunes*.
- Falta de características y estandarización. Al no prestarle atención específica a un módulo de software muchas veces se ignoran funcionalidades que podrían beneficiar a los usuarios, que son requeridas por la normativa nacional, o que presentan algún tipo de innovación. Además, dificulta o no ayuda a identificar la estandarización de los sistemas de gestión de trámites, a pesar de las similitudes que existen entre estos.
- Dificultad en el mantenimiento del software. Los esfuerzos de mantenimiento de cada sistema de gestión de trámites implementado en las distintas instancias públicas se distribuyen entre estas, cuando podrían centralizarse en un solo componente reutilizable. Además, futuras actualizaciones suelen depender de la persona o entidad que desarrolló el sistema en un principio, presentando el riesgo de acabar con un sistema obsoleto.
- Mala documentación. El código no reutilizado raras veces cuenta con buena documentación que pueda facilitar el futuro mantenimiento del software. A menudo, por ejemplo, las librerías de software cuentan con documentación útil que implica fácil adopción de tecnologías por una mayor cantidad de desarrolladores. Esto se debe a que se continúan sacando nuevas versiones de dichas librerías en un proceso de mejora constante.


== Abordaje al Problema

Estas desventajas podrían ser atacadas implementando un módulo, componte o subsistema reutilizable que atienda las características comunes entre distintos sistemas de gestión de trámites, buscando cumplir con normativa boliviana, siendo de tipo FOSS, con capacidad de integración de funcionalidades, interoperabilidad y considerando la definición, ejecución, registro, y control de dichos procesos administrativos.

== Desafíos

Sin embargo, la realización de elementos reutilizables de software acarrea varios desafíos técnicos y académicos, particularmente en el contexto de los trámites gubernamentales. A continuación se listan algunos de estos:

- Modelado general del trámite: Al querer atacar en específico estos procesos administrativos, pero deseando atenderlos de forma general, se deben inicialmente modelar, partiendo de las características comunes a cada trámite, usando herramientas disponibles como las redes de Petri, las máquinas de estado finitas, diagramas de actividad UML, entre otras. Esto implica la exploración y estudio de dichas herramientas formales de modelado, además de un conocimiento profundo de la normativa alrededor de los trámites.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un módulo FOSS existen ciertas particularidades, ya que este será utilizado por muchos otros proyectos que confiarán en el mismo y puede enriquecerse de participaciones futuras de una posible comunidad.
- Arquitectura de Software: Este es un tema poco estudiado durante el transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto, debido a que es crucial para la elaboración de un producto de software robusto y de calidad, que use patrones de diseño y emplee las mejores prácticas en conjunto con una correcta ingeniería de software.
- Documentación y Mantenimiento: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia. Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla. Además, esto debe facilitar el mantenimiento del software por terceros, tanto usuarios como contribuidores externos.
- Control de versiones y colaboración: Cualquier proyecto de software moderno requiere el uso de sistemas de versionado, pero en un proyecto de código abierto esto es especialmente importante para permitir colaboraciones externas y evolución constante.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su diseño y que no hagan algo distinto @myersArtSoftwareTesting2012. Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.