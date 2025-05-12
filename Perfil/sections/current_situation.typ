#import "@preview/acrostiche:0.5.1": acr

= Situación Actual <section:current_situation>

En relación al contexto planteado en la sección de antecedentes, resulta fundamental exponer, antes de abordar la problemática del proyecto, 
la situación actual en el campo o área de trabajo en distintos niveles, como pueden ser la normativa vigente, las tendencias tecnológicas y los trabajos o proyectos similares.

== Adopción del Internet y las Plataformas Digitales

Desde la aparición de Internet, el mundo ha cambiado drásticamente. La forma en que las personas se comunican, trabajan y realizan transacciones ha evolucionado de una forma acelerada.
Esta tendencia puede evidenciarse en el ritmo de adopción de Internet en el mundo que, de acuerdo a estimaciones de la #acr("UIT"), pasó de un 53% de la población mundial en el año 2019 a un 68% en el año 2024, como puede apreciarse en la @fig:internet_use. 
Esto significa que el año 2024 se registró que cerca de 5,5 mil millones de personas usan internet, mientras que 1,3 mil millones aún no estarían en línea a nivel mundial @Statistics.

#figure(
  image("../assets/internet_use.png", width: 60%),
  caption: [Número de usuarios de Internet en el mundo\ Fuente: #acr("UIT")],
  placement: auto
)<fig:internet_use>

Bolivia no es la excepción a esta tendencia, ya que el año 2023 se estima que el 70,2% de la población boliviana ya contaba con acceso a Internet, como puede verse en la @fig:internet_use_bolivia. 
Es decir que el país se encontraría por encima del promedio mundial de adopción de Internet. Sin embargo, aún queda un 29,8% de la población que no tiene acceso a Internet @IndividualsUsingInternet.

#figure(
  image("../assets/internet_use_bolivia.png", width: 80%),
  caption: [Número de usuarios de Internet en Bolivia y su crecimiento\ Fuente: #acr("UIT")],
  placement: auto
)<fig:internet_use_bolivia>

Se debe tomar en cuenta que la adopción de Internet se debe a los beneficios que trae consigo mediante la Web y las "webapps" (aplicaciones web), que son aplicaciones que se ejecutan en un navegador web y no requieren instalación en el dispositivo del usuario. Inicialmente, dichas aplicaciones eran puramente informativas, pero con la llegada de la Web 2.0, estas webapps evolucionaron a plataformas digitales completas, integrándose con aplicaciones de negocios @pressmanSoftwareEngineeringPractitioner2010. Muchas aplicaciones móviles también utilizan la red de redes para brindar sus servicios de manera similar.

De este modo, el uso de las plataformas digitales también ha incrementado bastante. Particularmente, podemos ver ejemplos como el de la @fig:ecommerce_adoption, en la que se ve la tendencia en la adopción de plataformas de comercio electrónico y cómo esta parece haber sido acelerada por la pandemia del COVID-19 en distintos países de América Latina y el Caribe.

#figure(
  image("../assets/ecommerce_adoption.png", width: 80%),
  caption: [Tendencia de adopción de plataformas de comercio electrónico en América Latina y el Caribe\ Fuente: Latinobarómetro],
  placement: auto
)<fig:ecommerce_adoption>

Como puede verse, la adopción de plataformas digitales ha crecido de forma acelerada en los últimos años, y se espera que continúe creciendo en el futuro. Esto se debe a la creciente disponibilidad de dispositivos móviles y a la mejora de la infraestructura de Internet en muchos países.

== Gobierno Electrónico y Trámites Digitales en la actualidad

Al día de hoy se podría decir que ser un gobierno electrónico es más que una simple tendencia temporal. Durante la pandemia del COVID-19 se hizo una necesidad y ahora parece ser la norma.
Esto puede verse reflejado en el reporte sobre gobiernos digitales de las Naciones Unidas,
en el que el indicador #acr("EGDI"), que mide la adopción de políticas que favorecen la implementación del gobierno electrónico,
tuvo un aumento relevante en tan sólo dos años (@fig:egdi2020_2022).

