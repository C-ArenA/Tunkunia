#import "@preview/acrostiche:0.5.1": acr

= Alcance

Para comprender el alcance de este proyecto se debe considerar que, cuando se habla de un _subsistema reutilizable_, se habla de capacidad de integración en sistemas más grandes, pero a la vez de cierto funcionamiento independiente, en este caso como un sistema de gestión de trámites en sí mismo. Por otro lado, al ser reutilizable, se hace referencia a que puede configurarse, modificarse o extenderse como se haría con un marco de trabajo o framework de desarrollo. Esta dualidad entre subsistema y marco de trabajo, se debe a que este elemento de software busca ser empleado por otros desarrolladores de sistemas de software, pero a la vez, aunque en menor medida, por usuarios finales#footnote[Cuando se habla de usuarios finales en este contexto, se hace referencia a usuarios sin conocimiento de desarrollo de software, es decir, todos aquellos que emplean el sistema desde una GUI simplificada que requiera poco entrenamiento para ser utilizada]. Un ejemplo popular de este paradigma es la plataforma de Wordpress, un content management system (CMS) que permite a usuarios finales crear sus propios sitios web, pero que a la vez permite a desarrolladores extender su funcionalidad o configurar los sitios con mayor libertad siguiendo lineamientos establecidos por la plataforma. En este caso, Wordpress podría ser considerado un framework o marco de trabajo de desarrollo, pero su tarea principal es la de crear y gestionar contenidos en forma de sitios web, por lo que se le suele llamar CMS. Otro ejemplo más cercano, aunque menos popular, es Odoo, que se encuentra descrito en la @section:related_work. De forma similar a estos ejemplos, a este proyecto se le llama entonces _subsitema reutilizable de gestión de flujos de trámite_, tomando en cuenta el objetivo final del sistema.

En este sentido, la pieza de software esperada de este proyecto no contempla un trámite completo de ningún tipo, sino que buscará sentar las bases para la posterior implementación de uno o más de estos. Sin embargo, como se listó en los objetivos específicos, se aplicará en situaciones reales de trámites como parte de este proyecto, aunque únicamente a manera de ejemplo. Adicionalmente, si bien se espera promocionar el uso de este sistema en instancias públicas, no se garantiza su uso efectivo en ninguna de estas durante el transcurso de este proyecto, debido a la carga burocrática que eso representaría.

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

Se elegirán tecnologías web modernas de desarrollo con documentación adecuada para que los usuarios finales puedan emplear el sistema fácilmente y que futuros contribuidores no tengan problemas en modificarlo, tanto en apariencia como en funcionalidad. En cuanto a la distribución del elemento reutilizable se empleará la plataforma GitHub y adicionalmente, en caso de ser conveniente para la reutilizaación, algún distribuidor de paquetes adecuado, de acuerdo a la tecnología utilizada. Asimismo, es importante notar que no se partirá desde cero en esta implementación y se pretende reutilizar código para facilitar el desarrollo de este proyecto. Es decir, se seguirá el mismo principio de reutilización que se pretende promover.

Para modelar el proceso del trámite se emplearán los trámites definidos por el #acr("RASIM"), dado que este proyecto fue inspirado en el #acr("SIAI"), aunque no se descarta el uso de otros casos para enriquecer el modelado. En caso de existir particularidades del trámite que no sean identificables mediante dicho reglamento, no se contemplarán en la versión entregada al finalizar este proyecto. Sin embargo, se buscará hacer un análisis de estos casos en las recomendaciones finales del proyecto para guiar versiones futuras.

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
- Para garantizar la creación de una comunidad colaborativa mínima alrededor del proyecto, se recibirá al menos un "pull request" en el repositorio para demostrar las bondades del software libre y se atenderá al menos un "issue" reportado.
- La funcionalidad de Ciudadanía Digital y otras que tengan que ver con instancias del estado no se implementarán necesariamente de forma completa, sino conceptual, debido a que dependen del aparato burocrático estatal, que debe brindar permisos para su utilización. Sin embargo, se emplearán servicios similares o simulados que aproximen el funcionamiento de estas plataformas y su integración, en base a la documentación facilitada en línea por la AGETIC.
- No se pretende profundizar en aspectos de eficiencia y escalabilidad, debido a que se implementará un producto mínimo viable y las optimizaciones se dejan a versiones futuras, posteriores a la ejecución de este proyecto.
- El funcionamiento del subsistema como sistema independiente para la gestión de trámites recién instalado será limitado en configuración y personalización, por lo que modificaciones específicas en el proceso del trámite pueden requerir intervención empleando algún lenguaje de programación. Esto representa un caso de uso esperado por el sistema, por lo que estas intervenciones deberán seguir los lineamientos del subsistema como marco de trabajo, mismos que estarán detallados en la documentación.

