#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge

= Solución Propuesta

Se propone la creación de un módulo de software libre que aglutine las funcionalidades alrededor de los flujos de trámite que, como una forma específica de los sistemas de gestión de flujos de trabajo (WFMS), cuente con la capacidad de realizar su definición, ejecución, registro, y control (@fig:modfun), permitiendo la interoperabilidad mediante REST API e interfaces de usuario opcionales, tanto de administración como de ciudadano, para el fácil seguimiento de los distintos procesos en concordancia con la normativa boliviana. El módulo tendrá los mecanismos necesarios para poder integrarlo en otros sistemas, permitiendo el uso del mismo para la lógica del negocio del sistema en el que se use, esto es, siguiendo un enfoque modular (@fig:modulegraph). Los detalles de implementación del módulo a nivel de arquitectura se definirán a partir del grado de cohesión requerido con otros módulos, como ser el de autenticación y las tecnologías de desarrollo utilizadas, que pueden condicionar ciertas decisiones.

#figure(
  image("../assets/modulegraph.png"),
  caption: [Representación gráfica a grandes rasgos del módulo Tunkunia\ Fuente: Elaboración propia],
)<fig:modulegraph>

Esto se conseguirá mediante el modelado del proceso del trámite usando como motor a las máquinas de estado finitas, redes de Petri, diagramas de actividad UML y otras técnicas de modelado. Se identificarán patrones comunes en los trámites, como el manejo de documentos, la verificación y aceptación de datos, etc., partiendo de flujos comunes como el de la @fig:stateex o el de la @fig:petricomplaints.

#figure(
  image("../assets/stateprocedureexample.png", width: 70%),
  caption: [Modelado simplificado del proceso de trámite\ Fuente: Elaboración propia],
)<fig:stateex>

#figure(
  image("../assets/petricomplaints.png", width: 70%),
  caption: [Red de Petri de un proceso de queja\ Fuente: The Application Of Petri Nets to Workflow Management @vanderaalstAPPLICATIONPETRINETS1998],
)<fig:petricomplaints>

Se explorarán técnicas para ayudar en el proceso de verificación y aceptación de datos, como el uso de modelos grandes de lenguaje con inteligencia artificial así como métodos determinísticos de validación de datos.

Los requerimientos que se tendrán en cuenta principalmente serán aquellos encontrados en el RASIM para el SIAI y la implementación realizada por la consultora 2IES, aunque pueden tomarse ejemplos externos para enriquecer el modelado.

Algunas funcionalidades que se espera tener son:

- Creación de Metadatos de trámite (Definición de trámite).

- Generación de códigos de trámite.

- Funcionalidad de notificaciones.

- Límites de tiempo asignables a los estados de trámite.

- Funcionalidad de persistencia de historial de estados incorporada.

- Funciones de recuperación de historia de trámite para seguimiento.

- Niveles de visibilidad de trámites para seguimiento.

- Mecanismos para dificultar el entorpecimiento de un trámite y
  facilitar la identificación de responsables.

- Interfaz sencilla para cambio de estados de una máquina de estados (trámite).

- Formularios flexibles para el manejo de documentos

- Registro de documentos de trámite usando o simulando aprobación de documentos de ciudadanía digital #footnote[De acuerdo a la norma técnica de adhesión para mecanismos de ciudadanía digital, se requiere seguir un procedimiento burocrático cuyo fracaso podría comprometer el proyecto. Es por ese motivo que, aunque con claras limitaciones y como contingencia, se habilita la posibilidad de simular ciertos mecanismos o usar algunos similares.]<fn:ciudad_dig>.

- Autenticación de usuarios usando o simulando el uso de ciudadanía digital #footnote(<fn:ciudad_dig>).

#figure(
  diagram(
    spacing: (18mm, 10mm),
    node-stroke: luma(80%),
    node((1.5, 0), [*Tunkunia*\ Trámites], name: <t>),
    node((0, 1), [*Definición*], name: <d>),
    node((1, 1), [*Ejecución*], name: <e>),
    node((2, 1), [*Registro*], name: <r>),
    node((3, 1), [*Control*], name: <c>),
    node((2.5, 2), [*Seguimiento*], name: <s>),
    node((3.5, 2), [*Reporte*], name: <re>),

    edge(<t>, <d>),
    edge(<t>, <e>),
    edge(<t>, <r>),
    edge(<t>, <c>),
    edge(<c>, <s>),
    edge(<c>, <re>),
  ),
  caption: [Funciones a grandes rasgos del módulo],
)<fig:modfun>
