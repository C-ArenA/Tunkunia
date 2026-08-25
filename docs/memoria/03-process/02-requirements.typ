#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, mmd-fig, typ-fig

== Ingeniería de Requerimientos

// Guía de redacción: explicar el método seguido para descubrir, analizar,
// especificar, verificar y gestionar los requerimientos, así como el alcance de
// la adaptación realizada respecto del estándar elegido.

La ingeniería de requerimientos de Tunkunia toma como referencia
ISO/IEC/IEEE 29148:2018 #cite(label("iso/iec/ieeeSystemsSoftwareEngineering2018")) #footnote[La aplicación del estándar es parcial y no de conformidad completa.] y las
prácticas descritas por el SWEBOK @washizakiGuideSoftwareEngineering2025.

De acuerdo al ISO 29148, un proyecto debería producir cuatro elementos de información:

+ Especificación de requerimientos del negocio (BRS)
+ Especificación de requerimientos de los interesados (StRS).
+ Especificación de requerimientos del sistema (SyRS).
+ Especificación de requerimientos del software (SRS).

Cada elemento de información tiene un propósito específico y responde a distintos niveles de abstracción.
La visión global de este proyecto se define en la introducción (@chap:intro), por lo que se omite la especificación de requerimientos del negocio (@BRS) y la especificación de requerimientos de los interesados (@StRS).
Por su lado, la especificación de requerimientos del sistema y la especificación de requerimientos del software responden a un nivel más técnico y aunque pueden atacar elementos similares, en especial en un proyecto puramente de software, conviene considerar aspectos de ambos de forma separada.

=== Elicitación, descubrimiento y gestión

Antes de describir las especificaciones mencionadas conviene presentar, de manera superficial, el trabajo realizado para elaborarlas mediante la elicitación, que forma parte de las actividades iniciales de desarrollo de los requerimientos @washizakiGuideSoftwareEngineering2025.

Las distintas especificaciones de requerimientos nacieron a partir de esta actividad y en atención a la definición del proyecto. La elicitación inicial realizada reúne necesidades expresadas en forma de historias de usuario, descripciones simples, requerimientos formales, entre otros, que permiten capturar las cualidades deseadas del sistema a partir de sus fuentes que
incluyen los objetivos, los alcances, la investigación sobre trámites bolivianos, la normativa y los planes de
gobierno electrónico considerados en el marco de referencia, así como la experiencia que
dio origen al proyecto.

Para registrar los elementos de la elicitación inicial, se creó una tabla simple con los siguientes elementos:

- Identificador
- Enunciado del requerimiento
- Nivel de prioridad: Usando la técnica MoSCoW de priorización

Se debe tomar en cuenta que no todos los elementos de la elicitación inicial se consideran en las especificaciones de requerimientos finales. Cada elemento pudo haber generado varios requerimientos. Las necesidades descartadas no se borraron de la tabla de elicitación.

// Aclaración editorial: se omiten los subtítulos de propósito y alcance de ambas
// especificaciones porque esa información ya se desarrolla en la introducción del
// proyecto. Los demás subtítulos del índice adaptado de ISO/IEC/IEEE 29148 se
// conservan para que su pertinencia pueda evaluarse durante la redacción.

=== Especificación de Requerimientos del Sistema

// Guía de redacción: describir Tunkunia en el nivel del sistema y relacionar sus
// capacidades con la institución operadora, las personas y los sistemas externos.
// Evitar convertir decisiones tecnológicas del prototipo en restricciones del
// sistema si no proceden de una necesidad o fuente externa.

==== Panorama del sistema

===== Contexto del sistema

// Guía de redacción: describir los límites del sistema, la institución operadora,
// los administradores y participantes, los proveedores de identidad, gob.bo,
// canales de notificación y otros sistemas autorizados. La institución define los
// procedimientos, competencias, infraestructura y políticas; Tunkunia los
// materializa mediante configuración y ejecución controlada.

#mmd-fig(
  "/assets/sources/tunkunia-system-context.mmd",
  [Contexto del sistema Tunkunia],
  <fig:tunkunia-system-context>,
  width: 90%,
)

