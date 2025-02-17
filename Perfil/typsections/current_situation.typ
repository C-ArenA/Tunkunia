= Situación Actual <section:current_situation>

En relación al contexto planteado en la sección de antecedentes, así como el desarrollo de sistemas modernos de software y la modularización de funcionalidades,
resulta fundamental exponer, antes de abordar los aspectos específicos del proyecto, el estado de la situación en distintos niveles, como pueden ser la normativa vigente, definiciones y acepciones relevantes, trabajos similares en el campo, tecnologías utilizadas, investigaciones académicas pertinentes, y buenas prácticas de la industria, entre otros.


== Trámites y Procedimientos Administrativos en la actualidad

#quote(attribution: [Comunicado de Prensa, BID @BIDDigitalizacionTramites])[
  Los tramites digitales se demoran 74% menos que tramites presenciales, cuestan mucho menos, y reducen la incidencia de corrupción, sin embargo, en América Latina y el Caribe todavía hay poca inversión para ofrecer servicios públicos en línea. ¿El resultado? Los ciudadanos, las empresas y la administración pública pierden tiempo, dinero y productividad.]

La anterior cita, si bien se realiza en base a un estudio realizado el año 2018 @rosethFinTramiteEterno2018, refleja parcialmente la situación actual ante la falta de estudios más recientes. En general, si bien se nota una mayor adopción de los trámites digitales, aún existen muchos que se realizan de forma total o parcialmente manual.

=== Normativa
Al respecto del trámite administrativo es menester citar al Decreto Supremo N° 3525 que tiene como uno de sus objetos normar la *tramitación digital* @DECRETOSUPREMO35252018. En dicho Decreto, podemos resaltar lo siguiente:

\
*Trámites Administrativos:*

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 12])[
  #par(
    first-line-indent: 0em,
    spacing: 1.4em,
  )[
    I. Las instituciones públicas *deberán priorizar en todos sus trámites el uso de tecnologías de información* y comunicación a efecto de digitalizar, automatizar, interoperar y simplificar la tramitación de los asuntos que son de su competencia.

    II. Para facilitar la realización de trámites a la ciudadanía, las entidades públicas, en observancia de su normativa específica, deberán intercambiar entre ellas datos e información mediante interoperabilidad. Los mecanismos y condiciones de publicación y acceso a los servicios de interoperabilidad serán establecidos por el Ente Rector de Gobierno Electrónico y Tecnologías de Información y Comunicación.

    III. El intercambio de datos e información mediante interoperabilidad no afectará la percepción de recursos de las entidades públicas titulares de la información por la prestación del servicio público.

    IV. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido emitido por la misma entidad, o cuya información esté disponible mediante servicios de interoperabilidad de otra entidad.

    V. Las entidades públicas no podrán exigir al administrado como requisito ningún documento que hubiera sido requerido con anterioridad, salvo actualización o modificación y conforme a normativa legal vigente. VI. Las entidades públicas tendrán un plazo máximo de veinte (20) días hábiles a partir de la publicación de un nuevo servicio de interoperabilidad para adecuar sus procesos y procedimientos al mismo]]

\
*Entidades generadoras de información:*

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 13])[

  #par(
    first-line-indent: 0em,
    spacing: 1.4em,
  )[
    ...II. En el marco de procesos de actualización, certificación o emisión de copias legalizadas de documentos que aún se encuentren en formato físico, los datos e información pertinente consignados en los mismos deberán ser registrados en medios digitales que permitan ser publicados mediante servicios de interoperabilidad.]]

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

Cuando hablamos de Gobierno Electrónico y su normativa es menester citar inicialmente a la Constitución Política del Estado Plurinacional de Bolivia, misma que en su Art. 103 y 298 denota la importancia del desarrollo de la ciencia y la investigación a favor de las bolivianas y los bolivianos.
Además, reconoce como prioridad el uso de las tecnologías y comunicación para el vivir bien:

#quote(attribution: "Artículo 103 de la Constitución Política del Estado Plurinacional de Bolivia")[

  #par(
    first-line-indent: 0em,
    hanging-indent: 2em,
    spacing: 1.4em,
  )[I. El Estado garantizará el desarrollo de la ciencia y la investigación científica, técnica y tecnológica en beneficio del interés general. Se destinarán los recursos necesarios y se creará el sistema estatal de ciencia y tecnología.

    II. El Estado asumirá como política la implementación de estrategias para incorporar el conocimiento y aplicación de nuevas tecnologías de información y comunicación.

    III. El Estado, las universidades, las empresas productivas y de servicio públicas y privadas, y las naciones y pueblos indígena originario campesinos, desarrollarán y coordinarán procesos de investigación, innovación, promoción, divulgación, aplicación y transferencia de ciencia y tecnología para fortalecer la base productiva e impulsar el desarrollo integral de la sociedad, de acuerdo con la ley.
  ]]

Asimismo el Artículo 298 de la citada normativa legal en su segundo parágrafo establece lo siguiente:

#quote[
  Declara prioridad nacional la promoción del uso de las tecnologías de información y comunicación para procurar el vivir bien de todas las bolivianos y bolivianos.]

