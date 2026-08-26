== Planteamiento del Problema<section:problem_statement>

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


=== Abordaje al Problema

Estas desventajas pueden abordarse mediante un subsistema reutilizable de software libre que formalice los aspectos comunes del trámite y concentre su definición, ejecución, registro y control. De este modo, las instituciones pueden descentralizar la implementación de sus necesidades particulares y, al mismo tiempo, compartir un modelo, lineamientos y capacidades comunes.

=== Desafíos

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

== Objetivo

#quote()[
  #par()[*Implementar*, como prototipo funcional, un *subsistema reutilizable de software libre* especializado en la gestión de flujos de *trámite* que, mediante el uso de técnicas de modelado de sistemas y procesos, represente e implemente los aspectos *comunes* del trámite y pueda ser adoptado por *distintas instituciones públicas* del estado *boliviano* mediante configuración y siguiendo los lineamientos establecidos por la normativa nacional sobre gobierno electrónico.]
]

Para alcanzar este objetivo se plantean los siguientes objetivos específicos:

- *Elegir un modelo formal de los aspectos comunes del trámite gubernamental*, a partir del análisis de casos representativos y mediante técnicas de modelado de procesos, con énfasis en identificar estructuras y acciones recurrentes.
- *Identificar los requerimientos del sistema y del software* derivados del modelo del trámite, de los actores involucrados y de los lineamientos bolivianos priorizados sobre gobierno electrónico y trámites digitales.
- *Diseñar el subsistema reutilizable* de modo que distinga el núcleo de gestión de flujos, las capacidades comunes y las particularidades configurables de cada trámite o institución.
- *Implementar un prototipo funcional* que permita definir flujos, ejecutar casos de trámite, registrar las acciones realizadas y consultar su estado e historial.
- *Validar el modelo y el prototipo mediante casos representativos de diferentes tipos de trámite*, comprobando que puedan definirse y recorrerse de principio a fin en un entorno controlado.
- *Evaluar los resultados y limitaciones del prototipo*, identificando las capacidades que deberán desarrollarse o profundizarse en versiones posteriores.
- *Publicar el proyecto como software libre*, bajo una licencia FOSS reconocida, en un repositorio público, permitiendo su inspección, modificación y distribución.
- *Elaborar documentación técnica y funcional*, orientada a la configuración, uso, integración, mantenimiento y evolución del subsistema por parte de equipos técnicos institucionales.

== Justificación

El subsistema reutilizable que se plantea implementar en este proyecto busca contribuir a la adopción del gobierno electrónico en Bolivia mediante la simplificación de la digitalización de trámites en diferentes instancias públicas.
Al favorecer el acceso a la información, el seguimiento y la trazabilidad de estos procedimientos administrativos, su aplicación podría contribuir a reducir gastos excesivos de tiempo y dinero, así como las oportunidades para prácticas de corrupción, discriminación o clientelismo asociadas al trámite presencial tradicional.
Esto es deseable porque, como se ha mencionado en los antecedentes de este documento, los trámites son una de las herramientas más importantes que tiene el gobierno para comunicarse con la ciudadanía y, por lo tanto, es importante que sean accesibles y fáciles de usar.

Al haber identificado que los trámites tienen muchas similitudes entre sí, este trabajo desea modelar estos procedimientos administrativos de forma general, ante la necesidad de contar con un modelo especializado que represente sus aspectos comunes en el contexto boliviano, utilizando técnicas modernas de modelado de procesos.
Además, se espera aportar una base conceptual que pueda contribuir a la futura armonización de los sistemas de trámites en Bolivia.
Esta abstracción permitirá también que este sistema demuestre cómo se aplica la normativa boliviana en el ámbito de los desarrollos de software gubernamentales, inspirando trabajos futuros en este campo y guiando implementaciones que se vayan a realizar para el aparato estatal.

