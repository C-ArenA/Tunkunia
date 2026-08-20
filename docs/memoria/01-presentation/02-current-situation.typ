#import "@preview/acrostiche:0.7.0": acr

== Situación Actual <section:current_situation>

En relación al contexto planteado en la sección de antecedentes, resulta fundamental exponer, antes de abordar la problemática del proyecto,
la situación actual en el campo o área de trabajo en distintos niveles, como pueden ser la normativa vigente, las tendencias tecnológicas y los trabajos o proyectos similares.

=== Adopción del Internet y las Plataformas Digitales<section:adoption>

Desde la aparición de Internet, el mundo ha cambiado drásticamente. La forma en que las personas se comunican, trabajan y realizan transacciones ha evolucionado de una forma acelerada.
Esta tendencia puede evidenciarse en el ritmo de adopción de Internet en el mundo que, de acuerdo a estimaciones de la #acr("UIT"), pasó de un 53% de la población mundial en el año 2019 a un 68% en el año 2024, como puede apreciarse en la @fig:internet_use.
Esto significa que el año 2024 se registró que cerca de 5,5 mil millones de personas usan internet, mientras que 1,3 mil millones aún no estarían en línea a nivel mundial @Statistics.

#figure(
  image("/assets/figures/internet_use.png", width: 60%),
  caption: [Número de usuarios de Internet en el mundo\ Fuente: #acr("UIT")],
)<fig:internet_use>

Bolivia no es la excepción a esta tendencia, ya que el año 2023 se estima que el 70,2% de la población boliviana ya contaba con acceso a Internet, como puede verse en la @fig:internet_use_bolivia.
Es decir que el país se encontraría por encima del promedio mundial de adopción de Internet. Sin embargo, aún queda un 29,8% de la población que no tiene acceso a Internet @IndividualsUsingInternet.

#figure(
  image("/assets/figures/internet_use_bolivia.png", width: 80%),
  caption: [Número de usuarios de Internet en Bolivia y su crecimiento\ Fuente: #acr("UIT")],
  placement: auto,
)<fig:internet_use_bolivia>

Se debe tomar en cuenta que uno de los factores posiblemente acelerando la adopción de Internet es la cantidad de beneficios que trae consigo mediante la Web y las "webapps" (aplicaciones web), que son aplicaciones que se ejecutan en un navegador web y no requieren instalación en el dispositivo del usuario. Inicialmente, dichas aplicaciones eran puramente informativas, pero con la llegada de la Web 2.0, estas webapps evolucionaron a plataformas digitales completas, integrándose con aplicaciones de negocios @pressmanSoftwareEngineeringPractitioner2010. Muchas aplicaciones móviles también utilizan la red de redes para brindar sus servicios de manera similar.

De este modo, el uso de las plataformas digitales también ha incrementado bastante. Podemos ver ejemplos como el de la @fig:ecommerce_adoption, en la que se ve la tendencia en la adopción de plataformas de comercio electrónico y cómo esta parece haber sido acelerada por la pandemia del COVID-19 en distintos países de América Latina y el Caribe.

#figure(
  image("/assets/figures/ecommerce_adoption.png", width: 80%),
  caption: [Tendencia de adopción de plataformas de comercio electrónico en América Latina y el Caribe\ Fuente: Latinobarómetro],
  placement: auto,
)<fig:ecommerce_adoption>

Como puede verse, la adopción de plataformas digitales ha crecido de forma acelerada en los últimos años, y se espera que continúe creciendo en el futuro. Esto se debe a la creciente disponibilidad de dispositivos móviles y a la mejora de la infraestructura de Internet en muchos países.

=== Gobierno Electrónico y Trámites Digitales en la actualidad

Al día de hoy se podría decir que ser un gobierno electrónico es más que una simple tendencia temporal. Durante la pandemia del COVID-19 se hizo una necesidad y ahora parece ser la norma.
Esto puede verse reflejado en el reporte sobre gobiernos digitales de las Naciones Unidas,
en el que el indicador #acr("EGDI"), que mide la adopción de políticas que favorecen la implementación del gobierno electrónico,
tuvo un aumento relevante en tan sólo dos años (@fig:egdi2020_2022).

#figure(
  image("/assets/figures/egdi2020_2022.png", width: 60%),
  caption: [Valores promedio del EGDI y sus componentes\ Fuente: 2020 and 2022 United Nations E-Government Surveys],
  placement: auto,
)<fig:egdi2020_2022>

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea. ¿El resultado? Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La anterior afirmación, si bien se cita de un estudio realizado el año 2018 @rosethFinTramiteEterno2018, refleja de forma aproximada la situación actual ante la falta de estudios más recientes. En general, si bien se nota una mayor adopción de los trámites digitales, aún existen muchos que se realizan de forma total o parcialmente presencial. Sin embargo, podemos encontrar una tendencia clara en la evolución hacia los gobiernos electrónicos y, siendo los servicios electrónicos una de sus áreas más relevantes @naserGobiernoElectronicoGestion2011, se espera que más trámites se digitalicen en el futuro. Lo anterior se hizo evidente durante la pandemia del COVID-19, durante la cual hubo un aumento considerable de canales digitales para la realización de trámites, llegando a remplazar alrededor del 20% de los trámites presenciales en distintos países de América Latina @rosethServiciosPublicosGobierno2021.

=== Normativa relevante vigente en Bolivia

Como se pudo ver en la sección de antecedentes, y de forma resumida en la @fig:bolivia_norms, Bolivia cuenta con una normativa bastante amplia en relación al uso de las #acr("TICs"), el gobierno electrónico, la digitalización de trámites y el desarrollo de software gubernamental. A continuación se presentan algunos elementos relevantes adicionales y, aunque no se pretende abarcar toda la normativa existente, dada su extensión, sí se desea poder atender a los aspectos más importantes como punto de partida para entender la situación normativa del país.

==== Acerca del Trámite

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

  ...II. En el marco de procesos de actualización, certificación o emisión de copias legalizadas de documentos que aún se encuentren en formato físico, los datos e información pertinente consignados en los mismos *deberán ser registrados en medios digitales* que permitan ser publicados mediante servicios de interoperabilidad.]

