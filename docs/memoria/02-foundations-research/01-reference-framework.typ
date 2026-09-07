#import "/shared/theme/lib.typ": img-fig

== Marco de Referencia<section:reference_framework>

=== Administración pública y trámite

==== Estado, gobierno y administración pública

Para los teóricos de la armonía social, el Estado aparece como la solución colectiva de necesidades nuevas que surgen a partir de situaciones también nuevas @vacarofernandezOrigenEstado2000[pág.
  3].
Se dice que esta organización representa un fenómeno político que *supuso la separación o la salida de lo político del terreno social* y *la conversión del individuo en un ciudadano*, cuya relación de pertenencia fundamental será con el Estado al margen de cualquier característica particular @gordilloperezPorQueSurge2017.
Dicha separación se ve reflejada en los cuatro elementos clave mediante los cuales se materializa el Estado: territorio, población, gobierno y soberanía @delarocharadaElementosParaTeoria2019.

El gobierno, del griego $kappa mu beta epsilon rho v á omega$ _kybernéin_, "pilotar un barco" o "capitán de un barco", es un sistema orgánico de autoridades a través del cual se expresa el poder del Estado, creando, afirmando y desenvolviendo el orden jurídico @fernandezruizDerechoParlamentario2023, siendo así el actor que *materializa el poder del Estado hacia la población*.

En consecuencia, se suele encontrar dentro del gobierno la figura de la administración pública, que gestiona los asuntos comunes respecto al ciudadano como miembro del Estado @guerreroCharlesJeanBonninSiglo2020.
Esta ciencia tiene la importante responsabilidad de poner en *contacto directo* a la población con el poder político @mostajomachicadoDerechoAdministrativoAdministracion2016.

Para lograr este propósito los gobiernos casi siempre ponen en práctica la *burocracia* #footnote[término acuñado en el siglo 18 por el filósofo francés Vincent de Gournay, derivando del francés _bureau_ y _cratie_, que significan "Escritorio para escribir" y "Gobierno" respectivamente @rockmanBureaucracyStructureProcesses2024].
Según el sociólogo alemán Max Weber, no sólo es la forma más avanzada de ejercer o empuñar el poder por aquellos que lo controlan @watersWeberRationalismModern2015[pág.
  114], sino también una *forma racional de organización* que, en su opinión, es la forma más pura de sistema legal de autoridad, es necesaria y tiene entre sus características fundamentales las jerarquías, la especialización y la definición estricta de *reglas y regulaciones* @archerDictionaryPublicAdministration2022.

De este modo, el gobierno, mediante la administración pública y practicando la burocracia, emplea diferentes mecanismos, entre los cuales se encuentra el trámite como una forma de hacer efectiva la comunicación con la población.

==== Definición y funcionamiento del trámite

La palabra trámite viene del latín "trames", "tramitis", que para los romanos significaba "senda" o "camino" @TramiteCastellanoPagina.
Según la Real Academia de la Lengua Española, se define como "Cada uno de los *pasos* y diligencias que hay que recorrer en un asunto hasta su conclusión" @asaleDiccionarioLenguaEspanola.
Algunos términos para referirse a lo mismo son "Procedimiento Administrativo", "Servicio Público Transaccional" o, en inglés, "Procedure" y "Paperwork".

Para efectos de este documento, se entiende por trámite al conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas *piden o entregan información* a una entidad pública, con *el fin de obtener* un derecho o *para cumplir* con una obligación @rosethFinTramiteEterno2018[pág.
  36].
En su forma tradicional se realiza presencialmente en una oficina pública, donde el ciudadano presenta documentos y cumple requisitos que pueden involucrar otros trámites.

==== Trámites de referencia

#set list(spacing: 1em)

El diseño de un subsistema reutilizable para trámites requiere conocer
procedimientos reales sin confundir su descripción administrativa con las
decisiones posteriores de software.
Por ello se reúne un conjunto reducido de
trámites bolivianos que sirve como referencia común para el diseño y para la
validación del proyecto.
La selección es intencional: no busca representar
estadísticamente todos los trámites del país, sino aportar situaciones variadas
y suficientemente documentadas.

