#import "@preview/acrostiche:0.5.1": acr

== Normativa relevante vigente en Bolivia

Como se pudo ver en la sección de antecedentes, y de forma resumida en la @fig:bolivia_norms, Bolivia cuenta con una normativa bastante amplia en relación al uso de las #acr("TICs"), el gobierno electrónico, la digitalización de trámites y el desarrollo de software gubernamental. A continuación se presentan algunos elementos relevantes adicionales y, aunque no se pretende abarcar toda la normativa existente, dada su extensión, sí se desea poder atender a los aspectos más importantes como punto de partida.

=== Acerca del Trámite

Al respecto del trámite administrativo es menester citar al Decreto Supremo N° 3525 que tiene como uno de sus objetos normar la *tramitación digital* @DECRETOSUPREMO35252018. Si bien aún no se consigue poner en práctica la totalidad de dicha norma, podemos resaltar lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 12])[
  *Trámites Administrativos:*

  I. Las instituciones públicas *deberán priorizar en todos sus trámites el uso de tecnologías de información* y comunicación a efecto de digitalizar, automatizar, interoperar y simplificar la tramitación de los asuntos que son de su competencia.

  II. Para facilitar la realización de trámites a la ciudadanía, las entidades públicas, en observancia de su normativa específica, deberán *intercambiar entre ellas datos e información mediante interoperabilidad*. Los mecanismos y condiciones de publicación y acceso a los servicios de interoperabilidad serán establecidos por el Ente Rector de Gobierno Electrónico y Tecnologías de Información y Comunicación.

  III. El intercambio de datos e información mediante interoperabilidad no afectará la percepción de recursos de las entidades públicas titulares de la información por la prestación del servicio público.

  IV. Las entidades públicas *no podrán exigir* al administrado como requisito ningún documento que hubiera sido *emitido por la misma entidad*, o cuya información esté disponible mediante servicios de interoperabilidad de otra entidad.

  V. Las entidades públicas *no podrán exigir al administrado como requisito ningún documento que hubiera sido requerido con anterioridad*, salvo actualización o modificación y conforme a normativa legal vigente.

  VI. Las entidades públicas tendrán un plazo máximo de veinte (20) días hábiles a partir de la publicación de un nuevo servicio de interoperabilidad para adecuar sus procesos y procedimientos al mismo.
]

Lo anterior es muy importante, no sólo porque establece la obligación de digitalizar los trámites administrativos, sino también porque establece la interoperabilidad entre entidades públicas y la necesidad de resguardar la información de los administrados. Esto es clave para el funcionamiento del sistema propuesto en este proyecto, ya que se espera que el mismo pueda integrarse con otros sistemas de información y servicios de interoperabilidad.

Muchas veces, los trámites que se digitalizan cuentan con documentos físicos importantes, que deben también ser tomados en cuenta en el proceso de digitalización. En este sentido, el mismo Decreto Supremo N° 3525 establece lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 13])[
  *Entidades generadoras de información:*

  ...II. En el marco de procesos de actualización, certificación o emisión de copias legalizadas de documentos que aún se encuentren en formato físico, los datos e información pertinente consignados en los mismos deberán ser registrados en medios digitales que permitan ser publicados mediante servicios de interoperabilidad.]

Asimismo, la ley 2341 tiene como uno de sus objetos "Establecer las normas que regulan la actividad administrativa y el *procedimiento
administrativo* del sector público" @ley2341, por lo que contiene normativa relevante al proceso del trámite y a la ejecución de los mismos. Podemos resaltar su Artículo 4, de "Principios Generales de la Actividad Administrativa" que cuenta con dos principios importantes en nuestro contexto, que son el "Principio de eficacia" y el "Principio de economía, simplicidad y celeridad". También, en el mismo documento, se indican los derechos de las personas, que en su Artículo 16 lista, entre otros, los siguientes derechos:

- d) A conocer *el estado del procedimiento* en que sea parte
- j) A *obtener* certificados y copias de documentos que estén en poder de la Administración Pública
- k) A *acceder* a registros y archivos administrativos

Esta ley también define la acción correspondiente a los silencios administrativos y otras situaciones propias del proceso administrativo. Podemos resaltar finalmente lo siguiente:

#quote(attribution: [Ley 2341, Artículo 18])[
  ...Las personas tienen derecho a *acceder* a los archivos, registros públicos y a los documentos
  que obren en poder de la Administración Pública, así como a obtener certificados o copias
  legalizadas de tales documentos *cualquiera que sea la forma de expresión*, gráfica, sonora,
  en imagen u otras, o el tipo de soporte material en que figuren...
]

La anterior normativa es importante porque, si bien es general, establece condiciones que pueden fácilmente ser atendidas con el uso de un sistema de gestión y seguimiento de trámites digitalizado. Estas necesidades pueden traducirse en objetivos del sistema propuesto en este proyecto, como el de poder consultar el estado de un trámite o poder obtener copias de documentos que obren en poder de la administración pública.

