== Diseño del Software

=== Introducción y alcance del diseño

// TODO: Identificar los elementos de software diseñados, la audiencia y el
// nivel de detalle cubierto por el capítulo.

Este capítulo documenta de forma selectiva el diseño de Tunkunia. Para ello, adopta el proceso de definición del diseño de ISO/IEC/IEEE 12207:2026 @iso12207SoftwareLifeCycle2026 y los lineamientos sobre elementos de información de ISO/IEC/IEEE 15289:2019 @iso15289InformationItems2019. Como convención documental se emplean de manera adaptada los puntos de vista de IEEE 1016-2009 @ieee1016SoftwareDesign2009, complementados por el área de conocimiento de diseño de software del SWEBOK @washizakiGuideSoftwareEngineering2025. No se declara conformidad completa con estos estándares.

=== Fundamentos y enfoque de documentación

// TODO: Explicar el proceso, los puntos de vista y las notaciones seleccionadas.

==== Proceso de definición del diseño

// TODO: Relacionar el diseño con requisitos, arquitectura y construcción.

==== Adaptación de IEEE 1016 y SWEBOK

// TODO: Justificar el uso selectivo de puntos de vista y temas de diseño.

==== Interesados e inquietudes de diseño

// TODO: Identificar lectores, usos esperados e inquietudes de diseño.

==== Trazabilidad con requisitos y arquitectura

// TODO: Relacionar decisiones y elementos con requisitos y vistas arquitectónicas.

==== Lenguajes y notaciones de diseño

// TODO: Delimitar el uso de UML @uml251, BPMN @bpmn202, redes de Petri, modelos
// entidad-relación, OpenAPI y prototipos de interfaz.

Las representaciones se seleccionan según la inquietud de diseño: UML 2.5.1 @uml251 para estructuras e interacciones, BPMN 2.0.2 @bpmn202 y redes de Petri para procesos, modelos entidad-relación para persistencia y OpenAPI para contratos HTTP.

==== Matriz de puntos de vista seleccionados

// TODO: Mapear inquietudes, secciones, modelos, notaciones y justificación.

=== Diseño del dominio y del flujo de trabajo

// TODO: Describir los conceptos y comportamientos centrales del trámite.

==== Trámites y casos

// TODO: Definir la relación entre procesos configurados y casos en ejecución.

==== Modelo conceptual del dominio

// TODO: Representar entidades, valores, relaciones e invariantes del dominio.

==== Modelo del proceso

// TODO: Formalizar las actividades, eventos y reglas comunes del trámite.

==== Selección del formalismo de representación

// TODO: Comparar las alternativas, justificar las redes de Petri y representar
// su correspondencia con el modelo de datos o con UML cuando sea pertinente.

==== Motor de flujo de trabajo

// TODO: Describir responsabilidades, entradas, salidas y comportamiento del motor.

===== Estados, transiciones y eventos

// TODO: Definir la dinámica de estados del proceso y de cada caso.

===== Reglas de procesamiento y validación

// TODO: Especificar reglas críticas sin repetir el detalle mecánico del código.

===== Concurrencia y contingencias

// TODO: Tratar ejecuciones simultáneas, fallos y recuperación del flujo.

=== Diseño estructural de los elementos de software

// TODO: Refinar las unidades arquitectónicas hasta elementos construibles.

==== Diseño interno del servidor

// TODO: Describir dominio, servicios, persistencia y transporte por módulo.

==== Diseño interno de la aplicación cliente

// TODO: Describir páginas, componentes, estado y acceso al servidor.

==== Patrones y responsabilidades

// TODO: Registrar patrones aplicados y asignación de responsabilidades.

==== Dependencias e interfaces internas

// TODO: Definir contratos y reglas de dependencia entre elementos internos.

==== Mecanismos de extensión y reutilización

// TODO: Explicar cómo adaptar o ampliar Tunkunia para otras instituciones.

=== Diseño de la información y persistencia

// TODO: Documentar los modelos y decisiones de almacenamiento de información.

==== Modelo conceptual y lógico de datos

// TODO: Relacionar conceptos del dominio con entidades y atributos persistentes.

