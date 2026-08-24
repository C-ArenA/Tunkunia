== Arquitectura del Sistema

=== Introducción y alcance de la descripción

// TODO: Identificar Tunkunia como sistema de interés, el propósito de la
// descripción arquitectónica, su audiencia y sus límites.

Este capítulo presenta una descripción adaptada de la arquitectura de Tunkunia de acuerdo con los conceptos de la norma ISO/IEC/IEEE 42010:2022 @iso42010ArchitectureDescription2022.
La organización se apoya en el enfoque _Views and Beyond_ @clementsDocumentingSoftwareArchitectures2010 y en una adaptación del modelo de vistas 4+1 @kruchtenArchitecturalBlueprints1995.
El modelo C4 @brownC4Model se emplea como notación para algunas representaciones y no como una estructura documental adicional.

=== Objetivos y restricciones arquitectónicas

// TODO: Presentar los factores que condicionan las decisiones arquitectónicas.

==== Objetivos arquitectónicos

// TODO: Derivar objetivos como modularidad, reutilización e interoperabilidad.

==== Interesados e inquietudes

// TODO: Relacionar interesados, inquietudes y vistas que las atienden.

==== Requerimientos arquitectónicamente significativos

// TODO: Seleccionar los requisitos con impacto estructural o transversal.

==== Restricciones y supuestos

// TODO: Registrar restricciones normativas, técnicas y del alcance del MVP.

=== Enfoque de documentación arquitectónica

// TODO: Explicar cómo se combinan los estándares, enfoques y notaciones.

==== Adopción de ISO/IEC/IEEE 42010

// TODO: Delimitar la adopción adaptada y los elementos de descripción usados.

==== Aplicación de Views and Beyond

// TODO: Explicar la selección por inquietudes y la información entre vistas.

==== Selección de vistas mediante el modelo 4+1

// TODO: Justificar las vistas lógica, de procesos, desarrollo y despliegue,
// además de los escenarios.

==== Uso de C4 y otras notaciones

// TODO: Asignar C4, UML y diagramas de secuencia a los modelos pertinentes.

==== Catálogo de puntos de vista y modelos

// TODO: Tabular interesados, inquietudes, modelos, notación y justificación.

=== Descripción general de la arquitectura

// TODO: Ofrecer una lectura inicial de la arquitectura antes de las vistas.

==== Contexto del sistema

// TODO: Presentar el sistema, sus usuarios y sistemas externos mediante C4 C1.

==== Estilos, patrones y principios arquitectónicos

// TODO: Justificar el monolito modular y los patrones de alto nivel adoptados.

==== Síntesis de la solución

// TODO: Resumir cliente, servidor, persistencia e integraciones principales.

==== Decisiones arquitectónicas principales

// TODO: Enumerar las decisiones clave y su motivación.

=== Vistas arquitectónicas

// TODO: Introducir las vistas y la plantilla breve aplicada a cada una.

==== Vista lógica

// TODO: Describir la descomposición funcional independiente de la ejecución.

===== Descomposición funcional

// TODO: Presentar responsabilidades y relaciones de alto nivel.

===== Servidor y sus módulos

// TODO: Documentar los módulos del monolito y sus dependencias permitidas.

===== Aplicación cliente

// TODO: Documentar las responsabilidades y partes principales de la SPA.

==== Vista de procesos

// TODO: Describir la estructura y el comportamiento del sistema en ejecución.

===== Unidades de ejecución y comunicación

// TODO: Presentar cliente, servidor y persistencia mediante C4 C2.

===== Interfaces y sistemas externos

// TODO: Mostrar los conectores y límites con servicios externos.

===== Interacciones dinámicas principales

// TODO: Representar flujos relevantes mediante secuencias o C4 dinámico.

==== Vista de desarrollo

// TODO: Describir la organización estática para quienes desarrollan el sistema.

===== Organización del código fuente

// TODO: Relacionar unidades arquitectónicas con la estructura del monorepositorio.

===== Dependencias y límites entre módulos

// TODO: Establecer reglas de dependencia y encapsulamiento modular.

===== Mecanismos de extensión y reutilización

// TODO: Explicar los puntos previstos para adaptar Tunkunia a instituciones.

==== Vista de despliegue

// TODO: Describir la asignación del software a su infraestructura de ejecución.

===== Unidades desplegables

// TODO: Identificar los artefactos que pueden construirse y desplegarse.

===== Topología de despliegue

// TODO: Representar nodos, artefactos y relaciones mediante C4 de despliegue.

===== Entornos y dependencias operativas

// TODO: Distinguir el entorno esperado de la instalación concreta del prototipo.

==== Vista de escenarios

// TODO: Usar escenarios como vista +1 para relacionar y validar las otras vistas.

===== Casos de uso arquitectónicamente significativos

// TODO: Seleccionar sólo los casos que condicionan decisiones arquitectónicas.

===== Recorridos entre vistas

// TODO: Trazar los elementos participantes en cada escenario entre las vistas.

=== Información transversal a las vistas

// TODO: Documentar información que no pertenece exclusivamente a una vista.

==== Correspondencias y consistencia entre vistas

// TODO: Relacionar elementos equivalentes y registrar inconsistencias conocidas.

==== Variabilidad y evolución

// TODO: Explicar configuraciones institucionales y puntos de evolución previstos.

==== Riesgos y limitaciones arquitectónicas

// TODO: Registrar riesgos, compromisos y aspectos diferidos después del MVP.

==== Relación con el diseño y la implementación

// TODO: Referir el detalle de seguridad, datos e interoperabilidad al capítulo de
// diseño, y tecnologías, OIDC y despliegue concreto al de implementación.
