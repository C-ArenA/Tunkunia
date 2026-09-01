#import "/shared/theme/lib.typ": img-fig

== Descripción de arquitectura

Este capítulo describe la arquitectura de Tunkunia siguiendo un enfoque de vistas y puntos de vista como recomienda el ISO 42010@iso42010ArchitectureDescription2022. Asimismo se organiza a partir de un marco de descripción de arquitectura de software (ADF) mencionado en un anexo del mismo estándar, conocido como el "4+1" de Kruchten@kruchtenArchitecturalBlueprints1995.

=== Alcance

La arquitectura propuesta tiene como alcance la primera versión del sistema Tunkunia, es decir un prototipo funcional evolutivo, en consideración a los requerimientos y las restricciones del proyecto así como necesidades posteriores del mismo. Comprende un sistema reutilizable de baja complejidad operacional pensando en la rápida validación y potencial adopción.

=== Arquitectura General

Considerando el alcance de la arquitectura sobre un prototipo funcional evolutivo, se consideró de acuerdo a los requerimientos y entendiendo que los interesados principales desean la implementación pronta de este sistema, que el prototipo inicialmente contemple una arquitectura monolítica, es decir, evitando los problemas de las arquitecturas distribuidas. Si bien es entendido que las arquitecturas distribuidas pueden proporcionar mayor escalabilidad, esto no se considera un problema, ya que un monolito es siempre un buen punto de partida para cualquier sistema. Es decir, en tanto el monolito sea estructurado de manera correcta, la arquitectura puede evolucionar a arquitecturas distribuidas si fuese necesario. Adicionalmente es importante notar que una mayoría de trámites no requieren el uso excesivo de recursos, es decir, no todos los trámites son realizados por toda la población de Bolivia en todo en cada momento del año. De este modo, el sistema inicialmente no requiere ser distribuido. También hay que considerar que en sistemas distribuidos. También hay que considerar que en sistemas distribuidos el costo de despliegue puede llegar a ser elevado. Entendemos de acuerdo a los requerimientos de negocio que este sistema debe ser desplegado en servidores del estado, mismos que no necesariamente, y en todos los casos serán muchos ni tendrán la mayor eficiencia posible. También se debe considerar que una restricción importante del proyecto es que este primer prototipo es realizado por una sola persona en cuanto a su desarrollo e implementación, por lo que la elección de un sistema distribuido podría no ser la decisión más inteligente si se consideran estas restricciones.

#img-fig("/assets/figures/modulegraph.png", [Arquitectura Inicial y Entorno de Tunkunia], <fig:modulegraph>)

Si bien lo anterior describe los requerimientos y restricciones que llevaron a la solución se puede ver que la primera aproximación a la solución que se planteó cuando el proyecto se propuso por primera vez sigue siendo correcto (@fig:modulegraph).

Ahora bien, desde un punto de vista más general y considerando el requerimiento de que el sistema debe ser accesible for the mayor cantidad de ciudadanos possibles, y además de que este debe correr in distinto dispositivos sin necesidad de instalaciones, se elige una arquitectura cliente-servidor, aprovechando las tecnologías web que actualmente se han vuelto las más utilizadas por la gente.

Por supuesto, si se desea evolucionar este sistema y si se desea que el sistema pueda responder a cambios futuros, es necesario que el monolito antes propuesto sea modular.

Esto define nuestro sistema como un monolito con arquitectura cliente-servidor adoptando un enfoque modular parecido al del estilo de arquitectura por servicios, pero sin las fronteras de despliegue, compartiendo interfaz de usuario y base de datos. Algunos lo llaman monolito modular.

Monolito orientado a servicios con arquitectura cliente-servidor. Esto se ve reflejado en la @fig:soa_monolith que puede ser comparable con la @fig:soa_topo.

#img-fig("/assets/figures/soa_monolith.svg", [Arquitectura General de Tunkunia], <fig:soa_monolith>)

=== Metas y Restricciones de la Arquitectura

Tunkunia se diseña como una *aplicación configurable*: cada institución adopta
el mismo producto, despliega su propia instancia y define en ella sus trámites,
participantes y datos institucionales. Esta forma de reutilización evita crear
una aplicación independiente para cada procedimiento y mantiene un núcleo común
para la definición, ejecución y seguimiento de casos. La instancia atiende a una
sola institución; la separación entre instituciones ocurre mediante despliegues
independientes y no mediante multitenencia dentro de una misma base de datos.

