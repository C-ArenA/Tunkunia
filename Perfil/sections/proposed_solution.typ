#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge
#import "@preview/acrostiche:0.5.1": acr

= Solución Propuesta

Se propone la creación de un módulo de software libre que aglutine las funcionalidades alrededor de los flujos de trámite que, como una forma específica de los sistemas de gestión de flujos de trabajo (WFMS), cuente con la capacidad de realizar su definición, ejecución, registro, y control (@fig:modfun), permitiendo la interoperabilidad mediante REST API e interfaces de usuario opcionales, tanto de administración como de ciudadano, para el fácil seguimiento de los distintos procesos en concordancia con la normativa boliviana. El módulo tendrá los mecanismos necesarios para poder integrarlo en otros sistemas, permitiendo el uso del mismo para la lógica del negocio del sistema en el que se use, esto es, siguiendo un enfoque modular (@fig:modulegraph). Los detalles de implementación del módulo a nivel de arquitectura se definirán a partir del grado de cohesión requerido con otros módulos, como ser el de autenticación y las tecnologías de desarrollo utilizadas, que pueden condicionar ciertas decisiones.

#figure(
  image("../assets/modulegraph.png"),
  caption: [Representación gráfica a grandes rasgos del módulo Tunkunia\ Fuente: Elaboración propia],
  placement: auto,
)<fig:modulegraph>

Esto se conseguirá mediante el modelado del proceso del trámite usando como motor a las máquinas de estado finitas, redes de Petri, diagramas de actividad UML y otras técnicas de modelado. Se identificarán patrones comunes en los trámites, como el manejo de documentos, la verificación y aceptación de datos, etc., partiendo de flujos comunes como el de la @fig:stateex o el de la @fig:petricomplaints.

#figure(
  image("../assets/stateprocedureexample.png", width: 70%),
  caption: [Modelado simplificado del proceso de trámite\ Fuente: Elaboración propia],
  placement: auto,
)<fig:stateex>

Se explorarán técnicas para ayudar en el proceso de verificación y aceptación de datos, como el uso de modelos grandes de lenguaje con inteligencia artificial así como métodos determinísticos de validación de datos.

Los requerimientos que se tendrán en cuenta principalmente serán aquellos encontrados en el RASIM para el SIAI y la implementación realizada por la consultora 2IES, aunque pueden tomarse ejemplos externos para enriquecer el modelado.

Algunas funcionalidades que se espera tener son:

- Creación de Metadatos de trámite (Definición de trámite).

- Generación de códigos de trámite.

- Funcionalidad de notificaciones.

- Límites de tiempo asignables a los estados de trámite.

- Funcionalidad de persistencia de historial de estados incorporada.

- Funciones de recuperación de historia de trámite para seguimiento.

- Niveles de visibilidad de trámites para seguimiento.

- Mecanismos para dificultar el entorpecimiento de un trámite y
  facilitar la identificación de responsables.

- Interfaz sencilla para cambio de estados de una máquina de estados (trámite).

- Formularios flexibles para el manejo de documentos

- Registro de documentos de trámite usando o simulando aprobación de documentos de ciudadanía digital #footnote[De acuerdo a la norma técnica de adhesión para mecanismos de ciudadanía digital, se requiere seguir un procedimiento burocrático cuyo fracaso podría comprometer el proyecto. Es por ese motivo que, aunque con claras limitaciones y como contingencia, se habilita la posibilidad de simular ciertos mecanismos o usar algunos similares.]<fn:ciudad_dig>.

- Autenticación de usuarios usando o simulando el uso de ciudadanía digital #footnote(<fn:ciudad_dig>).

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
  caption: [Funciones a grandes rasgos del módulo],
  placement: auto,
)<fig:modfun>

== Transición de lo presencial a lo digital

El funcionario se vuelve un asistente de uso del sistema, ya no un ejecutir del trámite en sí mismo.

== Arquitectura del módulo

Es un subsistema

Desde la perspectica dee reusabilidad
Es una aplicación completa e independiente de forma parcial
Además principalmente es un marco de trabajo

Inspirado en otros frameworks como Django, Spring, .Net, Laravel, etc.. pero será un marco de trabajo especializado en los trámites con funcionalidad out-of-the-box para la gestión de flujos de trámite, pero las actividades específicas de cada trámite se deben implementar o configurar. Los frameworks genéricos ya implementan muchas funcionalidades necesarias y se priorizará su uso, pero en base a ello se especializará.

Arquitectua abieta y bien documentada

== Integración e interoperabilidad

Al ser un marco de trabajo se debe configurar para cada caso de trámite
No se debe olvidar que es específico al trámite y no atiende todas las funcionalidades de un sistema de gestión de flujos de trabajo ni las funcionalidades de cada institución pública. Por esto no se debe mezclar con otros sistemas internos, pero se puede integrar con ellos.

== Tecnologías a usar y decisiones

Las tecnologías a usar dedpenderán de las necesidades y la situación actual. Al ser desarrollado inicialmente por un solo desarrollador, se priorizará el uso de tecnologías que ya conozca y que le permitan avanzar rápidamente. Se espera que el módulo sea desarrollado en PHP, con Laravel, pero no se descartan otras tecnologías.

Se debe atender a las limitaciones

Se comenzará a partir de un framework genérico para lograr un desarrollo rápido y luego se especializará. Se espera que el módulo sea desarrollado en PHP, con Laravel, pero no se descartan otras tecnologías.

== Configuración y personalización

Por deefecto el sistema no se espera que atienda por completo un trámitre, sino que se debe afinar, personalizar o congigurar para lograrlo.

Al ser un marco ded trabajo se espera que cada institucióin, mediante sus desarrolladores modeifque el sistema a su gusot

Sin embargho, también se espera poder bvrindar cierta funcionalidad de configurtación para el usuario final que administra el sistema en cada instanciapública.

Algo similar se ve en Wordpress, donde el usuario final puede configurar ciertos aspectos del sistema, pero no puede modificar el código fuente. En este caso se espera que el usuario final pueda configurar ciertos aspectos del sistema, como los formularios de trámite, pero no podrá modificar el código fuente.

Dado que el módulo no implementa por completo ningún trámite, se aplicará a ciertos trámites, inicialmente del RASIM por la experiencia del autor, pero no está limitado a ellos. Ejemplificación puede incluir OTTO, vidrios polarizados, etc.

// Añadir gráfico que muestre cómo el subsistema se distribuirá a las distintas instancias públicas, como el que usé para explicar a Diana

// Es un subsistema con características de un marco de trabajo especializado, porque no sólo funciona independiente y como parte de otros sistemas, sino que además está pensado para modificarse,. adaptarse y configurarse para atender distintos trámites. El problema es que los cambios en código posibles son tan limitados (a menos que hablemos de modificaciones del subsistema en sí), que practicamente es sólo un subsistema y no un marco de trabajo.
