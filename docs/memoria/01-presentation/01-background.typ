#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig

== Antecedentes

A continuación se presenta el recorrido que conduce a la problemática de este proyecto: los problemas del trámite tradicional, la adopción de tecnologías de la información por el gobierno boliviano, la atención a esta necesidad en el @SIAI mediante la consultora 2IES y la posterior identificación de características comunes a diversos trámites (@fig:background).

#img-fig(
  "/assets/figures/background.png",
  [Antecedentes a la identificación de la problemática de este proyecto],
  <fig:background>,
  width: 80%,
  placement: top,
)

=== Del trámite tradicional a la modernización administrativa

En su forma tradicional, los trámites se llevan a cabo de forma presencial, en una oficina pública, donde el ciudadano debe presentar una serie de documentos y cumplir con ciertos requisitos, muchos de los cuales involucran la realización de otros trámites.

Esto deriva en una serie de problemas que suelen afectar a la población, como la corrupción, el clientelismo, la excesiva cantidad de horas necesarias para completar un trámite (@fig:horastramite), las distancias entre el ciudadano y las oficinas públicas, el número de interacciones necesarias (@fig:tramites_una_interaccion), la falta de definición de requisitos y las deficiencias en el acceso a la información, entre otros.

Un ejemplo es el caso de *Domitila Murillo*, una ciudadana boliviana que, a causa de un trámite, se vio obligada a trasladarse entre varias localidades del país (recorriendo al menos 900 km durante 11 meses), realizando interminables filas y vagando perdida entre una cantidad indefinida y mal documentada de requisitos.
Su caso fue motivo de preocupación y, cuando finalmente logró recibir su cédula, que era el motivo del trámite, no le quedaron más que dos semanas antes de fallecer @charoskyQuejaComoEnergia2014[pág.
  23].

#img-fig(
  "/assets/figures/horastramite.png",
  [Horas necesarias para completar un trámite, por país],
  <fig:horastramite>,
  source: [Datos del Latinobarómetro, 2017],
  width: 50%,
  placement: auto,
)

#img-fig(
  "/assets/figures/tramites_una_interaccion.png",
  [Porcentaje de trámites resueltos en una interacción],
  <fig:tramites_una_interaccion>,
  source: [Datos del Latinobarómetro, 2017],
  width: 50%,
  placement: auto,
)

Estos problemas dentro de la administración pública despertaron el interés acerca del impacto que podría tener la utilización de las tecnologías de la información en este ámbito, llevando a la creación del concepto de *Gobierno Electrónico* o *e-government*, desarrollado en el @section:reference_framework.

=== Evolución del gobierno electrónico en Bolivia

La implementación de un gobierno electrónico no es una tarea sencilla, ya que requiere esfuerzos en conjunto dentro de los gobiernos.
En Bolivia, a partir del año 2009, se promulgaron decretos, leyes y reglamentos orientados a promover el uso de las tecnologías de la información y comunicación en la administración pública, aunque aún queda un largo camino por recorrer para lograr una implementación efectiva y eficiente.

La nueva Constitución Política del Estado, promulgada el 7 de febrero de 2009, estableció en su Artículo 103 que el Estado asumiría como política la implementación de estrategias para incorporar el conocimiento y la aplicación de nuevas tecnologías de información y comunicación @BoliviaConstitucionPolitica2009.
Esto dio lugar, el año 2011, a la Ley General de Telecomunicaciones, Tecnologías de Información y Comunicación (Ley Nº 164) @Ley164Ley2011 y, posteriormente, a políticas públicas, reglamentos y planes que profundizaron la incorporación del gobierno electrónico y el desarrollo de software para el Estado.

