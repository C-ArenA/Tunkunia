= Situación Actual <section:current_situation>

En relación al contexto planteado en la sección de antecedentes, así como el desarrollo de sistemas modernos de software y la modularización de funcionalidades,
resulta fundamental exponer, antes de abordar los aspectos específicos del proyecto, el estado de la situación en distintos niveles, como pueden ser la normativa vigente, definiciones y acepciones relevantes, trabajos similares en el campo, tecnologías utilizadas, investigaciones académicas pertinentes, y buenas prácticas de la industria, entre otros.

== Trámites y Procedimientos Administrativos en la actualidad

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea. ¿El resultado? Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La anterior cita, si bien se realiza en base a un estudio realizado el año 2018 @rosethFinTramiteEterno2018, refleja parcialmente la situación actual ante la falta de estudios más recientes. En general, si bien se nota una mayor adopción de los trámites digitales, aún existen muchos que se realizan de forma total o parcialmente manual.

=== Normativa
Al respecto del trámite administrativo es menester citar al Decreto Supremo N° 3525 que tiene como uno de sus objetos normar la *tramitación digital* @DECRETOSUPREMO35252018. En dicho Decreto, podemos resaltar lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 12])[
  *Trámites Administrativos:*

  I. Las instituciones públicas *deberán priorizar en todos sus trámites el uso de tecnologías de información* y comunicación a efecto de digitalizar, automatizar, interoperar y simplificar la tramitación de los asuntos que son de su competencia.

  II. Para facilitar la realización de trámites a la ciudadanía, las entidades públicas, en observancia de su normativa específica, deberán intercambiar entre ellas datos e información mediante interoperabilidad. Los mecanismos y condiciones de publicación y acceso a los servicios de interoperabilidad serán establecidos por el Ente Rector de Gobierno Electrónico y Tecnologías de Información y Comunicación.

  III. El intercambio de datos e información mediante interoperabilidad no afectará la percepción de recursos de las entidades públicas titulares de la información por la prestación del servicio público.

  IV. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido emitido por la misma entidad, o cuya información esté disponible mediante servicios de interoperabilidad de otra entidad.

  V. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido requerido con anterioridad, salvo actualización o modificación y conforme a normativa legal vigente. VI. Las entidades públicas tendrán un plazo máximo de veinte (20) días hábiles a partir de la publicación de un nuevo servicio de interoperabilidad para adecuar sus procesos y procedimientos al mismo]

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

== Gobierno Electrónico

El gobierno electrónico es una tendencia ya desde hace algunos años. Al realizar un proyecto alrededor del trámite es necesario conocer algunas de sus definiciones y acepciones actuales. Las siguientes son definiciones de distintas fuentes:

#set quote(block: true)
#quote(attribution: [Secretaría de la función pública del Gobierno de México @publicaGobiernoDigitalElectronico])[
  El concepto de Gobierno Electrónico incluye todas aquellas actividades basadas en las modernas tecnologías informáticas, en particular Internet, que el Estado desarrolla
  para aumentar la eficiencia de la gestión pública, mejorar los servicios ofrecidos a los ciudadanos y proveer a las acciones de gobierno de un marco mucho más transparente que el actual.]

Por su lado, la AGETIC, institución del Gobierno de Bolivia, define Gobierno Electrónico como:

#quote(attribution: [AGETIC @GobiernoElectronico])[
  ...la aplicación de las tecnologías de la información y la comunicación (TIC) al funcionamiento del sector público,
  con el objeto de incrementar la eficiencia, la transparencia y la participación ciudadana.
  Engloba la interacción digital entre el estado y los ciudadanos, entre entidades públicas, el Estado y los servidores públicos y, entre el Estado y las empresas,
  contribuyendo al uso intensivo de las TIC.
]

El Banco Mundial lo define como "El uso de las tecnologías de la información y comunicaciones para mejorar la eficiencia, la efectividad, la transparencia y la rendición de cuentas del gobierno".

Las Naciones Unidas, por su lado, lo definen como "La utilización de Internet y la _World Wide Web_ para entregar información y servicios del gobierno a los ciudadanos.

El elemento clave en estas definiciones es la "gestión pública por medios digitales" @naserGobiernoElectronicoGestion2011.

Al día de hoy se podría decir que ser un gobierno electrónico es más que una simple tendencia y, aunque tras la pandemia del COVID-19 se hizo una necesidad, ahora parece ser la norma

