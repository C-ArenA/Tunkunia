#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, typ-fig

== Planteamiento del Problema<section:problem_statement>

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


=== Abordaje al Problema

Estas desventajas podrían ser atacadas implementando un módulo, componte o subsistema reutilizable que atienda las características comunes entre distintos sistemas de gestión de trámites, buscando cumplir con normativa boliviana, siendo de tipo FOSS, con capacidad de integración de funcionalidades, interoperabilidad y considerando la definición, ejecución, registro, y control de dichos procesos administrativos.

=== Desafíos

Sin embargo, la realización de elementos reutilizables de software acarrea varios desafíos técnicos y académicos, particularmente en el contexto de los trámites gubernamentales. A continuación se listan algunos de estos:

- Modelado general del trámite: Al querer atacar en específico estos procesos administrativos, pero deseando atenderlos de forma general, se deben inicialmente modelar, partiendo de las características comunes a cada trámite, usando herramientas disponibles como las redes de Petri, las máquinas de estado finitas, diagramas de actividad UML, entre otras. Esto implica la exploración y estudio de dichas herramientas formales de modelado, además de un conocimiento profundo de la normativa alrededor de los trámites.
- Metodología de Desarrollo: Adoptar una buena metodología es importante para cualquier proyecto, pero en un módulo FOSS existen ciertas particularidades, ya que este será utilizado por muchos otros proyectos que confiarán en el mismo y puede enriquecerse de participaciones futuras de una posible comunidad.
- Arquitectura de Software: Este es un tema poco estudiado durante el transcurso de la carrera de Ingeniería Electrónica de la UMSA, por lo que representa un desafío académico importante para el éxito de este proyecto, debido a que es crucial para la elaboración de un producto de software robusto y de calidad, que use patrones de diseño y emplee las mejores prácticas en conjunto con una correcta ingeniería de software.
- Documentación y Mantenimiento: Escribir la documentación de una pieza de software reutilizable es de mayor relevancia. Se requiere el uso de un lenguaje técnico correcto y habilidades de redacción para que la adopción de la herramienta por otros desarrolladores sea sencilla. Además, esto debe facilitar el mantenimiento del software por terceros, tanto usuarios como contribuidores externos.
- Control de versiones y colaboración: Cualquier proyecto de software moderno requiere el uso de sistemas de versionado, pero en un proyecto de código abierto esto es especialmente importante para permitir colaboraciones externas y evolución constante.
- Testabilidad: Los proyectos de software moderno tienen como proceso importante el del testing, el cual permite realizar desarrollos que cumplan con lo que se desea en su diseño y que no hagan algo distinto @myersArtSoftwareTesting2012. Sin embargo, el campo del testing no es explorado en instituciones universitarias, a pesar de su importancia.

== Objetivo

#quote()[
  #par()[*Implementar*, como producto mínimo viable (MVP), un *subsistema reutilizable de software libre* especializado en la gestión de flujos de *trámite* que, mediante el uso de técnicas de modelado de sistemas y procesos, represente e implemente los aspectos *comunes* del trámite y pueda ser adoptado por *distintas instituciones públicas* del estado *boliviano* mediante adaptación o configuración mínima y siguiendo los lineamientos establecidos por la normativa nacional sobre gobierno electrónico.]
]

Para alcanzar este objetivo será necesario:
// Cada elemento listado podría fácilmente comenzar con la expresión "Quiero lograr..."

- *Elaborar un modelo formal del proceso general del trámite gubernamental*, empleando técnicas como las Redes de Petri o BPMN (Business Process Model and Notation), con énfasis en identificar estructuras recurrentes y patrones reutilizables, alineado con la normativa boliviana sobre gobierno electrónico y trámites digitales.
- *Desarrollar el subsistema siguiendo las etapas del ciclo de vida del software*, incluyendo al menos:
  - Análisis y definición de requerimientos, en función del modelo de trámite elaborado.
  - Diseño y modelado del sistema.
  - Implementación del software
  - Ejecución de pruebas,
  - Despliegue del MVP.
  - Recomendaciones para mantenimiento y evolución.
