//== Requisitos y análisis del dominio
//
//=== Modelado del Negocio
//
//==== Modelado de Trámites Gubernamentales
//
//==== Entidades y Relaciones
//
//Siguiendo el modelo de tres dimensiones para representar un flujo, la  traduce en un diagrama entidad-relación de Chen
//
//#figure(
//  image("/assets/figures/basiserd.svg"),
//  caption: [Diagrama ERD  básico\ Elaboración propia],
//)<fig:basiserd>
//
== Ingeniería de Requerimientos

El proceso de ingeniería de requerimientos se hizo de acuerdo al ISO 29148, presentando una conformidad adaptada, es decir, no una conformidad total, ya que se no se consideraron algunos elementos de información irrelevantes en el contexto de este proyecto dada la estructura de este documento. Además, se consideraron lineamientos establecidos en el @SWEBOK, es decir, la base de conocimientos sobre ingeniería de software. A continuación, se listan los distintos elementos requeridos por el estándar antes mencionado, precedidos por una lista de requerimientos producidos durante el proceso de elicitación.

=== Elicitación y Descubrimiento

==== Gestión de requerimientos

==== Identificación inicial de Actores

Como se pudo identificar en el modelado del trámite, pueden existir distintos actores involucrados en la vida de un trámite y cada institución puede poner un rótulo diferente a los mismos, por lo que es necesario crear una taxonomía de actores del trámite que no sólo permita entender sus funciones, sino que además sea lo suficientemente general para poder aplicarse en multitud de trámites a lo largo de diferentes instituciones.

Adicionalmente, si bien se identificaron actores del proceso en sí mismo, dado el objetivo de este proyecto se hacen aparentes actores adicionales del meta-proceso, del sistema, y aquellos potenciales que nacen de los alcances del proyecto.

Considerando el proceso en sí mismo, podemos identificar que este suele implicar a dos partes importantes, el participante de la ciudadanía y protagonista del trámite y el o los servidores públicos que examinan documentos y toman decisiones en representación de su entidad. En ciertos casos, podrían haber terceros involucrados.

Ahora bien, si hablamos del meta-proceso, el sistema y otros, es decir, la contribución importante de este proyecto, tenemos necesariamente que comenzar hablando de un gestor de trámites de la entidad, quien deberá encargarse de crear, poner en marcha y modificar los trámites, así como resolver casos excepcionales. También podemos señalar a los sistemas externos como aquellos de ciudadanía digital y otros subsistemas que se espera puedan interactuar con Tunkunia.

Para rotular algunos de los actores que no necesariamente forman parte del proceso tradicional del trámite, se emplea una analogía con el juego de la Tunkuña, sobre cuyo nombre se inspira este proyecto. En este juego

Los actores se dividen en dos grupos:

- Los que administran el sistema
- Los que gestionan trámites
- Los que participan de los trámites
  - Desde la ciudadanía
    - Protagonista del trámite
    - Terceros involucrados
  - Desde la entidad pública: servidores o funcionarios, personal de atención

Analogía
- El adulto que ve a los niños jugar, les enseña cómo hacerlo y resuelve sus dudas -> administrador del sistema
- Dibuja avioncito -> gestor de trámites
- Árbitro que verifica que se juegue correctamente y determina si el jugador gana -> examinador
- Jugador que salta por los cuadros en su turno -> ciudadano

==== Identificación inicial de requerimientos

=== Especificación de Requerimientos del Negocio y de los Interesados (BRS y StRS)

El estándar ISO 29148 presenta un listado de elementos necesarios que deberían formar parte de la especificación de requerimientos del negocio y de los interesados. Estos elementos se solapan en este trabajo con aquello definido en la definición misma del proyecto, además de tener poca compatibilidad con un trabajo de investigación tecnológica, por lo que se omiten como tal las especificaciones de requerimientos del negocio y de los interesados, más conocidos como BRS y STRS.

// TODO: Las reestricciones del proyecto podrían ir aquí quizás
=== Especificación de Requerimientos del Sistema

A continuación se especifican los requerimientos del sistema como un todo a partir de la estructura recomendada por el ISO 29148

==== Propósito del sistema
// TODO: Explicar por qué se desarrolla Tunkunia.

