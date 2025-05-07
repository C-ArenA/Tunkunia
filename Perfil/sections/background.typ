#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/acrostiche:0.5.1": *

= Antecedentes

A continuación se hace un repaso histórico en torno al trámite, su relevancia, sus problemas originales, la necesidad de adopción de tecnologías de la información por el gobierno boliviano, la atención a dicha necesidad en el sistema #acr("SIAI") y cómo esto deriva en la identificación de similitudes entre trámites distintos (@fig:background).

#figure(
  image("../assets/background.png", width: 80%),
  caption: [Antecedentes a la identificación de la problemática de este proyecto\ Fuente: Elaboración propia],
)<fig:background>

== El origen de los trámites gubernamentales

=== El Estado como Sistema Organizativo

Para los teóricos de la armonía social, el estado aparece como la solución colectiva de necesidades nuevas que surgen a partir de situaciones también nuevas @vacarofernandezOrigenEstado2000[pág. 3].
Además, se dice que esta organización representa un fenómeno político que *supuso la separación o la salida de lo político del terreno social* y
*la conversión del individuo en un ciudadano*, cuya relación de pertenencia fundamental será con el estado al margen de cualquier característica particular @gordilloperezPorQueSurge2017.
Esto implica que el ciudadano tiene en adelante una serie de *obligaciones* para con el estado al cual pertenece, así como *derechos*.

// Listado de los componentes del estado

De este modo el estado se materializa mediante cuatro elementos clave @delarocharadaElementosParaTeoria2019 que son territorio, población, gobierno y soberanía.

=== Gobierno, Burocracia y Administración Pública

El gobierno (del griego $kappa mu beta epsilon rho v á omega$ kybernéin "pilotar un barco" o "capitán de un barco"),
es un sistema orgánico de autoridades a través del cual se expresa el poder del estado, creando, afirmando y desenvolviendo el orden jurídico @fernandezruizDerechoParlamentario2023, siendo así el actor que *materializa el poder del estado hacia la población*.

En consecuencia, se suele encontrar dentro del gobierno la figura de la administración pública, que es la que gestiona los asuntos comunes respecto al ciudadano como miembro del estado @guerreroCharlesJeanBonninSiglo2020.
Esta ciencia tiene la importante responsabilidad de poner en *contacto directo* a la población con el poder político @mostajomachicadoDerechoAdministrativoAdministracion2016.

// Necesidad de practicar la burocracia

Para lograr este propósito los gobiernos casi siempre ponen en práctica la *burocracia*
#footnote[término acuñado en el siglo 18 por el filósofo francés Vincent de Gournay, derivando del francés _bureau_ y _cratie_ que significan "Escritorio para escribir" y "Gobierno" respectivamente @rockmanBureaucracyStructureProcesses2024],
que según el sociólogo alemán Max Weber no sólo es la forma más avanzada de ejercer o empuñar el poder por aquellos que lo controlan @watersWeberRationalismModern2015[pág. 114], sino que también es una *forma racional de organización* que en su opinión es la forma más pura de sistema legal de autoridad, es necesaria y algunas de sus características fundamentales son las jerarquías, la especialización y la definición estricta de *reglas y regulaciones* @archerDictionaryPublicAdministration2022.

De este modo, el gobierno, mediante la administración pública y practicando la burocracia, suele emplear el mecanismo del trámite para hacer efectiva la comunicación con la población.

== El trámite tradicional y sus problemas

La palabra trámite viene del latín "trames", "tramitis", que para los romanos significaba "senda" "camino",
de donde se derivó el sentido actual de "vía legal o *procedimiento* que debe seguir una gestión" @TramiteCastellanoPagina.
Según la Real Academia de la Lengua Española, se define al trámite como "Cada uno de los *pasos* y diligencias que hay que recorrer en un asunto hasta su conclusión" @asaleDiccionarioLenguaEspanola.
Algunos sinónimos de trámite son: "Procedimiento Administrativo", "Servicio Público Transaccional", o en inglés "Procedure", "Paperwork".