Los casos considerados cumplen los siguientes criterios:

- corresponden a instituciones públicas bolivianas;
- cuentan con normativa o información institucional accesible al público;
- permiten reconstruir, al menos, su propósito, participantes, información,
  pasos y resultados; y
- aportan comportamientos útiles para evaluar un prototipo reutilizable sin
  depender de una especialización sectorial completa.

La selección también toma como referencia la clasificación de Roseth et al.
@rosethFinTramiteEterno2018[pág.
  36], que distingue cuatro propósitos generales:

- *registro, certificaciones y constancias:* incorporar información a un
  registro estatal o producir un comprobante;
- *cumplimiento de obligaciones:* atender deberes establecidos por ley cuyo
  incumplimiento puede generar consecuencias negativas;
- *acceso a servicios:* obtener un beneficio provisto por una institución
  pública; y
- *obtención de permisos:* recibir autorización para realizar una actividad.

Esta clasificación orienta la diversidad de la muestra, pero no obliga a que
cada procedimiento pertenezca de manera exclusiva a una categoría.
Un trámite
puede combinar varios propósitos y se clasifica aquí según el que predomina en
el recorrido estudiado.

Para mantener comparables las descripciones se utiliza una ficha común.
Cada
ficha registra nombre, tipo, propósito, institución competente, fundamento,
iniciador, desencadenante, participantes, dependencias, precondiciones,
información intercambiada, procedimiento básico, decisiones, plazos y
resultados.
La ficha describe el trámite con independencia de la técnica que se
elija posteriormente para modelarlo en el software.

===== Registro Ambiental Industrial

- *Nombre:* Registro Ambiental Industrial (RAI).
- *Tipo:* trámite para cumplir una obligación.
- *Propósito:* registrar y categorizar unidades del sector industrial
  manufacturero para determinar las obligaciones ambientales que les
  corresponden.
- *Institución competente:* instancia ambiental del Gobierno Autónomo Municipal
  en cuya jurisdicción se encuentra o se proyecta la unidad industrial.
- *Fundamento:* artículos 20 a 27 y anexos 1 y 2 del Reglamento Ambiental para
  el Sector Industrial Manufacturero, aprobado mediante el Decreto Supremo Nº
  26736 @DecretoSupremo26736RASIM2002.
- *Iniciador:* representante legal de una unidad industrial en proyecto o en
  operación.
- *Desencadenante:* intención de instalar una unidad industrial, obligación de
  registrar una unidad en operación o necesidad de actualizar el registro por
  cambios relevantes.
- *Participantes:* representante legal y personal de la instancia ambiental
  municipal.
- *Dependencias:* la categoría obtenida puede originar instrumentos posteriores
  sometidos a otras autoridades ambientales, aunque esos procedimientos no
  forman parte del recorrido básico del RAI.
- *Precondiciones e información:* formulario RAI del anexo 2, presentado como
  declaración jurada, con datos de identificación, ubicación, actividad
  productiva, materias primas, productos, consumo de recursos y aspectos
  ambientales.
- *Procedimiento básico:*
  1. El representante completa y presenta el formulario.
  2. La instancia ambiental registra la recepción y revisa la información.
  3. La autoridad aplica la clasificación prevista en el anexo 1.
  4. Se notifica la categoría y las obligaciones correspondientes.
- *Decisiones:* la categoría depende del rubro, el riesgo de contaminación y la
  situación de proyecto u operación.
  Si existen varios rubros, se considera la
  subclase de mayor riesgo.
- *Plazos:* la revisión dispone de cinco días para una industria en proyecto y
  diez para una industria en operación.
  El registro tiene una vigencia de cinco
  años y debe renovarse treinta días antes de vencer.
- *Resultados:* asignación de una categoría que determina los instrumentos
  ambientales posteriores o la exención correspondiente.

