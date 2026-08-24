#import "/shared/theme/lib.typ": img-fig

== Situación Actual<section:current_situation>

En relación con el recorrido planteado en los antecedentes, esta sección presenta el estado contemporáneo del área mediante la adopción de plataformas digitales, los sistemas y soluciones existentes, las tendencias tecnológicas, los trabajos académicos relacionados y las brechas que permanecen.

=== Adopción de plataformas y servicios públicos digitales<section:adoption>

Desde la aparición de Internet, la forma en que las personas se comunican, trabajan y realizan transacciones ha evolucionado aceleradamente.
De acuerdo con estimaciones de la @UIT, el uso de Internet pasó del 53% de la población mundial en 2019 al 68% en 2024 (@fig:internet_use).
Esto significa que en 2024 cerca de 5,5 mil millones de personas usaban Internet, mientras que 1,3 mil millones aún no estaban en línea @Statistics.

#img-fig(
  "/assets/figures/internet_use.png",
  [Número de usuarios de Internet en el mundo],
  <fig:internet_use>,
  source: [@UIT],
  width: 60%,
)

Bolivia no es una excepción a esta tendencia.
Para 2023 se estimaba que el 70,2% de la población boliviana contaba con acceso a Internet (@fig:internet_use_bolivia), situando al país por encima del promedio mundial.
Sin embargo, aún quedaba un 29,8% de la población sin acceso @IndividualsUsingInternet.

#img-fig(
  "/assets/figures/internet_use_bolivia.png",
  [Número de usuarios de Internet en Bolivia y su crecimiento],
  <fig:internet_use_bolivia>,
  source: [@UIT],
  width: 80%,
  placement: auto,
)

Uno de los factores que posiblemente acelera esta adopción es la cantidad de beneficios ofrecidos mediante la Web y las _webapps_, aplicaciones ejecutadas en un navegador que no requieren instalación en el dispositivo del usuario.
Inicialmente estas aplicaciones eran puramente informativas, pero con la llegada de la Web 2.0 evolucionaron a plataformas digitales completas e integradas con aplicaciones de negocios @pressmanSoftwareEngineeringPractitioner2010.
Muchas aplicaciones móviles también utilizan Internet para brindar servicios de forma similar.

El uso de plataformas digitales también se ha incrementado.
La @fig:ecommerce_adoption muestra la tendencia de adopción de plataformas de comercio electrónico y cómo parece haber sido acelerada por la pandemia de COVID-19 en distintos países de América Latina y el Caribe.

#img-fig(
  "/assets/figures/ecommerce_adoption.png",
  [Tendencia de adopción de plataformas de comercio electrónico en América Latina y el Caribe],
  <fig:ecommerce_adoption>,
  source: [Latinobarómetro],
  width: 80%,
  placement: auto,
)

La adopción de plataformas digitales ha crecido aceleradamente en los últimos años y se espera que continúe creciendo, debido a la creciente disponibilidad de dispositivos móviles y a la mejora de la infraestructura de Internet en muchos países.

En cuanto al gobierno electrónico, durante la pandemia de COVID-19 dejó de ser una simple tendencia temporal para convertirse en una necesidad.
El @EGDI, indicador de las Naciones Unidas que mide la adopción de políticas favorables al gobierno electrónico, registró un aumento relevante en sólo dos años (@fig:egdi2020_2022).

#img-fig(
  "/assets/figures/egdi2020_2022.png",
  [Valores promedio del EGDI y sus componentes],
  <fig:egdi2020_2022>,
  source: [2020 and 2022 United Nations E-Government Surveys],
  width: 60%,
  placement: auto,
)

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea.
  ¿El resultado?
  Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La afirmación anterior, aunque procede de un estudio de 2018 @rosethFinTramiteEterno2018, refleja de forma aproximada la situación actual ante la falta de estudios más recientes.
Se observa una mayor adopción de trámites digitales, pero muchos todavía se realizan total o parcialmente de forma presencial.
Los servicios electrónicos son una de las áreas más relevantes del gobierno electrónico @naserGobiernoElectronicoGestion2011 y se espera que más trámites se digitalicen.
Durante la pandemia hubo un aumento considerable de canales digitales, que llegaron a reemplazar alrededor del 20% de los trámites presenciales en distintos países de América Latina @rosethServiciosPublicosGobierno2021.