Esto puede verse reflejado en el reporte sobre gobiernos digitales de las Naciones Unidas,
donde el indicador _EGDI (e-government Development Index)_, que mide la adopción de políticas que favorecen la implementación del gobierno electrónico,
tuvo un aumento relevante en tan sólo dos años (@fig:egdi2020_2022).

#figure(
  image("../assets/egdi2020_2022.png", width: 60%),
  caption: [Valores promedio del EGDI y sus componentes\ Fuente: 2020 and 2022 United Nations E-Government Surveys],
)<fig:egdi2020_2022>

=== Normativa

Existe en Bolivia abundante normativa relevante en cuanto a la adopción del gobierno electrónico. A continuación se citan las más importantes de acuerdo al enfoque presentado en este documento.

Es menester citar inicialmente a la Constitución Política del Estado Plurinacional de Bolivia, misma que en sus artículos 103 y 298 denota la importancia del desarrollo de la ciencia y la investigación a favor de las bolivianas y los bolivianos.
Además, reconoce como prioridad el uso de las tecnologías y comunicación para el vivir bien:

#quote(attribution: "Artículo 103 de la Constitución Política del Estado Plurinacional de Bolivia")[
  I. El Estado garantizará el desarrollo de la ciencia y la investigación científica, técnica y tecnológica en beneficio del interés general. Se destinarán los recursos necesarios y se creará el sistema estatal de ciencia y tecnología.

  II. El Estado asumirá como política la implementación de estrategias para incorporar el conocimiento y aplicación de nuevas tecnologías de información y comunicación.

  III. El Estado, las universidades, las empresas productivas y de servicio públicas y privadas, y las naciones y pueblos indígena originario campesinos, desarrollarán y coordinarán procesos de investigación, innovación, promoción, divulgación, aplicación y transferencia de ciencia y tecnología para fortalecer la base productiva e impulsar el desarrollo integral de la sociedad, de acuerdo con la ley.
]

#quote(attribution: [Artículo 298 de la Constitución Política del Estado Plurinacional de Bolivia])[
  ...Declara prioridad nacional la promoción del uso de las tecnologías de información y comunicación para procurar el vivir bien de todas las bolivianos y bolivianos.]

A su vez, es importante citar la Ley N°164 - Ley General de Comunicaciones, Tecnologías de Información y Comunicación, pues en su Artículo 71 declara prioridad nacional la promoción y uso de tecnologías de información y comunicación para procurar el vivir bien de todas las bolivianas y bolivianos.

Por otra parte, el párrafo I del Artículo 72 de la citada noma legal, establece el rol de Estado con referencia al uso de las TIC'S, el despliegue y uso de infraestructura, el desarrollo de contenidos y aplicaciones, la protección de las usuarias y usuarios, la seguridad informática y redes como mecanismos de democratización de oportunidades para todos los sectores de la sociedad y especialmente para aquellos con menores ingresos y con necesidades especiales. Posteriormente en el Artículo 75 de la citada norma legal, se hace referencia al Gobierno Electrónico, que se establece de forma expresa de acuerdo a lo siguiente:

#quote[
  I. El nivel central del Estado promueve la incorporación del Gobierno Electrónico a los procedimientos gubernamentales, a la prestación de sus servicios y a la difusión de información, mediante una estrategia enfocada al servicio de la población.
  II. El Órgano Ejecutivo del nivel central del Estado, elaborará los lineamientos para la incorporación del Gobierno Electrónico.]

También, el Artículo 76, define el Alcance de Gobierno Electrónico, señalando lo siguiente:

#quote[...El Estado fijará los mecanismos y condiciones que las entidades públicas aplicarán para garantizar el máximo aprovechamiento de las tecnologías de la información y comunicación, que permitan lograr la prestación de servicios eficientes.]

Otra normativa que regula lo referente al Gobierno Electrónico, es el "Reglamento para el Desarrollo de Tecnologías de Información y Comunicación", mismo que en su Art. 17 establece el objetivo de Gobierno Electrónico, señalando lo siguiente:

#quote[...I. Modernizar y transparentar la gestión pública, otorgando servicios y atención de calidad a la ciudadanía, garantizando el derecho a la información, así como contribuir a la eficiencia y eficacia de los actos administrativos en los procesos internos del gobierno, mediante el uso de las tecnologías de información y comunicación y otras herramientas. II. Generar mecanismos tecnológicos de participación y control social, mediante el uso de TIC por parte de los ciudadanos, organizaciones sociales y pueblos y naciones indígena originario campesinos.]

