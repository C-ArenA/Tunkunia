#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/acrostiche:0.5.1": acr

= Antecedentes

A continuación se hace un repaso histórico en torno al trámite, su relevancia, sus problemas originales, la necesidad de adopción de tecnologías de la información por el gobierno boliviano, la atención a dicha necesidad en el sistema #acr("SIAI") mediante la consultora 2IES y cómo esto deriva posteriormente en la identificación de características comunes a diversos trámites (@fig:background).

#figure(
  image("../assets/background.png", width: 80%),
  caption: [Antecedentes a la identificación de la problemática de este proyecto\ Fuente: Elaboración propia],
)<fig:background>

== El origen de los trámites gubernamentales

=== El Estado como Sistema Organizativo

Para los teóricos de la armonía social, el estado aparece como la solución colectiva de necesidades nuevas que surgen a partir de situaciones también nuevas @vacarofernandezOrigenEstado2000[pág. 3].
Se dice que esta organización representa un fenómeno político que *supuso la separación o la salida de lo político del terreno social* y
*la conversión del individuo en un ciudadano*, cuya relación de pertenencia fundamental será con el estado al margen de cualquier característica particular @gordilloperezPorQueSurge2017.
Dicha separación se ve reflejada en los cuatro elementos clave mediante los cuales se materializa el estado, que son el territorio, la población, el gobierno y la soberanía @delarocharadaElementosParaTeoria2019.

=== Gobierno, Burocracia y Administración Pública

El gobierno (del griego $kappa mu beta epsilon rho v á omega$ kybernéin "pilotar un barco" o "capitán de un barco"),
es un sistema orgánico de autoridades a través del cual se expresa el poder del estado, creando, afirmando y desenvolviendo el orden jurídico @fernandezruizDerechoParlamentario2023, siendo así el actor que *materializa el poder del estado hacia la población*.

En consecuencia, se suele encontrar dentro del gobierno la figura de la administración pública, que es la que gestiona los asuntos comunes respecto al ciudadano como miembro del estado @guerreroCharlesJeanBonninSiglo2020.
Esta ciencia tiene la importante responsabilidad de poner en *contacto directo* a la población con el poder político @mostajomachicadoDerechoAdministrativoAdministracion2016.

Para lograr este propósito los gobiernos casi siempre ponen en práctica la *burocracia*
#footnote[término acuñado en el siglo 18 por el filósofo francés Vincent de Gournay, derivando del francés _bureau_ y _cratie_ que significan "Escritorio para escribir" y "Gobierno" respectivamente @rockmanBureaucracyStructureProcesses2024],
que según el sociólogo alemán Max Weber no sólo es la forma más avanzada de ejercer o empuñar el poder por aquellos que lo controlan @watersWeberRationalismModern2015[pág. 114], sino que también es una *forma racional de organización* que en su opinión es la forma más pura de sistema legal de autoridad, es necesaria y algunas de sus características fundamentales son las jerarquías, la especialización y la definición estricta de *reglas y regulaciones* @archerDictionaryPublicAdministration2022.

De este modo, el gobierno, mediante la administración pública, y practicando la burocracia, emplea diferentes mecanismos, entre los cuales se encuentra el trámite como una forma de hacer efectiva la comunicación con la población.

== El trámite tradicional y sus problemas

La palabra trámite viene del latín "trames", "tramitis", que para los romanos significaba "senda" "camino" @TramiteCastellanoPagina.
Según la Real Academia de la Lengua Española, se define como "Cada uno de los *pasos* y diligencias que hay que recorrer en un asunto hasta su conclusión" @asaleDiccionarioLenguaEspanola.
Algunos términos para referirse a lo mismo son: "Procedimiento Administrativo", "Servicio Público Transaccional", o, en inglés, "Procedure", "Paperwork".

Para efectos de este documento, se entiende por trámite al conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas *piden o entregan información* a una entidad pública, con *el fin de obtener* un derecho o *para cumplir* con una obligación @rosethFinTramiteEterno2018[pág. 36].

En su forma tradicional, los trámites se llevan a cabo de forma presencial, en una oficina pública, donde el ciudadano debe presentar una serie de documentos y cumplir con ciertos requisitos, muchos de los cuales involucran la realización de otros trámites.

Sin embargo, esto deriva en una serie de problemas que suelen afectar a la población, como la corrupción, el clientelismo, la excesiva cantidad de horas necesarias para completar un trámite (@fig:horastramite), las distancias entre el ciudadano y las oficinas públicas, el número de interacciones necesarias (@fig:tramites_una_interaccion), la falta de definición de requisitos y las deficiencias en el acceso a la información, entre otros.