El contexto del sistema se formula dentro de instituciones públicas del gobierno boliviano (@fig:tunkunia-system-context). Es decir, debe contemplar la normativa sobre gobierno electrónico, así como interactuar con sistemas y plataformas actualmente vigentes. Estas plataformas se encuentran bajo autoridad de la AGETIC. Adicionalmente, pueden existir otros sistemas dentro de la institución donde se emplee este proyecto, pero también sistemas externos de los cuales se requiera recabar información. El sistema será desplegado e instanciado por instituciones públicas específicas, quienes definirán procedimientos de trámite para ser digitalizados dentro del mismo. Los procedimientos definidos tendrán como participantes tanto a ciudadanos, protagonistas del trámite, como a servidores públicos. De este modo, podríamos sintetizar a los siguientes elementos del sistema:

- *Tunkunia:* Sistema reutilizable de gestión de flujos de trabajo especializado en trámites
- *Institución Pública:* Entidad que requiere digializar trámites con Tunkunia
- *Ciudadanos:* Participantes y principales ejecutores de casos de trámite
- *Servidores Públicos:* Participantes de distintos trámites en representación de la institución
- *Ciudadanía Digital:* Plataforme centralizada de identidad digital en Bolivia
- *Plataforma gob.bo:* Directorio de Trámites del estado boliviano
- *AGETIC:* Agencia de Gobierno Electrónico y Tecnologías de Información y Comunicación
- *Subsistemas de la Institución:* Otros sistemas bajo control de la institución en cuestión
- *Sistemas externos:* Otros sistemas que puedan brindar información necesaria para un trámite

===== Funciones del sistema

// Guía de redacción: resumir las capacidades en el orden establecido por la
// identidad del proyecto: modelado formal del trámite, motor de procesos y
// gestión de casos. Añadir como servicios comunes la identidad, autorización,
// expediente, auditoría, notificaciones e interoperabilidad; y como propiedades
// de adopción la configuración institucional y la extensibilidad.
//
#typ-fig(
  diagram(
    spacing: (18mm, 10mm),
    node-stroke: luma(80%),
    node((1.5, 0), [*Tunkunia*\ Trámites], name: <t>),
    node((0, 1), [*Definición*], name: <d>),
    node((1, 1), [*Ejecución*], name: <e>),
    node((2, 1), [*Registro*], name: <r>),
    node((3, 1), [*Control*], name: <c>),

    edge(<t>, <d>),
    edge(<t>, <e>),
    edge(<t>, <r>),
    edge(<t>, <c>),
  ),
  [Funciones a grandes rasgos de Tunkunia],
  <fig:modfun>,
)
Las principales funciones del sistema prototipado comprenden la de un @WFMS (@fig:modfun) y las de un sistema tradicional de digitalización de trámites:

- *Modelar y publicar trámites digitales:* definir procedimientos.
- *Ejecutar flujos de trámite:* iniciar casos y controlar su avance conforme a
  la definición vigente, las validaciones, los roles y las decisiones previstas.
- *Gestionar y consultar casos:* registrar actuaciones, información y documentos,
  y permitir la consulta del estado, las tareas, el expediente y el historial.
- *Proveer servicios comunes:* autenticar y autorizar actores, conservar la
  trazabilidad, generar eventos de notificación e interoperar mediante interfaces
  documentadas. Es decir, implementar aspectos comunes en los distintos sistemas de digitalización de trámites

Las principales condicionantes y restricciones son:

- *Generalidad del modelo:* debe representar los aspectos comunes de distintos
  trámites e instituciones, sin quedar ligado a un procedimiento concreto.
- *Contexto boliviano:* debe atender los lineamientos nacionales aplicables de
  gobierno electrónico, identidad digital, interoperabilidad, simplificación,
  transparencia y software libre.
- *Integraciones dependientes de terceros:* la identidad, las notificaciones y el
  intercambio con plataformas estatales o sistemas externos están sujetos a sus
  contratos, disponibilidad, permisos y datos; en el prototipo pueden emplearse
  adaptadores o servicios simulados.
- *Alcance del prototipo:* la configuración interactiva y los formularios son
  básicos; las reglas, acciones e integraciones particulares pueden requerir
  programación, y no se garantiza preparación para producción ni optimización de
  eficiencia o escalabilidad.

