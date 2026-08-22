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

=== Especificación de Requerimientos del Software: Servidor

A partir de la estructura recomendada por el ISO 29148, a continuación se presenta la especificación de requerimientos del primer elemento de software que nace a partir de una primera iteración en el diseño a partir de los requerimientos del sistema y que en adelante llamaremos servidor.

=== Especificación de Requerimientos del Software: Aplicación

A partir de la estructura recomendada por el ISO 29148, a continuación se presenta la especificación de requerimientos del segundo elemento de software que nace a partir de una primera iteración en el diseño a partir de los requerimientos del sistema y que en adelante llamaremos aplicación.