- *Publicar el proyecto como software libre*, bajo una licencia FOSS reconocida, en un repositorio público, asegurando su disponibilidad y potencial reutilización.
- *Elaborar documentación técnica y funcional*, orientada tanto al uso como al mantenimiento del subsistema por parte de equipos técnicos institucionales.

== Justificación

El subsistema reutilizable que se plantea implementar en este proyecto busca contribuir a la adopción del gobierno electrónico en Bolivia mediante la simplificación en la digitalización de trámites en diferentes instancias públicas, permitiendo que la ciudadanía pueda efectuar esta actividad burocrática de una forma sencilla y rápida, minimizando el riesgo de ser víctimas de corrupción, discriminación, clientelismo o de gastos excesivos de tiempo y dinero en estos procedimientos administrativos, es decir, evitando las desventajas del trámite presencial tradicional. Esto es deseable porque, como se ha mencionado en los antecedentes de este documento, los trámites son una de las herramientas más importantes que tiene el gobierno para comunicarse con la ciudadanía y, por lo tanto, es importante que sean accesibles y fáciles de usar.

Al haber identificado que los trámites tienen muchas similitudes entre sí, este trabajo desea modelar estos procedimientos administrativos de forma general, ante la falta de otras definiciones formales en el ámbito académico, utilizando técnicas de modelado de procesos modernos. Además, se espera sentar las bases para la creación de estándares alrededor de los sistemas de trámites en Bolivia. Esta abstracción permitirá también que este sistema demuestre cómo se aplica la normativa boliviana en el ámbito de los desarrollos de software gubernamentales, inspirando trabajos futuros en este campo y guiando implementaciones que se vayan a realizar para el aparato estatal.

Si bien cada vez más instancias del estado priorizan el uso del software libre en sus desarrollos propios (en cumplimiento de la normativa vigente), el código fuente de los sistemas resultantes no es accesible al público. Es por esto que el subsistema reutilizable propuesto, al ser totalmente abierto y FOSS, en caso de aplicarse en trámites reales del gobierno, se busca que pueda permitir que el motor que corra detrás de estos procedimientos administrativos gubernamentales no venga del gobierno sino de la población. Esto permitirá que la ciudadanía tenga acceso al núcleo de los diferentes sistemas de gestión de trámites implementados, que pueda estudiarlos, analizarlos, agregar funcionalidades, probarlos, etc. De este modo habrá mayor confianza en los sistemas de trámites de gobierno que utilicen este elemento reutilizable. Se desea que la aplicación de este proyecto sea una garantía para el ciudadano de que sus trámites usan un código que es abierto y que puede ser auditado por cualquier persona. Esto es un paso hacia la transparencia del gobierno y la confianza de la ciudadanía en el mismo y debería ser un enfoque común en el software gubernamental que, más allá del uso del software libre, el software resultante sea abierto al público en gran medida.

Como puede percibirse, la característica de software libre tiene mucha importancia en este proyecto. No sólo atiende a una necesidad y requerimiento del gobierno boliviano mediante la normativa vigente, sino que además, busca contribuir al ecosistema de software libre en Bolivia, particularmente dentro del alma mater donde se realiza este proyecto, incentivando a la realización de más proyectos de este tipo, con un enfoque colaborativo, de comunidad y de crecimiento incluso después de finalizado el proyecto.

/*
Cuando se habla de digitalización de procesos administrativos, suele hablarse del impacto positivo que tiene en el medio ambiente. Esto es cierto, ya que la digitalización de los trámites permite reducir el uso de papel y otros recursos físicos. Sin embargo, no se puede ignorar el impacto negativo que tiene la digitalización en el medio ambiente, ya que la producción de dispositivos electrónicos y su desecho también tienen un impacto negativo en el medio ambiente. Por lo tanto, si bien se menciona este posible impacto, promovido por este proyecto, no se considerará una justificación válida para este trabajo.
*/

Por otra parte, el impacto económico positivo que se espera lograr con el proyecto es muy importante de mencionar, ya que se espera que el módulo de software reutilizable permita a las instituciones públicas implementar nuevos trámites de forma rápida y sencilla, lo que a su vez permitirá reducir costos y mejorar la eficiencia en la gestión de los trámites. Medir el impacto económico en un proyecto de software libre es difícil, pero algunos autores como Sommerville @sommervilleSoftwareEngineering2016, consideran que los costos de desarrollo son proporcionales al tamaño del software siendo desarrollado y la reutilización de software implica una menor cantidad de líneas de código escritas. Esta afirmación es controversial, ya que el número de líneas de código podría no ser un indicador serio para medir el tamaño del software, pero en base a ella podríamos determinar el impacto en los costos de implementación de los sistemas que utilizan el producto de este proyecto como motor para sus trámites de la siguiente manera:

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