A su vez, es importante citar la Ley N°164 - Ley General de Comunicaciones, Tecnologías de Información y Comunicación, misma que en su Artículo 71 declara prioridad nacional la promoción y uso de tecnologías de información y comunicación para procurar el vivir bien de todas las bolivianas y bolivianos. 
Por otra parte, el párrafo I del el Artículo 72 de la citada noma legal, establece el rol de Estado con referencia al uso de las TIC'S, el despliegue y uso de infraestructura, el desarrollo de contenidos y aplicaciones, la protección de las usuarias y usuarios, la seguridad informática y redes como mecanismos de democratización de oportunidades para todos los sectores de la sociedad y especialmente para aquellos con menores ingresos y con necesidades especiales, a su vez el Artículo 75 de la citada norma legal, hace referencia a Gobierno Electrónico, mismo que establece de forma expresa lo siguiente:
"I. El nivel central del Estado promueve la incorporación del Gobierno Electrónico a los procedimientos gubernamentales, a la prestación de sus servicios y a la difusión de información, mediante una estrategia enfocada al servicio de la población. II. El Órgano Ejecutivo del nivel central del Estado, elaborará los lineamientos para la incorporación del Gobierno Electrónico.".
Asimismo el Artículo 76, define el Alcance de Gobierno Electrónico, mismo que señala lo siguiente:
"...El Estado fijará los mecanismos y condiciones que las entidades públicas aplicarán para garantizar el máximo aprovechamiento de las tecnologías de la información y comunicación, que permitan lograr la prestación de servicios eficientes."

Otra normativa que regula lo referente al Gobierno Electrónico, se puede citar al Reglamento para el Desarrollo de Tecnologías de Información y Comunicación - Decreto Supremo N° 1793, mismo que en su Art. 17 establece el objetivo de Gobierno Electrónico, señalando lo siguiente:
"...I. Modernizar y transparentar la gestión pública, otorgando servicios y atención de calidad a la ciudadanía, garantizando el derecho a la información, así como contribuir a la eficiencia y eficacia de los actos administrativos en los procesos internos del gobierno, mediante el uso de las tecnologías de información y comunicación y otras herramientas. II. Generar mecanismos tecnológicos de participación y control social, mediante el uso de TIC por parte de los ciudadanos, organizaciones sociales y pueblos y naciones indígena originario campesinos."

== Sistema de Información Ambiental Industrial
=== RASIM

== FOSS y Soberanía digital
=== Normativa en Bolivia

Respetando el orden jerárquico de la normativa en Bolivia, en referencia al uso de software libre y soberanía digital, se tiene en la Constitución Política del Estado Plurinacional de Bolivia, el deber de:

#quote(attribution: [Constitución Política del Estado Plurinacional de Bolivia, Artículo 108])[
  Defender la unidad, la soberanía y la integridad territorial de Bolivia, y respetar sus símbolos
  y valores
]

Al respecto del software libre y su regulación normativa en nuestro país es importante citar la Ley N° 164 @Ley164Ley2011, misma que establece lo siguiente acerca del software libre:

#quote(attribution: [Artículo 77, Ley Nº 164])[
  #par(
    first-line-indent: 0em,
    hanging-indent: 2em,
    spacing: 1.4em,
  )[
    I. Los Órganos Ejecutivo, Legislativo, Judicial y Electoral en todos sus niveles,
    promoverán y priorizarán la *utilización del software libre y estándares abiertos*, en
    el marco de la soberanía y seguridad nacional.

    II. El Órgano Ejecutivo del nivel central del Estado, elaborará el *plan de
  implementación de software libre y estándares abiertos* en coordinación con los
    demás órganos del Estado y entidades de la administración pública.]
]

Asimismo, el Plan de Implementación de Software Libre y estándares abiertos en su marco conceptual define al SOFTWARE LIBRE de la siguiente manera:

#quote[…El software libre se fundamenta en una filosofía que busca mejorar la vida de las personas al orientar el desarrollo tecnológico hacia la igualdad y el bienestar común. Esta filosofía promueve la cooperación y permite que todos disfruten libremente de los avances tecnológicos, siempre respetando los derechos de los demás, promoviendo la libertad de usar, aprender y compartir tecnología y conocimiento…]

Como se evidencia de la normativa señalada anteriormente el Software libre hoy en día se encuentra regulado y se establecen los lineamientos y directrices para su implementación y posterior aplicación en nuestro país.

== Proyectos y trabajos similares
=== A nivel académico

Debido a la cantidad de procesos administrativos que existen en distintas instituciones, podemos encontrar una gran cantidad de proyectos de grado realizados en la región que tratan sobre la implementación de sistemas de control de trámites:

- SISTEMA DE CONTROL DE TRÁMITES UTILIZANDO MAQUINAS DE TURING CASO: DIVISIÓN DE GESTIONES ADMISIONES Y REGISTROS U.M.S.A.
- Desarrollo e Implementación del Sistema de Tramite
  Documentario en la Municipalidad Provincial de
  Huancayo para la atencion de expedientes.
- DESARROLLO DE UN SISTEMA WEB PARA MEJORAR EL PROCESO DE TRÁMITE DOCUMENTARIO ADMINISTRATIVO DEL HOSPITAL SUB REGIONAL DE ANDAHUAYLAS
- Sistema de información de trámite documentario basado en tecnología web para institutos de educación superior tecnológicos de la región Ancash en el año 2016
- Programa de automatización de los procedimientos de trámite documentario en la calidad del servicio a los usuarios del Hospital Nacional Arzobispo Loayza - Lima, 2016
- Implementación de un sistema de trámite documentario para la Agencia de Compras de las Fuerzas Armadas
- Implementación De Un Módulo De Control Y Seguimiento Para Mejorar La Gestión Del Trámite Documentario En La Municipalidad Distrital De Cayaltí, 2018
- Desarrollo de una aplicación _web responsive_ para mejorar el proceso de trámite documentario en un colegio profesional
- Desarrollar un sistema web de trámite documental para mantener las acreditadoras de la escuela de ingeniería informática de la URP

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