Un ejemplo de esto es el caso de *Domitila Murillo*, una ciudadana boliviana que, a causa de un trámite, se vio obligada a trasladarse entre varias localidades del país (recorriendo al menos 900km durante 11 meses), realizando interminables filas y vagando perdida entre una cantidad indefinida y mal documentada de requisitos. Su caso fue motivo de preocupación y cuando finalmente logró recibir su cédula (el cual era el motivo del trámite), no le quedaron más que dos semanas antes de fallecer @charoskyQuejaComoEnergia2014[pag. 23].

#figure(
  image("../assets/horastramite.png", width: 50%),
  caption: [Horas necesarias para completar un trámite, por país\ Fuente: Datos del Latinobarómetro, 2017],
  placement: auto,
)<fig:horastramite>

#figure(
  image("../assets/tramites_una_interaccion.png", width: 50%),
  caption: [Porcentaje de trámites resueltos en una interacción\ Fuente: Datos del Latinobarómetro, 2017],
  placement: auto,
)<fig:tramites_una_interaccion>

Estos problemas dentro de la administración pública, despiertan el interés acerca del impacto que podría tener la utilización de las tecnologías de la información en este ámbito, llevando a la creación del concepto de *Gobierno Electrónico* o *e-government*.

== La Modernización Administrativa

#let governmentFootNote = [
  No existe consenso en la definición y uso del término "Gobierno Electrónico" por ser relativamente incipiente y más de una vez se emplean los términos
  "Gobierno Digital" o incluso "Gobierno Inteligente" para referirse a lo mismo.
  En este documento se prefiere el uso del primero.
]

En una entrevista del año 2015 a Carlos Jiménez @digitalGobiernoInteligenteEntrevista2015, responsable mundial de _IEEE e-government_, este señaló que
el *gobierno electrónico #footnote(governmentFootNote)* es una fase para llegar a tener gobiernos inteligentes y abiertos y que:

#quote(attribution: "Carlos Jiménez")[
  ...consiste en implantar la tecnología para *mejorar procesos administrativos y permitir la interacción con los ciudadanos*
]

El Gobierno Electrónico brinda muchos beneficios a la población, como
la eliminación de barreras temporales y espaciales,
acceso igualitario a la información, colaboración, aumento en la producción de bienes y servicios,
en suma, brinda mayor calidad de vida a la ciudadanía @naserGobiernoElectronicoGestion2011. Los esfuerzos por digitalizar los trámites se enmarcarían dentro de este concepto.

Sin embargo, la implementación de un gobierno electrónico no es una tarea sencilla, ya que requiere la realización de esfuerzos en conjunto dentro de los gobiernos. En Bolivia, a partir del año 2009, se han promulgado decretos, leyes y reglamentos que buscan promover el uso de las tecnologías de la información y comunicación en la administración pública, pero aún queda un largo camino por recorrer para lograr una implementación efectiva y eficiente.

== Bolivia: Gobierno Electrónico

En Bolivia, la nueva Constitución Política del Estado, promulgada el 7 de febrero del año 2009, establece en su Artículo 103 que:
"El Estado asumirá como política la implementación de estrategias para incorporar el conocimiento y *aplicación de nuevas tecnologías de información y comunicación*" @BoliviaConstitucionPolitica.
Esto dio lugar, el año 2011, a la creación de la Ley General de Telecomunicaciones, Tecnologías de Información y Comunicación (Ley Nº 164) que tiene entre sus principales objetivos: "Promover el uso de las tecnologías de información y comunicación para
*mejorar las condiciones de vida de las bolivianas y bolivianos*" @Ley164Ley2011.

La citada norma legal establece, en su Artículo 71, que la promoción del uso de las tecnologías de información y comunicación es *prioridad nacional*,
mientras que el Artículo 72 del mismo documento indica que las entidades públicas deberán adoptar *todas las medidas necesarias* para su máximo aprovechamiento en el desarrollo de *sus funciones* y el Artículo 77 señala que se promoverá y priorizará el uso de *software libre* y estándares abiertos en todos los niveles del gobierno en el marco de la *soberanía y seguridad nacional*.