Este caso aporta una declaración jurada, una decisión de categorización, plazos
de revisión y vigencia, y un resultado que condiciona obligaciones posteriores.

===== Cédula de identidad por primera vez

- *Nombre:* emisión de cédula de identidad por primera vez.
- *Tipo:* trámite de registro, certificación y constancia.
- *Propósito:* registrar los datos de una persona en el Registro Único de
  Identificación y otorgarle por primera vez un número y un documento de
  identidad.
- *Institución competente:* Servicio General de Identificación Personal
  (SEGIP).
- *Fundamento:* Ley Nº 145 y reglamento emitido en el marco del Decreto Supremo
  Nº 4861, especialmente sus artículos 17 a 20
  @SEGIPReglamentoCedulaIdentidad2023.
- *Iniciador:* persona boliviana que todavía no cuenta con un registro
  consolidado; para una persona menor de edad interviene además su responsable.
- *Desencadenante:* solicitud voluntaria de obtención del documento por primera
  vez.
- *Participantes:* solicitante, servidor del SEGIP y, cuando corresponde,
  responsable de una persona menor de edad.
- *Dependencias:* el Servicio de Registro Cívico (SERECI) permite contrastar el
  certificado de nacimiento.
  Para personas naturalizadas también se requiere
  información emitida por la Dirección General de Migración.
- *Precondiciones e información:* certificado de nacimiento original,
  computarizado y vigente; datos de identidad; documentación migratoria cuando
  corresponda; y pago del costo establecido.
- *Procedimiento básico:*
  1. La persona presenta la solicitud y la documentación requerida.
  2. SEGIP verifica el certificado y contrasta la información con SERECI.
  3. Se registran los datos de identidad.
  4. Se asigna el número de cédula.
  5. Se emite y entrega el documento.
- *Decisiones:* el recorrido presenta variantes para menores, personas
  naturalizadas y bolivianos nacidos en el exterior.
  Una inconsistencia en los
  datos requiere un procedimiento de saneamiento o corrección distinto del
  recorrido ordinario.
- *Plazos:* la fuente consultada no establece un plazo general para completar el
  recorrido ordinario.
- *Resultado:* registro de identidad consolidado, número de cédula asignado y
  documento físico emitido.

Este caso aporta un recorrido principalmente secuencial, variantes según la
situación de la persona y una verificación de información con otra entidad.

===== Adscripción al Sistema Único de Salud

- *Nombre:* adscripción al Sistema Único de Salud (SUS).
- *Tipo:* trámite para acceder a servicios.
- *Propósito:* registrar a una persona beneficiaria y vincularla con el
  establecimiento público de primer nivel que constituye su puerta de ingreso
  al sistema de salud.
- *Institución competente:* establecimiento público de salud de primer nivel
  correspondiente al lugar de residencia de la persona, bajo el marco del
  Ministerio de Salud y Deportes.
- *Fundamento:* artículo 10 del Reglamento para la Aplicación Técnica,
  Administrativa y Financiera de la Ley Nº 1152
  @MinisterioSaludReglamento1152SUS2019.
- *Iniciador:* persona que no se encuentra cubierta por la Seguridad Social de
  Corto Plazo y solicita su adscripción; para menores interviene su responsable.
- *Desencadenante:* intención de acceder regularmente a las prestaciones del SUS
  o necesidad de formalizar la adscripción al momento de una atención.
- *Participantes:* persona beneficiaria o responsable y personal del
  establecimiento de salud.
- *Dependencias:* la plataforma de adscripción verifica si la persona se
  encuentra afiliada a un ente gestor de la Seguridad Social de Corto Plazo.
- *Precondiciones e información:* identificación de la persona y datos del
  formulario MS/SUS-001.
  El establecimiento debe corresponder al primer nivel de
  atención más cercano al domicilio.