#figure(
  image("../assets/egdi2020_2022.png", width: 60%),
  caption: [Valores promedio del EGDI y sus componentes\ Fuente: 2020 and 2022 United Nations E-Government Surveys],
  placement: auto
)<fig:egdi2020_2022>

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea. ¿El resultado? Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La anterior afirmación, si bien se cita de un estudio realizado el año 2018 @rosethFinTramiteEterno2018, refleja parcialmente la situación actual ante la falta de estudios más recientes. En general, si bien se nota una mayor adopción de los trámites digitales, aún existen muchos que se realizan de forma total o parcialmente presencial. Sin embargo, existe una tendencia clara y se espera que más trámites se digitalicen en el futuro. Lo anterior se hizo evidente durante la pandemia del COVID-19, durante la cual hubo un aumento considerable de canales digitales para la realización de trámites @rosethServiciosPublicosGobierno2021.

== Normativa relevante vigente en Bolivia

Como se pudo ver en la sección de antecedentes, y de forma resumida en la @fig:bolivia_norms, Bolivia cuenta con una normativa bastante amplia en relación al uso de las #acr("TICs"), el gobierno electrónico, la digitalización de trámites y el desarrollo de software gubernamental. A continuación se presentan algunos elementos relevantes adicionales y, aunque no se pretende abarcar toda la normativa existente, dada su extensión, sí se desea poder atender a los aspectos más importantes como punto de partida.

=== Acerca del Trámite

Al respecto del trámite administrativo es menester citar al Decreto Supremo N° 3525 que tiene como uno de sus objetos normar la *tramitación digital* @DECRETOSUPREMO35252018. Si bien aún no se consigue poner en práctica la totalidad de dicha norma, podemos resaltar lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 12])[
  *Trámites Administrativos:*

  I. Las instituciones públicas *deberán priorizar en todos sus trámites el uso de tecnologías de información* y comunicación a efecto de digitalizar, automatizar, interoperar y simplificar la tramitación de los asuntos que son de su competencia.

  II. Para facilitar la realización de trámites a la ciudadanía, las entidades públicas, en observancia de su normativa específica, deberán *intercambiar entre ellas datos e información mediante interoperabilidad*. Los mecanismos y condiciones de publicación y acceso a los servicios de interoperabilidad serán establecidos por el Ente Rector de Gobierno Electrónico y Tecnologías de Información y Comunicación.

  III. El intercambio de datos e información mediante interoperabilidad no afectará la percepción de recursos de las entidades públicas titulares de la información por la prestación del servicio público.

  IV. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido emitido por la misma entidad, o cuya información esté disponible mediante servicios de interoperabilidad de otra entidad.

  V. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido requerido con anterioridad, salvo actualización o modificación y conforme a normativa legal vigente. 
  
  VI. Las entidades públicas tendrán un plazo máximo de veinte (20) días hábiles a partir de la publicación de un nuevo servicio de interoperabilidad para adecuar sus procesos y procedimientos al mismo.
]

Lo anterior es muy importante, no sólo porque establece la obligación de digitalizar los trámites administrativos, sino también porque establece la interoperabilidad entre entidades públicas. Esto es clave para el funcionamiento del sistema propuesto en este proyecto, ya que se espera que el mismo pueda integrarse con otros sistemas de información y servicios de interoperabilidad.

Muchas veces, los trámites que se digitalizan cuentan con documentos físicos importantes, que deben también ser tomados en cuenta en el proceso de digitalización. En este sentido, el mismo Decreto Supremo N° 3525 establece lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 13])[
  *Entidades generadoras de información:*

  ...II. En el marco de procesos de actualización, certificación o emisión de copias legalizadas de documentos que aún se encuentren en formato físico, los datos e información pertinente consignados en los mismos deberán ser registrados en medios digitales que permitan ser publicados mediante servicios de interoperabilidad.]

Asimismo, la ley 2341 tiene como uno de sus objetos "Establecer las normas que regulan la actividad administrativa y el *procedimiento
administrativo* del sector público" @ley2341, por lo que contiene normativa relevante al proceso del trámite y a la ejecución de los mismos. Podemos resaltar su Artículo 4, de "Principios Generales de la Actividad Administrativa" que cuenta con dos principios importantes en nuestro contexto, que son el "Principio de eficacia" y el "Principio de economía, simplicidad y celeridad". También, en el mismo documento, se indican los derechos de las personas, que en su Artículo 16 lista, entre otros, los siguientes derechos:

- d) A *conocer el estado* del procedimiento en que sea parte
- j) A obtener certificados y copias de documentos que estén en poder de la Administración Pública
- k) A acceder a registros y archivos administrativos

Esta ley también define la acción correspondiente a los silencios administrativos y otras situaciones propias del proceso administrativo. Podemos resaltar finalmente lo siguiente:

#quote(attribution: [Ley 2341, Artículo 18])[
  ...Las personas tienen derecho a *acceder* a los archivos, registros públicos y a los documentos
  que obren en poder de la Administración Pública, así como a obtener certificados o copias
  legalizadas de tales documentos *cualquiera que sea la forma de expresión*, gráfica, sonora,
  en imagen u otras, o el tipo de soporte material en que figuren...
]

La anterior normativa es importante porque, si bien es general, establece condiciones que pueden fácilmente ser atendidas con el uso de un sistema de gestión y seguimiento de trámites digitalizado.
=== Acerca del Gobierno Electrónico

Si bien la Ley Nº 164 establece los fundamentos sobre el gobierno electrónico en Bolivia, a partir del reglamento aprobado por el Decreto Supremo 1793, el Decreto Supremo 3251 aprueba el "Plan de Implementación de Gobierno Electrónico", en el que se definen los ejes estratégicos y las líneas estratégicas para la implementación de la política de gobierno electrónico en el país, como puede verse en la @table:ejes_egob. Estos ejes definen mucho de lo contenido en las distintas leyes y reglamentos.

#figure(
table(
  columns: (1fr, 1.5fr),
  align: (center + horizon, left),
  inset: (.3em, .6em),
  table.header(
    "Ejes estratégicos", table.cell(align: center + horizon)[Líneas estratégicas]
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
)<table:ejes_egob>

=== Acerca del Software Libre

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

Como se evidencia de la normativa señalada anteriormente el Software libre hoy en día se encuentra regulado y se establecen los lineamientos y directrices para su implementación y posterior aplicación en nuestro país.
//TODO: Añadir subtítulo sobre los lineamientos aprobados por RM 079/20
== Tendencias tecnológicas
=== Sistemas de Gestión de Flujos de Trabajo y Procesos

Existe en la actualidad un tipo de sistema que va muy de la mano con el propuesto en este proyecto, el cual es el #acr("WFMS"). Estos sistemas contemplan de forma general el manejo de flujos de trabajo. De forma similar, y a veces usado de forma indistinta con WFM existe el término BPM (Business Process Management), que de modo más amplio es el arte y la ciencia de supervisar cómo el trabajo es realizado dentro de una organización.

Toda organización, incluido por supuesto el aparato gubernamental, debe manejar *procesos* @dumasFundamentalsBusinessProcess2013, siendo los trámites típicos ejemplos. Es por esto que tanto los WFMS y BPM tienen bastante relevancia en los sistemas de software.

Tal es la relevancia que existe una organización dedicada a estandarizar los WFMS y BPM, la cual fue fundada el año 1993 y es llamada "Workflow Management Coalition" (WfMC) @WorkflowManagementCoalition. Dicha organización define a los WFMS de la siguiente manera:

#quote(attribution: [Workflow Management Coalition])[
  A workflow management system (WMS) is a software application that is designed to help organizations automate and manage their business processes. A WMS allows an organization to define and implement a workflow - a series of tasks, steps, and decisions - that need to be followed to complete a specific process. The system can then be used to track the progress of the workflow, manage the flow of information and documents, and ensure that tasks are completed in the correct order and by the right people.

  A WMS can be used to automate a wide range of business processes, such as invoicing, order fulfillment, human resources, and project management. It can also be used to integrate different systems, such as email, calendar, and customer relationship management (CRM) software. WMS allows you to streamline the process and make it more efficient, reduce errors and delays, and give you real-time visibility into the status of your processes, also it's common to have a built-in reporting and analytics tools to measure the performance of the process.
]

La necesidad de manejar flujos de trabajo es realmente frecuente en muchos sistemas, por lo que ciertos autores creen que debe ser un módulo tan importante como el sistema de gestión de bases de datos, como se puede aproximar mediante la @fig:wfms_history.

#figure(
  image("../assets/wfms_history.png"),
  caption: [WFMS desde una perspectiva histórica\ Fuente: The Application of Petri Nets
    to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
)<fig:wfms_history>

Es importante entender que, de forma general y sintética, el propósito principal de los sistemas de flujo de trabajo (WFMS) es el apoyo en la definición, ejecución, registro y control de procesos @vanderaalstAPPLICATIONPETRINETS1998, algo que posteriormente podría guiar en la implementación de un sistema específico a los trámites administrativos.

=== LLMs e Inferencia