=== Planes de Implementación

Si bien la Ley Nº 164 establece los fundamentos sobre el uso de las tecnologías de la información en Bolivia a nivel normativo, a su vez establece la creación de planes de implementación, con una naturaleza más práctica. Esto es establecido a partir de lo siguiente:

#quote(attribution: [Ley Nº 164, Artículo 75])[
  ...

  II. El Órgano Ejecutivo del nivel central del Estado, elaborará los lineamientos para la incorporación del Gobierno Electrónico
]

#quote(attribution: [Ley Nº 164, Artículo 71])[
  ...

  II. El Órgano Ejecutivo del nivel central del Estado, elaborará el plan de implementación de software libre y estándares
  abiertos en coordinación con los demás órganos del Estado y entidades de la administración pública.
]

Todo esto es nuevamente requerido en el reglamento aprobado por el Decreto Supremo 1793, que es el "Reglamento para el Desarrollo de Tecnologías de Información y comunicación", mismo que contiene definiciones y normativa importante para personas naturales o jurídicas, públicas o privadas que realicen actividades o presten servicios relacionados con la certificación digital, gobierno electrónico, software libre, correo electrónico y el uso de documentos y firmas digitales en el Estado Plurinacional de Bolivia. Este reglamento tiene bastante importancia para este proyecto, pero su contenido sigue la misma filosofía encontrada tanto en la Ley Nº 164 como en los planes de implementación.

Dado lo anterior es que, mediante Decreto Supremo 3251, se aprobaron el "Plan de Implementación de Gobierno Electrónico" y el "Plan de Implementación de Software Libre y Estándares Abiertos".

=== Implementación del Gobierno Electrónico

El "Plan de Implementación de Gobierno Electrónico" es un documento en el que se definen los ejes estratégicos y las líneas estratégicas para la implementación de la política de gobierno electrónico en el país, como puede verse en la @table:ejes_egob. Estos ejes definen mucho de lo contenido en las distintas leyes y reglamentos y tienen bastante relevancia para afrontar cualquier proyecto de software gubernamental.

#pagebreak()
#figure(
  table(
    columns: (1fr, 1.5fr),
    align: (center + horizon, left),
    fill: (x, y) => {
      if y == 0 {
        return rgb(230, 230, 230)
      }
    },
    inset: (.3em, .6em),
    table.header(
      "Ejes estratégicos",
      table.cell(align: center + horizon)[Líneas estratégicas],
    ),
    table.cell(rowspan: 5)[Gobierno Soberano],
    [1. Infraestructura y conectividad],
    [2. Investigación, innovación y desarrollo tecnológico],
    [3. Interoperabilidad],
    [4. Ciudadanía digital],
    [5. Seguridad informática y de la información],
    table.cell(rowspan: 7)[Gobierno Eficiente],
    [6. Simplificación de trámites],
    [7. Gestión pública],
    [8. Asesoramiento y capacitación técnica],
    [9. Registros públicos],
    [10. Servicios de desarrollo económico],
    [11. Calidad de servicios públicos],
    [12. Entidades territoriales autónomas],
    table.cell(rowspan: 2)[Gobierno Abierto y Participativo],
    [13. Transparencia y datos abiertos],
    [14. Participación y control social],
  ),
  caption: [Ejes estratégicos y líneas estratégicas\ Fuente: Plan de Implementación de Gobierno Electrónico],
  placement: auto,
)<table:ejes_egob>


=== Implementación de Software Libre y Estándares Abiertos

Bolivia también cuenta con el "Plan de Implementación de Software Libre y Estándares Abiertos", en el que se define al software libre del modo siguiente:

#quote[
  El Software Libre se basa en una filosofía que busca que el desarrollo de la tecnología se
  oriente al bienestar de los seres humanos en términos de igualdad; que el conocimiento sea
  lo que realmente es: un bien común de la humanidad; que la cooperación sea el modelo de
  su desarrollo y que todos puedan libremente disfrutar de sus resultados, sin mellar los
  mismos derechos para los demás

  [...]

  La incorporación y uso del Software Libre y estándares abiertos, promueve valores de
  innovación, solidaridad, búsqueda del bien común y el desarrollo de los individuos y de la
  sociedad, coincidentes con los del Estado. A través de la implementación del Software Libre
  se busca que el Estado adquiera y desarrolle la capacidad de controlar las aplicaciones
  informáticas que utiliza con soberanía tecnológica.
]

Es muy importante citar la Ley N° 164 @Ley164Ley2011, misma que establece lo siguiente acerca del software libre:

#quote(attribution: [Artículo 77, Ley Nº 164])[
  I. Los Órganos Ejecutivo, Legislativo, Judicial y Electoral en todos sus niveles,
  promoverán y priorizarán la *utilización del software libre y estándares abiertos*, en
  el marco de la soberanía y seguridad nacional.
]

En base a ello, al igual que con el "Plan de Implementación de Gobierno Electrónico", se establecen los ejes estratégicos y líneas estratégicas para la implementación de la política de software libre y estándares abiertos en el país, como puede verse en la @table:ejes_software, que además incluye las metas planteadas para el año 2025.

#figure(
  table(
    columns: (1fr, 1.5fr, 2.5fr),
    align: (center + horizon, left + horizon, left + horizon),
    fill: (x, y) => {
      if y == 0 {
        return rgb(230, 230, 230)
      }
    },
    inset: (.6em, .5em),
    table.header(
      [Ejes\ estratégicos],
      table.cell(align: center + horizon)[Líneas estratégicas],
      table.cell(align: center + horizon)[Metas al 2025],
    ),
    table.cell(rowspan: 2)[Soberanía\ Tecnológica],
    [Proceso de implementación de software libre y estándares abiertos],
    [*100%* de los sistemas de las entidades públicas son Software Libre, excepto aquellos identificados en la norma.],
    [Software libre, ciclo de vida],
    [El Estado produce conocimiento en tecnologías libres a través de procesos de investigación en entidades públicas, empresas estatales y universidades públicas.],
    table.cell(rowspan: 5)[Descolonización del\ conocimiento],
    table.cell(rowspan: 3)[Formación y capacitación],
    [70% de los profesores del Sistema Educativo Plurinacional están formados y capacitados en herramientas de software libre.],
    [100% del software utilizado en el Sistema Educativo Plurinacional es software libre.],
    [100% de los servidores públicos del nivel central que utilizan herramientas informáticas en sus funciones diarias están capacitados en el manejo de software libre.],
    [Innovación, investigación y desarrollo],
    [80% de los desarrollos generados por los procesos de investigación, innovación y desarrollo del Estado son aplicados en instancias públicas.],
    [Sensibilización, difusión y comunicación],
    [30% de la población conoce el proceso de implementación de software libre.],
    [], [],
    [100% de los servidores públicos conocen los beneficios del software libre y el plan de implementación de su institución.],
    table.cell(rowspan: 3)[Gestión\ del Cambio],
    table.cell(rowspan: 2)[Soporte y\ acompañamiento],
    [80% de las solicitudes de soporte y acompañamiento en el proceso de migración fueron atendidas por el órgano competente.],
    [*Existe una oferta efectiva del sector privado* en servicios de desarrollo, soporte técnico y capacitación con respecto a software libre.],
    [Seguimiento, evaluación y control],
    [100% de las entidades públicas envían sus planes y reportes anuales al Estado para su verificación y validación.],
  ),
  caption: [Ejes estratégicos, líneas estratégicas y metas al 2025\ Fuente: Plan de Implementación de Software Libre y Estándares Abiertos],
  placement: auto,
)<table:ejes_software>

El mismo documento hace un análisis del estado de situación respecto al software libre en el país, del cual se puede resaltar lo siguiente:

- El 61% de las entidades públicas utiliza lenguajes de programación que están bajo estándares libres; y el 39% corresponde a herramientas privativas.
- Respecto a los Términos de Referencia (TDR) de todas y cada una de las 160 licitaciones analizadas, en la mayoría de los casos se trata de trabajos internos (dentro de la institución). Se indica que deben dejar todo el material de trabajo, aunque no se dice que están obligados a entregar el código fuente del programa; por el formato del contrato, se puede suponer que esto es así.
- El 64% de las contrataciones externas son realizadas sin solicitar herramientas de software libre y sólo el 36% de las mismas son realizadas solicitando herramientas de software libre
- El 57% de los desarrollos internos son realizados sin herramientas de software libre y el 43% de las mismas son realizadas con herramientas de software libre.
- La mayor parte de las empresas de software no trabajan con herramientas de desarrollo libres. El 59% de las empresas no trabajan desarrollando con herramientas de software libre, el 19% usan herramientas de software libre para sus desarrollos internos y sólo el 22% usan herramientas de desarrollo libre para los clientes.
- Las entidades públicas cuentan con buenas condiciones para iniciar el proceso de implementación de software libre y estándares abiertos.

Como se evidencia de la normativa señalada anteriormente el Software libre hoy en día se encuentra regulado y se establecen los lineamientos y directrices para su implementación y posterior aplicación en nuestro país.
//NOTE: Podríamos añadir subtítulo sobre los lineamientos aprobados por RM 079/2, pero a pesar de su relevancia, lo dejaremos para el final, porque ya tenemos mucha información. Quizá podríamos añadir lo que se indica sobre que cada entidad pública debe digitalizar los trámites por su cuenta