Asimismo, la Ley Nº 2341 tiene como uno de sus objetos "Establecer las normas que regulan la actividad administrativa y el *procedimiento
administrativo* del sector público" @LeyNo23412002, por lo que contiene normativa relevante al proceso del trámite y a la ejecución de los mismos. Podemos resaltar su Artículo 4, de "Principios Generales de la Actividad Administrativa" que cuenta con dos principios importantes en nuestro contexto, que son el "Principio de eficacia" y el "Principio de economía, simplicidad y celeridad". También, en el mismo documento, se indican los derechos de las personas, que en su Artículo 16 lista, entre otros, los siguientes derechos:

- Derecho a conocer *el estado del procedimiento* en que sea parte
- Derecho a *obtener* certificados y copias de documentos que estén en poder de la Administración Pública
- Derecho a *acceder* a registros y archivos administrativos

Esta ley también define la acción correspondiente a los silencios administrativos y otras situaciones propias del proceso administrativo.

La anterior normativa es importante porque, si bien es general, establece condiciones que pueden fácilmente ser atendidas con el uso de un sistema de gestión y seguimiento de trámites digitalizado. Estas necesidades pueden traducirse en objetivos del sistema propuesto en este proyecto, como el de poder consultar el estado de un trámite o poder obtener copias de documentos que obren en poder de la administración pública.

==== Planes de Implementación

Si bien la Ley Nº 164 establece los fundamentos sobre el uso de las tecnologías de la información en Bolivia a nivel normativo, a su vez establece la creación de planes de implementación, con una naturaleza más práctica. Esto se encuentra definido a partir de sus artículos 71 y 75, que establecen lo siguiente:

#quote(attribution: [Ley Nº 164, Artículo 75])[
  ...
  II. El Órgano Ejecutivo del nivel central del Estado, elaborará los lineamientos para la incorporación del Gobierno Electrónico
]

#quote(attribution: [Ley Nº 164, Artículo 71])[
  ...
  II. El Órgano Ejecutivo del nivel central del Estado, elaborará el plan de implementación de software libre y estándares
  abiertos en coordinación con los demás órganos del Estado y entidades de la administración pública.
]

Estos planes serían nuevamente requeridos en el reglamento aprobado por el Decreto Supremo Nº 1793, que es el "Reglamento para el Desarrollo de Tecnologías de Información y Comunicación", mismo que contiene definiciones y normativa importante para personas naturales o jurídicas, públicas o privadas que *realicen actividades o presten servicios relacionados con la certificación digital, gobierno electrónico, software libre, correo electrónico y el uso de documentos y firmas digitales en el Estado Plurinacional de Bolivia*. Este reglamento tiene bastante importancia para este proyecto, y su contenido sigue la misma filosofía encontrada tanto en la Ley Nº 164 como en los planes de implementación realizados de forma posterior a su aprobación.

Dado lo anterior es que, mediante Decreto Supremo Nº 3251, se aprobaron tanto el "Plan de Implementación de Gobierno Electrónico" como el "Plan de Implementación de Software Libre y Estándares Abiertos".

==== Implementación del Gobierno Electrónico

El "Plan de Implementación de Gobierno Electrónico" es un documento en el que se definen los ejes estratégicos y las líneas estratégicas para la implementación de la política de gobierno electrónico en el país, como puede verse en la @table:ejes_egob. Estos ejes definen mucho de lo que se puede encontrar en las distintas leyes y reglamentos relevantes a este proyecto y tienen bastante importancia para afrontar cualquier proyecto de software gubernamental.

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


==== Implementación de Software Libre y Estándares Abiertos

Bolivia también cuenta con un "Plan de Implementación de Software Libre y Estándares Abiertos", en el que se define al software libre del modo siguiente:

#quote(attribution: "Plan de Implementación de Software Libre y Estándares Abiertos")[
  El Software Libre se basa en una filosofía que busca que el desarrollo de la tecnología se
  oriente al bienestar de los seres humanos en términos de igualdad; que el conocimiento sea
  lo que realmente es: un bien común de la humanidad; que la cooperación sea el modelo de
  su desarrollo y que todos puedan libremente disfrutar de sus resultados, sin mellar los
  mismos derechos para los demás

  [...]

  La incorporación y uso del Software Libre y estándares abiertos, promueve valores de
  innovación, solidaridad, búsqueda del bien común y el desarrollo de los individuos y de la
  sociedad, coincidentes con los del Estado. A través de la implementación del Software Libre
  *se busca que el Estado adquiera y desarrolle la capacidad de controlar las aplicaciones
  informáticas que utiliza con soberanía tecnológica*.
]

Este plan derivaría directamente de la Ley N° 164 @Ley164Ley2011 que, en la misma línea, establece lo siguiente acerca del software libre:

#quote(attribution: [Artículo 77, Ley Nº 164])[
  I. Los Órganos Ejecutivo, Legislativo, Judicial y Electoral en todos sus niveles,
  promoverán y priorizarán la *utilización del software libre y estándares abiertos*, en
  el marco de la soberanía y seguridad nacional.
]

En base a ello, al igual que con el "Plan de Implementación de Gobierno Electrónico", se establecen los ejes estratégicos y líneas estratégicas para la implementación de la política de software libre y estándares abiertos en el país, como puede verse en la @table:ejes_software, que además incluye las metas que se plantearon para el año 2025.

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

Como se evidencia de la normativa señalada anteriormente el Software libre hoy en día se encuentra regulado y se establecen los lineamientos y directrices para su implementación y posterior aplicación en nuestro país de un modo prioritario.
//NOTE: Podríamos añadir subtítulo sobre los lineamientos aprobados por RM 079/2, pero a pesar de su relevancia, lo dejaremos para el final, porque ya tenemos mucha información. Quizá podríamos añadir lo que se indica sobre que cada entidad pública debe digitalizar los trámites por su cuenta

=== Tendencias tecnológicas