== Reglamento ambiental para el sector industrial manufacturero

El Artículo 1 del Decreto Supremo 26376, aprueba el Reglamento Ambiental para el Sector Industrial Manufacturero @DecretoSupremo263762002. En dicho reglamento se regulan las actividades del sector industrial manufacturero para reducir la generación de contaminantes y el uso de sustancias peligrosas, optimizar el uso de recursos naturales y de energía para proteger y conservar el medio ambiente @ReglamentoAmbientalPara.

Para lograr lo anterior, se plantean una serie de procedimientos, desde el registro de industrias mediante un formulario llamado RAI (Registro Ambiental Industrial). Si bien el reglamento detalla dichos procedimientos y documentos (llamados Instrumentos de Regulación Ambiental Particular), existe también una guía @garciaGuiaGeneralAplicacion2003, la cual lista los siguientes IRAPs:

- RAI: Registro Ambiental Industrial
- EEIA: Estudio de Evaluación de Impacto Ambiental
- DP: Descripción del Proyecto
- PMA: Plan de Manejo Ambiental
- MAI: Manifiesto Ambiental Industrial
- ARI-PC: Análisis de Riesgos Industriales y Plan de Contingencias
- IAA: Informe Ambiental Anual

Cada uno de los instrumentos listados conlleva a una serie de trámites para su presentación. Además, existe relación entre ellos, pudiendo uno habilitar al otro.

=== SIAI

El Sistema de Información Ambiental Industrial (SIAI), establecido en el Artículo 99 del RASIM @ReglamentoAmbientalPara, aglutina los distintos instrumentos de regulación para garantizar el acceso a la información, además de difundir documentos relacionados.

La implementación actual del SIAI contempla el llenado de instrumentos de regulación atendiendo las características de cada trámite y sus relaciones. Los trámites consisten de forma general en la presentación de documentos para la aceptación por diferentes niveles de administración de acuerdo a verificaciones específicas hasta conseguir un resultado, que puede ser el registro de una industria o la obtención de un certificado.

== FOSS y Soberanía digital

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

Al respecto, en el "Plan de Implementación de Software Libre y Estándares Abiertos" de Bolivia se define al software libre del modo siguiente:

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

=== Normativa

A continuación se lista la normativa relevante al software libre. Respetando el orden jerárquico de la normativa en Bolivia, en referencia al uso de software libre y soberanía digital, se debe primero señalar que en la Constitución Política del Estado Plurinacional de Bolivia, existe el deber de:

#quote(attribution: [Constitución Política del Estado Plurinacional de Bolivia, Artículo 108])[
  Defender la unidad, la soberanía y la integridad territorial de Bolivia, y respetar sus símbolos
  y valores
]

Es muy importante citar la Ley N° 164 @Ley164Ley2011, misma que establece lo siguiente acerca del software libre:

#quote(attribution: [Artículo 77, Ley Nº 164])[
  I. Los Órganos Ejecutivo, Legislativo, Judicial y Electoral en todos sus niveles,
  promoverán y priorizarán la *utilización del software libre y estándares abiertos*, en
  el marco de la soberanía y seguridad nacional.

  II. El Órgano Ejecutivo del nivel central del Estado, elaborará el *plan de
  implementación de software libre y estándares abiertos* en coordinación con los
  demás órganos del Estado y entidades de la administración pública.]

Como se evidencia de la normativa señalada anteriormente el Software libre hoy en día se encuentra regulado y se establecen los lineamientos y directrices para su implementación y posterior aplicación en nuestro país.

== Proyectos y trabajos similares
// TODO: Añadir POTyS, que aparentemente no cae en académico ni comercial, así que debemos reformular la sección
=== A nivel académico

Debido a la cantidad de procesos administrativos que existen en distintas instituciones, podemos encontrar una gran cantidad de proyectos de grado realizados en la región que tratan sobre la implementación de sistemas de control de trámites:

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

=== A nivel comercial

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

=== Software Libre

La cantidad de paquetes de software que existen y que se puede considerar que ayudan en el proceso de gestión, control y seguimiento de trámites es abundante, por lo que nos centraremos en aquellas presentes en el ecosistema de _Laravel_.

