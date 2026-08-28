=== Planteamiento del Problema<section:problem_statement>

La @section:related_work muestra que numerosas instituciones digitalizan sus trámites mediante sistemas desarrollados de manera independiente. Aunque los procedimientos atendidos pertenecen a dominios diferentes, estas implementaciones repiten capacidades relacionadas con la definición del trámite, la participación de distintos actores, la ejecución de acciones, el registro de información y el seguimiento de cada caso.

Los productos genéricos de gestión de flujos de trabajo pueden atender parte de esta necesidad, pero no siempre se especializan en trámites, se distribuyen como software libre ni se ajustan directamente al contexto institucional y normativo boliviano. Al mismo tiempo, las particularidades del modelo de negocio de cada institución dificultan sustituir todas las implementaciones por una única solución centralizada.

La normativa y los planes bolivianos de gobierno electrónico introducen lineamientos comunes sobre software libre, interoperabilidad, identidad digital, simplificación, transparencia y control ciudadano. En consecuencia, distintas instituciones deben resolver tanto requisitos recurrentes como necesidades particulares al digitalizar sus procedimientos.

El problema central del proyecto es, por tanto, la *repetición de funcionalidades y esfuerzos entre sistemas de gestión de trámites*, asociada a la falta de un modelo común y de una herramienta reutilizable especializada que pueda adaptarse a distintas instituciones públicas.

Esta carencia no es la causa única de las dificultades del trámite tradicional, pero incrementa la fricción técnica y económica para su digitalización. En consecuencia, puede contribuir a que persistan problemas como:

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

Desde la perspectiva de la ingeniería de software, no aprovechar la reutilización produce además desventajas directas @sommervilleSoftwareEngineering2016[pág. 439]:

- Violación del principio DRY (Don't Repeat Yourself) o, como se conoce en términos coloquiales, reinvención de la rueda.
- Menor atención a las capacidades propias del trámite cuando quedan diluidas dentro de sistemas institucionales más grandes.
- Tiempos de desarrollo mayores.
  Este aspecto resulta especialmente relevante cuando la creación o modificación de un trámite responde a cambios normativos y debe atenderse en plazos reducidos.
- Costos y productividad.
  En general, a pesar de no ser siempre el caso, la reutilización de software conlleva a un aumento en la productividad y una consecuente reducción de costos.
  De no aplicar esta filosofía, se enfrentan costos elevados, mucho más si los sistemas de gestión de trámites se implementan múltiples veces en distintas instancias públicas.
- Fricción en la digitalización de trámites.
  La dificultad de hacer buen software y el costo del mismo pueden complicar su adopción.
- Mayor susceptibilidad a desarrollos fallidos.
  La ausencia de un modelo de procesos compartido puede dificultar la comunicación de necesidades y aumentar el riesgo de interpretaciones inconsistentes.
- Falta de características y estandarización.
  La implementación separada dificulta compartir lineamientos y capacidades comunes, aunque cada institución conserve las particularidades de sus procedimientos.
- Dificultad en el mantenimiento del software.
  Los esfuerzos de mantenimiento de cada sistema de gestión de trámites implementado en las distintas instancias públicas se distribuyen entre estas, cuando podrían centralizarse en un solo componente reutilizable.
  Además, futuras actualizaciones suelen depender de la persona o entidad que desarrolló el sistema en un principio, presentando el riesgo de acabar con un sistema obsoleto.
- Duplicación de esfuerzos de documentación, pruebas y mantenimiento para capacidades semejantes.


==== Abordaje al Problema

Estas desventajas pueden abordarse mediante un subsistema reutilizable de software libre que formalice los aspectos comunes del trámite y concentre su definición, ejecución, registro y control. De este modo, las instituciones pueden descentralizar la implementación de sus necesidades particulares y, al mismo tiempo, compartir un modelo, lineamientos y capacidades comunes.

==== Desafíos

Sin embargo, la realización de elementos reutilizables de software acarrea varios desafíos técnicos y académicos, particularmente en el contexto de los trámites gubernamentales.
A continuación se listan algunos de estos:

- Modelado general del trámite: Al querer atacar en específico estos procesos administrativos, pero deseando atenderlos de forma general, se deben inicialmente modelar, partiendo de las características comunes a cada trámite, usando herramientas disponibles como las redes de Petri, las máquinas de estado finitas, diagramas de actividad UML, entre otras.
  Esto implica la exploración y estudio de dichas herramientas formales de modelado, además de un conocimiento profundo de la normativa alrededor de los trámites.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un subsistema FOSS existen particularidades relacionadas con su reutilización, mantenimiento y posible evolución colaborativa.
- Arquitectura de Software: Este es un tema poco estudiado durante el transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto, debido a que es crucial para la elaboración de un producto de software robusto y de calidad, que use patrones de diseño y emplee las mejores prácticas en conjunto con una correcta ingeniería de software.
- Documentación y Mantenimiento: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia.
  Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla.
  Además, esto debe facilitar el mantenimiento del software por terceros, tanto usuarios como contribuidores externos.
- Control de versiones y colaboración: Cualquier proyecto de software moderno requiere el uso de sistemas de versionado, pero en un proyecto de código abierto esto es especialmente importante para permitir colaboraciones externas y evolución constante.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su diseño y que no hagan algo distinto @myersArtSoftwareTesting2012.
  Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.