Las necesidades que surgen alrededor de la digitalización de trámites son diversas. Sin embargo, para resolver este tipo de problemas existen algunas prácticas que se han vuelto comunes, tanto a nivel de desarrollo de software, de sistemas y de enfoques. A su vez, pueden existir tendencias tecnológicas generales que potencialmente logren aportar a este proyecto. Las mismas no necesariamente responden a los trámites realizados por entidades públicas, sino a entidades privadas que enfrentan necesidades similares, pero pueden ser igualmente aplicadas. Algunas de estas tendencias se describen a continuación.

==== Reutilización de Software

La reutilización de software (software reuse) es el uso sistemático de piezas existentes de software para construir otras nuevas, modificadas o incluso productos de software completos a partir de las mismas. Estas piezas pueden ser código fuente, ejecutables, guìas de diseño, componentes de software libre, componentes comerciales, o arquitecturas completas. Es importante resaltar que el conocimiento también es reutilizable y se ve reflejado en la reutilización de patrones, procesos o arquitecturas de software @mohagheghiQualityProductivityEconomic2007. Las formas en que las piezas reutilizables se materializan son variadas y pueden incluir bibliotecas o librerías, frameworks, componentes, sistemas de software completos, etc (@fig:reuse_landscape).

#figure(
  image("/assets/figures/reuse_landscape.png", width: 60%),
  caption: [Reuse landscape\ Fuente: Sommerville, Software Engineering @sommervilleSoftwareEngineering2016],
  placement: auto,
)<fig:reuse_landscape>

Por la naturaleza de la reutilización del software, que consiste en usar trabajo existente como bloques de construcción para proyectos más grandes, se relaciona a esta práctica con un aumento en la productividad, un posible aumento de calidad @selbyEnablingReusebasedSoftware2005 y una disminución en los costos. Sin embargo, medir de forma empírica estos beneficios es bastante difícil y algunos intentos realizados, si bien pueden no contemplar todas las variables posibles, dada la naturaleza particular de cada proyecto, han mostrado resultados positivos, indicando que existe un claro aumento de productividad al reutilizar software @basiliHowReuseInfluences1996. Esto implicaría también beneficios en los tiempos y costos de desarrollo, reafirmando lo atractivo de la reutilización del software.

#figure(
  image("/assets/figures/mobile_reuse.png", width: 60%),
  caption: [Porcentaje de reutilización de software en aplicaciones móviles\ Fuente: A large-scale empirical study of the reuse of software components in mobile applications @mojicaLargeScaleEmpiricalStudy2014],
  placement: auto,
)<fig:mobile_reuse>

La reutilización de software se ha popularizado bastante en los últimos años, particularmente con el auge de los sistemas de código abierto y la creación de plataformas digitales. Esta tendencia también responde a la demanda por la disminución de costos de producción y mantenimiento de software, entregas más rápidas de los sistemas y mejoras en la calidad del software @sommervilleSoftwareEngineering2016.

En este sentido, la @fig:mobile_reuse, que forma parte de un estudio publicado el año 2014, sobre la reutilización de software en el desarrollo de aplicaciones móviles, halló que en las distintas categorías de aplicaciones analizadas, existe un alto porcentaje de reutilización #footnote[La reutilización en este estudio fue medida calculando la proporción de clases reutilizadas sobre la cantidad total de clases de cada proyecto], por encima del 62% @mojicaLargeScaleEmpiricalStudy2014.

Esta tendencia se ve también en otros campos del desarrollo de software, particularmente en el desarrollo web, donde se popularizó la herramienta de gestión de paquetes #acr("NPM") para facilitar la reutilización de código en el desarrollo de aplicaciones web y sobre la cual se puede evidenciar un aumento significativo de paquetes reutilizables, con más de un millón registrados el año 2022 y con un crecimiento del 60% entre los meses de enero del 2019 y 2022 @mujahidWhatAreCharacteristics2023. Una búsqueda actual (2025) en el sitio oficial de #acr("NPM") muestra que existen ya más de dos millones de paquetes disponibles en su registro y que cuenta con la contribución de más de 17 millones de desarrolladores de software a nivel mundial @NpmHome.

==== Sistemas de Gestión de Flujos de Trabajo y Procesos<section:wfms>

Existe en la actualidad un tipo de sistema que va muy de la mano con el propuesto en este proyecto, el cual es el #acr("WFMS"). Estos sistemas contemplan de forma general el manejo de flujos de trabajo. De forma similar, y a veces usado de forma indistinta con WFM existe el término BPM (Business Process Management), que de modo más amplio es el arte y la ciencia de supervisar cómo el trabajo es realizado dentro de una organización.

Toda organización, incluido por supuesto el aparato gubernamental, debe manejar *procesos* @dumasFundamentalsBusinessProcess2013, siendo los trámites típicos ejemplos. Es por esto que tanto los WFMS y BPM tienen bastante relevancia en los sistemas de software.

Tal es la relevancia que existe una organización dedicada a estandarizar los WFMS y BPM, la cual fue fundada el año 1993 y es llamada "Workflow Management Coalition" (WfMC) @WorkflowManagementCoalition. Dicha organización define a los WFMS de la siguiente manera:

#quote(attribution: [Workflow Management Coalition])[
  A workflow management system (WMS) is a software application that is designed to help organizations automate and manage their business processes. A WMS allows an organization to define and implement a workflow #sym.dash.em\a series of tasks, steps, and decisions#sym.dash.em that need to be followed to complete a specific process. The system can then be used to track the progress of the workflow, manage the flow of information and documents, and ensure that tasks are completed in the correct order and by the right people.

  A WMS can be used to automate a wide range of business processes, such as invoicing, order fulfillment, human resources, and project management. It can also be used to integrate different systems, such as email, calendar, and customer relationship management (CRM) software. WMS allows you to streamline the process and make it more efficient, reduce errors and delays, and give you real-time visibility into the status of your processes, also it's common to have a built-in reporting and analytics tools to measure the performance of the process.
]

#figure(
  image("/assets/figures/wfms_history.png"),
  caption: [WFMS desde una perspectiva histórica\ Fuente: The Application of Petri Nets
    to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)<fig:wfms_history>

La necesidad de manejar flujos de trabajo es realmente frecuente en muchos sistemas, por lo que ciertos autores creen que debe ser un módulo tan importante como el sistema de gestión de bases de datos, como se puede aproximar mediante la @fig:wfms_history.

