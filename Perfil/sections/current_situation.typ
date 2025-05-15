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
  placement: auto,
)<fig:internet_use>

Bolivia no es la excepción a esta tendencia, ya que el año 2023 se estima que el 70,2% de la población boliviana ya contaba con acceso a Internet, como puede verse en la @fig:internet_use_bolivia.
Es decir que el país se encontraría por encima del promedio mundial de adopción de Internet. Sin embargo, aún queda un 29,8% de la población que no tiene acceso a Internet @IndividualsUsingInternet.

#figure(
  image("../assets/internet_use_bolivia.png", width: 80%),
  caption: [Número de usuarios de Internet en Bolivia y su crecimiento\ Fuente: #acr("UIT")],
  placement: auto,
)<fig:internet_use_bolivia>

Se debe tomar en cuenta que uno de los factores posiblemente acelerando la adopción de Internet es la cantidad de beneficios que trae consigo mediante la Web y las "webapps" (aplicaciones web), que son aplicaciones que se ejecutan en un navegador web y no requieren instalación en el dispositivo del usuario. Inicialmente, dichas aplicaciones eran puramente informativas, pero con la llegada de la Web 2.0, estas webapps evolucionaron a plataformas digitales completas, integrándose con aplicaciones de negocios @pressmanSoftwareEngineeringPractitioner2010. Muchas aplicaciones móviles también utilizan la red de redes para brindar sus servicios de manera similar.

De este modo, el uso de las plataformas digitales también ha incrementado bastante. Podemos ver ejemplos como el de la @fig:ecommerce_adoption, en la que se ve la tendencia en la adopción de plataformas de comercio electrónico y cómo esta parece haber sido acelerada por la pandemia del COVID-19 en distintos países de América Latina y el Caribe.

#figure(
  image("../assets/ecommerce_adoption.png", width: 80%),
  caption: [Tendencia de adopción de plataformas de comercio electrónico en América Latina y el Caribe\ Fuente: Latinobarómetro],
  placement: auto,
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
  placement: auto,
)<fig:egdi2020_2022>

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea. ¿El resultado? Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La anterior afirmación, si bien se cita de un estudio realizado el año 2018 @rosethFinTramiteEterno2018, refleja de forma aproximada la situación actual ante la falta de estudios más recientes. En general, si bien se nota una mayor adopción de los trámites digitales, aún existen muchos que se realizan de forma total o parcialmente presencial. Sin embargo, podemos encontrar una tendencia clara en la evolución hacia los gobiernos electrónicos y, siendo los servicios electrónicos una de sus áreas más relevantes @naserGobiernoElectronicoGestion2011, se espera que más trámites se digitalicen en el futuro. Lo anterior se hizo evidente durante la pandemia del COVID-19, durante la cual hubo un aumento considerable de canales digitales para la realización de trámites, llegando a remplazar alrededor del 20% de los trámites presenciales en distintos países de América Latina @rosethServiciosPublicosGobierno2021.

#include "current_situation_norm.typ"

== Tendencias tecnológicas

Las necesidades que surgen alrededor de la digitalización de trámites son diversas. Sin embargo, para resolver este tipo de problemas existen algunas prácticas que se han vuelto comunes, tanto a nivel de desarrollo de software, de sistemas y de enfoques. A su vez, pueden existir tendencias tecnológicas generales que potencialmente logren aportar a este proyecto. Las mismas no necesariamente responden a los trámites realizados por entidades públicas, sino a entidades privadas que enfrentan necesidades similares, pero pueden ser igualmente aplicadas. Algunas de estas tendencias se describen a continuación.

=== Reutilización de Software

La reutilización de software (software reuse) es el uso sistemático de piezas existentes de software para construir otras nuevas, modificadas o incluso productos de software completos a partir de las mismas. Estas piezas pueden ser código fuente, ejecutables, guìas de diseño, componentes de software libre, componentes comerciales, o arquitecturas completas. Es importante resaltar que el conocimiento también es reutilizable y se ve reflejado en la reutilización de patrones, procesos o arquitecturas de software @mohagheghiQualityProductivityEconomic2007. Las formas en que las piezas reutilizables se materializan son variadas y pueden incluir bibliotecas o librerías, frameworks, componentes, sistemas de software completos, etc (@fig:reuse_landscape).

#figure(
  image("../assets/reuse_landscape.png", width: 60%),
  caption: [Reuse landscape\ Fuente: Sommerville, Software Engineering @sommervilleSoftwareEngineering2016],
  placement: auto,
)<fig:reuse_landscape>