A su vez, aunque estrechamente relacionado con el factor económico, existe un factor de tiempo que se busca atender con este proyecto. Un sistema que digitalice trámites en base a una implementación reutilizable inicial que requiera tan sólo algunas configuraciones para adaptarse a cada caso específico, es un sistema que toma menos tiempo de implementar. Las instituciones públicas están en constante cambio y muchas veces aparecen nuevos trámites que requieren ser implementados rápidamente. Este proyecto busca ser una solución a este problema, permitiendo que las instituciones públicas puedan implementar nuevos trámites de forma rápida y sencilla, sin necesidad de desarrollar un sistema desde cero.

Finalmente, no se puede ignorar que este proyecto también busca validar ciertos patrones, estilos y prácticas de la ingeniería y la arquitectura de software. Incluso al día de hoy se considera a estas ciencias relativamente nuevas y no existen definiciones claras en muchos aspectos como la modularidad @richardsFundamentalsSoftwareArchitecture2020[pág. 37], a pesar de su importancia. Además, en la práctica, los términos usados alrededor del desarrollo del software sufren de una constante evolución. En este sentido, se busca validar el empleo del concepto de subsistema reutilizable para abarcar lo que también podría referirse a un marco de trabajo (framework) especializado, pero que además contemple cierta independencia y pueda integrarse en sistemas más grandes, pertenecientes a instancias públicas diversas. A partir de esto, también se desea desafiar el enfoque de ventanilla única que se hizo popular en años recientes, considerando que los trámites muchas veces deben integrarse a modelos de negocio específicos a cada entidad y en opinión del autor no deberían centralizarse en su totalidad.

== Alcance

Para comprender el alcance de este proyecto se debe considerar que, cuando se habla de un _subsistema reutilizable_, se habla de capacidad de integración en sistemas más grandes, pero a la vez de cierto funcionamiento independiente, en este caso como un sistema de gestión de trámites en sí mismo. Por otro lado, al ser reutilizable, se hace referencia a que puede configurarse, modificarse o extenderse como se haría con un marco de trabajo o framework de desarrollo. Esta dualidad entre subsistema y marco de trabajo, se debe a que este elemento de software busca ser empleado por otros desarrolladores de sistemas de software, pero a la vez, aunque en menor medida, por usuarios finales#footnote[Cuando se habla de usuarios finales en este contexto, se hace referencia a usuarios sin conocimiento de desarrollo de software, es decir, todos aquellos que emplean el sistema desde una GUI simplificada que requiera poco entrenamiento para ser utilizada]. Un ejemplo popular de este paradigma es la plataforma de Wordpress, un content management system (CMS) que permite a usuarios finales crear sus propios sitios web, pero que a la vez permite a desarrolladores extender su funcionalidad o configurar los sitios con mayor libertad siguiendo lineamientos establecidos por la plataforma. En este caso, Wordpress podría ser considerado un framework o marco de trabajo de desarrollo, pero su tarea principal es la de crear y gestionar contenidos en forma de sitios web, por lo que se le suele denominar CMS. Otro ejemplo más cercano, aunque menos popular, es Odoo, que se encuentra descrito en la @section:related_work. De forma similar a estos ejemplos, al producto de este proyecto se le llama entonces _subsistema de gestión de flujos de trámite_, tomando en cuenta el objetivo final del sistema.

La denominación de las piezas modulares depende de la organización o persona que la emplee. Ingeno @ingenoSoftwareArchitectsHandbook2018 las clasifica en seis categorías: una *estructura* es la agrupación e interrelación entre elementos; *elemento* es el término genérico para cualquiera de estas piezas; *sistema* representa el proyecto completo y el mayor nivel de abstracción; *subsistema* es un sistema que forma parte de otro mayor con cierto nivel de independencia y que puede contener otros subsistemas; *módulo* es una parte de un sistema enfocada en un área lógica específica de responsabilidad; y *componente* es el nivel más pequeño de agrupación y de menor abstracción. Estos términos pueden ser intercambiables ante la falta de definiciones universales.