Podemos entender, de forma general y sintética, que el propósito principal de los sistemas de flujo de trabajo (WFMS) es el apoyo en la definición, ejecución, registro y control de procesos @vanderaalstAPPLICATIONPETRINETS1998, algo que posteriormente podría guiar en la implementación de un sistema específico a los trámites administrativos.

==== Arquitectura y Modularidad

Se puede advertir al día de hoy que queda cada vez más claro que una ingeniería de software efectiva requiere del diseño de la arquitectura del software, una práctica que siempre se lleva a cabo de forma implícita al desarrollar software, pero que conviene aplicar de forma fundamentada.
Primero, es importante poder reconocer paradigmas comunes para que se puedan entender las relaciones de alto nivel entre sistemas y para que se puedan construir nuevos sistemas como variaciones de sistemas antiguos.
Segundo, conseguir la arquitectura correcta es a menudo crucial para el éxito del diseño de un sistema de software, mientras que hacer esto de manera incorrecta puede llevar a resultados desastrosos.
Tercero, un entendimiento detallado de las arquitecturas de software permite al ingeniero hacer elecciones fundamentadas entre alternativas de diseño.
Cuarto, una representación arquitectónica del sistema es a menudo esencial para el análisis y la descripción de las propiedades de alto nivel de un sistema complejo @garlanIntroductionSoftwareArchitecture1994. En el presente, la arquitectura de software eficaz y su representación y diseño explícitos se han vuelto los temas dominantes en la ingeniería de software @pressmanSoftwareEngineeringPractitioner2010

Para los arquitectos de software es crucial entender la modularidad en los sistemas para poder aplicarla, dado que casi siempre los sistemas desarrollados están compuestos de varias piezas y la modularidad es un principio de organización importante en este contexto. De este modo modularidad es un término general para denotar grupos relacionados de código @richardsFundamentalsSoftwareArchitecture2020. Entonces el agrupamiento de código está relacionado con la reutilización del mismo y la organización de un sistema de software que busca tener modularidad para facilitar su mantenimiento y evolución consiguiendo el correcto orden.

Con esto en mente, muchos patrones y estilos de arquitectura buscan lograr modularidad en algún sentido. Por ejemplo, cuando hablamos de estilos de arquitectura, podemos mencionar la arquitectura en capas, la arquitectura orientada a servicios (SOA), la arquitectura basada en microservicios, la arquitectura de eventos, la arquitectura hexagonal, etc. Cada uno de estos estilos tiene sus propias características, ventajas y desventajas, pero todos buscan lograr modularidad y facilitar el mantenimiento y la evolución del software.

#figure(
  image("/assets/figures/micro_topo.png", width: 60%),
  caption: [Topología del estilo de arquitectura de microservicios\ Fuente: Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  placement: auto,
)<fig:micro_topo>

#figure(
  image("/assets/figures/soa_topo.png", width: 60%),
  caption: [Topología del estilo de arquitectura #acr("SOA")\ Fuente: Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  placement: auto,
)<fig:soa_topo>

En la actualidad, muchos de estos estilos se consolidaron como los más usados o se están haciendo cada vez más populares. Los siguientes estilos tienen bastante relevancia en el contexto de este proyecto y en la actualidad del desarrollo de software:

- *La arquitectura por capas* es un estándar de facto para muchas aplicaciones, principalmente por su simplicidad, familiaridad y sus bajos costos. También es una forma muy natural de desarrollar aplicaciones siguiendo la ley de Conway de reflejar la estructura de una organización en el diseño de un producto. Ya se vio en la @fig:siai_architecture_style una topología común de este tipo.
- *La arquitectura de microservicios* es un estilo de arquitectura extremadamente popular en la actualidad que se basa en la creación de pequeños servicios totalmente independientes que pueden comunicarse entre sí con el objetivo de garantizar un alto desacoplamiento. Este estilo es complejo y requiere independencia incluso en las bases de datos, como puede verse en la @fig:micro_topo.
- *La arquitectura orientada a servicios (SOA)* es un estilo de arquitectura pragmático y flexible que, si bien se basa en la creación de servicios independientes, no tiene el mismo nivel de complejidad que tienen los microservicios y otras arquitecturas distribuidas (ver @fig:soa_topo). Este estilo se volvió popular en muchas aplicaciones relacionadas a las empresas.

Finalmente, en lo que respecta a la arquitectura de software y modularidad, es importante mencionar que las distintas "piezas" modulares de un sistema pueden recibir un nombre, aunque este depende de la organización o persona que lo use. Por ejemplo, Ingeno, en su libro "Software Architect's Handbook" @ingenoSoftwareArchitectsHandbook2018, trata de definir estas piezas en seis categorías:

- Estructura: Agrupación e interrelación entre elementos.
- Elemento: Término genérico para referirse a cualquiera de estas "piezas".
- Sistema: Representa el proyecto de software en su totalidad, representando el nivel más grande de abstracción del diseño.
- Subsistema: Como ya se definió en la introducción de este documento, un subsistema es un sistema que forma parte de otro sistema más grande con cierto nivel de independencia y puede, a su vez, estar conformado por otros subsistemas. No se debe olvidar que un subsistema no deja de ser en sí mismo un sistema en términos generales.
- Módulo: De forma similar a los subsistemas, son una parte de un sistema más grande, pero se enfocan en un área lógica específica de responsabilidad.
- Componente: Son el nivel más pequeño de agrupación, con el nivel más bajo de abstracción.

Estos términos pueden ser intercambiables entre sí ante la falta de definiciones universales. Sin embargo, respecto al subsistema, conviene mencionar un proyecto licitado en años recientes por el gobierno boliviano, para la Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes (ATT), que es el "Sistema Integrado Nacional del Espectro Radioeléctrico" (SINER) @GobiernoLanzaSegunda2023. Este sistema cuenta con dos componentes de software que el documento base de contratación de dicha licitación define como subsistemas, haciendo referencia a que forman parte de un sistema más grande, a pesar de que los mismos pueden también ser utilizados, aunque parcialmente, de forma independiente. De hecho, se toma esto como inspiración para categorizar lo propuesto en este proyecto como un subsistema.