=== Sistemas y soluciones existentes

==== Sistema de Información Ambiental Industrial

El @SIAI, antecedente directo de este proyecto, fue construido como una aplicación web con arquitectura cliente-servidor, un _backend_ monolítico y un _frontend_ elaborado como una @SPA.
Para responder a futuras necesidades de integración e interoperabilidad se eligió una comunicación entre ambos mediante una @API @REST abierta y bien documentada.

De forma más específica se adoptó el estilo de arquitectura por capas, con tres unidades físicas desplegables (@fig:siai_architecture_style), correspondiente a una arquitectura monolítica común en aplicaciones web.
La capa de negocio, sin embargo, interopera con otros sistemas mediante servicios @REST @API #footnote[El SIAI consume datos de un servicio provisional del SEPREC para obtener información sobre las industrias registradas en el país], lo que le brinda características híbridas entre una arquitectura principalmente monolítica y una arquitectura de servicios.

#img-fig(
  "/assets/figures/siai_architecture_style.png",
  [Arquitectura por capas (layered architecture) del sistema SIAI],
  <fig:siai_architecture_style>,
  source: [Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  width: 40%,
  placement: auto,
)

El _backend_ fue desarrollado en PHP con Laravel; el _frontend_, con Vue.js, que permite crear aplicaciones web interactivas y dinámicas; y se utilizó el sistema de gestión de bases de datos relacional PostgreSQL.

==== Soluciones de gestión y modelado de procesos

No se encontraron módulos especializados en gestión de trámites que pudieran integrarse en sistemas mayores con un enfoque de reutilización, pero sí sistemas con características similares o capaces de gestionar procesos administrativos.
También existen casos de instancias públicas que pueden inspirar la solución propuesta.

#img-fig(
  "/assets/figures/r2docuotimeline.png",
  [Captura de pantalla del homepage de R2 Docuo donde se puede ver el timeline de un trámite],
  <fig:r2docuotimeline>,
  source: [www.r2docuo.com],
  width: 40%,
  placement: auto,
)

#img-fig(
  "/assets/figures/odoowfms.png",
  [Descripción de módulo de manejo de flujos de trabajo en Odoo],
  <fig:odoowfms>,
  source: [Captura de pantalla tomada de la tienda de extensiones de Odoo],
  width: 40%,
  placement: auto,
)

#img-fig(
  "/assets/figures/conecosa.png",
  [Captura de pantalla de CONECOSA],
  <fig:conecosa>,
  source: [The Application of Petri Nets to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
  width: 40%,
)

#img-fig(
  "/assets/figures/insitecrm.jpg",
  [Captura de pantalla de Insite CRM],
  <fig:insitecrm>,
  width: 50%,
  placement: auto,
)

#img-fig(
  "/assets/figures/att_platform.png",
  [Captura de pantalla de la vista de ingreso a PlATTaformas Virtuales para acceder al sistema OTTO],
  <fig:att_platform>,
  source: [https://plataformas.att.gob.bo/],
  width: 50%,
  placement: auto,
)

#img-fig(
  "/assets/figures/stateflowrobot.png",
  [Diagrama de estados finitos elaborado con Stateflow],
  <fig:stateflowrobot>,
  source: [Documentación MathWorks - Stateflow],
  width: 50%,
  placement: auto,
)

#img-fig(
  "/assets/figures/camunda_modeler.png",
  [Modelado de un proceso BPMN ejecutable en Camunda Web Modeler],
  <fig:camunda_modeler>,
  source: [#link("https://docs.camunda.io/docs/components/modeler/web-modeler/")[Documentación oficial de Camunda]],
  width: 75%,
)

#img-fig(
  "/assets/figures/temporal_timeline.png",
  [Línea de tiempo de la ejecución de un workflow en Temporal],
  <fig:temporal_timeline>,
  source: [#link("https://temporal.io/blog/lets-visualize-a-workflow")[Temporal]],
  width: 80%,
)

#img-fig(
  "/assets/figures/n8n_workflow.png",
  [Flujo de trabajo visual con bifurcación y combinación de datos en n8n],
  <fig:n8n_workflow>,
  source: [#link("https://n8n.io/features/")[Sitio oficial de n8n]],
  width: 70%,
)

- *SoftExpert BPM:* solución para la gestión de procesos de negocio @BusinessProcessManagemente.
  Aunque no se enfoca en trámites, cuenta con elementos de modelado y seguimiento de procesos útiles en este contexto.