A su vez, la Ley 164, dio lugar a una serie de políticas públicas, reglamentos y planes que profundizan en la incorporación del Gobierno Electrónico y el desarrollo de software para el estado, además de requerir a las instancias públicas su adopción, como se puede ver en la @fig:bolivia_norms, en la que se muestran los principales documentos normativos relacionados con el gobierno electrónico en Bolivia.

#figure(
  image("../assets/bolivia_norms.png", width: 70%),
  caption: [Documentos normativos relacionados con el gobierno electrónico en Bolivia y las relaciones más relevantes entre las mismas\ Fuente: Elaboración propia],
)<fig:bolivia_norms>

Dentro de estos documentos, el Plan de Implementación de Gobierno Electrónico, aprobado mediante Decreto Supremo Nº 3251 @DecretoSupremoNo2017, señala en su línea estratégica número 3, que se debe asegurar el intercambio de información entre entidades públicas y con la ciudadanía mediante la interoperabilidad.

Adicionalmente, dada la situación de emergencia sanitaria provocada por la pandemia de COVID-19, el gobierno boliviano ha acelerado la implementación de #acr("TICs") en la administración pública, promoviendo el uso de plataformas digitales para la atención al ciudadano y la gestión de trámites. Por esto mismo, se aprobó, mediante Resolución Ministerial Nº 079/20, el documento de "Lineamientos y estándares técnicos para el desarrollo e implementación de Servicios Digitales", mismo que no sólo insiste en la digitalización de servicios como el trámite, sino que proporciona una guía a las entidades públicas y privadas que desarrollan software bajo este propósito, indicando la disponibilidad de diferentes herramientas creadas por la AGETIC, como la de Ciudadanía Digital.

No se debe ignorar que en lineas generales, la Constitución Política del Estado Plurinacional de Bolivia, en su Artículo 21, también establece el derecho de la ciudadanía a acceder a la información pública y a la administración pública, así como el derecho a la participación en la gestión pública.

Como puede notarse, aunque se lista solamente lo considerado más relevante, existe bastante normativa y documentación que promueve y/o demanda el uso de las #acr("TICs") y la digitalización de trámites en el gobierno boliviano. En este contexto, distintas entidades públicas han comenzado a implementar sistemas para facilitar sus funciones administrativas, en particular las funciones que tienen que ver con trámites.

=== Sistema de Información Ambiental Industrial

Un caso que ilustra la implementación de un sistema con características de gestión de trámites es el Sistema de Información Ambiental Industrial (SIAI), desarrollado por el Ministerio de Desarrollo Productivo y Economía Plural (MDPyEP) en Bolivia.

El D.S. 26736, que aprueba el Reglamento Ambiental del Sector Industrial Manufacturero (RASIM), en su Artículo 9 (Organismo Sectorial Competente), indica las competencias, atribuciones y funciones del Viceministro de Industria y Comercio Interno que actualmente es el Viceministro del Políticas de Industrialización, y en su inciso f) señala: "Establecer y administrar el Sistema de Información Ambiental Industrial (SIAI) y el Sistema de Evaluación y Revelación de Información (SERI)" @DecretoSupremo263762002.

A través de un análisis realizado en la gestión 2020 se determinó que el SIAI requiere una adecuación para, primeramente, reducir los tiempos de envió de la información desde las instancias departamentales y municipales, facilitando el llenado a través de internet, además de generar usuarios y autorizaciones para este llenado.

Por lo anterior, se requirió el año 2023, mediante licitación, la implementación de este sistema, con el siguiente objetivo:

#quote(
  attribution: [Términos de Referencia del proyecto de implementación del SIAI @ConsultoriaPorProducto],
)[Diseñar e implementar un sistema informático denominado “Sistema de Información Ambiental Industrial (SIAI)”, que permita un Registro en Línea de la Información Ambiental Industrial y que ayude en el monitoreo y seguimiento Nacional a través del MDPyEP y los gobiernos subnacionales competentes en el marco de lo establecido en el Reglamento Industrial para el Sector Industrial Manufacturero, actualizando los datos ambientales de la industria a nivel nacional y acreditar la idoneidad de los mismos, asegurando el cumplimiento de la normativa ambiental vigente]

== Consultoría de 2IES

La consultora 2IES #sym.dash.em Ingeniería Estructural e Ingeniería de Telecomunicaciones #sym.dash.em, es una empresa fundada en Bolivia el año 1997 y cuenta con experiencia en sectores de infraestructura y en áreas relacionadas con la planificación estratégica, la regulación, el mejoramiento de negocios, y el desarrollo de sistemas, así como la aplicación e integración en Tecnologías de la Información y Comunicación, tanto en empresas como entidades del sector público.