Si bien cada vez más instancias del estado priorizan el uso del software libre en sus desarrollos propios (en cumplimiento de la normativa vigente), el código fuente de los sistemas resultantes no siempre es accesible al público.
Por ello, el subsistema reutilizable propuesto será abierto y FOSS, de modo que las instituciones puedan inspeccionarlo, modificarlo, desplegarlo y mantenerlo sin depender exclusivamente de un proveedor.
Esta capacidad contribuye a la soberanía tecnológica del país y facilita que el conocimiento producido pueda ser compartido y aprovechado en otras implementaciones.
Asimismo, la publicación del código permite su estudio y favorece la auditoría y el escrutinio independiente.
Aunque su disponibilidad no garantiza por sí sola la transparencia ni demuestra que una instancia desplegada corresponda exactamente con el código publicado, sí crea condiciones técnicas que pueden fortalecer la confianza y la rendición de cuentas en los sistemas gubernamentales que adopten este subsistema.

Como puede percibirse, la característica de software libre tiene mucha importancia en este proyecto.
No sólo atiende a una necesidad y requerimiento del gobierno boliviano mediante la normativa vigente, sino que además, busca contribuir al ecosistema de software libre en Bolivia, particularmente dentro del alma mater donde se realiza este proyecto, incentivando a la realización de más proyectos de este tipo, con un enfoque colaborativo, de comunidad y de crecimiento incluso después de finalizado el proyecto.

Por otra parte, el subsistema reutilizable podría producir un impacto económico positivo al reducir el esfuerzo necesario para implementar las características comunes de nuevos trámites y evitar que cada institución desarrolle una solución completa desde cero.
Medir este impacto en un proyecto de software libre es difícil, pero autores como Sommerville @sommervilleSoftwareEngineering2016 relacionan el costo de desarrollo con el tamaño del software y señalan que la reutilización puede reducir la cantidad de código nuevo que debe escribirse.
Bajo el supuesto simplificado de que los demás factores permanecen constantes, esta relación puede expresarse de la siguiente manera:

$ C prop \L\O\C $
$ \L\O\C_"sr" > \L\O\C_"cr" $
$ therefore C_"sr" > C_"cr" $

Donde:

- $C$ es el costo de desarrollo del software.
- $\L\O\C$ es la cantidad de líneas de código.
- $C_"sr"$ es el costo de desarrollo del software sin reutilización de código.
- $C_"cr"$ es el costo de desarrollo del software con reutilización de código.
- $\L\O\C_"sr"$ es la cantidad de líneas de código del software sin reutilización de código.
- $\L\O\C_"cr"$ es la cantidad de líneas de código del software con reutilización de código.

Esta formulación constituye únicamente una aproximación teórica y no una demostración empírica del ahorro, pues la cantidad de líneas de código no representa por sí sola la complejidad ni incorpora costos de integración, configuración, mantenimiento o capacitación.
Su utilidad en este trabajo se limita a ilustrar el beneficio potencial de reutilizar una base existente.

A su vez, aunque estrechamente relacionado con el factor económico, existe un factor de tiempo que se busca atender con este proyecto.
En este trabajo, la reutilización se entiende principalmente como la adopción de una misma aplicación configurable por distintas instituciones.
Para los casos comunes, los usuarios administrativos podrán definir y configurar trámites de manera interactiva, evitando que cada institución deba desarrollar un sistema independiente desde cero.
Las posibilidades de integrar el subsistema, extenderlo mediante programación o modificar su código fuente complementan esta forma de adopción, pero no constituyen el criterio principal con el que se demostrará su reutilización.

Finalmente, no se puede ignorar que este proyecto también busca validar ciertos patrones, estilos y prácticas de la ingeniería y la arquitectura de software.
Incluso al día de hoy se considera a estas ciencias relativamente nuevas y no existen definiciones claras en muchos aspectos como la modularidad @richardsFundamentalsSoftwareArchitecture2020[pág.
  37], a pesar de su importancia.
Además, en la práctica, los términos usados alrededor del desarrollo del software sufren de una constante evolución.
En este sentido, se busca validar el empleo del concepto de subsistema reutilizable para describir una aplicación configurable que puede funcionar con cierto grado de independencia y, a la vez, integrarse en sistemas pertenecientes a instancias públicas diversas.
Este enfoque busca conciliar la descentralización de la adopción y configuración con la centralización de modelos, lineamientos y capacidades comunes: cada institución conserva la posibilidad de atender su propio modelo de negocio, pero parte de una base compartida que favorece la interoperabilidad y la armonización. De esta manera, Tunkunia plantea para los trámites un enfoque análogo al de otras iniciativas estatales que proporcionan soluciones comunes para que cada institución construya y mantenga su propia presencia digital.