- *R2 Docuo:* sistema completo de gestión de procesos con una funcionalidad para solicitudes y trámites @SoftwareParaGestionb.
  Crea fichas de información, define los pasos de cada trámite, almacena documentos y ahorra tiempo mediante formularios y avisos (@fig:r2docuotimeline).
- *Odoo:* @ERP @ERPCRMCodigo con herramientas para flujos de trabajo y un diseño modular que admite soluciones de terceros, entre ellas una, actualmente sin mantenimiento, que permite crear flujos desde una herramienta gráfica (@fig:odoowfms).
  Su edición "Community" es totalmente de código abierto y, por ser un ERP completo con capacidad de manejar procesos, podría ser un punto de partida para proyectos de digitalización de trámites.
- *COSA:* gestor antiguo de flujos de trabajo citado como caso de uso de redes de Petri en un @WFMS @vanderaalstAPPLICATIONPETRINETS1998 mediante la herramienta CONE (@fig:conecosa).
- *Insite CRM:* CRM desarrollado por Insite @tanjaOPERATIONALCRM2024 con un módulo de gestión de flujos de trabajo (@fig:insitecrm), que permite definir procesos en una interfaz avanzada semejante a un editor de diagramas @BPMN como los de la @fig:bpmn.
- *POTyS:* en palabras de Marco Antonio Bravo Fabián, director general del Instituto Quintanarroense de Innovación y Tecnología, el Portal Oficial de Trámites y Servicios busca que la ciudadanía realice trámites gubernamentales en línea, disminuyendo al máximo el contacto físico, las filas y la corrupción @candurizDigitalizanTramitesGobierno.
  Funciona como ventanilla única para centralizar trámites del estado de Quintana Roo, México, y para finales de 2022 incluía 26 procedimientos @ramirezQuintanaRoo262022.
- *OTTO:* la plataforma digital de Otorgamientos en Telecomunicaciones, aprobada mediante Resolución Administrativa Interna ATT-DJ-RAI LP 8/2019, atiende solicitudes y renovaciones de licencias para el uso de frecuencias @ResolucionAdministrativaInterna.
  Estos trámites requieren un análisis técnico interno especializado sobre gestión del espectro radioeléctrico.
  Esto muestra que, aunque existen características comunes, las verificaciones no son homogéneas y las instancias públicas necesitan implementar sistemas conforme a sus modelos de negocio, en contraposición con una única ventanilla.
  El ingreso a OTTO puede realizarse mediante Ciudadanía Digital (@fig:att_platform), siguiendo las guías bolivianas de gobierno electrónico.
- *Stateflow by MathWorks:* producto incluido en MatLab para modelar y simular procesos mediante máquinas de estado y diagramas de flujo con un lenguaje gráfico @Stateflow.
  Aunque se emplea comúnmente para simulación en electrónica y control (@fig:stateflowrobot), podría utilizarse, no necesariamente de la forma más adecuada, para modelar trámites.
  Su interfaz conecta la lógica de estados, el modelado y la ejecución, por lo que aproxima la definición de procedimientos buscada por el proyecto.
- *Camunda:* plataforma de orquestación que permite modelar procesos ejecutables con BPMN, desplegarlos y coordinar tareas humanas y sistemas externos (@fig:camunda_modeler).
- *Temporal:* plataforma de ejecución durable orientada a desarrolladores; los flujos se implementan en código y conservan su estado para continuar después de fallos, mientras su interfaz permite observar cada ejecución y sus eventos (@fig:temporal_timeline).
- *n8n:* herramienta de automatización visual que conecta aplicaciones y transforma datos mediante nodos, bifurcaciones y bucles; resulta útil para integrar servicios y automatizar tareas alrededor de un trámite (@fig:n8n_workflow).

=== Tendencias tecnológicas y enfoques actuales

Las necesidades alrededor de la digitalización de trámites son diversas.
Para resolverlas se han vuelto comunes distintas prácticas, sistemas y enfoques.
Algunas tendencias generales proceden de entidades privadas con necesidades similares, pero pueden aplicarse también a trámites de entidades públicas.

==== Reutilización de software