==== Diseño de la base de datos

// TODO: Presentar tablas, relaciones, restricciones e índices relevantes.

==== Integridad y consistencia

// TODO: Especificar invariantes, transacciones y restricciones entre datos.

==== Auditoría y trazabilidad de datos

// TODO: Definir qué cambios se registran y cómo se identifica su origen.

==== Conservación y protección de la información

// TODO: Tratar retención, respaldo y protección de datos sensibles.

=== Diseño de interfaces e integraciones

// TODO: Documentar contratos externos, intercambio de datos e interacciones.

==== Principios de diseño de la API

// TODO: Justificar recursos, versionado, formatos y convenciones HTTP.

==== Especificación OpenAPI

// TODO: Explicar el contrato OpenAPI 3.1 @openapi310 y su organización modular.

La interfaz HTTP se describe mediante OpenAPI 3.1 @openapi310 y se mantiene como artefacto versionado junto al código fuente.

==== Modelo de errores y validación

// TODO: Definir errores interoperables, validaciones y respuestas anómalas.

==== Interoperabilidad

// TODO: Describir mecanismos de integración sin repetir la vista arquitectónica.

==== Servicios externos

// TODO: Especificar contratos y supuestos de servicios gubernamentales o simulados.

==== Notificaciones

// TODO: Definir eventos, destinatarios, contenido, entrega y fallos.

=== Diseño de identidad, seguridad y acceso

// TODO: Documentar identidad, autorización, privacidad y evidencia de actividad.

==== Usuarios, roles y permisos

// TODO: Definir actores internos, roles, permisos y reglas de asignación.

==== Flujo de autenticación

// TODO: Representar el flujo OIDC y el establecimiento de la sesión local.

==== Autorización y control de acceso

// TODO: Especificar dónde y cómo se evalúan las políticas de acceso.

==== Privacidad y protección de datos

// TODO: Identificar datos sensibles y controles aplicables durante su uso.

==== Registro de actividad y auditoría

// TODO: Diseñar los eventos de auditoría y su asociación con actores y acciones.

=== Diseño de la interfaz de usuario

// TODO: Aplicar principios de diseño centrado en las personas de ISO 9241-210
// @iso9241HumanCentredDesign2019 y criterios WCAG 2.2 @iso40500WCAG2025.

El diseño de la aplicación cliente toma como referencia el diseño centrado en las personas de ISO 9241-210:2019 @iso9241HumanCentredDesign2019 y los criterios de accesibilidad WCAG 2.2 adoptados como ISO/IEC 40500:2025 @iso40500WCAG2025, sin declarar conformidad completa.

==== Usuarios, tareas y contextos de uso

// TODO: Relacionar perfiles de usuario, objetivos, capacidades y entorno.

==== Arquitectura de información y navegación

// TODO: Definir jerarquía de contenidos, rutas y navegación entre tareas.

==== Flujos de interacción y estados

// TODO: Representar tareas críticas, estados vacíos, carga, éxito y error.

==== Componentes y patrones de interfaz

// TODO: Describir componentes reutilizables y reglas de interacción coherentes.

==== Vistas y prototipos

// TODO: Presentar las pantallas principales y sus decisiones de diseño.

==== Diseño responsivo y accesibilidad

// TODO: Definir criterios para dispositivos, teclado, foco, contraste y formularios.

=== Información transversal del diseño

// TODO: Registrar decisiones y relaciones que afectan varias secciones.

==== Decisiones y justificación

// TODO: Documentar alternativas, elección y consecuencias de decisiones clave.

==== Manejo de errores y contingencias

// TODO: Consolidar criterios comunes de validación, fallos y recuperación.

==== Correspondencias entre vistas

// TODO: Relacionar entidades equivalentes entre dominio, datos, API y UI.

==== Evaluación de consistencia y trazabilidad

// TODO: Comprobar cobertura de inquietudes, requisitos y restricciones.

==== Limitaciones y diseño diferido

// TODO: Registrar aspectos omitidos o postergados después del MVP.

==== Relación con la implementación

// TODO: Referir código, migraciones, OpenAPI y componentes como materialización.