- *Procedimiento básico:*
  1. La persona solicita la adscripción en el establecimiento correspondiente.
  2. El personal verifica su identidad y la ausencia de afiliación a un ente
    gestor de corto plazo.
  3. Se registran los datos directamente en la plataforma o, en el procedimiento
    manual, se completa el formulario MS/SUS-001.
  4. Si el registro fue manual, la información se incorpora posteriormente a la
    plataforma.
  5. Se confirma la adscripción al establecimiento de primer nivel.
- *Decisiones:* el registro puede ser manual o informatizado.
  La afiliación a un
  ente gestor impide seguir el recorrido ordinario del SUS; las urgencias y
  determinadas situaciones sin identificación reciben un tratamiento
  excepcional.
- *Plazos:* la adscripción es un proceso continuo y permanente; la normativa
  consultada no fija un plazo individual de resolución.
- *Resultado:* persona registrada como beneficiaria y asociada a su
  establecimiento de primer nivel para acceder a las prestaciones aplicables.

Este caso aporta dos canales de registro, una verificación contra otro sistema y
excepciones en las que la atención no debe quedar subordinada al recorrido
ordinario.

===== Solicitud de patente de invención

- *Nombre:* solicitud de patente de invención.
- *Tipo:* trámite para obtener un permiso o protección administrativa.
  Esta
  correspondencia es aproximada: el resultado no es una licencia operativa,
  sino un derecho exclusivo reconocido por el Estado.
- *Propósito:* obtener protección sobre una invención que cumpla novedad, nivel
  inventivo y aplicación industrial.
- *Institución competente:* Servicio Nacional de Propiedad Intelectual
  (SENAPI).
- *Fundamento:* Decisión 486 de la Comisión de la Comunidad Andina
  @ComunidadAndinaDecision4862000 y requisitos operativos publicados por SENAPI
  @SENAPIPatentesDisenosIndustriales.
- *Iniciador:* persona natural o jurídica solicitante, directamente o mediante
  representación.
- *Desencadenante:* presentación voluntaria de una solicitud de protección.
- *Participantes:* solicitante o representante, personal receptor, examinadores
  de forma y patentabilidad, autoridad que resuelve y terceros que pueden
  presentar oposiciones.
- *Dependencias:* pueden intervenir expertos, otras oficinas y documentos sobre
  prioridad, recursos genéticos o conocimientos tradicionales.
- *Precondiciones e información:* indicación de que se solicita una patente,
  identificación o medio de contacto, descripción, dibujos cuando correspondan
  y comprobante de pago.
  El expediente puede incorporar petitorio,
  reivindicaciones, resumen, poderes y otros documentos aplicables.
- *Procedimiento básico:*
  1. Presentación y recepción de la solicitud.
  2. Examen de forma y, cuando corresponda, subsanación.
  3. Publicación y periodo para oposiciones.
  4. Solicitud y realización del examen de patentabilidad.
  5. Respuesta a observaciones de fondo cuando existan.
  6. Resolución de concesión o denegación.
- *Decisiones:* la solicitud puede no ser admitida, abandonarse, recibir
  oposiciones, superar los exámenes, ser modificada dentro de ciertos límites o
  concluir por desistimiento.
- *Plazos:* existen plazos distintos para el examen de forma, la subsanación, la
  publicación, las oposiciones, la solicitud del examen de patentabilidad y la
  respuesta a observaciones; algunos admiten una prórroga.
- *Resultados:* título de patente o resolución de denegación, abandono o
  desistimiento.

La patente aporta conceptos valiosos, como expediente, requisitos condicionales,
subsanaciones, plazos prorrogables, participación de terceros y exámenes
sucesivos.
Sin embargo, su complejidad y la falta de detalle público sobre parte
de la operación interna impedirían representarla sin introducir demasiadas
interpretaciones.
Por ello se conserva como referencia para el diseño, pero se
descarta de la validación conceptual del prototipo.

Los tres casos no descartados —RAI, cédula de identidad y adscripción al SUS— se
retomarán en la validación.
La síntesis de los mecanismos que influyen en el
software y la elección de una técnica formal de modelado se realizan en la etapa
de diseño, donde corresponde justificar esas decisiones.