Para efectos de este documento, se entiende por trámite:

#quote(attribution: [El Fin del Trámite Eterno @rosethFinTramiteEterno2018[pág. 36]])[
  ...el conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas *piden o entregan información* a una entidad pública, con *el fin de obtener* un derecho o *para cumplir* con una obligación.
]

En su forma tradicional, los trámites se llevan a cabo de forma presencial, en una oficina pública, donde el ciudadano debe presentar una serie de documentos y cumplir con ciertos requisitos.

Sin embargo, por lo anterior surge una serie de problemas que afectan a la población, como la corrupción, el clientelismo, los sobornos, la excesiva cantidad de horas necesarias para completar un trámite (@fig:horastramite), el ir y venir y las distancias entre el ciudadano y las oficinas públicas (@fig:tramites_una_interaccion), la falta de definición y acceso a la lista de requisitos, entre otros.

Un ejemplo de esto es el caso de *Domitila Murillo*, una ciudadana boliviana que a causa de un trámite se vio obligada a trasladarse entre varias localidades del país, realizar interminables filas y vagar perdida entre una cantidad indefinida y mal documentada de requisitos. Su caso es muy popular ya que fue motivo de preocupación y cuando finalmente logró recibir su cédula (el cual era el motivo del trámite), no le quedaron más que dos semanas antes de fallecer @charoskyQuejaComoEnergia2014.

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

Estos problemas dentro de la administración pública, despiertan el interés acerca del impacto que podría tener la utilización de las tecnologías de la información dentro del gobierno.

== e-government: Hacia la modernización administrativa

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
en suma, brinda mayor calidad de vida a la ciudadanía @naserGobiernoElectronicoGestion2011.

=== La Digitalización en Bolivia

En Bolivia, la nueva constitución política del estado, promulgada el año 2009, establece en su artículo 103 que "El Estado asumirá como política la implementación de estrategias para incorporar el conocimiento y
aplicación de nuevas tecnologías de información y comunicación". A partir de ello se dio lugar, el año 2011, a la Ley General de Telecomunicaciones, Tecnologías de Información y Comunicación (Ley Nº 164) que tiene entre sus objetivos el de "Promover el uso de las tecnologías de información y comunicación para
mejorar las condiciones de vida de las bolivianas y bolivianos" @Ley164Ley2011.

La misma ley establece, en su Artículo 71, que la promoción del uso de las tecnologías de información y comunicación es prioridad nacional, mientras que el Artículo 72 indica que las entidades públicas deberán adoptar todas las medidas necesarias para su máximo aprovechamiento en el desarrollo de sus funciones.

A partir de la promulgación de esta ley, el gobierno boliviano ha implementado una serie de políticas públicas, creado reglamentos y planes que profundizan en la incorporación del Gobierno Electrónico y el desarrollo de software para el estado.

Una de las características más importantes de la Ley Nº 164 es que establece, en el marco de la soberanía nacional, que se ha de promover y priorizar el uso de software libre, algo que se detalla en el Plan de Implementación de Software Libre y Estándares Abiertos.

El Plan de Implementación de Gobierno Electrónico, aprobado mediante Decreto Supremo Nº 3251, señala en su línea estrátegica 3, que se debe asegurar el intercambio de información entre entidades públicas y con la ciudadanía mediante la interoperabilidad.

Adicionalmente, dada la situación de emergencia sanitaria provocada por la pandemia de COVID-19, el gobierno boliviano ha acelerado la implementación de tecnologías en la administración pública, promoviendo el uso de plataformas digitales para la atención al ciudadano y la gestión de trámites y aprobando mediante Resolución Ministerial Nº 079/20 el documento de "Lineamientos y estándares técnicos para el desarrollo e implementación de Servicios Digitales".

También, en lineas generales, la Constitución Política del Estado Plurinacional de Bolivia, en su Artículo 21, establece el derecho de la ciudadanía a acceder a la información pública y a la administración pública, así como el derecho a la participación en la gestión pública.