Por la naturaleza de la reutilización del software, que consiste en usar trabajo existente como bloques de construcción para proyectos más grandes, se relaciona a esta práctica con un aumento en la productividad y una disminución en los costos. Sin embargo, medir de forma empírica estos beneficios es bastante difícil y algunos intentos realizados, si bien pueden no contemplar todas las variables posibles, dada la naturaleza particular de cada proyecto, han mostrado resultados positivos, indicando que existe un claro aumento de productividad al reutilizar software @basiliHowReuseInfluences1996. Esto implicaría también beneficios en los tiempos y costos de desarrollo, reafirmando lo atractivo de la reutilización del software.

#figure(
  image("../assets/mobile_reuse.png", width: 60%),
  caption: [Porcentaje de reutilización de software en aplicaciones móviles\ Fuente: A large-scale empirical study of the reuse of software components in mobile applications @mojicaLargeScaleEmpiricalStudy2014],
  placement: auto,
)<fig:mobile_reuse>

La reutilización de software se ha popularizado bastante en los últimos años, particularmente con el auge de los sistemas de código abierto y la creación de plataformas digitales. Esta tendencia también responde a la demanda por la disminución de costos de producción y mantenimiento de software, entregas más rápidas de los sistemas y mejoras en la calidad del software @sommervilleSoftwareEngineering2016.

En este sentido, la @fig:mobile_reuse, que forma parte de un estudio publicado el año 2014, sobre la reutilización de software en el desarrollo de aplicaciones móviles, halló que en las distintas categorías de aplicaciones analizadas, existe un alto porcentaje de reutilización #footnote[La reutilización en este estudio fue medida calculando la proporción de clases reutilizadas sobre la cantidad total de clases de cada proyecto], por encima del 62% @mojicaLargeScaleEmpiricalStudy2014.

Esta tendencia se ve también en otros campos del desarrollo de software, particularmente en el desarrollo web, donde se popularizó la herramienta de gestión de paquetes #acr("NPM") para facilitar la reutilización de código en el desarrollo de aplicaciones web y sobre la cual se puede evidenciar un aumento significativo de paquetes reutilizables, con más de un millón registrados el año 2022 y con un crecimiento del 60% entre los meses de enero del 2019 y 2022 @mujahidWhatAreCharacteristics2023. Una búsqueda actual (2025) en el sitio oficial de #acr("NPM") muestra que existen ya más de dos millones de paquetes disponibles en su registro y que cuenta con la contribución de más de 17 millones de desarrolladores de software a nivel mundial @NpmHome.

// Hablaremos de cómo se reutiliza el software en la actualidad (métodos)

=== Sistemas de Gestión de Flujos de Trabajo y Procesos

Existe en la actualidad un tipo de sistema que va muy de la mano con el propuesto en este proyecto, el cual es el #acr("WFMS"). Estos sistemas contemplan de forma general el manejo de flujos de trabajo. De forma similar, y a veces usado de forma indistinta con WFM existe el término BPM (Business Process Management), que de modo más amplio es el arte y la ciencia de supervisar cómo el trabajo es realizado dentro de una organización.

Toda organización, incluido por supuesto el aparato gubernamental, debe manejar *procesos* @dumasFundamentalsBusinessProcess2013, siendo los trámites típicos ejemplos. Es por esto que tanto los WFMS y BPM tienen bastante relevancia en los sistemas de software.

Tal es la relevancia que existe una organización dedicada a estandarizar los WFMS y BPM, la cual fue fundada el año 1993 y es llamada "Workflow Management Coalition" (WfMC) @WorkflowManagementCoalition. Dicha organización define a los WFMS de la siguiente manera:

#quote(attribution: [Workflow Management Coalition])[
  A workflow management system (WMS) is a software application that is designed to help organizations automate and manage their business processes. A WMS allows an organization to define and implement a workflow - a series of tasks, steps, and decisions - that need to be followed to complete a specific process. The system can then be used to track the progress of the workflow, manage the flow of information and documents, and ensure that tasks are completed in the correct order and by the right people.

  A WMS can be used to automate a wide range of business processes, such as invoicing, order fulfillment, human resources, and project management. It can also be used to integrate different systems, such as email, calendar, and customer relationship management (CRM) software. WMS allows you to streamline the process and make it more efficient, reduce errors and delays, and give you real-time visibility into the status of your processes, also it's common to have a built-in reporting and analytics tools to measure the performance of the process.
]