#set list(spacing: auto)

=== Gobierno electrónico y contexto institucional boliviano <sec:egov>

#let governmentFootNote = [
  No existe consenso en la definición y uso del término "Gobierno Electrónico" por ser relativamente incipiente y más de una vez se emplean los términos
  "Gobierno Digital" o incluso "Gobierno Inteligente" para referirse a lo mismo.
  En este documento se prefiere el uso del primero.
]

En una entrevista del año 2015 a Carlos Jiménez @digitalGobiernoInteligenteEntrevista2015, responsable mundial de _IEEE e-government_, este señaló que el *gobierno electrónico #footnote(governmentFootNote)* es una fase para llegar a tener gobiernos inteligentes y abiertos y que:

#quote(attribution: "Carlos Jiménez")[
  ...consiste en implantar la tecnología para *mejorar procesos administrativos y permitir la interacción con los ciudadanos*
]

El Gobierno Electrónico brinda muchos beneficios a la población, como la eliminación de barreras temporales y espaciales, el acceso igualitario a la información, la colaboración y el aumento en la producción de bienes y servicios; en suma, brinda mayor calidad de vida a la ciudadanía @naserGobiernoElectronicoGestion2011.
Los esfuerzos por digitalizar los trámites se enmarcan dentro de este concepto.

==== AGETIC

La Agencia de Gobierno Electrónico y Tecnologías de Información y Comunicación
(AGETIC) es una institución pública descentralizada de derecho público, bajo
tuición del Ministerio de la Presidencia, con personalidad jurídica, patrimonio
propio y autonomía de gestión administrativa, financiera, legal y técnica.
Fue
creada mediante el Decreto Supremo Nº 2514, de 9 de septiembre de 2015
@AGETICPlanEstrategicoInstitucional.

Sus atribuciones comprenden elaborar, proponer e implementar políticas, planes y
estrategias de gobierno electrónico y tecnologías de información y comunicación
para el sector público; coordinar su ejecución; proponer lineamientos técnicos
para servicios e infraestructura informática; establecer lineamientos de
seguridad de la información; coordinar la gestión de incidentes; y evaluar la
calidad y eficiencia de los servicios de gobierno electrónico.
También articula
y actualiza los planes nacionales de gobierno electrónico y de software libre y
estándares abiertos @AGETICPlanEstrategicoInstitucional.
Por tanto, constituye un
actor técnico central del contexto institucional en el que Tunkunia pretende ser
adoptado, aunque cada institución pública conserva la responsabilidad sobre sus
competencias y procedimientos.

==== Ciudadanía Digital

La ciudadanía digital consiste en el ejercicio de derechos y deberes mediante el
uso de tecnologías de información y comunicación en la interacción de las
personas con entidades públicas y con entidades privadas que prestan servicios
públicos delegados por el Estado.
El servicio de Ciudadanía Digital reúne los
mecanismos que, al integrarse con los servicios digitales de estas entidades,
permiten una interacción eficiente, transparente y segura, y pueden evitar la
presencia física y la presentación de documentación en papel durante un trámite
@CiudadaniaDigitalPreguntasFrecuentes.

Entre sus mecanismos se encuentran la autenticación de la persona mediante
credenciales únicas, la aprobación digital de documentos, las notificaciones
electrónicas y la autorización de acceso a servicios o información.
Estos
mecanismos no constituyen por sí mismos un sistema de gestión de trámites, sino
servicios comunes que las plataformas institucionales pueden integrar
@CiudadaniaDigitalTerminos.
En Tunkunia resultan especialmente relevantes como
proveedor externo de identidad y como referencia para futuras integraciones de
aprobación y notificación.

==== Plataforma GOB.BO

La plataforma gob.bo es el portal que centraliza y facilita el acceso a
información del Estado Plurinacional de Bolivia.
Gestiona información sobre
trámites y servicios, entidades y páginas institucionales, datos abiertos y
observatorios para la ciudadanía @GobBoAcerca.
En el caso de los trámites,
funciona como catálogo oficial: permite conocer sus requisitos y características
y acceder o iniciar aquellos que ya fueron virtualizados.
Esto no implica que la
plataforma implemente por sí misma los procesos internos de cada institución,
pero la información que publica constituye una fuente relevante para modelarlos.