==== Proyectos de Software Libre

El software libre tiene un efecto democratizador en los gobiernos @donorfioPoliticsFreeOpen2004 y también brinda soberanía sobre el código utilizado por los mismos, permitiéndoles tener el *control de la tecnología* empleada @LibertadSoftwareSu.
De acuerdo a Richard Stallman, gran referente en el área, es necesario usar software libre en el gobierno electrónico para no tener la necesidad de pedir *permiso a un tercero* para manipular el código fuente y para que gobiernos de todo el mundo puedan *utilizar, corregir, difundir y contribuir a la mejora del software* @SoftwareLibreGobierno.

Actualmente software libre significa a grandes rasgos que los usuarios tienen la *libertad* de *ejecutar, copiar, distribuir, estudiar, modificar y mejorar* el software @QueEsSoftware.
Por la ambigüedad del término en inglés #footnote[_free_ también puede significar "gratis"]
nació el término _Open Source_ como otra forma de referirse a lo mismo, salvo diferencias filosóficas según Stallman @WhyOpenSource. Posteriormente se crearía un término que abarca a ambos, _free software_ y _open source_, el cual es _free and open source software_ (FOSS).
En este documento nos referimos a ellos casi indistintamente y teniendo preferencia por el uso de *FOSS*.

Cuando Richard Stallman comenzó a trabajar como programador en el Laboratorio de Inteligencia Artificial del MIT el año 1971,
pasó a formar parte, por primera vez, de una *comunidad* de "hackers"
#footnote[El término hacker es entendido por Stallman como aquel que hace referencia a una persona inteligente y curiosa con espíritu de sagacidad imaginativa y de exploración]
que *compartían software* y, sin saberlo porque en aquel entonces la práctica era tan común que no tenía un término propio, eran también una comunidad de "software libre" @stallmanSoftwareLibrePara. Estas comunidades de hackers y de software libre no dejaron de existir a pesar de que la industria del software comenzó a ver el software como un producto comercial.

En años recientes, los proyectos de software libre sentaron las bases para muchos de los avances tecnológicos que hoy tenemos disponibles e incluso las grandes empresas tecnológicas, que otrora daban exclusiva preferencia al software propietario, ahora los utilizan de forma masiva y contribuyen a su desarrollo @vonkroghCarrotsRainbowsMotivation2012.

#figure(
  image("/assets/figures/github_contributions.png", width: 50%),
  caption: [Número de contribuciones a proyectos públicos y de software libre en GitHub (2021-2024)\ Fuente: GitHub Octoverse],
  placement: auto,
)<fig:github_contributions>

Una de estas empresas es Microsoft que, entre otras cosas, adquirió la plataforma de colaboración GitHub en el año 2018, la cual es la plataforma más popular para el desarrollo de software libre y de código abierto. Como parte del trabajo realizado por esta compañía, tenemos disponibles algunos datos sobre el estado del software libre en el reporte "GitHub Octoverse" @staffOctoverseAILeads2024. Estos son algunos datos relevantes:

- El año 2024, desarrolladores de todo el mundo realizaron cerca de 1000 millones de contribuciones (1 billion contributions) a proyectos públicos y de software libre en GitHub. Esto representa un aumento respecto a años anteriores, como puede apreciarse en la @fig:github_contributions.
- Una de las principales motivaciones para contribuir a proyectos de software libre es el poder aportar a la comunidad y generar cambios positivos en la sociedad. Algunos proyectos que han motivado a contribuidores nóveles están relacionados con el sistema de orfanatos para personas jóvenes, la investigación de drogas en países de ingresos medios y bajos, y la creación de herramientas para ayudar a las personas a denunciar maltratos de forma anónima.

Este último dato señala algo importante y sobre lo cual Haefliger, von Krogh y Spaeth profundizan en uno de sus artículos @vonkroghCarrotsRainbowsMotivation2012 y es que el desarrollo del software libre podría tener una motivación social y comunitaria, más allá de lo económico.

==== Lenguajes de Modelado de Procesos<section:modeling>

Cuando se habla de trámites, de acuerdo a las definiciones establecidas en la sección de antecedentes, se hace referencia a *procesos*. Por lo tanto, es importante mencionar que existen varios lenguajes para modelar procesos que permiten representar gráficamente los mismos y que, de forma general, consisten mínimamente en conjuntos de nodos de dos tipos: actividad y control @dumasFundamentalsBusinessProcess2013. A continuación se describen algunos de estos lenguajes o herramientas para modelar procesos:

#figure(
  image("/assets/figures/bpmn.png", width: 60%),
  caption: [Ejemplo de un diagrama BPMN\ Fuente: Business Process Model and Notation (BPMN) Version 2.0.2 @bpmn202],
  placement: auto,
)<fig:bpmn>

- *Diagramas de flujo:* Quizá uno de los lenguajes más antiguos para describir procesos, en su forma más básica consiste de rectángulos para representar actividades (no de actividad) y rombos o diamantes para representar puntos de decisión (nodo de control).
- *Diagramas de actividad UML (Unified Modeling Language):* Es un lenguaje de modelado que se utiliza para representar sistemas de software. UML es ampliamente utilizado en la industria del software. Los diagramas de actividad de UML son una forma de representar procesos de negocio de manera gráfica a través de distintas organizaciones.
- *EPC (Event-driven Process Chain):* Es una técnica de modelado de procesos que se utiliza para representar procesos de negocio de manera gráfica. EPC es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos. Tiene ciertas similitudes con los diagramas de flujo, pero se diferencia en que trata a los eventos como ciudadanos de primera clase.
- *Familia IDEF (Integration Definition):* Es un conjunto de métodos y técnicas de modelado de procesos que se utilizan para representar procesos de negocio de manera gráfica, que fue creado por la fuerza aérea estadounidense y están basados en el manejo de escenarios. IDEF3 provee un mecanismo par recolectar y documentar procesos @IDEF3ProcessDescription.
- *BPMN (Business Process Model and Notation):* Es un estándar de modelado de procesos que permite representar gráficamente los procesos de negocio. Su última versión es BPMN 2.0.2 y fue publicada como un estándar del Object Management Group (OMG) el año 2014. En este lenguaje las actividades se representan mediante rectángulos redondeados, los nodos de control (llamados gateways) se representan usando formas de diamante. Los nodos se conectan mediante arcos, como se puede ver en la @fig:bpmn, donde se muestra un proceso colaborativo entre un paciente y la recepción de un médico.