#figure(
  image("../assets/wfms_history.png"),
  caption: [WFMS desde una perspectiva histórica\ Fuente: The Application of Petri Nets
    to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)<fig:wfms_history>

La necesidad de manejar flujos de trabajo es realmente frecuente en muchos sistemas, por lo que ciertos autores creen que debe ser un módulo tan importante como el sistema de gestión de bases de datos, como se puede aproximar mediante la @fig:wfms_history.

Podemos entender, de forma general y sintética, que el propósito principal de los sistemas de flujo de trabajo (WFMS) es el apoyo en la definición, ejecución, registro y control de procesos @vanderaalstAPPLICATIONPETRINETS1998, algo que posteriormente podría guiar en la implementación de un sistema específico a los trámites administrativos.

=== Arquitecturas Modulares y Distribuidas

// Hablaremos de modularidad
// Hablaremos de nuevas arquitecturas como microservicios
// Hablaremos de la interoperabilidad y los subsistemas con el ejemplo del proyecto SINER

=== Proyectos de Software Libre

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
  image("../assets/github_contributions.png", width: 50%),
  caption: [Número de contribuciones a proyectos públicos y de software libre en GitHub (2021-2024)\ Fuente: GitHub Octoverse],
  placement: auto,
)<fig:github_contributions>

Una de estas empresas es Microsoft que, entre otras cosas, adquirió la plataforma de colaboración GitHub en el año 2018, la cual es la plataforma más popular para el desarrollo de software libre y de código abierto. Como parte del trabajo realizado por esta compañía, tenemos disponibles algunos datos sobre el estado del software libre en el reporte "GitHub Octoverse" @staffOctoverseAILeads2024. Estos son algunos datos relevantes:


- El año 2024, desarrolladores de todo el mundo realizaron cerca de 1000 millones de contribuciones (1 billion contributions) a proyectos públicos y de software libre en GitHub. Esto representa un aumento respecto a años anteriores, como puede apreciarse en la @fig:github_contributions.
- Una de las principales motivaciones para contribuir a proyectos de software libre es el poder aportar a la comunidad y generar cambios positivos en la sociedad. Algunos proyectos que han motivado a contribuidores nóveles están relacionados con el sistema de orfanatos para personas jóvenes, la investigación de drogas en países de ingresos medios y bajos, y la creación de herramientas para ayudar a las personas a denunciar maltratos de forma anónima.

Este último dato señala algo importante y sobre lo cual Haefliger, von Krogh y Spaeth profundizan en uno de sus artículos @vonkroghCarrotsRainbowsMotivation2012 y es que el desarrollo del software libre podría tener una motivación social y comunitaria, más allá de lo económico.

=== Herramientas de Modelado de Procesos

Cuando se habla de trámites, de acuerdo a las definiciones establecidas en la sección de antecedentes, se hace referencia a *procesos* administrativos. Por lo tanto, es importante mencionar que existen herramientas de modelado de procesos que permiten representar gráficamente los mismos. Estas herramientas son útiles para entender y analizar los procesos, así como para identificar áreas de mejora. También, muchas de estas herramientas podrían servir para la definición de los trámites que puedan ser llevados a cabo mediante el subsistema propuesto en este proyecto.

Algunas de estas herramientas son:

- BPMN (Business Process Model and Notation): Es un estándar de modelado de procesos que permite representar gráficamente los procesos de negocio. BPMN es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- EPC (Event-driven Process Chain): Es una técnica de modelado de procesos que se utiliza para representar procesos de negocio de manera gráfica. EPC es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- UML (Unified Modeling Language): Es un lenguaje de modelado que se utiliza para representar sistemas de software. UML es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- IDEF (Integration Definition): Es un conjunto de métodos y técnicas de modelado de procesos que se utilizan para representar procesos de negocio de manera gráfica. IDEF es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- ARIS (Architecture of Integrated Information Systems): Es una herramienta de modelado de procesos que se utiliza para representar procesos de negocio de manera gráfica. ARIS es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- Flowchart: Es una técnica de modelado de procesos que se utiliza para representar procesos de negocio de manera gráfica. Flowchart es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- SIPOC (Suppliers, Inputs, Process, Outputs, Customers): Es una técnica de modelado de procesos que se utiliza para representar procesos de negocio de manera gráfica. SIPOC es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- Six Sigma: Es una metodología de mejora de procesos que se utiliza para representar procesos de negocio de manera gráfica. Six Sigma es ampliamente utilizado en la industria y es compatible con muchas herramientas de modelado de procesos.
- Máquinas de Turing: Es un modelo matemático de computación que se utiliza para representar procesos de negocio de manera gráfica. Las máquinas de Turing son ampliamente utilizadas en la industria y son compatibles con muchas herramientas de modelado de procesos.
- Máquinas de estados: Es un modelo matemático de computación que se utiliza para representar procesos de negocio de manera gráfica. Las máquinas de estados son ampliamente utilizadas en la industria y son compatibles con muchas herramientas de modelado de procesos.
- Redes de Petri: Es un modelo matemático de computación que se utiliza para representar procesos de negocio de manera gráfica. Las redes de Petri son ampliamente utilizadas en la industria y son compatibles con muchas herramientas de modelado de procesos.