===== Características de los usuarios

// Guía de redacción: caracterizar administradores y participantes sin imponer una
// estructura institucional. Considerar que los ciudadanos pueden usar el sistema
// ocasionalmente y sin conocimientos técnicos, que los servidores públicos lo
// usan para atender tareas y decisiones, y que la configuración administrativa de
// los casos comunes no debería exigir programación.

Las personas relacionadas con Tunkunia se organizan en dos categorías
(@fig:tunkunia-user-use-cases):

- *Personal técnico:* interviene en la adopción y evolución del sistema, pero no
  necesariamente participa en los trámites.
  - *Operador de la instancia:* despliega, configura inicialmente y mantiene la
    aplicación y su infraestructura. Debe poseer conocimientos técnicos y acceso
    autorizado a los servidores de la institución.
  - *Desarrollador o modificador:* extiende los módulos y puntos de integración
    publicados, o adapta el código fuente cuando las necesidades institucionales
    exceden la configuración disponible. Debe respetar los contratos y
    lineamientos técnicos del producto.
- *Usuarios directos:* acceden a Tunkunia mediante la aplicación web y desempeñan
  funciones institucionales o participan en casos de trámite.
  - *Administrador institucional:* configura los datos de la institución, define
    y publica trámites, y asigna responsabilidades. Se prevé que sea personal
    capacitado y que la cantidad de administradores por instancia sea reducida.
  - *Participantes del trámite:* realizan acciones conforme a los permisos que la
    definición del proceso y el caso les concedan. Esta categoría comprende:
    - *Ciudadano:* consulta la oferta de trámites, inicia o participa en casos,
      proporciona información y realiza seguimiento. Puede utilizar el sistema de
      manera ocasional, tener distintos niveles de alfabetización digital y
      requerir asistencia.
    - *Servidor público:* atiende tareas, revisiones y decisiones en representación
      de la institución. Se prevé que conozca los procedimientos bajo su
      responsabilidad y reciba capacitación para utilizar el sistema.
  - *Visitante:* Un ciudadano no autenticado en el sistema, pero que es capaz de acceder al registro de trámites de modo informativo sin tener que participar en alguno.

#img-fig(
  "/assets/figures/tunkunia-user-use-cases.svg",
  [Casos de uso generales y jerarquía de usuarios de Tunkunia],
  <fig:tunkunia-user-use-cases>,
  width: 90%,
  placement: auto,
)

Los usuarios directos podrán acceder desde un navegador, siempre que dispongan de
conectividad y credenciales válidas del proveedor de identidad habilitado. Cuando
un ciudadano enfrente barreras de acceso o de uso, un servidor público podrá
asistirlo mediante la misma aplicación web, sin sustituir su identidad ni omitir
el registro de las actuaciones. Así, la atención digital puede complementarse con
la asistencia presencial.

Ciudadanos y servidores públicos comparten el tratamiento general de
participantes; sus facultades concretas no dependen únicamente de la categoría,
sino de los permisos asignados a cada acción dentro de la definición del proceso y del caso.
La cantidad de participantes depende de la institución y de cada trámite, por lo
que no se establece un máximo general para el sistema. Las estimaciones iniciales
de pocos administradores y decenas de servidores públicos por instancia son referenciales, pero cada trámite y cada institución son distintos.

// TODO: La descripcion de usuarios del SRS debe hacer referencia a este apartado y no desarrollarse ahí

==== Requerimientos funcionales

// Guía de redacción: especificar las funciones requeridas del sistema completo.
// Cubrir, como mínimo: definiciones y versiones de trámites; catálogo y
// publicación; representación de estados, acciones, participantes y decisiones;
// validación y ejecución de flujos; inicio autorizado de casos; tareas, plazos,
// correcciones y excepciones; formularios y documentos; expediente, historial y
// auditoría; autenticación y autorización; notificaciones; interoperabilidad;
// configuración institucional; y puntos de extensión.
//
// La versión de una definición asociada a un caso debería permanecer estable
// durante su ejecución. El archivado de una definición no debería destruir sus
// casos ni su historial. Las intervenciones excepcionales deberían mantenerse
// dentro del sistema y dejar trazabilidad.