La reutilización de software se ha popularizado, particularmente con el auge de los sistemas de código abierto y las plataformas digitales.
Esta tendencia responde a la demanda de reducir costos de producción y mantenimiento, entregar sistemas con mayor rapidez y mejorar su calidad @sommervilleSoftwareEngineering2016.

#img-fig(
  "/assets/figures/mobile_reuse.png",
  [Porcentaje de reutilización de software en aplicaciones móviles],
  <fig:mobile_reuse>,
  source: [A large-scale empirical study of the reuse of software components in mobile applications @mojicaLargeScaleEmpiricalStudy2014],
  width: 60%,
  placement: auto,
)

La @fig:mobile_reuse, procedente de un estudio de 2014 sobre aplicaciones móviles, muestra un porcentaje de reutilización superior al 62% en las distintas categorías analizadas #footnote[La reutilización en este estudio fue medida calculando la proporción de clases reutilizadas sobre la cantidad total de clases de cada proyecto] @mojicaLargeScaleEmpiricalStudy2014.
En el desarrollo web, @NPM facilitó la reutilización de código: registraba más de un millón de paquetes en 2022 y creció un 60% entre enero de 2019 y enero de 2022 @mujahidWhatAreCharacteristics2023.
Una búsqueda realizada en 2025 en el sitio oficial mostraba más de dos millones de paquetes y contribuciones de más de 17 millones de desarrolladores @NpmHome.

===== Sistemas configurables

Uno de los tipos de sistemas reutilizables descritos por Somerville son los sistemas configurables. Estos sistemas se especializan en un dominio específico y permiten a los usuarios implementar funcionalidad con simple configuración. El ejemplo más popular de este tipo de sistemas es WordPress, el cual permitió que usuarios sin conocimientos técnicos puedan desplegar sitios web completos que antes requerirían la escritura de código. Otro ejemplo que vale la pena mencionar es Pocketbase, un sistema para generar backends mediante una interfaz de usuario amigable que no requiere la escritura de código. Es importante mencionar que en ambos casos, estas herramientas exponen una serie de interfaces de código reutilizables para usuarios técnicos con necesidades más específicas.

==== Gestión de flujos de trabajo y arquitectura

Los @WFMS y BPM constituyen enfoques actuales relevantes porque las organizaciones, incluido el aparato gubernamental, gestionan procesos y los trámites son ejemplos típicos @dumasFundamentalsBusinessProcess2013.
Su definición, capacidades y fundamentos se desarrollan en la @section:wfms.

En arquitectura de software, los estilos por capas, de microservicios y @SOA se han consolidado entre los más utilizados o han incrementado su popularidad.
Sus diferencias y fundamentos se presentan en el Marco teórico; en este proyecto son relevantes como enfoques para organizar sistemas modulares, mantenibles y evolutivos.

==== Software libre y colaboración

En años recientes, los proyectos de software libre sentaron las bases de muchos avances tecnológicos disponibles y grandes empresas tecnológicas, que antes daban preferencia exclusiva al software propietario, ahora los utilizan masivamente y contribuyen a su desarrollo @vonkroghCarrotsRainbowsMotivation2012.

#img-fig(
  "/assets/figures/github_contributions.png",
  [Número de contribuciones a proyectos públicos y de software libre en GitHub (2021-2024)],
  <fig:github_contributions>,
  source: [GitHub Octoverse],
  width: 50%,
  placement: auto,
)

Microsoft adquirió GitHub en 2018, la plataforma más popular para el desarrollo de software libre y de código abierto.
Según el reporte "GitHub Octoverse" @staffOctoverseAILeads2024:

- En 2024, desarrolladores de todo el mundo realizaron cerca de 1000 millones de contribuciones (_1 billion contributions_) a proyectos públicos y de software libre, un aumento respecto a años anteriores (@fig:github_contributions).
- Una motivación principal para contribuir es aportar a la comunidad y generar cambios positivos.
  Algunos proyectos que motivaron a contribuidores nóveles estuvieron relacionados con orfanatos para personas jóvenes, investigación de drogas en países de ingresos medios y bajos y herramientas para denunciar maltratos anónimamente.

Este último dato señala que el desarrollo de software libre puede tener una motivación social y comunitaria, más allá de lo económico, aspecto analizado por Haefliger, von Krogh y Spaeth @vonkroghCarrotsRainbowsMotivation2012.

El Plan de Implementación de Software Libre y Estándares Abiertos también presenta los siguientes datos sobre la situación del país:

- El 61% de las entidades públicas utiliza lenguajes de programación bajo estándares libres y el 39% emplea herramientas privativas.
- De 160 licitaciones analizadas, la mayoría corresponde a trabajos internos.
  Se exige dejar todo el material, aunque no se dice expresamente que deba entregarse el código fuente; por el formato del contrato, se puede suponer que es así.
- El 64% de las contrataciones externas no solicita herramientas de software libre y sólo el 36% sí lo hace.
- El 57% de los desarrollos internos se realiza sin herramientas de software libre y el 43% con ellas.
- El 59% de las empresas no desarrolla con herramientas libres, el 19% las usa en desarrollos internos y sólo el 22% las usa para clientes.
- Las entidades públicas cuentan con buenas condiciones para iniciar la implementación de software libre y estándares abiertos.

==== Modelado de procesos

Actualmente existe una amplia variedad de lenguajes, herramientas y técnicas para modelar sistemas y procesos: diagramas de flujo, diagramas de actividad UML, EPC, IDEF, @BPMN, máquinas de estados y redes de Petri.
Un mismo proceso puede representarse mediante diferentes alternativas; su definición y fundamentos se desarrollan en la @section:modeling.

==== Inteligencia artificial

La inteligencia artificial ha tenido un crecimiento exponencial en los últimos años y su uso se ha vuelto común en muchos ámbitos, aunque el concepto existe desde hace décadas.
Lo que ha cambiado es la forma de aplicación y la cantidad de datos disponibles para entrenar modelos.

Con la salida gratuita de ChatGPT el 30 de noviembre de 2022 @ChatGPTTurns1euro, los grandes modelos de lenguaje comenzaron a utilizarse masivamente.
Aunque existían desde antes, sólo en años recientes alcanzaron su nivel actual de precisión e inteligencia aparente.

Uno de los servicios alrededor de los LLM consiste en APIs que permiten integrarlos en diversos sistemas.
Entre las aplicaciones aún exploradas está la inferencia, que puede analizar documentos y datos sin entrenar otro modelo.
Este análisis se asemeja al realizado por funcionarios públicos al revisar formularios de un trámite.
Sin embargo, actualmente se siguen empleando servidores fuera de Bolivia para usar estos modelos, por lo que su utilización podría estar limitada por la normativa vigente.
Aun así, constituye una posible aplicación dentro de la digitalización de trámites.

=== Trabajos académicos relacionados<section:related_work>

Los trabajos se buscaron en torno al trámite digital y distintos procesos administrativos, tanto en el sector público como en el privado.
Esto permite abarcar relaciones directas e indirectas.
Los trabajos encontrados carecen de características fundamentales como la reutilización o la naturaleza de software libre y no se encontró ninguno que reúna todas las características deseadas.
Sin embargo, muchos presentan funcionalidades o conceptos que pueden inspirar el subsistema propuesto.

Debido a la cantidad de procesos administrativos en distintas instituciones, existe también una gran cantidad de proyectos de grado sobre sistemas de gestión de trámites.
Entre los más relevantes se encuentran:

- *Sistema de Control de Trámites utilizando Máquinas de Turing para la División de Gestiones, Admisiones y Registros U.M.S.A.*
  @nachoSISTEMACONTROLTRAMITES2007: proyecto de 2007 basado teóricamente en máquinas de Turing, modelo matemático de computación que describe una cinta dividida en casillas que funciona como memoria y un cabezal que escribe y lee de ella cambiando de estados.
  Aunque esta conceptualización no fue implementada estrictamente, señala la necesidad de modelar procesos y presenta una forma innovadora de hacerlo.
  Incluye seguimiento y control desde el registro hasta la conclusión y atiende cerca de veintiún procesos diferentes de una misma institución con un mismo sistema y técnica de modelado.
- *Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí* @murosalazarImplementacionModuloControl2018: tesis de 2018, dentro de una línea de reforma y modernización del Estado, que busca demostrar la importancia de un módulo específico de trámites.
  Brinda recomendaciones, pero no implementa una solución práctica.
  Prefiere @XP frente a SCRUM, posiblemente por la demanda de desarrollos breves en instituciones públicas, y recomienda seguir dicha metodología ágil respetando el ciclo de vida del software para obtener un sistema *reutilizable, portable e interoperable*.
  Su enfoque modular es evidente.