=== Inteligencia Artificial

Es difícil no hablar de inteligencia artificial (IA) en la actualidad. La IA ha tenido un crecimiento exponencial en los últimos años, y su uso se ha vuelto común en muchos ámbitos. Sin embargo, es importante aclarar que la IA no es un concepto nuevo, sino que ha existido desde hace décadas. Lo que ha cambiado es la forma en que se aplica y la cantidad de datos disponibles para entrenar modelos de IA.

Una forma de IA que se popularizó en años recientes es la de los grandes modelos de lenguaje (LLM), que son un tipo de inteligencia artificial que reconoce y genera texto, entre otras tareas. Los LLMs son entrenados en conjuntos grandes de datos, por eso el nombre de "grande" (large). Los LLMs se construyen en base a machine learning, en específico un tipo de red neuronal llamado transformer @WhatLLMLarge.

Con la salida al mercado de forma gratuita de ChatGPT el 30 de Noviembre de 2022 @ChatGPTTurns1euro, el mundo sufrió un cambio importante, ya que se empezaron a utilizar de forma masiva los grandes modelos de lenguaje (LLMs). Los modelos de lenguaje, si bien existen ya hace mucho tiempo, no lograron el nivel de precisión e inteligencia aparente sino hasta hace un par de años.

Uno de los servicios alrededor de los LLMs es el uso de APIs que permiten la integración de dichas herramientas en diversos sistemas. Las aplicaciones son muchas y aún se siguen explorando. Sin embargo, una de ellas es claramente el uso de la inferencia en base a inteligencia artificial.

La inferencia consiste en usar modelos de inteligencia artificial ya entrenados para reconocer patrones y sacar conclusiones sobre información nueva que no vieron antes @WhatAIInference2024. Dicho enfoque puede usarse para analizar documentos y, en general, datos, sin necesidad de entrenar otro modelo.

Este análisis de documentos tiene cierto parecido con el análisis realizado por funcionarios públicos al momento de revisar los formularios de un trámite. Sin embargo, hoy en día se siguen empleando servidores fuera de Bolivia para emplear estos modelos de lenguaje, por lo que su utilización podría estar limitada por la normativa vigente en el país. Aún así, es importante mencionar este tipo de posibles aplicaciones dentro del proceso de digitalización de trámites.

== Trabajos Relacionados

Para poder identificar los trabajos relacionados a este proyecto se buscaron los mismos en torno al trámite digital y distintos procesos administrativos, tanto en el sector público, como en el sector privado. Esto nos permite abarcar trabajos relacionados de forma directa e indirecta. Se debe tomar en cuenta que estos trabajos carecen de características fundamentales como la reutilización o la naturaleza de software libre y no se encontró ninguno que cumpla con todas las características deseadas. Sin embargo, muchos de ellos sí tienen una gran cantidad de funcionalidades o conceptos que podrían inspirar el desarrollo del subsistema propuesto en este proyecto.

=== En el ámbito académico

Debido a la cantidad de procesos administrativos que existen en distintas instituciones, podemos encontrar también una gran cantidad de proyectos de grado realizados que tratan sobre la implementación de sistemas de control de trámites:

- *Sistema de Control de Trámites utilizando Máquinas de Turing para la División de Gestiones, Admisiones y Registros U.M.S.A.* @nachoSISTEMACONTROLTRAMITES2007: En este proyecto de grado, realizado el año 2007, se toma como base teórica a las máquinas de Turing. En dichas máquinas, que son un modelo matemático de computación, se describe una suerte de cinta dividida en casillas que funciona como memoria y un cabezal que escribe y lee de esa cinta, cambiando de estados. Esta conceptualización, sin ser estrictamente especificada se puede ver repetida en otras implementaciones de módulos de control de trámites.