Al 24 de agosto de 2026, las estadísticas visibles en la plataforma registraban
1.195 trámites publicados, de los cuales 286 estaban digitalizados, equivalentes
a aproximadamente 23,9 %, además de 662 entidades registradas @PortalGobbo.
Estas
cifras describen el estado del portal en la fecha de consulta y pueden variar a
medida que las instituciones publiquen, actualicen o retiren información.

#img-fig(
  "/assets/figures/gobbo-proporcion-digitalizacion.pdf",
  [Proporción de trámites digitalizados entre los publicados en gob.bo al 24 de agosto de 2026],
  <fig:gobbo-proporcion-digitalizacion>,
  source: [Plataforma gob.bo @PortalGobbo],
  width: 70%,
)

==== Distribución de soluciones a instituciones

Además de operar servicios transversales como Ciudadanía Digital, la AGETIC
facilita la adopción de soluciones comunes por parte de las instituciones
públicas.
Un ejemplo son las Plantillas de Portales Web Institucionales,
desarrolladas sobre los sistemas de gestión de contenidos Drupal y WordPress,
ambos de código abierto y uso gratuito.
Las plantillas buscan uniformar el
contenido y la estructura de los portales públicos, mejorar la experiencia de
las personas usuarias y simplificar la gestión y actualización de la información
institucional @AGETICPlantillasPortalesInstitucionales.

La AGETIC proporciona plantillas demostrativas y en blanco, especificaciones
técnicas y manuales de instalación y configuración, y prevé su publicación en el
Repositorio Estatal de Software Libre para que estén disponibles a las entidades
del sector público @AGETICPlantillasPortalesInstitucionales.
Este mecanismo
constituye un antecedente directo para la forma de reutilización propuesta por
Tunkunia: distribuir una base tecnológica común y configurable sin centralizar
en ella las competencias ni la lógica particular de todas las instituciones.

=== Marco normativo boliviano

Bolivia cuenta con una normativa amplia en relación con el uso de las @TICs, el gobierno electrónico, la digitalización de trámites y el desarrollo de software gubernamental.
La @fig:bolivia_norms resume los principales documentos normativos y sus relaciones más relevantes.

#img-fig(
  "/assets/figures/bolivia_norms.png",
  [Documentos normativos relacionados con el gobierno electrónico en Bolivia y las relaciones más relevantes entre los mismos],
  <fig:bolivia_norms>,
  width: 70%,
)

==== Fundamentos constitucionales

La Constitución Política del Estado, promulgada el 7 de febrero de 2009, establece en su Artículo 103 que: "El Estado asumirá como política la implementación de estrategias para incorporar el conocimiento y *aplicación de nuevas tecnologías de información y comunicación*" @BoliviaConstitucionPolitica2009.

En líneas generales, su Artículo 21 también establece el derecho de la ciudadanía a acceder a la información pública y a la administración pública, así como el derecho a la participación en la gestión pública.

==== Procedimiento administrativo

La Ley Nº 2341 tiene como uno de sus objetos "Establecer las normas que regulan la actividad administrativa y el *procedimiento administrativo* del sector público" @LeyNo23412002.
Su Artículo 4, "Principios Generales de la Actividad Administrativa", incluye dos principios importantes en este contexto: el "Principio de eficacia" y el "Principio de economía, simplicidad y celeridad".
El Artículo 16 lista, entre otros, los siguientes derechos:

- Derecho a conocer *el estado del procedimiento* en que sea parte.
- Derecho a *obtener* certificados y copias de documentos que estén en poder de la Administración Pública.
- Derecho a *acceder* a registros y archivos administrativos.