===== Institución Pública Instanciadora
+ El sistema deberá permitir que la institución pública instanciadora configure sus datos institucionales básicos:
  - Nombre
  - Descripción
  - Descripción de la instancia de Tunkunia
  - Enlace al sitio institucional principal
+ El sistema deberá registrar una cuenta de administración inicial
+ El sistema deberá permitir la definición de trámites de la institución
+ El sistema deberá permitir configurar el estado de publicación de los trámites definidos
+ El sistema deberá permitir la definición de los procesos asociados al trámite
+ El sistema deberá permitir la configuración básica de elementos del proceso:
  - Permisos
  - Tipos de acciones mínimas:
    - Formularios configurables
    - Toma de decisiones
    - Generación de documentos
    - Consulta de datos
  - Tiempos de vida de las etapas del proceso
+ El sistema deberá permitir la configuración de la estructura del expediente asociado al caso de trámite
+ El sistema deberá permitir la gestión de usuarios a la institución pública instanciadora
+ El sistema deberá mostrar datos históricos de trámites llevados a cabo a la institución para su análisis posterior
+ El sistema deberá permitir la configuración de credenciales y datos secretos mediante variables de entorno consumidos en tiempo de ejecución

===== Plataformas de Gobierno Electrónico

+ El sistema deberá conectarse con el servicio de identidad de Ciudadanía Digital
+ El sistema deberá autenticar usuarios usando el servicio de Ciudadanía Digital
+ El sistema deberá emitir un reporte de trámites registrados que pueda ser usado para actualizar la información en la plataforma gob.bo, es decir, conteniendo los datos que el manual de esta plataforma requiere

===== Sistemas externos o Interoperabilidad
+ El sistema deberá exponer la especificación de su API
+ El sistema deberá gestionar llaves de acceso para otorgar a otros sistemas
+ El sistema deberá contar con una acción en el proceso del trámite para consumo de datos de sistemas externos que implementen un endpoint específico.

===== Participantes del Trámite
+ El sistema deberá mostrar el catálogo de trámites publicados a todos los usuarios autenticados o no autenticados del sistema, así como sus detalles y la definición de su proceso
+ El sistema deberá permitir al ciudadano iniciar la ejecución de trámites
+ El sistema deberá notificar a los participantes del trámite los eventos relevantes del proceso:
  - Tarea asignada o pendiente: Para todos los participantes
  - Cambio de estado: Para los ciudadanos
+ El sistemas deberá almacenar un registro histórico del caso de trámite en forma de un expediente que evolucione junto al trámite ejecutado
+ El sistema deberá permitir al participante realizar el seguimiento de sus procesos en ejecución
+ El sistema deberá mostrar el historial de casos de trámite que involucren al participante

==== Requerimientos de usabilidad

// Guía de redacción: definir objetivos medibles de usabilidad y calidad en uso
// para cada grupo de usuarios. Las interfaces deberían emplear el vocabulario de
// los trámites, mostrar claramente estados, tareas y errores, permitir el acceso
// desde un navegador sin instalar otra aplicación y ofrecer validación antes de
// publicar cambios. No inventar umbrales cuantitativos sin una línea base; ligarlos
// al plan de validación y a una muestra definida.
- La institución deberá ser capaz de digitalizar un trámite sencillo en menos de 30 minutos si tiene el procedimiento claro
- El despliegue de la aplicación podrá realizarse en un sólo día hábil
- Los trámites analizados en el modelado de trámites deben ser implementables
- El ingreso a la plataforma debe ser la primera acción que el usuario vea al ingresar al sitio principal.
- La lista de trámites publicados debe aparecer en la vista principal de la interfaz.
- Los datos de los casos de trámite pasados deben conservarse
- La eliminación debe ser con borrado suave (_soft delete_) para preservar ejecuciones en curso del trámite

==== Requerimientos de rendimiento

// Guía de redacción: establecer condiciones, cargas y métricas críticas de
// rendimiento y consumo de recursos. Relacionar la eficiencia con la posibilidad
// de operar una instancia en infraestructura institucional de costo razonable,
// sin transformar la expectativa de soberanía tecnológica en una topología o
// ubicación física obligatoria no sustentada.
- El sistema en dispositivos modernos y con conexión estable deberá cargar en menos de 3 segundos
- El consumo base de RAM en los servidores no debe superar los 500MB