- *Desarrollo e Implementación del Sistema de Tramite Documentario en la Municipalidad Provincial de Huancayo para la atencion de expedientes* @bastidasparragaDesarrolloImplementacionSistema2016.

- *DESARROLLO DE UN SISTEMA WEB PARA MEJORAR EL PROCESO DE TRÁMITE DOCUMENTARIO ADMINISTRATIVO DEL HOSPITAL SUB REGIONAL DE ANDAHUAYLAS* @quispeperezDESARROLLOSISTEMAWEB2018.

- *Sistema de información de trámite documentario basado en tecnología web para institutos de educación superior tecnológicos de la región Ancash en el año 2016* @tapiajacintoSistemaInformacionTramite2017.

- *Programa de automatización de los procedimientos de trámite documentario en la calidad del servicio a los usuarios del Hospital Nacional Arzobispo Loayza - Lima, 2016* @cepedagamioProgramaAutomatizacionProcedimientos2017.

- *Implementación de un sistema de trámite documentario para la Agencia de Compras de las Fuerzas Armadas* @yrupailladiazImplementacionSistemaTramite2019.

- *Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí, 2018* @murosalazarImplementacionModuloControl2018: Esta tesis busca demostrar la importancia de la creación de un módulo específico de trámites que sea *reutilizable*. Brinda algunas recomendaciones sobre su implementación, pero no realiza ninguna implementación práctica.

- *Desarrollo de una aplicación _web responsive_ para mejorar el proceso de trámite documentario en un colegio profesional* @cajusolvallejosDesarrolloAplicacionWeb2020

- *Desarrollar un sistema web de trámite documental para mantener las acreditadoras de la escuela de ingeniería informática de la URP* @zegarrajibajaDesarrollarSistemaWeb2019.

=== Fuera del ámbito académico

Si bien, no existen módulos de trámite que se puedan integrar en sistemas más grandes de manera comercial, sí se pueden ver sistemas completos con la funcionalidad de gestión de trámites que ofrecen todo lo necesario para llevar a cabo procesos administrativos. Algunos son:

- *SoftExpert - Gestión de Trámites:* Visibilidad y control sobre el procesamiento de documentos, archivos y objetos

- *R2 Docuo:* Expedientes, Solicitudes y trámites a toda velocidad: En su _homepage_ puede verse la funcionalidad de seguimiento temporal de trámites (@fig:r2docuotimeline)

#figure(
  image("../assets/r2docuotimeline.png", width: 50%),
  caption: [Captura de pantalla del homepage de R2 Docuo donde se puede ver el timeline de un trámite\ Fuente: www.r2docuo.com],
  placement: auto,
)<fig:r2docuotimeline>

- *Filestage:* Si bien no es específico para trámites, tiene un sistema de tránsito de documentos hasta su aceptación, que es una funcionalidad común en los trámites.

- *Odoo:* Es un ERP @ERPCRMCodigo con herramientas para el manejo de flujos de trabajo (BPM) y cuenta con un diseño modular, permitiendo la creación de soluciones de terceros, entre las cuales existe una, ya sin mantenimiento, que permite crear flujos desde una GUI (@fig:odoowfms).

#figure(
  image("../assets/odoowfms.png", width: 50%),
  caption: [Descripción de módulo de manejo de flujos de trabajo en Odoo\ Fuente: Captura de pantalla tomada de la tienda de extensiones de Odoo],
  placement: auto,
)<fig:odoowfms>

- *COSA:* Un gestor de flujos de trabajo antiguo que se menciona como ejemplo de caso de uso de redes de Petri en un WFMS @vanderaalstAPPLICATIONPETRINETS1998, esto mediante una herramienta llamada CONE (@fig:conecosa).

#figure(
  image("../assets/conecosa.png", width: 40%),
  caption: [Screenshot tomada del artículo "The Application of Petri Nets to Workflow Management" @vanderaalstAPPLICATIONPETRINETS1998],
  placement: auto,
)<fig:conecosa>

- *Insite CRM:* CRM desarrollado por Insite @tanjaOPERATIONALCRM2024, el cual cuenta con un módulo de gestión de flujos de trabajo (@fig:insitecrm)

#figure(
  image("../assets/insitecrm.png", width: 50%),
  caption: [Screenshot de video tutorial del producto Insite CRM],
  placement: auto,
)<fig:insitecrm>

- *Sistema de Otorgamientos OTTO:*

- *Sistema de Trámites POTyS:*
