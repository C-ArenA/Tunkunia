#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "/shared/theme/lib.typ": img-fig, typ-fig

= Introducción

Los trámites constituyen uno de los principales mecanismos de relación entre el
Estado y la población. Su digitalización puede reducir costos, tiempos y
oportunidades de corrupción @rosethFinTramiteEterno2018, pero la cantidad y
diversidad de procedimientos existentes dificulta desarrollar y mantener una
solución independiente para cada uno.

En Bolivia, este proceso forma parte de las políticas de gobierno electrónico
impulsadas desde la Ley Nº 164 de 2011 @Ley164Ley2011. Sin embargo, al 24 de
agosto de 2026, gob.bo registraba 1.195 trámites publicados y 286 digitalizados
@PortalGobbo, aproximadamente el 23,9 %. Esta diferencia no demuestra por sí
sola la calidad de las soluciones existentes, pero sí muestra que una parte
importante de la oferta registrada todavía no se identifica como digital.

Tunkunia parte de la hipótesis de ingeniería de que trámites pertenecientes a
dominios distintos comparten mecanismos que pueden implementarse una sola vez y
configurarse para cada institución. La presente investigación aporta la base
empírica de esa hipótesis: caracteriza una muestra deliberadamente diversa de
procedimientos bolivianos para que posteriormente puedan compararse sus casos,
participantes, datos, documentos, actividades, decisiones, plazos y resultados.

El propósito no es describir exhaustivamente el funcionamiento administrativo
de las instituciones seleccionadas ni producir un catálogo general de trámites.
Los resultados deben servir directamente para:

- delimitar el modelo de trámite utilizado por Tunkunia;
- derivar requerimientos del sistema y del software;
- justificar los conceptos del diseño, como proceso, recurso, caso, expediente,
  actuación y plazo; y
- preparar casos con los que posteriormente pueda validarse la expresividad del
  modelo y el comportamiento del prototipo.

= Metodología

Se adopta un enfoque inductivo de casos múltiples. La unidad de análisis es el
trámite entendido como un procedimiento que coordina actuaciones de personas o
sistemas y transforma información hasta obtener un resultado administrativo.
Las fuentes utilizadas son normativa vigente y documentación publicada por las
instituciones responsables. Los diagramas constituyen interpretaciones del
procedimiento realizadas para esta investigación y no reproducciones oficiales.

== Selección intencional de casos

La muestra se reduce a tres casos mediante un criterio de máxima variación. No
se pretende representatividad estadística; se busca que cada caso introduzca
mecanismos diferentes y relevantes para el diseño:

- *Registro Ambiental Industrial (RAI):* procedimiento regulatorio que clasifica
  una unidad industrial y determina obligaciones posteriores.
- *Cédula de identidad por primera vez:* servicio ciudadano de recorrido breve,
  con verificación de información en otra entidad.
- *Patente de invención:* procedimiento complejo con requisitos documentales,
  exámenes sucesivos, subsanaciones, plazos y participación de terceros.

Se descartan de esta etapa la renovación del RAI, la adscripción al SUS, la
licencia para conducir y la división y partición en Derechos Reales. La
renovación se conserva como una variante temporal dentro del caso RAI; los demás
procedimientos no añaden, para esta muestra inicial, una diferencia que compense
el costo de caracterizarlos con el mismo nivel de detalle.

== Dimensiones y ficha de levantamiento

El levantamiento se organiza a partir de las dimensiones de caso, proceso y
recursos propuestas para los flujos de trabajo
@vanderaalstAPPLICATIONPETRINETS1998, representadas en la
@fig:vanderaals3dwf.

#typ-fig(
  include "/assets/figures/vanderaals3dwf.typ",
  [Abstracción en tres dimensiones de los flujos de trabajo según Van der Aalst],
  <fig:vanderaals3dwf>,
)

Para poder comparar los procedimientos, cada ficha registra los mismos
elementos:

- *Caso:* nombre, propósito, institución competente, fundamento normativo,
  desencadenante, precondiciones y resultados posibles.