== Alcance

Para comprender el alcance de este proyecto se debe considerar que, cuando se habla de un _subsistema reutilizable_, se habla de capacidad de integración en sistemas más grandes, pero a la vez de cierto funcionamiento independiente, en este caso como un sistema de gestión de trámites en sí mismo.
Para delimitar el proyecto, su reutilización se entiende según el enfoque de las aplicaciones configurables descrito por Sommerville @sommervilleSoftwareEngineering2016: una misma aplicación se diseña para ser adoptada por distintos clientes y ajustada a sus necesidades mediante configuración.
Por tanto, una institución reutiliza Tunkunia cuando adopta el subsistema y configura en él sus propios flujos de trámite, sin requerir un desarrollo independiente para cada procedimiento.
Tunkunia no se plantea como una librería que deba incorporarse a otro programa.
En el prototipo la interoperabilidad, la extensibilidad y la disponibilidad del código fuente son propiedades complementarias que amplían sus posibilidades de adopción y se alinean con normativa relevante, pero no se emplean como significados alternativos de la reutilización ni como condiciones necesarias para demostrarla en este proyecto.

La denominación de las piezas modulares depende de la organización o persona que la emplee.
Ingeno @ingenoSoftwareArchitectsHandbook2018 las clasifica en seis categorías: una *estructura* es la agrupación e interrelación entre elementos; *elemento* es el término genérico para cualquiera de estas piezas; *sistema* representa el proyecto completo y el mayor nivel de abstracción; *subsistema* es en sí mismo un sistema que forma parte de otro mayor con cierto nivel de independencia y que puede contener otros subsistemas; *módulo* es una parte de un sistema enfocada en un área lógica específica de responsabilidad; y *componente* es el nivel más pequeño de agrupación y de menor abstracción.
Estos términos pueden ser intercambiables ante la falta de definiciones universales. El sistema propuesto cumple con esta definición de subsistema, ya que es un sistema en sí mismo, pero busca formar parte de un sistema mayor que es el sistema de gobierno electrónico de Bolivia.

Un antecedente para la elección del término es el Sistema Integrado Nacional del Espectro Radioeléctrico (SINER), licitado para la Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes @GobiernoLanzaSegunda2023.
Su documento base de contratación define dos componentes de software como subsistemas por formar parte de un sistema mayor, aunque pueden utilizarse parcialmente de forma independiente.
Este uso inspira la categorización del producto propuesto como subsistema.

Ahora bien, es menester precisar que el prototipo no constituye la implementación de un trámite institucional concreto, sino el sistema sobre el cual pueden definirse y ejecutarse distintos trámites.
Aún así, el prototipo se aplicará a casos representativos y permitirá definirlos en un entorno controlado, sin afirmar que estos se encuentran listos para su operación real en producción.
Adicionalmente, si bien se espera promocionar el uso de este sistema en instancias públicas, no se garantiza su uso efectivo en ninguna de estas durante el transcurso de este proyecto, debido a la carga burocrática que eso representaría.

Las pruebas al prototipo deben cumplir con los requerimientos desarrollados y con la definición de distintos trámites como procesos en un sistema de gestión de flujos de trabajo. Es decir, la digitalización de un trámite dentro del prototipo abarcará su dimensión como un proceso y el entorno básico que un trámite digitalizado suele tener en un sistema de trámites:

- Autenticación
- Notificaciones
- Historial y Seguimiento

La adopción prevista consiste principalmente en desplegar y configurar una instancia del subsistema según las necesidades de cada institución, el prototipo considerará esto en su diseño, pero no será desplegado para ninguna institución real.

El diseño del sistema podrá contemplar capacidades necesarias de un subsistema totalmente finalizado y listo para desplegarse en una institución real, pero esto no entra dentro de los alcances de este proyecto como tal y, tanto el diseño como la implementación, estarán orientados principalmente hacia el prototipo.

En el nivel del producto diseñado, la arquitectura contemplará:

+ *Núcleo de gestión de flujos:* modelado, definición y ejecución de procesos; creación de casos; registro de acciones; y consulta de su estado e historial.
+ *Servicios comunes:* gestión de actores y responsabilidades, auditoría, autenticación mediante servicios de identidad, notificaciones e interoperabilidad con otros sistemas.