Esta ley también define la acción correspondiente a los silencios administrativos y otras situaciones propias del proceso administrativo.
Aunque es general, establece condiciones que pueden ser atendidas con un sistema digitalizado de gestión y seguimiento de trámites, como consultar el estado de un trámite u obtener copias de documentos que obren en poder de la administración pública.

==== Tecnologías de información y gobierno electrónico

La Constitución dio lugar, el año 2011, a la Ley General de Telecomunicaciones, Tecnologías de Información y Comunicación (Ley Nº 164), que tiene entre sus principales objetivos: "Promover el uso de las tecnologías de información y comunicación para *mejorar las condiciones de vida de las bolivianas y bolivianos*" @Ley164Ley2011.

La citada norma establece en su Artículo 71 que la promoción del uso de las tecnologías de información y comunicación es *prioridad nacional*.
El Artículo 72 indica que las entidades públicas deberán adoptar *todas las medidas necesarias* para su máximo aprovechamiento en el desarrollo de *sus funciones*, y el Artículo 77 señala que se promoverá y priorizará el uso de *software libre* y estándares abiertos en todos los niveles del gobierno, en el marco de la *soberanía y seguridad nacional*.

La Ley Nº 164 también dispone la creación de planes de implementación con una naturaleza más práctica:

#quote(attribution: [Ley Nº 164, Artículo 75])[
  ...
  II.
  El Órgano Ejecutivo del nivel central del Estado, elaborará los lineamientos para la incorporación del Gobierno Electrónico
]

#quote(attribution: [Ley Nº 164, Artículo 71])[
  ...
  II.
  El Órgano Ejecutivo del nivel central del Estado, elaborará el plan de implementación de software libre y estándares
  abiertos en coordinación con los demás órganos del Estado y entidades de la administración pública.
]

Estos planes serían nuevamente requeridos en el reglamento aprobado por el Decreto Supremo Nº 1793, "Reglamento para el Desarrollo de Tecnologías de Información y Comunicación", que contiene definiciones y normativa importante para personas naturales o jurídicas, públicas o privadas que *realicen actividades o presten servicios relacionados con la certificación digital, gobierno electrónico, software libre, correo electrónico y el uso de documentos y firmas digitales en el Estado Plurinacional de Bolivia*.
Este reglamento sigue la misma filosofía de la Ley Nº 164 y de los planes posteriores.

==== Plan de Implementación de Gobierno Electrónico

Mediante Decreto Supremo Nº 3251 se aprobaron tanto el "Plan de Implementación de Gobierno Electrónico" como el "Plan de Implementación de Software Libre y Estándares Abiertos" @DecretoSupremoNo2017.

El primero define los ejes y líneas estratégicas para implementar la política de gobierno electrónico en el país, como puede verse en la @table:ejes_egob.
Estos ejes reflejan gran parte de lo establecido en las leyes y reglamentos relevantes para cualquier proyecto de software gubernamental.

#figure(
  table(
    columns: (1fr, 1.5fr),
    align: (center + horizon, left),
    fill: (x, y) => {
      if y == 0 { return rgb(230, 230, 230) }
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

La línea estratégica número 3 establece que se debe asegurar el intercambio de información entre entidades públicas y con la ciudadanía mediante la interoperabilidad.

==== Tramitación digital e interoperabilidad

El Decreto Supremo Nº 3525 tiene como uno de sus objetos normar la *tramitación digital* @DECRETOSUPREMO35252018.
Si bien aún no se consigue poner en práctica la totalidad de dicha norma, se puede resaltar lo siguiente:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 12])[
  *Trámites Administrativos:*

  I.
  Las instituciones públicas *deberán priorizar en todos sus trámites el uso de tecnologías de información* y comunicación a efecto de digitalizar, automatizar, interoperar y simplificar la tramitación de los asuntos que son de su competencia.

  II.
  Para facilitar la realización de trámites a la ciudadanía, las entidades públicas, en observancia de su normativa específica, deberán *intercambiar entre ellas datos e información mediante interoperabilidad*.
  Los mecanismos y condiciones de publicación y acceso a los servicios de interoperabilidad serán establecidos por el Ente Rector de Gobierno Electrónico y Tecnologías de Información y Comunicación.

  III.
  El intercambio de datos e información mediante interoperabilidad no afectará la percepción de recursos de las entidades públicas titulares de la información por la prestación del servicio público.

  IV.
  Las entidades públicas *no podrán exigir* al administrado como requisito ningún documento que hubiera sido *emitido por la misma entidad*, o cuya información esté disponible mediante servicios de interoperabilidad de otra entidad.

  V.
  Las entidades públicas *no podrán exigir al administrado como requisito ningún documento que hubiera sido requerido con anterioridad*, salvo actualización o modificación y conforme a normativa legal vigente.

  VI.
  Las entidades públicas tendrán un plazo máximo de veinte (20) días hábiles a partir de la publicación de un nuevo servicio de interoperabilidad para adecuar sus procesos y procedimientos al mismo.
]