Un modelo grande de lenguaje (LLM) es un tipo de inteligencia artificial que reconoce y genera texto, entre otras tareas. Los LLMs son entrenados en conjuntos grandes de datos, por eso el nombre de "grande" (large). Los LLMs se construyen en base a machine learning, en específico un tipo de red neuronal llamado transformer @WhatLLMLarge.

Con la salida al mercado de forma gratuita de ChatGPT el 30 de Noviembre de 2022 @ChatGPTTurns1euro, el mundo sufrió un cambio importante, ya que se empezaron a utilizar de forma masiva los grandes modelos de lenguaje (LLMs). Los modelos de lenguaje, si bien existen ya hace mucho tiempo, no lograron el nivel de precisión e inteligencia aparente sino hasta hace un par de años.

Uno de los servicios alrededor de los LLMs es el uso de APIs que permiten la integración de dichas herramientas en distintos sistemas. Las aplicaciones son muchas y aún se siguen explorando. Sin embargo, es claro el uso de la inferencia en base a inteligencia artificial.

La inferencia consiste en usar modelos de inteligencia artificial ya entrenados para reconocer patrones y sacar conclusiones sobre información nueva que no vieron antes @WhatAIInference2024. Dicho enfoque puede usarse para analizar documentos y, en general, datos, sin necesidad de entrenar otro modelo.

=== Proyectos de Software Libre

Cuando Richard Stallman comenzó a trabajar como programador en el Laboratorio de Inteligencia Artificial del MIT el año 1971,
pasó a formar parte, por primera vez, de una comunidad de
"hackers" #footnote[El término hacker es entendido por Stallman como aquel que hace referencia a una persona inteligente y curiosa con espíritu de sagacidad imaginativa y de exploración]
que *compartían software* y, sin saberlo porque en aquel entonces la práctica era tan común que no tenía un término propio, eran también una comunidad de "software libre" @stallmanSoftwareLibrePara.

Actualmente software libre significa a grandes rasgos que los usuarios tienen la libertad de ejecutar, copiar, distribuir, estudiar, modificar y mejorar el software @QueEsSoftware.
Por la ambigüedad del término en inglés #footnote[_free_ también puede significar "gratis"]
nació otra forma de referirse a lo mismo, salvo diferencias filosóficas según Stallman @WhyOpenSource, y que se popularizó bastante: _Open Source_. Posteriormente se crearía un término que abarca ambos, _free software_ y _open source_, el cual es _free and open source software_ (FOSS).
En este documento nos referimos a ellos casi indistintamente y teniendo preferencia por el uso de *FOSS*.

% Por qué se prefiere FOSS
% Los gobiernos prefieren FOSS
El software libre tiene un efecto democratizador en los gobiernos @donorfioPoliticsFreeOpen2004,
además de brindar soberanía sobre el código utilizado por los mismos permitiéndoles tener el control de la tecnología empleada @LibertadSoftwareSu.
De acuerdo a Stallman, es necesario usar software libre en el gobierno electrónico para no tener la necesidad de pedir permiso a un tercero para manipular el código fuente y para que gobiernos de todo el mundo puedan utilizar, corregir, difundir y contribuir a la mejora del software @SoftwareLibreGobierno.


== Trabajos Relacionados
// TODO: Añadir POTyS, que aparentemente no cae en académico ni comercial, así que debemos reformular la sección
=== En el ámbito académico

Debido a la cantidad de procesos administrativos que existen en distintas instituciones, podemos encontrar también una gran cantidad de proyectos de grado realizados que tratan sobre la implementación de sistemas de control de trámites:

- SISTEMA DE CONTROL DE TRÁMITES UTILIZANDO MAQUINAS DE TURING CASO: DIVISIÓN DE GESTIONES ADMISIONES Y REGISTROS U.M.S.A. @nachoSISTEMACONTROLTRAMITES2007.
- Desarrollo e Implementación del Sistema de Tramite Documentario en la Municipalidad Provincial de Huancayo para la atencion de expedientes @bastidasparragaDesarrolloImplementacionSistema2016.
- DESARROLLO DE UN SISTEMA WEB PARA MEJORAR EL PROCESO DE TRÁMITE DOCUMENTARIO ADMINISTRATIVO DEL HOSPITAL SUB REGIONAL DE ANDAHUAYLAS @quispeperezDESARROLLOSISTEMAWEB2018.
- Sistema de información de trámite documentario basado en tecnología web para institutos de educación superior tecnológicos de la región Ancash en el año 2016 @tapiajacintoSistemaInformacionTramite2017.
- Programa de automatización de los procedimientos de trámite documentario en la calidad del servicio a los usuarios del Hospital Nacional Arzobispo Loayza - Lima, 2016 @cepedagamioProgramaAutomatizacionProcedimientos2017.
- Implementación de un sistema de trámite documentario para la Agencia de Compras de las Fuerzas Armadas @yrupailladiazImplementacionSistemaTramite2019.
- Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí, 2018 @murosalazarImplementacionModuloControl2018.
- Desarrollo de una aplicación _web responsive_ para mejorar el proceso de trámite documentario en un colegio profesional @cajusolvallejosDesarrolloAplicacionWeb2020
- Desarrollar un sistema web de trámite documental para mantener las acreditadoras de la escuela de ingeniería informática de la URP @zegarrajibajaDesarrollarSistemaWeb2019.

De estos trabajos podemos destacar dos por su relevancia con el proyecto que se propone en este documento:

==== Sistema de control de trámites utilizando máquinas de Turing

En este proyecto de grado, realizado el año 2007, se toma como enfoque teórico a las máquinas de Turing. En dichas máquinas, que son un modelo matemático de computación, se describe una suerte de cinta dividida en casillas que funciona como memoria y un cabezal que escribe y lee de esa cinta, cambiando de estados. Esta conceptualización, sin ser estrictamente especificada se puede ver repetida en otras implementaciones de módulos de control de trámites.

==== Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí

Esta tesis busca demostrar la importancia de la creación de un módulo específico de trámites que sea *reutilizable*. Brinda algunas recomendaciones sobre su implementación, pero no realiza ninguna implementación práctica.

=== En el ámbito comercial o práctico

Si bien, no existen módulos de trámite que se puedan integrar en sistemas más grandes de manera comercial, sí se pueden ver sistemas completos con la funcionalidad de gestión de trámites que ofrecen todo lo necesario para llevar a cabo procesos administrativos. Algunos son:

- _SoftExpert_: Gestión de Trámites: Visibilidad y control sobre el procesamiento de documentos, archivos y objetos

- R2 Docuo: Expedientes, Solicitudes y trámites a toda velocidad: En su _homepage_ puede verse la funcionalidad de seguimiento temporal de trámites (@fig:r2docuotimeline)
#figure(
  image("../assets/r2docuotimeline.png", width: 50%),
  caption: [Captura de pantalla del homepage de R2 Docuo donde se puede ver el timeline de un trámite\ Fuente: www.r2docuo.com],
)<fig:r2docuotimeline>

- _Filestage_: Si bien no es específico para trámites, tiene un sistema de tránsito de documentos hasta su aceptación, que es una funcionalidad común en los trámites.

- Odoo: Es un ERP @ERPCRMCodigo con herramientas para el manejo de flujos de trabajo (BPM) y cuenta con un diseño modular, permitiendo la creación de soluciones de terceros, entre las cuales existe una, ya sin mantenimiento, que permite crear flujos desde una GUI (@fig:odoowfms).
#figure(
  image("../assets/odoowfms.png", width: 50%),
  caption: [Descripción de módulo de manejo de flujos de trabajo en Odoo\ Fuente: Captura de pantalla tomada de la tienda de extensiones de Odoo],
)<fig:odoowfms>

- COSA: Un gestor de flujos de trabajo antiguo que se menciona como ejemplo de caso de uso de redes de Petri en un WFMS @vanderaalstAPPLICATIONPETRINETS1998, esto mediante una herramienta llamada CONE (@fig:conecosa).
#figure(
  image("../assets/conecosa.png", width: 40%),
  caption: [Screenshot tomada del artículo "The Application of Petri Nets to Workflow Management" @vanderaalstAPPLICATIONPETRINETS1998],
)<fig:conecosa>

- Insite CRM: CRM desarrollado por Insite @tanjaOPERATIONALCRM2024, el cual cuenta con un módulo de gestión de flujos de trabajo (@fig:insitecrm)
#figure(
  image("../assets/insitecrm.png", width: 50%),
  caption: [Screenshot de video tutorial del producto Insite CRM],
)<fig:insitecrm>


Se debe notar que si bien los dos primeros logran la funcionalidad deseada en este proyecto, no permiten la personalización, no son necesariamente software libre y no se pueden introducir en sistemas más grandes de la misma manera que lo haría un paquete de software reutilizable.