==== Alcance del sistema
// TODO: Delimitar qué hará y qué no hará el sistema.

==== Panorama del sistema
// TODO: Resumir el sistema, su contexto y sus usuarios.

===== Contexto del sistema
// TODO: Describir los límites, elementos e interfaces principales.

===== Funciones del sistema
// TODO: Resumir las capacidades y restricciones principales.

===== Características de los usuarios
// TODO: Caracterizar los tipos de usuario y su forma de uso.

==== Requerimientos funcionales
// TODO: Especificar las funciones requeridas del sistema.

==== Requerimientos de usabilidad
// TODO: Definir objetivos medibles de usabilidad y calidad en uso.

==== Requerimientos de rendimiento
// TODO: Definir condiciones y métricas críticas de rendimiento.

==== Requerimientos de interfaces del sistema
// TODO: Especificar interfaces internas, humanas y externas.

==== Operación del sistema
// TODO: Definir los requerimientos asociados a la operación.

===== Integración entre personas y sistema
// TODO: Especificar la asignación e interacción entre personas y sistema.

===== Mantenibilidad
// TODO: Definir objetivos cuantitativos de mantenimiento y soporte.

===== Fiabilidad
// TODO: Definir objetivos cuantitativos y condiciones de fiabilidad.

===== Otros atributos de calidad
// TODO: Especificar atributos como compatibilidad y portabilidad.

==== Modos y estados del sistema
// TODO: Definir modos, estados y transiciones operativas.

==== Características físicas
// TODO: Registrar restricciones físicas y necesidades de adaptación.

===== Requerimientos físicos

Este elemento no aplica: Tunkunia no prescribe equipamiento físico dedicado.

===== Adaptabilidad
// TODO: Definir necesidades de crecimiento, expansión y contracción.

==== Condiciones ambientales
// TODO: Definir condiciones técnicas, legales y sociales del entorno.

==== Seguridad del sistema
// TODO: Especificar requisitos de seguridad, privacidad y recuperación.

==== Gestión de la información
// TODO: Definir recepción, generación, protección y conservación de información.

==== Políticas y normativa
// TODO: Derivar requisitos de políticas institucionales y normativa aplicable.

==== Sostenimiento durante el ciclo de vida
// TODO: Definir actividades y medios de soporte durante el ciclo de vida.

==== Embalaje, manipulación, envío y transporte

Este elemento no aplica: Tunkunia se distribuye como producto digital y no requiere transporte físico.

==== Verificación
// TODO: Indicar los métodos previstos para verificar los requerimientos.

==== Supuestos y dependencias
// TODO: Enumerar los supuestos y dependencias del sistema.

=== Especificación de Requerimientos del Software de Tunkunia

A partir de la estructura recomendada por ISO/IEC/IEEE 29148, a continuación se presenta una única especificación para Tunkunia como producto software. El servidor y la aplicación web no constituyen productos independientes: son componentes lógicos con responsabilidades y entornos de ejecución diferentes, pero forman parte de una misma unidad de entrega. El objetivo de distribución es incorporar los recursos construidos de la aplicación web en el binario de Go; mientras esta integración no haya sido implementada, debe considerarse una condición objetivo y no una descripción del estado actual del prototipo.

==== Propósito

// TODO: Delimitar el propósito de la especificación y los lectores a quienes está
// dirigida.

==== Alcance

// TODO: Identificar Tunkunia como producto software y describir sus límites sin
// repetir el alcance del sistema sociotécnico.

==== Perspectiva del producto

// TODO: Relacionar el producto software con el sistema, sus usuarios, los sistemas
// externos y el entorno institucional.

===== Relación con el sistema

// TODO: Explicar qué requerimientos del sistema se asignan al software y qué
// responsabilidades permanecen en las personas, instituciones o sistemas externos.

===== Componentes lógicos y asignación

// TODO: Presentar el servidor y la SPA como componentes lógicos de un mismo
// producto. Asignar al servidor dominio, persistencia, API, identidad e
// integraciones; a la SPA, presentación, navegación e interacción; y a ambos, las
// responsabilidades transversales.

La separación lógica no implica dos especificaciones ni dos productos distribuibles. El servidor se ejecuta como proceso en el entorno de instalación y la SPA se ejecuta en el navegador después de que sus recursos estáticos son entregados por el servidor.