==== Requerimientos de interfaces del sistema

// Guía de redacción: especificar interfaces humanas y externas, entradas, salidas,
// identidades, autorizaciones, errores y eventos relevantes. Contemplar
// navegadores, proveedores de identidad como Ciudadanía Digital, gob.bo, correo y
// otros sistemas institucionales. Las interfaces externas deberían ser
// documentadas, versionadas y basadas en formatos abiertos; su acceso no concede
// autorización general sobre los expedientes.

- El sistema deberá exponer una interfaz de tipo REST API mediante protocolo http para consumo de recursos por sistemas externos autorizados. El mismo deberá contar con una especificación OpenAPI.
- El sistema deberá exponer interfaces para la autenticación conforme a la tecnología utilizada por el servicio de identificación de ciudadanía digital.
- El sistema deberá contar con un CLI básico para el despliegue de la aplicación, con configuraciones específicas usando variables de entorno.
- El sistema deberá proporcionar una interfaz gráfica para el administrador institucional.
- El sistema deberá proporcionar una interfaz gráfica para los participantes de trámites.
- El sistema deberá exponer la funcionalidad principal de manejo de flujos de trabajo definida para su potencial extensibilidad mediante código así como funciones utilitarias que puedan ser empleadas en otros sistemas de gestión de flujos de trámite.

==== Operación del sistema

// Guía de redacción: definir los requerimientos asociados a operación normal,
// mantenimiento, indisponibilidad de integraciones, reintentos, procedimientos
// alternativos, respaldo, restauración y actualización. La integridad entre
// definiciones, casos, expedientes y auditoría debe preservarse en esas operaciones.

//===== Integración entre personas y sistema

// Guía de redacción: especificar la asignación e interacción entre personas y
// sistema. Las acciones humanas deberían asignarse a participantes o
// responsabilidades del flujo; el sistema debería mostrar qué acción está
// pendiente, su plazo y las consecuencias de la decisión, y registrar quién la
// realizó.

===== Mantenibilidad

// Guía de redacción: definir objetivos verificables de mantenimiento y soporte.
// Considerar modularidad por capacidades, contratos deliberados entre módulos,
// pruebas, migraciones y documentación suficiente para que un equipo distinto del
// autor pueda comprender, desplegar, mantener y extender el sistema.

- El sistema deberá emplear prácticas de código limpio y arquitecturas modulares para facilitar su mantenimiento.
- El sistema deberá emplear tecnologías de alto nivel para facilitar su modificación y mejora.
- El sistema deberá ser escrito utilizando lenguajes de tipado fuerte para mostrar intención en el código.
- El sistema deberá ser escrito utilizando lenguajes de tipado estático para reducir errores en tiempo de ejecución.

==== Condiciones ambientales

// Guía de redacción: definir condiciones técnicas, legales, institucionales y
// sociales del entorno. Para el entorno físico, indicar que no existen condiciones
// distintas de las exigidas por la infraestructura seleccionada. Para el entorno
// sociotécnico, considerar conectividad, normativa boliviana, capacidades de la
// institución y disponibilidad de servicios gubernamentales.

Condicionan a los requerimientos del sistema:

- Cambios en la normativa sobre gobierno electrónico y trámites digitales
- Implementaciones similares realizadas por la AGETIC

==== Seguridad del sistema

// Guía de redacción: especificar autenticación, autorización por función y por
// relación con el caso, mínimo privilegio, confidencialidad, integridad,
// trazabilidad, protección de credenciales, manejo seguro de errores, respaldo y
// recuperación. La transparencia no implica divulgar datos personales ni
// expedientes a personas no autorizadas.

- El sistema deberá permitir el ingreso de usuarios únicamente mediante ciudadanía digital.
- El sistema deberá restringir la eliminación total de datos críticos del sistema como las definiciones de trámites, de procedimientos y los datos de usuarios.
- El sistema deberá implementar mecanismos de trazabilidad de datos para detectar datos corrompidos.
- El sistema deberá restringir su interfaz API con llaves de acceso.
- El sistema deberá controlar su flujo de autenticación de manera interna.
- El sistema deberá restringir el acceso a datos de trámites en los cuales no participe el usuario.