- *Recursos:* iniciador, participantes internos, terceros y sistemas o entidades
  externas.
- *Información:* datos, formularios, documentos, expediente y constancias
  producidas.
- *Proceso:* actividades, decisiones, caminos alternativos, correcciones,
  eventos, plazos y condiciones de terminación.

Esta estructura conecta el estudio con Tunkunia. Los participantes observados
permitirán definir recursos y reglas de asignación; los datos y documentos, la
estructura del expediente; las actividades y decisiones, lugares y transiciones;
los plazos, reglas temporales; y las dependencias institucionales, interfaces de
interoperabilidad. La comparación posterior deberá indicar cuáles de estos
elementos son comunes y cuáles permanecen como particularidades configurables.

= Caracterización de los casos

== Registro Ambiental Industrial

- *Nombre:* Registro Ambiental Industrial.
- *Propósito:* registrar y categorizar unidades del sector industrial
  manufacturero para determinar las obligaciones ambientales que les
  corresponden.
- *Institución competente:* Instancia Ambiental del Gobierno Municipal en cuya
  jurisdicción se encuentra o se proyecta la unidad industrial.
- *Fundamento:* artículos 20 a 27 y anexos 1 y 2 del Reglamento Ambiental para el
  Sector Industrial Manufacturero, aprobado mediante el Decreto Supremo Nº 26736
  @DecretoSupremo26736RASIM2002.
- *Iniciador:* representante legal de una unidad industrial en proyecto o en
  operación.
- *Desencadenante:* para una unidad en proyecto, la intención de iniciar su
  instalación; para una unidad en operación, la obligación de registrarse. El
  registro también debe modificarse cuando cambia el rubro o la capacidad
  instalada.
- *Participantes:* representante legal y personal de la instancia ambiental
  municipal. La categoría resultante puede dar paso a instrumentos revisados por
  otras autoridades ambientales, pero esas actuaciones posteriores no forman
  parte del recorrido básico del RAI.
- *Entrada principal:* formulario RAI del anexo 2, presentado como declaración
  jurada. El formulario reúne identificación de la unidad y del representante,
  ubicación, actividad productiva, materias primas, productos, consumo de
  recursos y aspectos ambientales necesarios para aplicar la clasificación del
  anexo 1.
- *Proceso básico:*
  1. El representante completa y presenta el formulario.
  2. La instancia ambiental registra la recepción y revisa la información.
  3. La autoridad aplica la clasificación del anexo 1.
  4. Se notifica la categoría y las obligaciones correspondientes.
- *Plazos:* la revisión dispone de cinco días para una industria en proyecto y
  diez para una industria en operación. El registro tiene vigencia de cinco años
  y debe renovarse treinta días antes de vencer.
- *Decisiones y alternativas:* la categoría depende del rubro, el riesgo de
  contaminación y la situación de proyecto u operación. Si existen varios
  rubros, se utiliza la subclase de mayor riesgo.
- *Resultados:* las categorías 1 y 2 de proyectos requieren EEIA y PMA; la
  categoría 3 requiere DP y PMA; y la categoría 4 queda exenta de los
  instrumentos indicados en el artículo 23. Para industrias en operación, las
  categorías 1, 2 y 3 requieren MAI y PMA.
- *Cambios posteriores:* el registro se actualiza ante inicio de operaciones,
  cambio de razón social o representante y cierre. La diversificación del rubro,
  la ampliación de capacidad o el traslado pueden obligar a modificarlo o iniciar
  uno nuevo.

Este caso deja disponibles para el análisis posterior una decisión de
categorización, plazos de revisión y vigencia, ramificaciones que producen
obligaciones posteriores y un documento con carácter de declaración jurada.

== Cédula de identidad por primera vez

- *Nombre:* emisión de cédula de identidad por primera vez.
- *Propósito:* registrar los datos de una persona en el Registro Único de
  Identificación y otorgarle por primera vez un número y un documento de
  identidad.
- *Institución competente:* Servicio General de Identificación Personal (SEGIP).
- *Fundamento:* Ley Nº 145 y reglamento emitido en el marco del Decreto Supremo
  Nº 4861, especialmente sus artículos 17 a 20
  @SEGIPReglamentoCedulaIdentidad2023.
