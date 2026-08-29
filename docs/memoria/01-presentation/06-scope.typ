=== Alcance

Para comprender el alcance de este proyecto se debe considerar que, cuando se habla de un _subsistema reutilizable_, se habla de capacidad de integración en sistemas más grandes, pero a la vez de cierto funcionamiento independiente, en este caso como un sistema de gestión de trámites en sí mismo.
En este proyecto se entiende como producto mínimo viable (MVP) a un prototipo funcional de carácter académico y demostrativo.
Para delimitar el proyecto, su reutilización se entiende según el enfoque de las aplicaciones configurables descrito por Sommerville @sommervilleSoftwareEngineering2016: una misma aplicación se diseña para ser adoptada por distintos clientes y ajustada a sus necesidades mediante configuración.
Por tanto, una institución reutiliza Tunkunia cuando adopta el subsistema y configura en él sus propios flujos de trámite, sin requerir un desarrollo independiente para cada procedimiento.
Tunkunia no se plantea como una librería que deba incorporarse a otro programa.
En el prototipo la interoperabilidad, la extensibilidad y la disponibilidad del código fuente son propiedades complementarias que amplían sus posibilidades de adopción y se alinean con normativa relevante, pero no se emplean como significados alternativos de la reutilización ni como condiciones necesarias para demostrarla en este proyecto.

La denominación de las piezas modulares depende de la organización o persona que la emplee.
Ingeno @ingenoSoftwareArchitectsHandbook2018 las clasifica en seis categorías: una *estructura* es la agrupación e interrelación entre elementos; *elemento* es el término genérico para cualquiera de estas piezas; *sistema* representa el proyecto completo y el mayor nivel de abstracción; *subsistema* es en sí mismo un sistema que forma parte de otro mayor con cierto nivel de independencia y que puede contener otros subsistemas; *módulo* es una parte de un sistema enfocada en un área lógica específica de responsabilidad; y *componente* es el nivel más pequeño de agrupación y de menor abstracción.
Estos términos pueden ser intercambiables ante la falta de definiciones universales.
El sistema propuesto cumple con esta definición de subsistema, ya que es un sistema en sí mismo, pero busca formar parte de un sistema mayor que es el sistema de gobierno electrónico de Bolivia.

Un antecedente para la elección del término es el Sistema Integrado Nacional del Espectro Radioeléctrico (SINER), licitado para la Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes @GobiernoLanzaSegunda2023.
Su documento base de contratación define dos componentes de software como subsistemas por formar parte de un sistema mayor, aunque pueden utilizarse parcialmente de forma independiente.
Este uso inspira la categorización del producto propuesto como subsistema.

Ahora bien, es menester precisar que el prototipo no constituye la implementación de un trámite institucional concreto, sino el sistema sobre el cual pueden definirse y ejecutarse distintos trámites.
Aún así, el prototipo se aplicará a casos representativos y permitirá definirlos en un entorno controlado, sin afirmar que estos se encuentran listos para su operación real en producción.
Adicionalmente, si bien se espera promocionar el uso de este sistema en instancias públicas, no se garantiza su uso efectivo en ninguna de estas durante el transcurso de este proyecto, debido a la carga burocrática que eso representaría.

Las pruebas al prototipo deben cumplir con los requerimientos desarrollados y con la definición de distintos trámites como procesos en un sistema de gestión de flujos de trabajo.
Es decir, la digitalización de un trámite dentro del prototipo abarcará su dimensión como un proceso y el entorno básico que un trámite digitalizado suele tener en un sistema de trámites:

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

Para modelar el proceso se emplearán casos representativos de diferentes tipos de trámite seleccionados en la investigación correspondiente.
Entre ellos se incluyen procedimientos derivados del @RASIM, como antecedente directo del proyecto, y trámites pertenecientes a otros dominios, con el propósito de identificar estructuras comunes sin suponer que el modelo abarcará todas las particularidades posibles.

El trámite se formalizará como un proceso mediante técnicas de modelado apropiadas para representar estados, acciones, participantes y decisiones.
La selección y aplicación detallada de dichas técnicas se desarrolla en los capítulos de fundamentos, investigación y diseño.

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