==== Políticas y normativa

// Guía de redacción: derivar requerimientos de las políticas institucionales y de
// la normativa boliviana priorizada: software libre, estándares abiertos,
// soberanía tecnológica, interoperabilidad, simplificación, identidad digital,
// transparencia, trazabilidad, participación y control social. No afirmar
// cumplimiento exhaustivo de toda la normativa en el prototipo.

- El sistema deberá ser de software libre en cumplimiento al artículo 77 de la Ley 164.
- El sistema deberá emplear datos de identificación del Servicio de Identificación de Ciudadanía Digital para evitar exigir como requisito el mismo documento que hubiera sido requerido con anterioridad, como estipula el Decreto Supremo 3525 en su Artículo 12.
- El sistema deberá garantizar interfaces de interoperabilidad en conformidad al plan de implementación de gobierno electrónico.
- El sistema deberá emplear el servicio de ciudadanía digital para alinearse con el plan de implementación de gobierno electrónico.

==== Embalaje, manipulación, envío y transporte

// Guía de redacción: indicar que el transporte físico no aplica. Tratar en su
// lugar la distribución digital, integridad, autenticidad y documentación de los
// artefactos instalables, sin imponer aquí un formato tecnológico específico.

El transporte físico no aplica a este sistema. Sin embargo, si se considera que el sistema
deberá ser distribuido minimamente mediante un repositorio público de GitHub. Formas adicionales de distribución dependerán de las tecnologías seleccionadas en la etapa de diseño y/o construcción.

=== Especificación de Requerimientos del Software

Como se mencionó anteriormente, la especificación de requerimientos del software y la especificación de requerimientos del sistema pueden solaparse en muchos aspectos cuando el sistema es únicamente compuesto por un producto de software. Sin embargo, existen algunos apartados recomendados en el @SRS que pueden aportar riqueza a la descripción de requerimientos del proyecto.
// Guía de redacción: especificar Tunkunia como producto software y asignar al
// software los requerimientos derivados de la SyRS. El servidor y la aplicación
// web son componentes lógicos con responsabilidades y entornos de ejecución
// diferentes, pero forman parte de una misma unidad de entrega.

===== Relación con el sistema

// Guía de redacción: explicar qué requerimientos de la SyRS se asignan al software
// y cuáles permanecen en personas, instituciones o sistemas externos. El software
// materializa definiciones, ejecución, información, autorización y trazabilidad;
// la institución conserva la potestad de definir procedimientos, competencias y
// políticas, y los proveedores externos conservan sus propias obligaciones.

- El sistema deberá exponer una interfaz de tipo REST API: El software deberá implementar una capa http con sus funciones principales. Además, deberá brindar una vista con las especificaciones de la API.
- Interfaces para la autenticación: El software deberá tener un módulo de autenticación conectado al servicio externo de identidad.
- CLI básico: El software deberá envolver sus distintas funcionalidades en un selector de funciones y deberá tener un módulo de configuración con lectura de variables de entorno.
- Interfaz gráfica para el administrador institucional y los participantes del trámite: El software deberá exponer una interfaz gráfica GUI, es decir, un frontend.
- Interfaz para extensibilidad: El software deberá exponer una librería de código.

===== Interfaces de usuario

// Guía de redacción: especificar las interfaces y reglas generales para visitantes,
// ciudadanos, servidores públicos y administradores. Considerar catálogo público,
// inicio y seguimiento de casos, bandeja de tareas, gestión de definiciones,
// retroalimentación de operaciones, lenguaje del dominio y accesibilidad.

- El software deberá brindar las siguientes vistas al usuario:
  - Vista pública con listado de trámites y acción de ingreso al sistema.
  - Vista pública de detalle de cada trámite.
  - Aplicación del participante de flujos de trámite.
    - Bandeja de notificación de tareas.
    - Acceso al catálogo de trámites.
    - Listado de historial de casos ejecutados.
    - Mapa del caso de trámite en ejecución.
    - Pantalla de ejecución de paso de trámite.
  - Aplicación de administración institucional.
    - Vista del gestor de trámites y procesos.
    - Vista del gestor de usuarios y roles.
    - Vista del gestor de llaves de acceso.
    - Vista del gestor institucional.

