= Planteamiento del Problema

La ubicuidad del trámite en distintos espacios gubernamentales y la cantidad de los mismos implican el desarrollo de características o funcionalidades similares en muchos sistemas de la administración pública. 

Además, dada la conexión de dichos trámites con el modelo del negocio de las distintas instituciones, se requiere la capacidad de integrar estas funcionalidades en algún tipo de módulo o servicio que sea aprovechable y permita la interoperabilidad.

La modernización de los gobiernos, sustentada por la normativa descrita en @section:current_situation implica un mayor uso de recursos y la reescritura de funcionalidades idénticas afecta de muchos modos a la eficiencia de los proyectos.

Todo esto conlleva a muchas desventajas directas e indirectas (que tienen que ver con la no digitalización correcta de los trámites):

- Reinvención de la rueda, como se conoce en términos coloquiales, o violación del principio DRY (Don't Repeat Yourself)
- Baja atención al detalle sobre el módulo de trámite, ofuscado en medio de sistemas más grandes, a pesar de su importancia.
- Tiempos de desarrollo mayores. Esto para el aparato estatal es impensables, ya que la mayoría de sus licitaciones piden desarrollos en tiempo record y ante la falta de módulos reutilizables, los proyectos corren peligro de fracasar por cumplir plazos.
- Costos elevados. El costo de la hora de trabajo del desarrollador de software, a pesar de haber dejado de subir en el mercado, sigue siendo bastante caro.
- Dificultad elevada en proyectos pequeños. La funcionalidad del trámite debería ser básica y aplicable facilmente en proyectos pequeños, pero al no existir herramientas, la gestión de trámites puede terminar agrandando el tamaño de un proyecto.
- Fricción en la digitalización de trámites. La dificultad de hacer buen software y el costo del mismo pueden complicar la adopción del mismo.
- Mayor susceptibilidad a desarrollos fallidos. Se sabe que en distintos países los desarrollos de software para instancias gubernamentales acaban en fracaso, entre otros motivos por falta de entendimiento y modelado de procesos comunes.
- Falta de características esenciales. Al no prestarle atención específica a un módulo de software muchas veces se ignoran funcionalidades que podrían beneficiar a los usuarios.
- Dificultad en el mantenimiento del software. El código no modularizado raras veces cuenta con buena documentación que pueda facilitar el futuro mantenimiento del software. A menudo, por ejemplo, las librerías de software cuentan con documentación útil que implica fácil adopción de tecnologías por una mayor cantidad de desarrolladores.
- Los trámites tradicionales o trámites digitales mal implementados conllevan a los mismos problemas de siempre como la corrupción, poca eficiencia y dificultad.

Estas desventajas se pueden atacar implementando un módulo, ya sea en forma de un servicio o de una _software library/package_ que, buscando cumplir con normativa boliviana y atendiendo a la necesidad de la sociedad con un enfoque de comunidad, sea de tipo FOSS. Dicho módulo enfrentaría funcionalidades comunes a los distintos procesos de trámite, considerando su creación, gestión y seguimiento.

Sin embargo, la realización de módulos de software acarrea varios desafíos, entre ellos académicos. A continuación se listan algunos:

- Elección de tipo de módulo: Se debe realizar un análisis para decidir la manera en la que se facilitará el módulo a los usuarios del mismos.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un módulo FOSS existen ciertas particularidades, ya que éste será utilizado por muchos proyectos que confiarán en el mismo y puede enriquecerse de participaciones futuras de la comunidad.
- Arquitectura de Software: Este es un tema poco durante el
transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto.
- Documentación: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia. Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla.
- Know-how FOSS: Se cuenta con muy poco conocimiento del desarrollo de software
libre en el contexto local y mucho menos de sistemas con éxito. Se debe documentar bien el proceso.
- Versionado: Cualquier proyecto de software moderno requiere el uso de sistemas de
versionado, pero en un proyecto de código abierto esto es especialmente importante
para permitir colaboraciones externas.
- Buenas prácticas de desarrollo y uso de patrones de diseño: Para tener una buena implementación existen recomendaciones y patrones que pueden ser empleados, además de
experiencias compartidas en internet por distintos desarrolladores. Las mismas pueden potenciar un proyecto y son importantes de estudiar.
- Interoperabilidad: Se debe pensar en cómo interactuará el módulo con los sistemas que lo empleen.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el
del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su
diseño y que no hagan algo distinto @myersArtSoftwareTesting2012. Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.
- Modelado de procesos. Si bien se parte de la premisa de haber identificado funcionalidad común a cada trámite, modelar dichos aspectos comunes no es una tarea trivial. Se deben usar herramientas de modelado correctas que brinden la información requerida por el módulo en su conjunto.
- Escalabilidad y Robustez: Una pieza de software reutilizable debe garantizar robustez y posibilidad de escalar a los usuarios de la misma. Las estrategias para enfrentar dichos requerimientos demandan un estudio y análisis adicional.
- Flexibilidad: Es difícil poder predecir que un sistema contemple todos los posibles casos de uso existentes alrededor del trámite. Por esto mismo el desarrollo debe estar orientado a la flexibilidad, a que los usuarios del código puedan modificarlo a sus necesidades.
- Los sistemas que no piensan en el usuario no son útiles: La carrera de Ingeniería Electrónica en su mención sistemas contempla aspectos más cercanos al #quote[bajo nivel] de las computadoras. Si bien este proyecto contempla temas de infraestructura, también requiere la consideración de factores muy lejanos a la materia, como la experiencia de usuario y, probablemente, las interfaces de usuario.
- Infraestructura y despliegue: La realización de pruebas del módulo requiere que se aprendan técnicas de despliegue de aplicaciones, como administración de VPSs o manejo de contenedores. Además, esto se debe documentar para que los usuarios sepan cómo hacer el despliegue correspondiente.