===== Interfaces con el sistema

// TODO: Relacionar las interfaces del software con los elementos y requerimientos
// definidos en la especificación del sistema.

===== Interfaces de usuario

// TODO: Especificar las interfaces y reglas generales de interacción con los
// distintos grupos de usuarios.

===== Interfaces de hardware

Este elemento no aplica: Tunkunia no requiere interfaces directas con hardware específico.

===== Interfaces de software

// TODO: Especificar dependencias e interfaces con otros programas, incluidos el
// navegador, la base de datos y el proveedor de identidad.

===== Interfaces de comunicación

// TODO: Especificar protocolos, formatos e interfaces de comunicación internas y
// externas.

===== Restricciones de memoria

// TODO: Registrar límites de memoria del servidor o de los dispositivos cliente
// sólo cuando el entorno objetivo imponga valores verificables.

===== Operaciones

// TODO: Describir los modos de operación normal y excepcional, además de las
// necesidades de respaldo, recuperación y mantenimiento.

===== Adaptación a la institución o entorno

// TODO: Definir los datos y opciones que permiten adaptar el producto a distintas
// instituciones sin modificar su código fuente.

===== Interfaces con servicios

// TODO: Especificar las interacciones con servicios gubernamentales, proveedores
// de identidad y otros servicios externos o simulados.

==== Funciones del producto

// TODO: Resumir las capacidades principales del producto completo, con
// independencia del componente que las materialice.

==== Características de los usuarios

// TODO: Describir los grupos de usuarios y las características que condicionan
// los requerimientos del software.

==== Limitaciones

// TODO: Registrar restricciones regulatorias, técnicas, institucionales y
// operativas aplicables al producto.

==== Supuestos y dependencias

// TODO: Enumerar factores externos que puedan afectar los requerimientos del
// software o su verificación.

==== Requerimientos especificados

// TODO: Formular requerimientos identificables, necesarios, trazables y
// verificables. Emplear un espacio global de identificadores, por ejemplo
// SWR-FUN-001, y registrar por separado su asignación al servidor, a la SPA o a
// ambos componentes.

===== Interfaces externas

// TODO: Definir las entradas y salidas observables del producto, agrupadas por
// interfaz de usuario, API y servicios externos cuando corresponda.

===== Requerimientos funcionales

// TODO: Especificar el procesamiento de entradas, reglas y salidas por capacidad
// del producto, no por tecnología de implementación.

===== Usabilidad

// TODO: Definir objetivos medibles de usabilidad y calidad en uso, principalmente
// observables mediante la SPA.

===== Rendimiento

// TODO: Establecer límites medibles de capacidad, tiempos de respuesta y uso de
// recursos, indicando las condiciones de medición.

===== Base de datos lógica

// TODO: Definir los requerimientos de información, integridad, acceso, seguridad
// y retención, sin prescribir innecesariamente el diseño físico.

===== Restricciones de diseño

// TODO: Registrar únicamente decisiones impuestas externamente o indispensables
// para satisfacer el propósito del producto.

====== Distribución y empaquetado

// TODO: Formular como requisito verificable que la distribución objetivo incluya
// el servidor y los recursos construidos de la SPA en un único binario de Go.
// Aclarar las plataformas objetivo y cualquier recurso que deba permanecer
// externo, como archivos de configuración o datos persistentes.

===== Cumplimiento de estándares

// TODO: Especificar requerimientos derivados de normas, regulaciones y contratos
// de interoperabilidad aplicables.

===== Atributos del sistema de software

// TODO: Definir fiabilidad, disponibilidad, seguridad, mantenibilidad,
// compatibilidad y portabilidad mediante condiciones verificables.

==== Asignación y trazabilidad de requerimientos

// TODO: Relacionar cada requerimiento del software con su origen en la SyRS, su
// asignación al servidor, la SPA o ambos, y su método de verificación. Evitar que
// el identificador dependa del componente para permitir reasignaciones futuras.

==== Verificación

// TODO: Indicar los métodos previstos para verificar el producto y distinguir las
// comprobaciones por componente de las pruebas del producto integrado.

==== Información de apoyo

// TODO: Añadir antecedentes, glosario, modelos y materiales complementarios
// necesarios para interpretar la especificación.
