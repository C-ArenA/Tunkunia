#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, typ-fig

= Introducción

Siguiendo las tendencias tecnológicas, el gobierno de Bolivia busca utilizar las tecnologías de la información para modernizar el estado y sus procedimientos. Esta iniciativa, que esta presente al menos desde la promulgación de la Ley Nº 164 de Telecomunicaciones, Tecnologías de Información y Comunicación del año 2011@Ley164Ley2011, tuvo claros intentos de puesta en ejecución, en algunos casos de forma exitosa, pero en muchos más sin logros significativos y esto sin contar los escenarios en los cuales no se hizo aún ningún esfuerzo.

Por supuesto, un tipo de procedimiento que se busca digitalizar constantemente es el conocido como trámite. Esto no es una sorpresa ya que, como puede verse justificado en el perfil del proyecto al cual se suscribe este documento, los trámites son ubicuos en la comunicación entre el gobierno y su población. Además, existen claras ventajas económicas y en contra de la corrupción cuando los mismos se digitalizan@rosethFinTramiteEterno2018.

Sin embargo, la cantidad de trámites que puede llegar a tener el estado en sus diferentes instituciones, representa un desafío en la digitalización de todos ellos. No sólo por la cantidad, sino además por la difícil estandarización y control en cada uno de ellos. Un avance importante, en el último año antes de la publicación de este documento, es la creación del portal gob.bo que aglutina en forma de catálogo o directorio una gran cantidad de los trámites del gobierno boliviano. Según sus estadísticas, tiene publicados alrededor de 1250 trámites, de los cuales sólo 274 estarían digitalizados@PortalGobbo, es decir, el 22% tras haber transcurrido cerca de 15 años a partir de la Ley Nº 164 y cerca de 9 a partir de la implementación del Plan de Implementación de Gobierno Electrónico mediante Decreto Supremo 3251@DecretoSupremoNo2017.

Una inspección rápida parece indicar que incluso los trámites que se señalan como digitalizados carecen de una implementación correcta y que, en general, cada uno se realiza de forma independiente sin seguir ningún estándar. Además, la ejecución de los proyectos de digitalización pueden tener una gran complejidad y representar costos importantes para las instituciones, sin contar que los trámites pueden cambiar, pueden desaparecer o pueden crearse, obligando a una constante manipulación de los mismos por parte de las instituciones.

Los esfuerzos alrededor de la implementación de trámites digitales parecen repetir ciertos patrones que pueden ser reutilizados. Si bien existen modelos generales para flujos de trabajo, aún podrían identificarse características similares en procedimientos de tipo trámite que puedan aportar en futuros desarrollos de sistemas alrededor de ellos.

En esta investigación se trata de encontrar, usando un método inductivo, las similitudes que pueden existir entre distintos trámites y un modelo general del trámite que no sea tan amplio como los modelos de procesos como BPMN o Petri Nets, pero que se base en estos para resultar en una perspectiva especializada en los procedimientos de trámites en Bolivia.

= Metodología

Para lograr identificar patrones en el proceso y en las tareas involucradas en un trámite, se sigue principalmente un enfoque *inductivo* que permita modelar un número limitado de casos de trámites en Bolivia para buscar a partir de los diferentes casos generalizar características similares.

Los candidatos a estudio son todos los trámites registrados en las siguientes fuentes:

- Plataforma gob.bo de la AGETIC
- Procedimientos descritos en el RASIM
- Portales gubernamentales
- Normativa con descripción de trámites

Para elegir los casos de trámites a modelar se busca cubrir un amplio espectro de situaciones, por lo que se parte de la clasificación en cuatro categorías generales de los trámites de Roseth@rosethFinTramiteEterno2018 y grupos o categorías particulares adicionales que puedan enriquecer el análisis posterior:

- Trámites de registro, certificaciones y constancias
- Trámites de sólo certificaciones y constancias
- Trámites para cumplir con obligaciones
- Trámites para acceder a servicios
- Trámites para obtener permisos
- Trámites simplificados
- Trámites complejos (múltiples etapas)

Cada trámite se deberá definir en función a los siguientes parámetros:
- Datos requeridos por la plataforma gob.bo para el registro de nuevos trámites
- Análisis sobre rasgos y características particulares del trámite
- Modelado de procecos

Dado el enfoque en gestión de flujos de trabajo, se deben también considerar de manera prioritaria que lo anterior tenga relación con las dimensiones del flujo de trabajo según Van Der Aalst@vanderaalstAPPLICATIONPETRINETS1998, como se puede ver exn la @fig:vanderaals3dwf

#typ-fig(
  include "/assets/figures/vanderaals3dwf.typ",
  [Abstracción en 3 dimensiones de los flujos de trabajo según Van Der Aalst],
  <fig:vanderaals3dwf>,
)

De este modo, los datos a relevar para cada trámite son:

- Dimensión de casos:
  - Nombre del trámite
  - Descripción
  - Marco Legal
  - Tipo de Trámite
  - Características Resaltantes
- Dimensión de recursos:
  - Involucrados
  - Dependencias
- Dimensión de Proceso
  - Desencadenante
  - Modelado con BPMN
  - Modelado con Redes de Petri
  - Modelado alternativo
  - Tareas Identificadas

= Resultados

== Trámites Analizados
En función a la metodología se hace la selección de los siguientes trámites:

- Trámite de Registro: Registro Ambiental Industrial
- Trámite de Certificación o Constancia: Patente SENAPI
- Trámite para cumplir con obligaciones: Renovación RAI
- Trámite para acceder a servicios: Adscripción al SUS
- Trámite para obtener permisos: Licencia para conducir
- Trámite simplificado: Cédula de Identidad
- Trámite complejo: Inscripción de división y partición DDRR

=== Cédula de Identidad

- *Nombre:* Trámite para obtener Cédula de Identidad por Primera Vez.
- *Descripción*: Trámite esencial para el ciudadano boliviano, para ingresar al Registro Único de Identificación.
- *Marco Legal*: DS 4861, DS 4342
- *Tipo de Trámite*: Trámite de Registro y Certificación
- *Características Resaltantes*:
  - La normativa existente alrededor de este trámite solamente especifica los objetivos del trámite y no el trámite en sí mismo dejando esto a criterio de la institución. Este es un antecedente importante para otros trámites que no pueden ser simplificados debido al andamiaje legal que los aprisionan.
  - Para comunicar al ciudadano, se divide el trámite en dos, uno para menores de edad y otro para mayores de edad. Sin embargo, para enriquecer este análisis se consideran ambos como parte del mismo trámite.
- *Involucrados*:
  - Funcionario del SEGIP
  - Ciudadano que desea obtener su Cédula
  - Tercero encargado en caso de que el ciudadano sea menor de edad
- *Dependencias*:
  - SERECI: Certificado de Nacimiento y otros
  - Entidad Bancaria: Pagos
- *Desencadenante*: Ciudadano con intención de obtener su cédula de identidad
- *Modelos*: Se modeló el trámite usando una Red de Petri de tipo WFNet como se puede ver en la @fig:ci_wfnet.

#img-fig(
  "/assets/figures/ci_wfnet.png",
  [Red de Petri para Trámite de Obtención de Cédula de Identidad],
  <fig:ci_wfnet>,
  width: 80%,
)

=== Trámite: Solicitud de Patente SENAPI

- *Características Resaltantes*:
  - Respaldado por la Decisión 486 de La Comisión de la Comunidad Andina en sus capítulos III y IV
  - Se detallan características de los plazos: días hábiles
  - Existen condiciones claras para el inicio de la solicitud: Condiciones de sí o no
  - Existen requisitos obligatorios cuya ausencia imposibilita el inicio del trámite (Artículo 33)
  - La solicitud debe contener:
    - 1 comprobante de pago (g)
    - 1 elemento de texto plano (e)
    - 2 formularios (a, b)
    - 1 colección de elementos de texto plano (c)
    - 1 colección de elementos multimedia (d)
    - 3 copias de documentos existentes (h,i,k)
    - 1 colección de documentos originales de certificación existente (f, j)
  - Existen requisitos opcionales que sólo son necesarios si se cumplen otras condiciones. Esto sugiere que pueden pertenecer a otras subetapas
  - El trámite inicia con la presentación de requisitos de solicitud. Es decir, cuando el solicitante lo desee
  - El trámite parece ser de tipo servicio
  - El solicitante puede modificar su información de solicitud durante el trámite e incluso la naturaleza del trámite. Esto sugiere un cambio de trámite (mismo caso o diferente caso) que pueda heredar información del anterior.
  - Existe una etapa de examen de documentos
  - Existe un plazo de 30 días para examinar la solicitud
  - Existe una etapa de reparación de solicitud con plazo de 2 meses
  - La etapa de reparación de solicitud tiene un número máximo de retries
  - La "oficina" debe notificar al "solicitante" cada decisión
  - Tras cumplir el primer examen de forma, se publican los resultados y sólo entonces se pasa a una segunda ronda de examen de patentabilidad
  - El segundo examen debe ser inicializado por el solicitante
  - Actores externos pueden influir con oposiciones a la solicitud de patentado
  - Tras el segundo examen se toma una decisión que se convierte en un título de patente (un certificado)
  - Al conjunto de información que se va recolectando se le llama expediente, similar a como se hace en juzgados

#typ-fig(
  diagram(
    spacing: (4mm, 10mm),
    node-stroke: luma(80%),
    node((0, 0), [Solicitud]),
    edge("->"),
    node((0, 1), [Examen\ de Forma]),
    edge("->"),
    node((1, 0), [Publicación]),
    edge("->"),
    node((1, 1), [Espera de\ Oposiciones]),
    edge("->"),
    node((2, 0), [Examen de\ Patentabilidad]),
    edge("->"),
    node((2, 1), [Otorgación o\ Denegatoria]),
  ),
  [Etapas del trámite de solicitud de patente en el SENAPI],
  <fig:senapiblocks>,
  placement: auto,
)

=== Documento de Identidad

== Similitudes

Se identifican similitudes en los siguientes niveles:
- Casos
- Recursos (Actores)
- Procedimiento o Flujo
- Actividades del Proceso
- Modelo General del Trámite

== Definición del Trámite

= Discusión
Este modelo podrá ayudar a implementar trámites y digitalizarlos de forma especializada o incluso servir como generalización para sistemas genéricos de trámites
Ignoramos trámites en otros países, pero pueden ser muy similares

= Conclusión
Se tiene modelado el trámite para casos específicos. Hace un tiempo los pagos digitales no eran una posibilidad y ahora lo son, por lo que se debe estar atento a cómo evolucionan los trámites, lo cual podría tener implicación en los hallazgos de esta investigación