Entre estos instrumentos, el Plan de Implementación de Gobierno Electrónico fue aprobado mediante Decreto Supremo Nº 3251 @DecretoSupremoNo2017.
Más adelante, la emergencia sanitaria provocada por la pandemia de COVID-19 aceleró la implementación de @TICs en la administración pública y promovió plataformas digitales para la atención al ciudadano y la gestión de trámites.
En ese contexto se aprobó, mediante Resolución Ministerial Nº 079/20, el documento de "Lineamientos y estándares técnicos para el desarrollo e implementación de Servicios Digitales".

Esta evolución normativa, desarrollada sistemáticamente en el @section:reference_framework, impulsó a distintas entidades públicas a implementar sistemas que facilitaran sus funciones administrativas, particularmente aquellas relacionadas con trámites.

=== El SIAI y la experiencia de 2IES

Un caso que ilustra esta evolución es el Sistema de Información Ambiental Industrial (@SIAI), desarrollado para el Ministerio de Desarrollo Productivo y Economía Plural (@MDPyEP) en Bolivia.

A través de un análisis realizado en la gestión 2020 se determinó que el SIAI requería una adecuación para reducir los tiempos de envío de la información desde las instancias departamentales y municipales, facilitar el llenado a través de Internet y generar usuarios y autorizaciones para este llenado.

Por lo anterior, se requirió el año 2023, mediante licitación, la implementación de este sistema con el siguiente objetivo:

#quote(
  attribution: [Términos de Referencia del proyecto de implementación del SIAI @ConsultoriaPorProducto],
)[Diseñar e implementar un sistema informático denominado “Sistema de Información Ambiental Industrial (SIAI)”, que permita un Registro en Línea de la Información Ambiental Industrial y que ayude en el monitoreo y seguimiento Nacional a través del MDPyEP y los gobiernos subnacionales competentes en el marco de lo establecido en el Reglamento Industrial para el Sector Industrial Manufacturero, actualizando los datos ambientales de la industria a nivel nacional y acreditar la idoneidad de los mismos, asegurando el cumplimiento de la normativa ambiental vigente]

La consultora 2IES #sym.dash.em Ingeniería Estructural e Ingeniería de Telecomunicaciones #sym.dash.em es una empresa fundada en Bolivia el año 1997 y cuenta con experiencia en sectores de infraestructura y en áreas relacionadas con la planificación estratégica, la regulación, el mejoramiento de negocios y el desarrollo de sistemas, así como la aplicación e integración de Tecnologías de la Información y Comunicación, tanto en empresas como en entidades del sector público.

En años recientes, con la adopción de las tecnologías de la información cada vez más relevante en el mercado local boliviano, el desarrollo de sistemas de software se volvió un pilar fundamental para 2IES, lo que llevó a su presentación en la licitación del proyecto de implementación del SIAI.

La ejecución del proyecto, licitado por el @MDPyEP, estuvo a cargo de la consultora 2IES, que procedió a implementar el nuevo @SIAI atendiendo las especificaciones técnicas del Documento Base de Contratación y las distintas interacciones efectuadas con el cliente.

=== Identificación de la necesidad del proyecto

Además de atender los requerimientos iniciales del DBC, 2IES propuso funcionalidades que modernizaran el trabajo con el SIAI.
A partir del requerimiento de hacer seguimiento a las solicitudes de distintos documentos ambientales y a la generación de estos, se identificó a dichos procesos como trámites que debían ser digitalizados.

Dado que una gran parte de la funcionalidad del sistema consistía en el manejo de documentos y su seguimiento mediante trámites, la consultora implementó el manejo de estados y roles, creó formularios e integró los datos al modelo de negocio general.

Al implementar los diferentes componentes referentes a dichos trámites, se identificaron claras similitudes entre ellos, como la necesidad de permitir un seguimiento transparente, la aprobación de documentos por etapas, la auditoría y la gestión general de cada trámite.

Si bien el proyecto del SIAI llegó a su conclusión, las similitudes identificadas al implementar sus distintos trámites, además de su potencial correspondencia con trámites de otras instancias del sector público, guiaron la identificación del problema presentado en este proyecto.