Un antecedente para la elección del término es el Sistema Integrado Nacional del Espectro Radioeléctrico (SINER), licitado para la Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes @GobiernoLanzaSegunda2023. Su documento base de contratación define dos componentes de software como subsistemas por formar parte de un sistema mayor, aunque pueden utilizarse parcialmente de forma independiente. Este uso inspira la categorización del producto propuesto como subsistema.

En este sentido, es menester precisar que la pieza de software esperada de este proyecto no contempla un trámite completo de ningún tipo, sino que buscará sentar las bases para la posterior implementación de uno o más de estos. Sin embargo, se aplicará en casos de trámites como parte de este proyecto, aunque sea únicamente a manera de ejemplo, sin ponerlo en funcionamiento en un entorno real de producción. Adicionalmente, si bien se espera promocionar el uso de este sistema en instancias públicas, no se garantiza su uso efectivo en ninguna de estas durante el transcurso de este proyecto, debido a la carga burocrática que eso representaría.

Como se indicó, el sistema estará dirigido principalmente a desarrolladores de software, con ciertas configuraciones posibles de realizar por un usuario final mediante una interfaz gráfica (GUI). Lo que el sistema pretende abarcar es:

+ Asistencia en la definición de los procesos de trámite,
+ creación y configuración de los procesos de trámite,
+ puesta en marcha y finalización de los procesos de trámite,
+ facilidades de creación de formularios,
+ interfaz out-of-the-box para el seguimiento de trámites por parte del ciudadano,
+ capacidad de auditoría de los datos manejados por el sistema,
+ conexión con ciudadanía digital para la autenticación de usuarios,
+ conexión con ciudadanía digital para la validación de documentos, en lugar de la firma digital,
+ capacidad de interoperabilidad mediante interfaces API de tipo REST y webhooks,
+ dashboard de gestión de trámites para los distintos tipos de usuario,
+ varios niveles de validación de documentos,
+ emisión de notificaciones por correo electrónico para informar acerca de eventos del trámite al ciudadano y
+ generación de reportes y estadísticas de cada trámite y de los procesos de trámite en general

Para modelar el proceso del trámite se emplearán los trámites definidos por el @RASIM, dado que este proyecto fue inspirado en la implementación del @SIAI, aunque no se descarta el uso de otros casos para enriquecer el modelado. En caso de existir particularidades del trámite que no sean identificables mediante dicho reglamento, no se contemplarán en la versión entregada al finalizar este proyecto. Sin embargo, se buscará hacer un análisis de estos casos en las recomendaciones finales del proyecto para guiar versiones futuras.

Las técnicas de modelado utilizadas serán aquellas dirigidas a los sistemas que involucran procesos. Particularmente, se hará una exploración a la aplicación de las Redes de Petri y el uso del Business Process Model and Notation (BPMN), además de máquinas de estado y diagramas de actividad UML. De este modo se podrá partir de una vista formal de los aspectos comunes del trámite.

Se elegirán tecnologías web modernas de desarrollo con documentación adecuada para que los usuarios finales puedan emplear el sistema fácilmente y que futuros contribuidores no tengan problemas en modificarlo, tanto en apariencia como en funcionalidad. En cuanto a la distribución del elemento reutilizable se empleará la plataforma GitHub y adicionalmente, en caso de ser conveniente para la reutilización, algún distribuidor de paquetes adecuado, de acuerdo a la tecnología utilizada. Asimismo, es importante notar que no se partirá desde cero en esta implementación y se pretende reutilizar código para facilitar el desarrollo de este proyecto. Es decir, se seguirá el mismo principio de reutilización que se pretende promover.

Finalmente, se debe considerar lo siguiente:

- El artefacto de software desarrollado se considerará como una primera versión (v1.0) y un producto mínimo viable (MVP), debiendo pasar al menos el 80% de tests para su aceptación, mas no se garantiza que el mismo esté libre de "bugs", lo cual es natural en los desarrollos de software.
- La licencia de software libre a emplearse permitirá el uso de este proyecto sin restricciones, pero debe contemplar que quien lo use haga mención del autor de este proyecto y de la carrera de Ingeniería Electrónica de la Universidad Mayor de San Andrés.
- Se contará con elementos de documentación en línea, contemplando:
  - Documentación general del proyecto y su implementación
  - Uso del marco de trabajo para desarrolladores
  - interoperabilidad e integración
  - Configuración y uso para el administrador
  - Guía de uso básico para el ciudadano
  - Guía de despliegue para al menos un entorno, que puede ser en un servidor privado virtual (VPS), Docker u otro.
- Se busca promover la creación de una comunidad colaborativa mínima alrededor del proyecto, por lo que se recibirá al menos un "pull request" en el repositorio público para demostrar las bondades del software libre y se atenderá al menos un "issue" reportado.
- La funcionalidad de Ciudadanía Digital y otras que tengan que ver con instancias del estado no se implementarán necesariamente de forma completa, sino conceptual, debido a que dependen del aparato burocrático estatal, que debe brindar permisos para su utilización. Sin embargo, se emplearán servicios similares o simulados que aproximen el funcionamiento de estas plataformas y su integración, en base a la documentación facilitada en línea por la AGETIC.
- No se pretende profundizar demasiado en aspectos de eficiencia y escalabilidad, debido a que se implementará un producto mínimo viable y las optimizaciones se dejan a versiones futuras, posteriores a la ejecución de este proyecto.
- El funcionamiento del subsistema como sistema independiente para la gestión de trámites recién instalado será limitado en configuración y personalización, por lo que modificaciones específicas en el proceso del trámite pueden requerir intervención empleando algún lenguaje de programación. Esto representa un caso de uso esperado por el sistema, por lo que estas intervenciones deberán seguir los lineamientos del subsistema como marco de trabajo, mismos que estarán detallados en la documentación.

== Solución Propuesta

#img-fig(
  "/assets/figures/tunkunia_dist.excalidraw.png",
  [Método de distribución y uso del subsistema Tunkunia],
  <fig:tunkunia_dist>,
  width: 100%,
  placement: auto,
)

En función de lo establecido en secciones anteriores, principalmente en la presentación de la problemática, se observó que las distintas instituciones públicas o instancias del estado que desean digitalizar sus trámites, realizan implementaciones propias desde cero (tanto por cuenta propia, como mediante el lanzamiento de licitaciones públicas), cada una por su lado, de forma independiente, sin seguir los mismos lineamientos y estándares ni responder de forma estricta a la normativa boliviana. Además, existe una necesidad de enfrentar la digitalización de los trámites en tiempos cortos y con bajos presupuestos. Por ello, en el presente proyecto proponemos la creación de un subsistema reutilizable de software libre que contemple la funcionalidad común a cualquier trámite y responda a los lineamientos del gobierno boliviano. Este artefacto o paquete, como puede apreciarse en la @fig:tunkunia_dist, estará publicado en un repositorio de código y opcionalmente en un gestor de paquetes desde el cual podrá ser distribuido según requerimiento a las distintas instituciones del estado o entidades privadas que brinden sus servicios a las mismas, facilitando la implementación de procesos o flujos de trámite específicos mediante simple configuración y/o adaptación del código de acuerdo a un marco de trabajo.

El subsistema tendrá funcionalidad out-of-the-box simplificada para usuarios finales sin conocimiento de programación, pero además marcará una serie de lineamientos para usuarios avanzados que deseen adaptar el software a casos de trámite particulares. Por lo tanto, se podría considerar que este subsistema es a su vez un marco de trabajo de desarrollo, pero especializado en el manejo de trámites. Al ser principalmente un subsistema, el mismo contará con ciertas integraciones como la de Ciudadanía Digital, pero además ofrecerá interfaces REST API para facilitar la interoperabilidad e integración con otros subsistemas que formen parte del mismo sistema.

#img-fig(
  "/assets/figures/framework2subsystem.png",
  [Construcción a partir de un framework de desarrollo],
  <fig:framework2subsystem>,
  width: 80%,
  placement: auto,
)

