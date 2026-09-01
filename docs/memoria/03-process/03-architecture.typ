#import "/shared/theme/lib.typ": img-fig

== Descripción de arquitectura

Este capítulo describe la arquitectura de Tunkunia siguiendo un enfoque de vistas y puntos de vista como recomienda el ISO 42010@iso42010ArchitectureDescription2022.
Asimismo se organiza a partir de un marco de descripción de arquitectura de software (ADF) mencionado en un anexo del mismo estándar, conocido como el "4+1" de Kruchten@kruchtenArchitecturalBlueprints1995.

=== Alcance

La arquitectura propuesta tiene como alcance la primera versión del sistema Tunkunia, es decir un prototipo funcional evolutivo, en consideración a los requerimientos y las restricciones del proyecto así como necesidades posteriores del mismo.
Comprende un sistema reutilizable de baja complejidad operacional pensando en la rápida validación y potencial adopción.

=== Arquitectura General

Considerado el alcance de la arquitectura, correspondiente a un prototipo
funcional evolutivo, se optó por una arquitectura monolítica. Esta
decisión responde a los requerimientos del proyecto y a la necesidad de
facilitar su instalación y despliegue en entornos institucionales diversos, a
la vez que evita la complejidad operativa propia de las arquitecturas
distribuidas. En particular, la posibilidad de distribuir el sistema como un
único binario reduce la cantidad de componentes que cada institución debe
instalar, configurar y mantener.

Si bien las arquitecturas distribuidas pueden proporcionar una mayor
escalabilidad, esta no representa un problema inmediato para el proyecto. Un
monolito constituye un buen punto de partida y, siempre que esté estructurado
correctamente, puede evolucionar hacia una arquitectura distribuida si llegara
a ser necesario.

Además, se parte de la hipótesis de que la carga de la mayoría de los trámites
estará acotada por su población destinataria y por los periodos en los que se
realizan. Muchos procedimientos corresponden a grupos específicos de ciudadanos
o empresas y no se solicitan de manera continua; por tanto, no se espera que
todos los trámites sean realizados por toda la población boliviana de forma
simultánea. Esta hipótesis deberá comprobarse mediante mediciones durante la
evolución del sistema, pero permite evitar desde el inicio una distribución que
la demanda observada todavía no justifica. En un subsistema reutilizable, que espera cargas variadas, es difícil determinar las necesidades exactas de demanda.

#img-fig(
  "/assets/figures/modulegraph.png",
  [Arquitectura Inicial y Entorno de Tunkunia],
  <fig:modulegraph>,
  placement: bottom,
)

También debe considerarse que una arquitectura distribuida incrementaría los
recursos necesarios para el despliegue y la operación. De acuerdo con los
requerimientos de negocio, el sistema debe poder instalarse en infraestructura
administrada por distintas instituciones del Estado, cuyas capacidades y
prácticas operativas pueden variar. Por ello, resulta conveniente utilizar de
manera eficiente los recursos disponibles y reducir la cantidad de componentes
que deben administrarse, sin presuponer que todas las instituciones cuentan con
la misma infraestructura o las mismas herramientas de despliegue.

Otra restricción importante a nivel de proyecto es que el desarrollo y la implementación de este
primer prototipo están a cargo de una sola persona. En estas condiciones, elegir
un sistema distribuido añadiría una complejidad difícil de justificar.

Los requerimientos y las restricciones anteriores confirman que la primera
aproximación planteada al inicio del proyecto continúa siendo adecuada
(@fig:modulegraph).

Desde un punto de vista más general, se elige una arquitectura cliente-servidor
basada en tecnologías web. Esta elección responde al requerimiento de que el
sistema sea accesible para la mayor cantidad posible de ciudadanos y pueda
utilizarse en distintos dispositivos sin necesidad de instalaciones.

Para que el sistema pueda evolucionar y responder a cambios futuros, el
monolito propuesto debe organizarse de manera modular.

En consecuencia, Tunkunia adopta un enfoque semejante al de la arquitectura orientada a
servicios (@fig:soa_topo), pero sin establecer fronteras de despliegue independientes y
compartiendo la interfaz de usuario y la base de datos. En otras palabras, podemos definir que:

#rect()[
  Tunkunia es un monolito orientado a servicios#footnote[A veces nos referimos a él como monolito modular, un término usado en la industria] con arquitectura cliente-servidor,
  como se muestra en la @fig:soa_monolith.
]

#img-fig(
  "/assets/figures/soa_monolith.svg",
  [Arquitectura General de Tunkunia],
  <fig:soa_monolith>,
  placement: bottom,
)

=== Metas y Restricciones de la Arquitectura

Tunkunia se diseña como una *aplicación configurable*: cada institución adopta
el mismo producto, despliega su propia instancia y define en ella sus trámites,
participantes y datos institucionales.
Esta forma de reutilización evita crear
una aplicación independiente para cada procedimiento y mantiene un núcleo común
para la definición, ejecución y seguimiento de casos.
La instancia atiende a una
sola institución; la separación entre instituciones ocurre mediante despliegues
independientes y no mediante multitenencia dentro de una misma base de datos.

La solución adopta un *monolito orientado a servicios*.
Sus capacidades se ejecutan en un mismo
proceso y se despliegan como una unidad, pero cada módulo conserva su lenguaje de
dominio, sus servicios y sus datos.
Las dependencias cruzan los límites mediante
interfaces o tipos públicos deliberados; los modelos de persistencia y los
detalles de transporte permanecen encapsulados.
La comunicación interna se
realiza mediante llamadas directas, pues un bus de eventos, un intermediario de
mensajes o servicios distribuidos añadirían complejidad que el primer prototipo no necesita.

Se distingue un módulo importante denominado *Petrunia* que es público y sirve como motor de ejecución de Redes de Petri reutilizable.
Petrunia no conoce usuarios, expedientes,
persistencia, HTTP ni reglas institucionales.
Esta independencia permite probar
el motor de forma aislada y deja abierta su extracción futura sin convertir a
Tunkunia en una biblioteca.

Cada módulo adopta una arquitectura hexagonal como primera opción, pero en casos triviales como módulos CRUD, se consideran arquitecturas internas de capas.

=== Contexto del sistema y Escenarios

El contexto de Tunkunia se resume en la @fig:tunkunia-c4-system-context.
Un
visitante consulta el catálogo sin autenticarse.
Después del ingreso, una misma
persona puede actuar como ciudadana o servidora pública según el recurso que
ocupe en un caso.
El administrador institucional configura la instancia y
publica trámites, mientras que el operador técnico se ocupa del despliegue y el
respaldo.
Ciudadanía Digital proporciona la identidad, gob.bo recibe la
información del catálogo por medio de un reporte y los demás sistemas se
representan mediante interfaces controladas.

#img-fig(
  "/assets/figures/tunkunia-c4-system-context.svg",
  [Contexto del sistema Tunkunia],
  <fig:tunkunia-c4-system-context>,
  width: 100%,
)

=== Vista lógica

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

El módulo Casos ocupa el centro de la colaboración.
Obtiene de Catálogo la
versión inmutable aplicable, solicita a Petrunia la evaluación formal del
marcado, consulta a Usuarios las asignaciones y registra auditoría y avisos.

=== Vista de desarrollo

La vista de desarrollo refleja principalmente la vista lógica y no aporta mayor información sobre la arquitectura.

=== Vista de procesos

En tiempo de ejecución, las capacidades del servidor operan dentro de un único
proceso Go, sin permitir múltiples instancias.

#img-fig(
  "/assets/figures/tunkunia-deployment.svg",
  [Despliegue de una instancia de Tunkunia],
  <fig:tunkunia-deployment>,
  width: 100%,
  placement: top,
)

=== Vista física

La topología prevista utiliza un servidor Linux.
Un proxy inverso termina HTTPS
y reenvía las solicitudes al proceso Go.
El mismo binario sirve la API y
la aplicación Nuxt generada como archivos estáticos, por lo que navegador y
servidor comparten un origen.
Un volumen persistente contiene el archivo SQLite
y el directorio de documentos; el proveedor OIDC permanece fuera de la
instancia.
Las direcciones, rutas, credenciales y secretos se suministran
mediante variables de entorno.
Los datos administrables —identidad visual,
información institucional, usuarios y trámites— se almacenan y modifican desde
la aplicación.

El respaldo es responsabilidad del operador y debe capturar de manera
consistente tanto SQLite como el directorio documental, porque ambos forman una
sola unidad lógica de información.