La solución adopta un *monolito orientado a servicios*. Sus capacidades se ejecutan en un mismo
proceso y se despliegan como una unidad, pero cada módulo conserva su lenguaje de
dominio, sus servicios y sus datos. Las dependencias cruzan los límites mediante
interfaces o tipos públicos deliberados; los modelos de persistencia y los
detalles de transporte permanecen encapsulados. La comunicación interna se
realiza mediante llamadas directas, pues un bus de eventos, un intermediario de
mensajes o servicios distribuidos añadirían complejidad que el primer prototipo no necesita.

Se distingue un módulo importante denominado *Petrunia* que es público y sirve como motor de ejecución de Redes de Petri reutilizable. Petrunia no conoce usuarios, expedientes,
persistencia, HTTP ni reglas institucionales. Esta independencia permite probar
el motor de forma aislada y deja abierta su extracción futura sin convertir a
Tunkunia en una biblioteca.

Cada módulo adopta una arquitectura hexagonal como primera opción, pero en casos triviales como módulos CRUD, se puede considerar una arquitectura de capas.

=== Vista Lógica



=== Contexto, despliegue y módulos

El contexto de Tunkunia se resume en la @fig:tunkunia-c4-system-context. Un
visitante consulta el catálogo sin autenticarse. Después del ingreso, una misma
persona puede actuar como ciudadana o servidora pública según el recurso que
ocupe en un caso. El administrador institucional configura la instancia y
publica trámites, mientras que el operador técnico se ocupa del despliegue y el
respaldo. Ciudadanía Digital proporciona la identidad, gob.bo recibe la
información del catálogo por medio de un reporte y los demás sistemas se
representan mediante interfaces controladas.

#img-fig(
  "/assets/figures/tunkunia-c4-system-context.svg",
  [Contexto del sistema Tunkunia],
  <fig:tunkunia-c4-system-context>,
  width: 100%,
)

La topología prevista utiliza un servidor Linux. Un proxy inverso termina HTTPS
y reenvía las solicitudes a un único proceso Go. El mismo binario sirve la API y
la aplicación Nuxt generada como archivos estáticos, por lo que navegador y
servidor comparten un origen. Un volumen persistente contiene el archivo SQLite
y el directorio de documentos; el proveedor OIDC permanece fuera de la
instancia. Las direcciones, rutas, credenciales y secretos se suministran
mediante variables de entorno. Los datos administrables —identidad visual,
información institucional, usuarios y trámites— se almacenan y modifican desde
la aplicación.

Esta topología deliberadamente sencilla no proporciona alta disponibilidad ni
ejecución simultánea en varios nodos. Ante un reinicio, el proceso recupera los
vencimientos pendientes desde la base de datos. El respaldo es responsabilidad
del operador y debe capturar de manera consistente tanto SQLite como el
directorio documental, porque ambos forman una sola unidad lógica de
información.

La @fig:tunkunia-modules muestra la división del servidor por capacidades:

- *Institución* conserva la información propia de la instancia.
- *Catálogo* administra los trámites y las versiones de sus procesos.
- *Casos* inicia y ejecuta casos, mantiene sus asignaciones, marcado, expediente
  e historial, y coordina las operaciones que deben ocurrir juntas.
- *Usuarios* conserva las identidades locales, los grupos y los roles globales.
- *Autenticación* integra OIDC y establece la sesión local.
- *Notificaciones* mantiene la bandeja interna de avisos.
- *Interoperabilidad* genera el reporte para gob.bo, gestiona la demostración con
  claves API y abstrae la consulta simulada a sistemas externos.
- *Auditoría* conserva un registro transversal y de solo adición de las acciones
  relevantes.

#img-fig(
  "/assets/figures/tunkunia-modules.svg",
  [Módulos y dependencias principales de Tunkunia],
  <fig:tunkunia-modules>,
  width: 100%,
)

`cmd` y la composición de la API conectan estas capacidades sin contener reglas
del trámite. La carga de configuración también es infraestructura y no un módulo
de negocio: prepara los adaptadores concretos y entrega sus dependencias a los
módulos. Dentro de cada capacidad se separan el dominio, los servicios de
aplicación, los repositorios y la traducción HTTP. Ningún módulo accede de forma
directa a las tablas o implementaciones internas de otro.

El módulo Casos ocupa el centro de la colaboración. Obtiene de Catálogo la
versión inmutable aplicable, solicita a Petrunia la evaluación formal del
marcado, consulta a Usuarios las asignaciones y registra auditoría y avisos. Las
llamadas son síncronas y explícitas. Las interfaces hacia notificaciones y
sistemas externos permiten sustituir la implementación demostrativa más
adelante, pero no se introduce un sistema general de complementos ni webhooks en
el prototipo.