En este contexto, distintas entidades públicas han comenzado a implementar sistemas para facilitar sus funciones administrativas, en particular las funciones que tienen que ver con trámites.

== Sistema de Información Ambiental Industrial

Un caso que ilustra la implementación de un sistema con características de gestión de trámites es el Sistema de Información Ambiental Industrial (SIAI), desarrollado por el Ministerio de Desarrollo Productivo y Economía Plural (MDPyEP) en Bolivia.

El D.S. 26736 que aprueba el Reglamento Ambiental del Sector Industrial Manufacturero (RASIM) en su Artículo 9 (Organismo Sectorial Competente), señala las competencias, atribuciones y funciones del Viceministro de Industria y Comercio Interno que actualmente es el Viceministro del Políticas de Industrialización, y en su inciso f) señala: "Establecer y administrar el Sistema de Información Ambiental Industrial (SIAI) y el Sistema de Evaluación y Revelación de Información (SERI)".

A través de un análisis realizado en la gestión 2020 se determinó que el SIAI requiere una adecuación para, primeramente, reducir los tiempos de envió de la información desde las instancias departamentales y municipales, facilitando el llenado a través de internet, además de generar usuarios y autorizaciones para este llenado.

Por lo anterior, se requirió el año 2023, mediante licitación, la implementación de este sistema, bajo el objetivo:

#quote(
  attribution: [Términos de Referencia - SIAI @ConsultoriaPorProducto],
)[Diseñar e implementar un sistema informático denominado “Sistema de Información Ambiental Industrial (SIAI)”, que permita un Registro en Línea de la Información Ambiental Industrial y que ayude en el monitoreo y seguimiento Nacional a través del MDPyEP y los gobiernos Subnacionales competentes en el marco de lo establecido en el Reglamento Industrial para el Sector Industrial Manufacturero, actualizando los datos ambientales de la industria a nivel nacional y acreditar la idoneidad de los mismos, asegurando el cumplimiento de la normativa ambiental vigente]

== Consultoría de 2IES

La consultora 2IES - Ingeniería Estructural e Ingeniería de Telecomunicaciones -, es una empresa fundada en Bolivia el año 1997 y cuenta con experiencia en sectores de infraestructura y en áreas relacionadas con la planificación estratégica, la regulación, el mejoramiento de negocios, y el desarrollo de sistemas, así como la aplicación e integración en Tecnologías de la Información y Comunicación, tanto en empresas como entidades del sector público.

En años recientes, con la adopción de tecnologías de la información cada vez más relevante, el desarrollo de sistemas de software se volvió un pilar fundamental para 2IES.

=== Experiencias en el desarrollo del SIAI

Esta consultora ejecutó el proyecto licitado por el #acr("MDPyEP") y, atendiendo a las especificaciones técnicas del Documento Base de Contratación, se identificaron distintos módulos para la implementación del nuevo SIAI.

El sistema se implementó utilizando PHP con el framework de desarrollo Laravel para el backend y la implementación de la lógica del negocio, exponiendo un servicio REST API consumido por un SPA realizado con el framework de frontend Vue.

Además de atender a los requerimientos iniciales, 2IES propuso funcionalidades que modernicen el trabajo con el SIAI.

Dado que una gran parte de la funcionalidad de este sistema, consistía en el manejo de documentos y su seguimiento mediante trámites, la consultora 2IES hizo una implementación recurriendo al manejo de estados y de roles, creando formularios e integrando los datos al modelo del negocio general.

Una vez concluido el proyecto, se identificaron posibles mejoras al software desarrollado que tienen que ver con la identificación de funcionalidades comunes a cada trámite y las necesidades a las que estos conllevan como la realización de seguimiento, la auditoría y la gestión en general. Se notó que los distintos trámites tienen características comunes y que el sistema SIAI podría ser modularizado para facilitar la implementación de ciertos componentes en otros sistemas gubernamentales.