Para lograr esta implementación se partirá de un framework de desarrollo web genérico, para lograr, mediante la adición de características, el framework especializado en trámites deseado (@fig:framework2subsystem). Tener un punto de partida utilizando una herramienta conocida permitirá una flexibilidad mayor por parte de quien use el subsistema, pudiendo incluso integrar características ajenas al trámite en la misma base de código, aunque eso no se contempla en este proyecto.

#typ-fig(
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
  [Funciones a grandes rasgos de Tunkunia],
  <fig:modfun>,
  placement: auto,
  width: 60%,
)

Si bien la funcionalidad esperada del subsistema se detalla en la sección de alcances, podemos considerar que, tomando como inspiración lo señalado en la @section:wfms acerca de los @WFMS, la funcionalidad de este subsistema contemplará a grandes rasgos y de forma general lo señalado en la @fig:modfun. Es decir, la gestión de los flujos de trámite, desde la creación de estos procedimientos, pasando por su ejecución (trámites individuales), hasta el control de los mismos.

Las funciones anteriores obligarán a contemplar distintos tipos de roles de usuario, los cuales también serán implementados. Si bien se pretende brindar facilidades de manejos de rol al administrador del sistema, se propone inicialmente la creación de tres grandes categorías: administradores, verificadores y ciudadanos, donde los administradores se harán cargo de la gestión general de los flujos de trámite, mientras que los verificadores serán empleados públicos dedicados a la revisión de documentos y los ciudadanos serán los ejecutores de cada trámite.


Es fundamental para el éxito de este proyecto, como se sugiere en uno de los objetivos específicos, conseguir un modelado general de los aspectos comunes del proceso del trámite. Para lograr esto se emplearan técnicas y lenguajes de modelado de procesos como los listados en la @section:modeling. Incluso antes de comenzar con la implementación del proyecto, se pueden identificar ciertos patrones comunes en los trámites, como el manejo de documentos con cambios de estado, la verificación y aceptación de datos, etc. Esto podría, por ejemplo, modelarse con máquinas de estados como se muestra en la @fig:stateex. Afortunadamente, como se vio en la @fig:petricomplaints, donde se muestra una Red de Petri, también existen ejemplos de modelado de procesos que, si bien no son generalizaciones del trámite, son un buen punto de partida.

#img-fig(
  "/assets/figures/stateprocedureexample.png",
  [Modelado simplificado del proceso de trámite],
  <fig:stateex>,
  width: 60%,
  placement: bottom,
)

El modelado señalado se formulará principalmente alrededor de los distintos trámites establecidos o sugeridos por el @RASIM, debido a la experiencia existente en los mismos (Ver antecedentes). Sin embargo, para lograr cubrir una mayor cantidad de características comunes no se descarta el uso de otros casos de trámites para la consolidación del modelo general del trámite.

#img-fig(
  "/assets/figures/modulegraph.png",
  [Representación gráfica, a grandes rasgos, del módulo Tunkunia],
  <fig:modulegraph>,
  placement: auto,
)

El subsistema que implementará el modelado realizado será principalmente monolítico, aunque con un claro enfoque modular y fuertemente inspirado por la arquitectura Model View Controller (MVC). La @fig:modulegraph muestra una aproximación de la estructura final del producto de este proyecto. Se puede observar que se consideran los distintos tipos de usuario, que además se busca separar, en correspondencia con la @fig:wfms_history, el núcleo de manejo de procesos de trámite en su propio módulo, y que se planea no sólo garantizar la interoperabilidad, sino además facilitar la integración out-of-the-box con Ciudadanía Digital. También se muestran ejemplos potenciales de integración con LLMs y otros subsistemas.

=== Transición de lo presencial a lo digital

Es importante considerar que los trámites digitales, si bien tienen muchas ventajas, no son accesibles a todo el público, como pudo verse en la @section:adoption. Para no correr el riesgo de dejar de lado a cierta parte de la población, la solución propuesta tiene un enfoque claro: Tunkunia deberá poder funcionar con asistencia de funcionarios públicos. Es decir, el ciudadano sin acceso a internet aún podrá hacer sus trámites con ayuda en forma presencial. Este tipo de aplicación del sistema, si bien depende exclusivamente de quien lo emplee, se deberá tomar en cuenta a la hora de implementar la solución planteada.