===== Interfaces de hardware

// Guía de redacción: indicar que Tunkunia no requiere interfaces directas con
// hardware específico; el navegador y el proceso servidor se ejecutan sobre
// equipos de propósito general.
//
- El software deberá correr en servidores del gobierno boliviano.
- La interfaz de usuario deberá correr en dispositivos móviles y computadoras de escritorio.

===== Interfaces de software

// Guía de redacción: especificar dependencias e interfaces con navegador,
// persistencia, proveedor de identidad, servicios gubernamentales y consumidores
// autorizados. Distinguir una dependencia necesaria de la tecnología concreta
// elegida por la implementación actual.

- En el servidor, el software deberá ejecutarse en el sistema operativo Linux. Este es el sistema operativo que suelen tener los servidores del gobierno boliviano.
- La interfaz de usuario deberá ejecutarse en un navegador web para garantizar mayor accesibilidad.
- El software empleará un sistema de gestión de bases de datos.
- El software podrá hacer uso de librerías y herramientas que faciliten el desarrollo.
- El software interactuará con un servidor http.
- El software podrá usar herramientas auxiliares para simular funcionalidades aún no accesibles.

===== Interfaces de comunicación

// Guía de redacción: especificar protocolos, formatos, versionado, autenticación,
// autorización, manejo de errores y protección de datos para comunicaciones
// internas y externas. Favorecer estándares abiertos y contratos documentados.
- El software deberá usar el protocolo HTTP.

===== Restricciones de memoria

// Guía de redacción: registrar límites de memoria del servidor o de los
// dispositivos cliente solo cuando el entorno objetivo permita establecer valores
// verificables. No convertir la expectativa general de eficiencia en una cifra
// arbitraria.
- El software no debe superar en el servidor los 200 MB de uso de RAM en estado de espera.

===== Adaptación a la institución o entorno

// Guía de redacción: definir
Estos deben ser los datos y opciones que permiten adaptar Tunkunia a instituciones diferentes sin modificar su código:
- Identidad institucional
- Catálogo de Trámites
- Usuarios Registrados

Cada instancia del sistema deberá servir para una institución. No podrán usar la misma instancia dos instituciones y no se contempla en el prototipo que puedan ejecutarse múltiples instancias para una sola institución con el mismo grupo de trámites.
// canales, políticas y otros parámetros justificados.

===== Interfaces con servicios

// Guía de redacción: especificar las interacciones con Ciudadanía Digital, gob.bo,
// correo y otros servicios externos o simulados. Cada integración debería aislarse
// mediante un contrato configurable, aplicar autorización de mínimo alcance y
// registrar eventos relevantes; una falla de entrega no demuestra que la
// actuación principal no ocurrió.

- El software deberá interactuar con Ciudadanía Digital

==== Limitaciones

// Guía de redacción: registrar restricciones regulatorias, técnicas,
// institucionales y operativas aplicables al producto. Tunkunia se orienta a
// instituciones públicas bolivianas, utiliza estándares abiertos y se distribuye
// como software libre. No se define por un lenguaje, base de datos, interfaz
// visual, topología o mecanismo único de instalación.

- El acceso al servicio de identidad de ciudadanía digital está restringido solo a instituciones públicas. Es decir, en el prototipo desarrollado en este proyecto, no se podrá acceder al mismo.

//===== Base de datos lógica

// Guía de redacción: definir información, relaciones, integridad, acceso,
// confidencialidad, auditoría, retención, respaldo y recuperación sin prescribir
// innecesariamente el diseño físico. Distinguir definiciones y versiones de
// trámite, casos, participantes, acciones, tareas, formularios, documentos,
// expedientes, notificaciones y registros de auditoría.

//===== Restricciones de diseño

// Guía de redacción: registrar únicamente decisiones impuestas externamente o
// indispensables para satisfacer el producto. Tecnologías presentes en el
// repositorio, como Go, Nuxt, SQLite, REST o redes de Petri, deben justificarse en
// arquitectura y diseño si no constituyen una restricción del requerimiento.