- *Iniciador:* persona boliviana que todavía no cuenta con un registro consolidado
  para la emisión de su cédula. En el caso de menores interviene además la persona
  responsable conforme a la normativa específica.
- *Desencadenante:* solicitud de obtención del documento por primera vez.
- *Participantes:* solicitante, servidor del SEGIP y, cuando corresponde,
  responsable de una persona menor de edad.
- *Dependencias:* el Servicio de Registro Cívico (SERECI) proporciona y permite
  contrastar el certificado de nacimiento. Para personas naturalizadas también
  interviene documentación emitida por la Dirección General de Migración.
- *Precondiciones e información:* certificado de nacimiento original,
  computarizado y vigente; datos de identidad necesarios para el registro;
  documentación migratoria cuando corresponda; y pago del costo establecido. El
  reglamento fija en Bs 17 el costo de la emisión física.
- *Proceso básico:*
  1. La persona presenta la solicitud y el certificado de nacimiento.
  2. SEGIP verifica el certificado y contrasta la información con SERECI.
  3. Se registran los datos de identidad en el sistema correspondiente.
  4. Se asigna el número de cédula.
  5. Se emite y entrega el documento.
- *Decisiones y alternativas:* el recorrido varía para menores, personas
  naturalizadas y bolivianos nacidos en el exterior. Una inconsistencia en los
  datos impide continuar por el recorrido ordinario y requiere una actuación de
  saneamiento o corrección cuya descripción detallada queda fuera de este caso.
- *Resultado:* registro de identidad consolidado, número de cédula asignado y
  documento físico emitido.

#img-fig(
  "/assets/figures/ci_wfnet.png",
  [Representación preliminar del trámite de obtención de cédula de identidad],
  <fig:ci_wfnet>,
  width: 80%,
)

Este caso permite analizar un recorrido principalmente secuencial, una
precondición documental, una verificación con otra entidad, variantes según la
situación de la persona y la producción de un documento final. La
@fig:ci_wfnet representa una interpretación inicial que deberá revisarse durante
el análisis formal.

== Solicitud de patente de invención

- *Nombre:* solicitud de patente de invención.
- *Propósito:* obtener el derecho exclusivo que el Estado concede sobre una
  invención que cumpla novedad, nivel inventivo y aplicación industrial.
- *Institución competente:* Servicio Nacional de Propiedad Intelectual (SENAPI).
- *Fundamento:* Decisión 486 de la Comisión de la Comunidad Andina
  @ComunidadAndinaDecision4862000 y requisitos operativos publicados por SENAPI
  @SENAPIPatentesDisenosIndustriales.
- *Iniciador:* persona natural o jurídica solicitante, directamente o mediante
  representación.
- *Desencadenante:* presentación voluntaria de una solicitud de protección.
- *Participantes:* solicitante o representante, personal receptor, examinadores
  de forma y patentabilidad y autoridad que concede o deniega. Después de la
  publicación pueden intervenir terceros con interés legítimo; también pueden
  requerirse expertos u otras oficinas.
- *Información y documentos:* petitorio, descripción, reivindicaciones, resumen,
  dibujos cuando sean necesarios, identificación, poderes cuando corresponda,
  comprobantes de pago y los demás documentos aplicables a prioridad, recursos
  genéticos o conocimientos tradicionales.
- *Precondición de admisión:* para asignar fecha de presentación deben existir,
  como mínimo, indicación de que se solicita una patente, identificación o medio
  de contacto del solicitante, descripción, dibujos cuando correspondan y
  comprobante de pago.
- *Proceso básico:*
  1. Presentación y recepción de la solicitud.
  2. Examen de forma.
  3. Subsanación cuando se detectan omisiones formales.
  4. Publicación de la solicitud.
  5. Periodo para oposiciones de terceros.
  6. Solicitud y realización del examen de patentabilidad.
  7. Respuesta del solicitante a observaciones de fondo, cuando existan.
  8. Resolución de concesión o denegación.