Lo anterior no sólo establece la obligación de digitalizar los trámites administrativos, sino también la interoperabilidad entre entidades públicas y la necesidad de resguardar la información de los administrados.
Esto es clave para el funcionamiento del sistema propuesto, que se espera pueda integrarse con otros sistemas de información y servicios de interoperabilidad.

Muchos trámites que se digitalizan cuentan con documentos físicos importantes.
Al respecto, el mismo decreto establece:

#quote(attribution: [Decreto Supremo Nº 3525, Artículo 13])[
  *Entidades generadoras de información:*

  ...II.
  En el marco de procesos de actualización, certificación o emisión de copias legalizadas de documentos que aún se encuentren en formato físico, los datos e información pertinente consignados en los mismos *deberán ser registrados en medios digitales* que permitan ser publicados mediante servicios de interoperabilidad.]

Durante la concepción de este proyecto, se presentó como situación actual un listado de normativas relevantes con efectos prácticos en el trabajo.
Posteriormente, durante su desarrollo, se suscitaron cambios, siendo el más relevante la creación de manuales a partir del Decreto Supremo Nº 5340.

Este decreto tiene como objeto crear la plataforma digital del Estado Plurinacional de Bolivia, también contemplada en el Decreto Supremo Nº 3525 y que a la fecha resulta en el portal gob.bo vigente.

La emergencia sanitaria provocada por la pandemia de COVID-19 aceleró la implementación de @TICs en la administración pública.
Por esto se aprobó, mediante Resolución Ministerial Nº 079/20, el documento de "Lineamientos y estándares técnicos para el desarrollo e implementación de Servicios Digitales", que insiste en la digitalización de servicios como el trámite, guía a las entidades públicas y privadas que desarrollan software con este propósito e indica la disponibilidad de herramientas creadas por la AGETIC, como Ciudadanía Digital.

==== Software libre y estándares abiertos

El "Plan de Implementación de Software Libre y Estándares Abiertos" establece los ejes, líneas y metas que se muestran en la @table:ejes_software.

#figure(
  table(
    columns: (1fr, 1.5fr, 2.5fr),
    align: (center + horizon, left + horizon, left + horizon),
    fill: (x, y) => {
      if y == 0 { return rgb(230, 230, 230) }
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

La Ley Nº 164 establece al respecto:

#quote(attribution: [Artículo 77, Ley Nº 164])[
  I.
  Los Órganos Ejecutivo, Legislativo, Judicial y Electoral en todos sus niveles,
  promoverán y priorizarán la *utilización del software libre y estándares abiertos*, en
  el marco de la soberanía y seguridad nacional.
]

Como evidencia esta normativa, el software libre se encuentra regulado y se establecen lineamientos y directrices para su implementación y posterior aplicación prioritaria en el país.

//NOTE: Podríamos añadir subtítulo sobre los lineamientos aprobados por RM 079/2, pero a pesar de su relevancia, lo dejaremos para el final, porque ya tenemos mucha información. Quizá podríamos añadir lo que se indica sobre que cada entidad pública debe digitalizar los trámites por su cuenta
