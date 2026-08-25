#import "/shared/theme/lib.typ": img-fig

== Arquitectura y diseño del software

Este capítulo describe la arquitectura prevista para el prototipo funcional de
Tunkunia. La descripción se concentra en las decisiones que condicionan su
construcción y en el diseño del núcleo de trámites; el grado en que estas
decisiones se materializaron se evalúa posteriormente en el capítulo de
implementación. Se usan diagramas C4 @brownC4Model y UML @uml251 cuando permiten explicar con mayor claridad el contexto, la estructura o una
interacción relevante.

=== Decisiones rectoras

Tunkunia se diseña como una *aplicación configurable*: cada institución adopta
el mismo producto, despliega su propia instancia y define en ella sus trámites,
participantes y datos institucionales. Esta forma de reutilización evita crear
una aplicación independiente para cada procedimiento y mantiene un núcleo común
para la definición, ejecución y seguimiento de casos. La instancia atiende a una
sola institución; la separación entre instituciones ocurre mediante despliegues
independientes y no mediante multitenencia dentro de una misma base de datos.

La solución adopta un *monolito modular*. Sus capacidades se ejecutan en un mismo
proceso y se despliegan como una unidad, pero cada módulo conserva su lenguaje de
dominio, sus servicios y sus datos. Las dependencias cruzan los límites mediante
interfaces o tipos públicos deliberados; los modelos de persistencia y los
detalles de transporte permanecen encapsulados. La comunicación interna se
realiza mediante llamadas directas, pues un bus de eventos, un intermediario de
mensajes o servicios distribuidos añadirían complejidad que el prototipo no
necesita.

El motor formal se denomina *Petrunia* y constituye una excepción intencional a
los módulos internos. Se diseña como un paquete Go público, ubicado fuera de
`internal`, que recibe una red, un marcado y una transición y devuelve el nuevo
marcado o un error de dominio. Petrunia no conoce usuarios, expedientes,
persistencia, HTTP ni reglas institucionales. Esta independencia permite probar
el motor de forma aislada y deja abierta su extracción futura sin convertir a
Tunkunia en una biblioteca.

Las demás decisiones estructurales responden al carácter demostrativo del
producto: una sola unidad desplegable, persistencia local, integraciones
estatales o institucionales simuladas cuando requieren permisos externos y un
consumo base reducido. Se priorizan la trazabilidad y la corrección de cada caso
por encima del escalamiento horizontal. Las definiciones publicadas, los casos,
los expedientes y la auditoría no se eliminan físicamente; se archivan o
inhabilitan para preservar las relaciones históricas.

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