Adicionalmente, existen otros lenguajes de modelado de sistemas que no son tan comunes para describir procesos, pero que pueden ser útiles ya que reflejan la naturaleza paso a paso de los trámites. Algunas de estas herramientas son:

#figure(
  image("/assets/figures/statediagramex.png", width: 50%),
  caption: [Ejemplo de una máquina de estados\ Fuente: Elaboración propia],
  placement: auto,
)<fig:statediagramex>

#figure(
  image("/assets/figures/petricomplaints.png", width: 70%),
  caption: [Red de Petri de un proceso de queja\ Fuente: The Application Of Petri Nets to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)<fig:petricomplaints>

- *Máquinas de Estados:* Si bien las máquinas de estado no se suelen mencionar como lenguaje para modelar gráficamente los procesos administrativos, no hay duda de que pueden cumplir con este propósito (ver @fig:statediagramex). Una máquina de estados es un conjunto de 5 elementos $M=(S,I,O,v,w)$, donde $S$ representa a la colección de estados de $M$; $I$ representa al alfabeto de entradas para $M$; $O$ es el alfabeto de salidas de $M$; $v:S x I->S$ es la función del siguiente estado; y $w:S x I->O$ es la función de salida @grimaldiDiscreteCombinatorialMathematics1998.
- *Redes de Petri:* Una de las técnicas de modelado más antiguas en el campo de las ciencias de la computación, inspiró en algunos aspectos al actualmente predominante lenguaje universal de modelado UML, tiene diversas variantes y está definido de manera formal y matemática, permitiendo el análisis de los sistemas modelados con esta técnica @reisigUnderstandingPetriNets2013. Las Redes de Petri también son llamadas place/transition nets por el hecho de estar formadas precisamente por lugares, representados por círculos, y transiciones, representadas por rectángulos, formando así un lenguaje matemático y una forma de representar sistemas distribuidos discretos @simonStateMachinesPetri. Algunos autores defienden que esta técnica es capaz de modelar procesos @vanderaalstAPPLICATIONPETRINETS1998, y existen ejemplos como el de la @fig:petricomplaints.

Podemos ver que al día de hoy tenemos disponibles una gran cantidad de lenguajes, herramientas y técnicas para modelar sistemas de software y procesos. La elección del lenguaje dependerá de la naturaleza del sistema a modelar y de los beneficios que cada uno de ellos pueda aportar. Aún así, es posible modelar un mismo sistema de procesos usando distintos lenguajes.

==== Inteligencia Artificial

Es difícil no hablar de inteligencia artificial (IA) en la actualidad. La IA ha tenido un crecimiento exponencial en los últimos años, y su uso se ha vuelto común en muchos ámbitos. Sin embargo, es importante aclarar que la IA no es un concepto nuevo, sino que ha existido desde hace décadas. Lo que ha cambiado es la forma en que se aplica y la cantidad de datos disponibles para entrenar modelos de IA.

Una forma de IA que se popularizó en años recientes es la de los grandes modelos de lenguaje (LLM), que son un tipo de inteligencia artificial que reconoce y genera texto, entre otras tareas. Los LLMs son entrenados en conjuntos grandes de datos, por eso el nombre de "grande" (large). Los LLMs se construyen en base a machine learning, en específico un tipo de red neuronal llamado transformer @WhatLLMLarge.

Con la salida al mercado de forma gratuita de ChatGPT el 30 de Noviembre de 2022 @ChatGPTTurns1euro, el mundo sufrió un cambio importante, ya que se empezaron a utilizar de forma masiva los grandes modelos de lenguaje (LLMs). Los modelos de lenguaje, si bien existen ya hace mucho tiempo, no lograron el nivel de precisión e inteligencia aparente sino hasta hace un par de años.

Uno de los servicios alrededor de los LLMs es el uso de APIs que permiten la integración de dichas herramientas en diversos sistemas. Las aplicaciones son muchas y aún se siguen explorando. Sin embargo, una de ellas es claramente el uso de la inferencia en base a inteligencia artificial.

La inferencia consiste en usar modelos de inteligencia artificial ya entrenados para reconocer patrones y sacar conclusiones sobre información nueva que no vieron antes @WhatAIInference2024. Dicho enfoque puede usarse para analizar documentos y, en general, datos, sin necesidad de entrenar otro modelo.

Este análisis de documentos tiene cierto parecido con el análisis realizado por funcionarios públicos al momento de revisar los formularios de un trámite. Sin embargo, hoy en día se siguen empleando servidores fuera de Bolivia para emplear estos modelos de lenguaje, por lo que su utilización podría estar limitada por la normativa vigente en el país. Aún así, es importante mencionar este tipo de posibles aplicaciones dentro del proceso de digitalización de trámites.

=== Trabajos Relacionados<section:related_work>

Para poder identificar los trabajos relacionados a este proyecto se buscaron los mismos en torno al trámite digital y distintos procesos administrativos, tanto en el sector público, como en el sector privado. Esto nos permite abarcar trabajos relacionados de forma directa e indirecta. Se debe tomar en cuenta que estos trabajos carecen de características fundamentales como la reutilización o la naturaleza de software libre y no se encontró ninguno que cumpla con todas las características deseadas. Sin embargo, muchos de ellos sí tienen una gran cantidad de funcionalidades o conceptos que podrían inspirar el desarrollo del subsistema propuesto en este proyecto.

==== En el ámbito académico

Debido a la cantidad de procesos administrativos que existen en distintas instituciones, podemos encontrar también una gran cantidad de proyectos de grado realizados que tratan sobre la implementación de sistemas de gestión de trámites. A continuación se listan algunos de los más relevantes:

- *Sistema de Control de Trámites utilizando Máquinas de Turing para la División de Gestiones, Admisiones y Registros U.M.S.A.* @nachoSISTEMACONTROLTRAMITES2007: En este proyecto de grado, realizado el año 2007, se toma como base teórica a las máquinas de Turing. En dichas máquinas, que son un modelo matemático de computación, se describe una suerte de cinta dividida en casillas que funciona como memoria y un cabezal que escribe y lee de esa cinta, cambiando de estados. Esta conceptualización, a pesar de no haber sido implementada de forma estricta en dicho proyecto, señala la necesidad de modelar los procesos y presenta una forma innovadora de hacerlo. El sistema propuesto presenta muchas de las funcionalidades esperadas en el presente proyecto, como el seguimiento y el control de los trámites desde el registro inicial hasta la conclusión del mismo. Además, este trabajo atiende alrededor de veintiún procesos diferentes que, si bien son todos parte de una misma institución, representan la atención a distintos trámites con un mismo sistema y técnica de modelado, algo muy relevante para el subsistema propuesto en este documento.

- *Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí* @murosalazarImplementacionModuloControl2018: Esta tesis, del año 2018, forma parte de una línea de investigación de reforma y modernización del estado y busca demostrar la importancia de la creación de un módulo específico de trámites. Brinda algunas recomendaciones, pero no realiza ninguna implementación práctica. Se sugiere cierta preferencia en la metodología #acr("XP") por encima de la metodología SCRUM de desarrollo de software, la cual puede deberse a la demanda de desarrollos en corto tiempo dentro de las instituciones públicas. En la propuesta de este trabajo se recomienda entonces seguir dicha metodología ágil #acr("XP"), respetando el ciclo de vida del software para así obtener un sistema que sea, entre otras cosas, *reutilizable, portable e interoperable*. El enfoque de modularidad es evidente en este documento.

- *Desarrollo de una aplicación _web responsive_ para mejorar el proceso de trámite documentario en un colegio profesional* @cajusolvallejosDesarrolloAplicacionWeb2020: Este trabajo de tipo tesis, realizado el año 2020, en el contexto de la ingeniería de sistemas, muestra la implementación de un sistema de gestión de trámites en un colegio profesional de Perú. Al igual que el proyecto realizado en la división de gestiones, admisiones y registros de la U.M.S.A., se enfrenta a una *variedad de procesos administrativos*, pero además se encarga de conceptualizarlos correctamente desde su origen. Al ser una implementación completa, el trabajo muestra bastante detalle sobre el proceso de desarrollo del software, utilizando una metodología SCRUM y documentando los diferentes sprints realizados. Finalmente, efectúa un análisis del impacto del nuevo sistema y hace una serie de recomendaciones, entre las cuales se puede resaltar la importancia de usar *software libre para reducir costos* y la necesidad de capacitar a los usuarios del sistema para lograr un máximo aprovechamiento del mismo.

- *Desarrollar un sistema web de trámite documental para mantener las acreditadoras de la escuela de ingeniería informática de la URP* @zegarrajibajaDesarrollarSistemaWeb2019: Esta tesis, del año 2019, implementa un sistema de trámites usando tecnologías web, hace uso extensivo de diagramas de diseño, cuenta con un manual de uso y, a diferencia de los otros proyectos listados, realiza *pruebas de software*. Se debe tomar en cuenta que este sistema se enfoca en un solo proceso.

- *Desarrollo e Implementación del Sistema de Tramite Documentario en la Municipalidad Provincial de Huancayo para la atencion de expedientes* @bastidasparragaDesarrolloImplementacionSistema2016: Este trabajo de tesis, que forma parte de un posgrado, fue realizaado el año 2016 e implementa un sistema de trámite documental que se aplica a todo un municipio. De acuerdo a su autor se concluye que reduce el tiempo de atención a expedientes en un 30% respecto a un sistema anterior. Esto quiere decir que ya existía otra implementación que se buscó mejorar y que la calidad de un sistema de software puede afectar la eficiencia en su uso.

- *Sistema de información de trámite documentario basado en tecnología web para institutos de educación superior tecnológicos de la región Ancash en el año 2016* @tapiajacintoSistemaInformacionTramite2017: La implementación realizada en este otro trabajo de posgrado se cita aquí por una particularidad que también debería atenderse en otros proyectos de este tipo y es que el mismo no pretende remplazar el trámite presencial, sino complementarlo. Esto es importante ya que, si bien el objetivo de este proyecto girará en torno a la digitalización de trámites, no se puede ignorar que gran parte de la población no tiene acceso a internet o a dispositivos que le permitan utilizar plataformas digitales. Por lo tanto, es importante buscar un puente entre lo digital y lo presencial en cuanto a este tipo de servicios.

- *Implementación de un sistema de trámite documentario para la Agencia de Compras de las Fuerzas Armadas* @yrupailladiazImplementacionSistemaTramite2019: Este proyecto, realizado el año 2019, es otra implementación más de un sistema de trámite documentario. Sin embargo, añade una característica que, a pesar de no contemplarse de la misma forma en este proyecto, es muy importante y tiene que ver con la integración de la firma digital. Los trámites involucran el manejo de documentos para tomar decisiones importantes, por lo que la veracidad de estos es importante.

==== Fuera del ámbito académico

Si bien no se pudo encontrar módulos especializados en la gestión de trámites que se puedan integrar en sistemas más grandes con un enfoque de reutilización de software, sí existen sistemas con características similares a la funcionalidad de gestión de trámites o que incluso ofrecen todo lo necesario para gestionar procesos administrativos. A su vez, existen casos dentro de instancias públicas que podrían inspirar la solución propuesta más adelante.

#figure(
  image("/assets/figures/r2docuotimeline.png", width: 40%),
  caption: [Captura de pantalla del homepage de R2 Docuo donde se puede ver el timeline de un trámite\ Fuente: www.r2docuo.com],
  placement: auto,
)<fig:r2docuotimeline>

#figure(
  image("/assets/figures/odoowfms.png", width: 40%),
  caption: [Descripción de módulo de manejo de flujos de trabajo en Odoo\ Fuente: Captura de pantalla tomada de la tienda de extensiones de Odoo],
  placement: auto,
)<fig:odoowfms>

#figure(
  image("/assets/figures/conecosa.png", width: 40%),
  caption: [Screenshot tomada del artículo "The Application of Petri Nets to Workflow Management" @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)<fig:conecosa>