- *Plazos y correcciones:* el examen de forma se realiza dentro de treinta días.
  Las omisiones notificadas pueden subsanarse dentro de dos meses, prorrogables
  una sola vez por un periodo igual. La publicación ordinaria ocurre después de
  dieciocho meses, aunque puede solicitarse antes una vez concluido el examen de
  forma. Desde la publicación, terceros con interés legítimo disponen de sesenta
  días para oponerse. El examen de patentabilidad debe solicitarse dentro de seis
  meses; durante este examen, el solicitante dispone de sesenta días para
  responder observaciones, prorrogables una vez por treinta días.
- *Decisiones y alternativas:* una solicitud puede no ser admitida, declararse
  abandonada por falta de subsanación o de solicitud del examen, recibir
  oposiciones, superar los exámenes o concluir en denegación. El solicitante
  puede modificar la solicitud sin ampliar la protección inicialmente divulgada
  y puede desistir durante el trámite.
- *Resultado:* título de patente cuando se concede la protección, o resolución de
  denegación, abandono o desistimiento.

#typ-fig(
  diagram(
    spacing: (4mm, 10mm),
    node-stroke: luma(80%),
    node((0, 0), [Solicitud]),
    edge("->"),
    node((0, 1), [Examen\ de forma]),
    edge("->"),
    node((1, 0), [Publicación]),
    edge("->"),
    node((1, 1), [Espera de\ oposiciones]),
    edge("->"),
    node((2, 0), [Examen de\ patentabilidad]),
    edge("->"),
    node((2, 1), [Concesión o\ denegación]),
  ),
  [Etapas principales de la solicitud de patente de invención],
  <fig:senapiblocks>,
  placement: auto,
)

Este caso aporta al análisis una estructura de expediente, requisitos
obligatorios y opcionales, subsanaciones, abandonos, plazos prorrogables,
publicación, participación de terceros y dos niveles de examen. La
@fig:senapiblocks resume únicamente el recorrido principal y no sustituye el
modelo formal de sus alternativas.

= Base preparada para el análisis

La caracterización anterior deja una base homogénea, pero todavía no constituye
por sí misma el modelo general del trámite. La siguiente etapa deberá comparar
los tres casos sin asumir que una característica observada una sola vez es
necesariamente común a todos los trámites.

La comparación deberá responder, al menos, las siguientes preguntas:

- ¿Qué elementos aparecen en los tres casos y pueden considerarse parte del
  núcleo de Tunkunia?
- ¿Qué elementos aparecen solo en uno o dos casos, pero deben admitirse como
  configuración opcional?
- ¿Qué particularidades dependen de reglas institucionales o normativa sectorial
  y no deberían incorporarse al motor general?
- ¿Cómo se representan las correcciones, abandonos, decisiones, plazos y
  actuaciones externas mediante redes de Petri?
- ¿Qué información pertenece al marcado y cuál debe conservarse en el
  expediente?
- ¿Qué conceptos resultantes requieren trazabilidad hacia los requerimientos y
  el capítulo de arquitectura y diseño?

Como producto de esa etapa se espera una matriz comparativa, una definición
operativa del trámite, un catálogo breve de mecanismos comunes y modelos de
Petri revisados. Esos artefactos constituirán la entrada para la especificación
de Tunkunia y, posteriormente, el comportamiento esperado contra el cual se
realizará la validación conceptual y funcional.

= Limitaciones del levantamiento

La muestra es intencional y pequeña, por lo que no permite afirmar que los
mecanismos encontrados cubren todos los trámites bolivianos. Las fuentes
normativas describen obligaciones y decisiones, pero no siempre revelan el
procedimiento operativo completo, sus sistemas internos ni el tratamiento de
excepciones. Por ello, los modelos posteriores deberán identificar qué pasos
provienen directamente de una fuente y cuáles son interpretaciones necesarias
para representar el flujo.

La normativa y los servicios también pueden cambiar. La caracterización
corresponde a las fuentes consultadas hasta agosto de 2026 y deberá verificarse
antes de utilizarse para una implementación institucional real.