- *Desarrollo de una aplicación _web responsive_ para mejorar el proceso de trámite documentario en un colegio profesional* @cajusolvallejosDesarrolloAplicacionWeb2020: tesis de 2020 en ingeniería de sistemas que implementa un sistema de trámites en un colegio profesional peruano.
  Atiende una variedad de procesos, los conceptualiza desde su origen y, al ser una implementación completa, muestra detalle del desarrollo con SCRUM y de los diferentes _sprints_.
  Finalmente analiza el impacto y recomienda usar *software libre para reducir costos* y capacitar a los usuarios para lograr el máximo aprovechamiento.
- *Desarrollar un sistema web de trámite documental para mantener las acreditadoras de la escuela de ingeniería informática de la URP* @zegarrajibajaDesarrollarSistemaWeb2019: tesis de 2019 que implementa un sistema web, usa extensivamente diagramas, incluye un manual y, a diferencia de otros trabajos, realiza *pruebas de software*.
  Se enfoca en un solo proceso.
- *Desarrollo e Implementación del Sistema de Tramite Documentario en la Municipalidad Provincial de Huancayo para la atencion de expedientes* @bastidasparragaDesarrolloImplementacionSistema2016: tesis de posgrado de 2016 que aplica un sistema documental a todo un municipio.
  Según su autor, reduce el tiempo de atención de expedientes en un 30% respecto a un sistema anterior, mostrando que la calidad del software afecta la eficiencia de uso.
- *Sistema de información de trámite documentario basado en tecnología web para institutos de educación superior tecnológicos de la región Ancash en el año 2016* @tapiajacintoSistemaInformacionTramite2017: trabajo de posgrado que no pretende reemplazar el trámite presencial, sino complementarlo.
  Esto es importante porque parte de la población carece de Internet o dispositivos, por lo que se necesita un puente entre servicios digitales y presenciales.
- *Implementación de un sistema de trámite documentario para la Agencia de Compras de las Fuerzas Armadas* @yrupailladiazImplementacionSistemaTramite2019: proyecto de 2019 que integra firma digital, característica que, aunque no se contempla de la misma forma en este proyecto, es importante.
  Los trámites manejan documentos para decisiones relevantes, por lo que su veracidad debe considerarse.

=== Brechas identificadas

La situación revisada muestra una adopción creciente de Internet, plataformas digitales y servicios de gobierno electrónico; además, existen sistemas de gestión de procesos, soluciones institucionales, técnicas de modelado y numerosos trabajos académicos.
Sin embargo, una parte de la población boliviana todavía no tiene acceso a Internet y muchos trámites permanecen total o parcialmente presenciales, por lo que la transición debe mantener un puente entre ambos canales.

También existen productos capaces de modelar o gestionar procesos, pero no se encontró un módulo especializado en trámites que pudiera integrarse en sistemas mayores y reuniera a la vez reutilización y naturaleza de software libre.
Las experiencias revisadas atienden capacidades semejantes, mientras que casos como OTTO muestran que las verificaciones y los modelos de negocio institucionales no son homogéneos.
En consecuencia, sigue siendo necesario atender las características comunes de los trámites sin impedir que cada institución incorpore su funcionalidad específica.

/*NOTE
Realmente existen otros temas más que podrían ser relevantes, pero se incluye sólo lo más prioritario dada la extensión actual de esta sección.
  - Más sistemas de trámite y ventanilla única: El gobierno boliviano tiene más trámites digitalizados, recientemente se lanzó el sistema VUCE (Ventanilla Única de Comercio Exterior). También en una versión anterior de este mismo documento, se llegó a hablar del trámite de vidrios polarizados, entre otros que ya habrían sido digitalizados.
  - En cuanto a tecnologías se dejan en el tintero aspectos como la interoperabilidad, la firma digital, la ciudadanía digital, etc, que simplemente se mencionan como parte de los planes de implementación citados en el subtítulo de normativa vigente.
  - Dentro de la normativa también podrían haberse añadido los lineamientos aprobados por la RM 079/20, donde se habla de trámites y cómo estos deben ser implementados en forma digital por cada instancia pública.
En fin, hay muchos otros puntos que podríamos revisitar en una versión futura de este documento si es que así se ameritase, siendo los anteriormente descritos los más importantes para una actualización de esta sección.
*/