En el nivel de implementación, las capacidades se delimitan de la siguiente manera:

- *Implementadas en el prototipo:* definición y configuración interactiva básica de trámites, sus flujos y formularios sencillos; ejecución y seguimiento de trámites; gestión de roles y validaciones; auditoría; interfaz de programación de aplicaciones (API) REST; e interfaces básicas para los actores considerados.
- *Simuladas en un entorno controlado:* autenticación mediante adaptadores que representen servicios como Ciudadanía Digital, y generación de eventos de notificación sin requerir la entrega efectiva de correo electrónico.
- *Contempladas en el diseño arquitectónico:* integración real con Ciudadanía Digital, entrega efectiva de correo electrónico, webhooks, reportes y estadísticas avanzados, y ampliación de las opciones de configuración mediante GUI.
  Estas capacidades quedarán fuera de la implementación obligatoria del prototipo, pero deberán contar con contratos o puntos de extensión que permitan su desarrollo posterior.

La edición interactiva de formularios en el prototipo será mínima y demostrativa: permitirá describir formularios sencillos compuestos por un conjunto reducido de campos de entrada y una acción de envío.
No se desarrollará un constructor visual de formularios de propósito general; las necesidades específicas podrán resolverse posteriormente mediante la extensión del producto o la adaptación de su código fuente.

Para modelar el proceso se emplearán casos representativos de diferentes tipos de trámite seleccionados en la investigación correspondiente. Entre ellos se incluyen procedimientos derivados del @RASIM, como antecedente directo del proyecto, y trámites pertenecientes a otros dominios, con el propósito de identificar estructuras comunes sin suponer que el modelo abarcará todas las particularidades posibles.

El trámite se formalizará como un proceso mediante técnicas de modelado apropiadas para representar estados, acciones, participantes y decisiones. La selección y aplicación detallada de dichas técnicas se desarrolla en los capítulos de fundamentos, investigación y diseño.

Se elegirán tecnologías web modernas de desarrollo con documentación adecuada para que los usuarios finales puedan emplear el sistema fácilmente y que futuros contribuidores no tengan problemas en modificarlo, tanto en apariencia como en funcionalidad.
El código fuente se distribuirá mediante un repositorio público y el producto contará con artefactos desplegables que permitan su uso autónomo.

Finalmente, se debe considerar lo siguiente:

- El artefacto de software entregado se considerará un prototipo funcional de carácter académico y demostrativo.
  Su aceptación se basará principalmente en la ejecución completa de casos representativos, el registro de sus acciones e historial y la configuración de dos instancias institucionales ficticias que utilicen el mismo producto para necesidades diferentes.
- El código fuente se publicará bajo la licencia MIT, cuyas condiciones permiten su uso, copia, modificación y distribución, siempre que se conserven el aviso de derechos de autor y el aviso de permiso correspondientes.
- Se contará con elementos de documentación en línea, contemplando:
  - Documentación general del proyecto y su implementación
  - Uso de la API, extensión y adaptación del código para desarrolladores
  - interoperabilidad e integración
  - Configuración y uso para el administrador
  - Guía de uso básico para el ciudadano
  - Guía de despliegue para al menos un entorno, que puede ser en un servidor privado virtual (VPS), Docker u otro.
- La integración efectiva con Ciudadanía Digital y otros servicios estatales no forma parte de la implementación obligatoria, debido a que requiere permisos y condiciones externas al proyecto.
  El prototipo empleará adaptadores y servicios simulados, basados en la documentación disponible de la AGETIC, para demostrar conceptualmente los puntos de integración previstos por la arquitectura.
- No se pretende profundizar demasiado en aspectos de eficiencia y escalabilidad, debido al carácter de prototipo funcional de la implementación; las optimizaciones se dejan a versiones futuras, posteriores a la ejecución de este proyecto.
- El subsistema permitirá configurar interactivamente los aspectos comunes de los trámites.
  Las acciones, reglas o integraciones específicas que excedan esas capacidades podrán requerir extensión o adaptación mediante programación, pero no forman parte del criterio principal de reutilización del prototipo.
  Dichas intervenciones deberán seguir los lineamientos arquitectónicos y de extensión detallados en la documentación.