En años recientes, con la adopción de las tecnologías de la información cada vez más relevante en el mercado local boliviano, el desarrollo de sistemas de software se volvió un pilar fundamental para 2IES, lo que llevó a su presentación en la licitación del proyecto de implementación del SIAI.

=== Experiencias en el desarrollo del SIAI

La ejecución del proyecto, licitado por el #acr("MDPyEP"), estuvo entonces a cargo de la consultora 2IES,
que procedió a la implementación del nuevo #acr("SIAI") atendiendo a las especificaciones técnicas del Documento Base de Contratación,
así como a las distintas interacciones efectuadas con el cliente.

El sistema fue construido como una aplicación web con la arquitectura cliente-servidor, con un backend monolítico y un frontend construido como una #acr("SPA"). En base a esto y para poder responder a necesidades de integración e interoperabilidad futuras, se optó además por una comunicación entre el frontend y el backend mediante una #acr("API") de tipo #acr("REST"), abierta y bien documentada.

De forma más específica, se adoptó el estilo de arquitectura por capas (Layered Architecture Style),
con tres unidades físicas desplegables, como se puede ver en la @fig:siai_architecture_style,
que correspondería a una arquitectura monolítica muy común en aplicaciones web.
La capa de negocio, sin embargo, interopera a su vez con otros sistemas mediante servicios #acr("REST") #acr("API")
#footnote[El SIAI consume datos de un servicio provisional del SEPREC para obtener información sobre las industrias registradas en el país],
dándole características híbridas al sistema entre una arquitectura principalmente monolítica y una arquitectura de microservicios.

#figure(
  image("../assets/siai_architecture_style.png", width: 40%),
  caption: [Arquitectura por capas (layered architecture) del sistema SIAI\ Fuente: Fundamentals of Software Architecture: An Engineering Approach @richardsFundamentalsSoftwareArchitecture2020],
  placement: auto,
)<fig:siai_architecture_style>

El backend fue desarrollado utilizando el lenguaje de programación PHP, con uno de los frameworks de desarrollo más populares y completos de su ecosistema, Laravel. El frontend, por su lado, fue desarrollado utilizando el framework Vue.js, que permite crear aplicaciones web interactivas y dinámicas. Además, se utilizó el sistema de gestión de bases de datos PostgreSQL, de tipo relacional.

Inicialmente, se debe mencionar que el sistema #acr("SIAI") atiende una amplia variedad de requerimientos, de los cuales son relevantes en este documento aquellos de tipo administrativo, que involucran un grupo de documentos ambientales a ser obtenidos y actualizados por las industrias manufactureras del país, dependiendo de ciertas características y condiciones dadas a conocer en un primer trámite de registro (RAI).

Es decir, el SIAI tiene como protagonistas a las industrias manufactureras que deben cumplir con la normativa ambiental vigente de acuerdo al #acr("RASIM"). Esta normativa demanda la obtención de una serie de documentos llamados #acr("IRAP", plural: true), que se listan a continuación:

- RAI: Registro Ambiental Industrial
- EEIA: Estudio de Evaluación de Impacto Ambiental
- DP: Descripción del Proyecto
- PMA: Plan de Manejo Ambiental
- MAI: Manifiesto Ambiental Industrial
- ARI-PC: Análisis de Riesgos Industriales y Plan de Contingencias
- IAA: Informe Ambiental Anual

Además de atender a los requerimientos iniciales del DBC, 2IES propuso funcionalidades que modernicen el trabajo con el SIAI. A partir del requerimiento de hacer seguimiento a las solicitudes de distintos documentos ambientales y la generación de los mismos, se entendió a estos procesos como trámites, los cuales debían ser digitalizados.

Dado que una gran parte de la funcionalidad de este sistema, consistía en el manejo de documentos y su seguimiento mediante trámites, la consultora 2IES hizo una implementación recurriendo al manejo de estados y de roles, creando formularios e integrando los datos al modelo del negocio general.

Al implementar los diferentes componentes referentes a dichos trámites, se identificaron claras similitudes entre ellos, como la necesidad de permitir un seguimiento transparente, la aprobación de documentos por etapas, la auditoría y la gestión general de cada trámite.

Si bien el proyecto del SIAI llegó a su conclusión, estas similitudes identificadas a la hora de implementar los distintos trámites, además de la potencial similitud con trámites de otras distintas instancias del sector público, motivaron a la realización del presente proyecto.