#figure(
  image("/assets/figures/insitecrm.jpg", width: 50%),
  caption: [Screenshot de video tutorial del producto Insite CRM],
  placement: auto,
)<fig:insitecrm>

#figure(
  image("/assets/figures/att_platform.png", width: 50%),
  caption: [Captura de pantalla de la vista de ingreso a PlATTaformas Virtuales para acceder al sistema OTTO\ Fuente: https://plataformas.att.gob.bo/],
  placement: auto,
)<fig:att_platform>

#figure(
  image("/assets/figures/stateflowrobot.png", width: 50%),
  caption: [Diagrama de estados finitos elaborado con Stateflow\ Fuente: Documentación MathWorks - Stateflow],
  placement: auto,
)<fig:stateflowrobot>


- *SoftExpert BPM:* Solución de software para la gestión de procesos de negocio @BusinessProcessManagemente. Si bien su foco no son los trámites, cuenta con elementos de modelado y seguimiento de procesos que podrían ser útiles en el contexto de los trámites digitales.
- *R2 Docuo:* Sistema completo de gestión de procesos que cuenta con una funcionalidad para el manejo de solicitudes y trámites @SoftwareParaGestionb. Crea fichas de información, define los pasos de cada trámite, almacena documentos asociados y ahorra tiempo con formularios y avisos (@fig:r2docuotimeline)
- *Odoo:* Es un #acr("ERP") @ERPCRMCodigo con herramientas para el manejo de flujos de trabajo y con un diseño modular que permite la creación de soluciones de terceros, entre las cuales existe una, ya sin mantenimiento, que permite crear flujos desde una herramienta gráfica de modelado de procesos (@fig:odoowfms). Es importante resaltar que Odoo cuenta con una edición llamada "Community" que es totalmente de código abierto, y dado que es un ERP completo con capacidad de manejo de procesos, podría ser un punto de partida interesante para proyectos de digitalizazción de trámites.
- *COSA:* Un gestor de flujos de trabajo antiguo que se menciona como ejemplo de caso de uso de redes de Petri en un #acr("WFMS") @vanderaalstAPPLICATIONPETRINETS1998, esto mediante una herramienta llamada CONE (@fig:conecosa).
- *Insite CRM:* Es un CRM desarrollado por Insite @tanjaOPERATIONALCRM2024, el cual cuenta con un módulo de gestión de flujos de trabajo (@fig:insitecrm), mediante el cual se permite la definición de procesos en una interfaz de usuario avanzada que parece ser un editor de diagramas #acr("BPMN"), como los vistos en la @fig:bpmn.
- *POTyS:* En palabras de Marco Antonio Bravo Fabián, director general del Instituto Quintanarroense de Innovación y Tecnología, el Portal Oficial de Trámites y Servicios (POTyS) tiene como objetivo que la ciudadanía pueda realizar los trámites de gobierno en línea, disminuyendo al máximo el contacto físico, las filas y la corrupción @candurizDigitalizanTramitesGobierno. Esta plataforma busca ser una ventanilla única, que pueda centralizar los distintos trámites existentes en el estado de Quintana Roo de México. Para finales del año 2022, esta plataforma llegó a incluir un total de 26 procedimientos de este tipo @ramirezQuintanaRoo262022.
- *OTTO:* La plataforma digital de Otorgamientos en Telecomunicaciones OTTO, que fue aprobada mediante Resolución Administrativa Interna ATT-DJ-RAI LP 8/2019 de la Autoridad de Regulación y Fiscalización de Telecomunicaciones y Transportes, atiende distintos trámites de solicitud y renovación de licencias para el uso de frecuencias @ResolucionAdministrativaInterna. Estos trámites tienen como una actividad importante la realización de un análisis técnico interno especializado relativo al campo de la gestión del espectro radioeléctrico para determinar el resultado de los mismos. Esta particularidad implica que, si bien hay características comunes en distintos trámites, la ejecución de verificaciones no es homogénea, siendo necesario que las distintas instancias públicas puedan implementar sus propios sistemas de gestión de trámites, conforme a sus propios modelos de negocio, en contraposición con la idea de usar una ventanilla única. Finalmente, vale la pena notar que, como puede verse en la @fig:att_platform, el ingreso a la plataforma OTTO se puede hacer mediante el uso de Ciudadanía Digital, siguiendo las guías de implementación de gobierno electrónico en Bolivia.
- *Stateflow by MathWorks:* Producto incluido en MatLab para modelar y simular procesos usando máquinas de estado y diagramas de flujo con un lenguaje gráfico@Stateflow. Esta herramienta, comunmente empleada en simulación de sistemas en carreras relacionadas a la electrónica y el control (Ver @fig:stateflowrobot), podría, aunque no de la manera más adecuada, ser usada para modelar procesos como el trámite. Su interfaz gráfica permite conectar la lógica de los estados, el modelado y la ejecución, por lo que se presenta como una implementación aproximada a la que se desea en este proyecto en cuanto a la definición de procedimientos de trámites.

/*NOTE
Realmente existen otros temas más que podrían ser relevantes, pero se incluye sólo lo más prioritario dada la extensión actual de esta sección.
  - Más sistemas de trámite y ventanilla única: El gobierno boliviano tiene más trámites digitalizados, recientemente se lanzó el sistema VUCE (Ventanilla Única de Comercio Exterior). También en una versión anterior de este mismo documento, se llegó a hablar del trámite de vidrios polarizados, entre otros que ya habrían sido digitalizados.
  - En cuanto a tecnologías se dejan en el tintero aspectos como la interoperabilidad, la firma digital, la ciudadanía digital, etc, que simplemente se mencionan como parte de los planes de implementación citados en el subtítulo de normativa vigente.
  - Dentro de la normativa también podrían haberse añadido los lineamientos aprobados por la RM 079/20, donde se habla de trámites y cómo estos deben ser implementados en forma digital por cada instancia pública.
En fin, hay muchos otros puntos que podríamos revisitar en una versión futura de este documento si es que así se ameritase, siendo los anteriormente descritos los más importantes para una actualización de esta sección.
*/