El seguimiento de trámites requiere que tengamos guardada la información de todos los pasos de un trámite y los cambios realizados. Además, la naturaleza de los trámites, como se podrá ver en el análisis de la solución, tiene que ver con estados (pasos de un procedimiento administrativo). Es por esto que las siguientes librerías podrían ser utilizadas con un objetivo similar al paquete que se pretende desarrollar en este proyecto:

- _Laravel Auditing_: Permite mantener control sobre los datos en una aplicación y para hacer seguimiento de los cambios realizados en los mismos. Es muy potente y fácil de usar.
- _Laravel Eloquent State Machines_: Máquinas de estado aplicadas sobre los modelos _Eloquent_ (@fig:laravelstatemachines).
- _Laravel-Permission_: Permite asociar usuarios con roles.

#figure(
  image("../assets/laravelstatemachines.png", width: 50%),
  caption: [Paquete de manejo de estados en Laravel\ Fuente: https://github.com/asantibanez/laravel-eloquent-state-machines],
)<fig:laravelstatemachines>

De los tres paquetes anteriores, sin duda el de las máquinas de estados es el que más se acerca a lo que se requiere en este proyecto. La funcionalidad es similar a la que se pretende, pero no es específica a los procesos administrativos y por lo tanto no brinda ciertas herramientas que podrían ser necesarias en los mismos, como el seguimiento, el cual podría ser implementado con la ayuda del segundo paquete mencionado.

== WFMS y BPM

Existe en la actualidad un tipo de sistema que va muy de la mano con el propuesto en este proyecto, el cual es el WFMS (Workflow Management System). Estos sistemas contemplan de forma general el manejo de flujos de trabajo. De forma similar, y a veces usado de forma indistinta con WFM existe el término BPM (Business Process Management), que de modo más amplio es el arte y la ciencia de supervisar cómo el trabajo es realizado dentro de una organización.

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

== LLMs e Inferencia

Un modelo grande de lenguaje (LLM) es un tipo de inteligencia artificial que reconoce y genera texto, entre otras tareas. Los LLMs son entrenados en conjuntos grandes de datos, por eso el nombre de "grande" (large). Los LLMs se construyen en base a machine learning, en específico un tipo de red neuronal llamado transformer @WhatLLMLarge.

Con la salida al mercado de forma gratuita de ChatGPT el 30 de Noviembre de 2022 @ChatGPTTurns1euro, el mundo sufrió un cambio importante, ya que se empezaron a utilizar de forma masiva los grandes modelos de lenguaje (LLMs). Los modelos de lenguaje, si bien existen ya hace mucho tiempo, no lograron el nivel de precisión e inteligencia aparente sino hasta hace un par de años.

Uno de los servicios alrededor de los LLMs es el uso de APIs que permiten la integración de dichas herramientas en distintos sistemas. Las aplicaciones son muchas y aún se siguen explorando. Sin embargo, es claro el uso de la inferencia en base a inteligencia artificial.

La inferencia consiste en usar modelos de inteligencia artificial ya entrenados para reconocer patrones y sacar conclusiones sobre información nueva que no vieron antes @WhatAIInference2024. Dicho enfoque puede usarse para analizar documentos y, en general, datos, sin necesidad de entrenar otro modelo.
/*
== Sistemas de flujo de procesos
=== WFMS
=== WfMC
=== BPMS

== Herramientas para modelar estados
=== Máquinas de Estado Finitas
=== Redes de Petri
=== Diagramas de actividad UML

== Tecnologías de software
=== Lenguajes de Programación
==== PHP
==== JavaScript
==== Typescript
==== HTML
==== CSS
=== Frameworks y Librerías
==== Laravel
==== Vue
==== Spatie
==== UI kits
==== UX tools
==== Librerías de Flujo de Procesos
=== Sistemas de Control de Versiones
==== Git
==== GitHub
==== GitLab
==== Flujos de trabajo en Git
=== Datos
==== SGBD
==== ORMs

== Arquitectura y Planificación
=== SOA
=== Rest API
=== Autenticación y Roles
=== Prácticas y roles de desarrollo de software
=== Monolitos
=== Manejadores de Paquetes
=== Documentación y Gráficos
=== Herramientas de Gestión de Proyectos

== infraestructura de despliegue


== Tendencias del mercado y herramientas
=== Inteligencia Artificial
=== Asistentes de Desarrollo
=== APIs de inferencia LLM
=== Simulador de Redes de Petri
*/
