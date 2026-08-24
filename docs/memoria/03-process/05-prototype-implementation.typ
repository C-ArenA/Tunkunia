== Implementación del prototipo

=== Introducción y alcance de la implementación

// TODO: Identificar los elementos construidos, la audiencia del capítulo y el
// alcance concreto del prototipo.

Este capítulo documenta de forma selectiva la construcción del prototipo de Tunkunia.
Para ello, adopta el proceso de implementación de ISO/IEC/IEEE 12207:2026 @iso12207SoftwareLifeCycle2026 y los lineamientos sobre elementos de información de ISO/IEC/IEEE 15289:2019 @iso15289InformationItems2019.
Como guía para los aspectos propios de la construcción se emplea el área de conocimiento de construcción de software del SWEBOK @washizakiGuideSoftwareEngineering2025.
No se declara conformidad completa con estos estándares.

La exposición se concentra en la materialización del servidor, la aplicación web y los servicios de apoyo.
Las decisiones estructurales se remiten al capítulo de arquitectura, el detalle prescriptivo al capítulo de diseño y los resultados de las pruebas al capítulo de validación.

=== Estrategia de construcción del prototipo

// TODO: Explicar cómo se materializó el diseño mediante una construcción
// iterativa y cómo se integraron progresivamente los elementos del prototipo.

==== Correspondencia entre diseño y código

// TODO: Relacionar requisitos, elementos de diseño, módulos, artefactos de código
// y funcionalidades construidas, sin repetir las especificaciones de diseño.

==== Proceso de construcción e integración

// TODO: Describir las iteraciones, el orden de implementación y los puntos de
// integración relevantes con la metodología de desarrollo adoptada.

==== Selección del stack tecnológico

// TODO: Presentar una tabla con elemento, tecnología, versión, función y
// justificación. Distinguir restricciones previas de decisiones tomadas durante
// la construcción.

==== Entorno y herramientas de desarrollo

// TODO: Documentar las herramientas necesarias para editar, generar, compilar,
// ejecutar y comprobar el prototipo, evitando enumerar herramientas incidentales.

=== Implementación del servidor

// TODO: Describir cómo se materializaron las responsabilidades del servidor y
// remitir su descomposición conceptual al diseño y a la vista lógica.

==== Composición y punto de entrada

// TODO: Explicar la composición de la aplicación, el arranque y la conexión de
// los módulos y adaptadores en cmd/, main.go e internal/api/.

==== Módulos de negocio

// TODO: Presentar los módulos implementados por capacidad de negocio, sus
// responsabilidades efectivas y los mecanismos relevantes de colaboración.

==== Persistencia y migraciones

// TODO: Describir la materialización del modelo de datos, las migraciones y los
// adaptadores de persistencia, incluyendo el tratamiento del código generado.

==== API HTTP

// TODO: Explicar la implementación del contrato OpenAPI, el transporte HTTP, la
// validación y la correspondencia entre tipos de transporte y dominio.

==== Identidad, autorización y auditoría

// TODO: Documentar los mecanismos implementados para sesión, permisos y registro
// de actividad, remitiendo sus reglas al capítulo de diseño.

=== Implementación de la aplicación web

// TODO: Describir cómo se materializó el diseño de la SPA y remitir los flujos y
// prototipos de interacción al capítulo de diseño.

==== Estructura de la aplicación

// TODO: Presentar la organización de la aplicación Nuxt, sus puntos de entrada,
// layouts, middleware y mecanismos de composición.

==== Páginas y navegación

// TODO: Relacionar las rutas y páginas implementadas con las tareas principales
// de los usuarios.

==== Componentes y estado

// TODO: Describir los componentes reutilizables, composables y mecanismos de
// estado relevantes para la implementación.

==== Integración con la API

// TODO: Explicar el uso del cliente generado, el intercambio de datos y el
// tratamiento de respuestas y errores.

==== Formularios y estados de interacción

// TODO: Presentar la implementación de validación, carga, ausencia de datos,
// éxito y error, además de las medidas responsivas y de accesibilidad aplicadas.

=== Servicios e infraestructura de apoyo

// TODO: Identificar los servicios necesarios para ejecutar el prototipo que no
// constituyen por sí mismos elementos funcionales de Tunkunia.

==== Base de datos y almacenamiento

// TODO: Describir el motor utilizado por el prototipo, su inicialización y los
// supuestos operativos relevantes.

==== Integración OIDC

// TODO: Explicar la configuración concreta del proveedor, los puntos de
// integración y el recorrido de autenticación implementado.

===== Entorno de prueba con Dex

Para simular la existencia de un módulo de ciudadanía digital con el estándar OIDC, se empleó una herramienta llamada Dex.
Esta herramienta tiene como propósito conectar distintos tipos de sistemas de autenticación mediante OIDC, lo cual resultó útil para crear un _mock_ del servicio de autenticación de la AGTIC.

// TODO: Documentar la configuración y las limitaciones de Dex como sustituto del
// servicio real, sin presentarlo como parte del producto desplegable.

==== Servicios externos y simulados

// TODO: Registrar otros servicios externos o sustitutos empleados, sus contratos
// y las diferencias relevantes respecto a un entorno institucional real.

=== Integración y comprobaciones de construcción

// TODO: Documentar cómo se obtuvo un conjunto ejecutable coherente. Los resultados
// cuantitativos y la evaluación del producto corresponden al capítulo de validación.

==== Integración de los elementos del prototipo

// TODO: Explicar la integración entre servidor, aplicación web, persistencia,
// proveedor de identidad y demás servicios de apoyo.

==== Dependencias y generación de código

// TODO: Describir la gestión de dependencias y los flujos de generación para la
// base de datos, OpenAPI y otros artefactos reproducibles.

==== Comprobaciones mínimas de construcción

// TODO: Indicar las comprobaciones aplicadas durante la construcción, como
// compilación, formato, análisis estático y pruebas unitarias, y remitir sus
// resultados consolidados al capítulo de validación.

=== Repositorio y gestión de la configuración

// TODO: Presentar sólo la información necesaria para comprender y reproducir la
// construcción. Remitir las convenciones operativas al apéndice de configuración
// y gestión de cambios.

==== Organización del monorepositorio

// TODO: Resumir la distribución del servidor, la SPA, la documentación y los
// artefactos compartidos, relacionándola con la vista de desarrollo.

==== Automatización y tareas reproducibles

// TODO: Documentar los comandos y tareas que automatizan generación, compilación,
// ejecución y comprobaciones.

==== Control de versiones y código generado

// TODO: Sintetizar la estrategia de control de versiones y explicar qué
// artefactos se generan, cuáles se versionan y cuáles no se editan manualmente.

=== Construcción y despliegue del prototipo

// TODO: Describir la instalación concreta del prototipo. La topología esperada y
// las alternativas de infraestructura permanecen en la vista de despliegue.

==== Unidades y artefactos construidos

// TODO: Identificar ejecutables, paquetes de la SPA, migraciones, especificaciones
// y archivos de configuración producidos por la construcción.

==== Configuración y secretos

// TODO: Explicar las fuentes de configuración, sus valores predeterminados y el
// tratamiento seguro de credenciales y secretos, sin publicar valores sensibles.

==== Procedimiento de construcción y ejecución

// TODO: Presentar los prerrequisitos y la secuencia reproducible para preparar,
// compilar e iniciar el prototipo.

==== Despliegue concreto

// TODO: Registrar el entorno donde se ejecutó el prototipo, la asignación de sus
// artefactos y las diferencias respecto al despliegue objetivo.

=== Resultados y limitaciones de la implementación

// TODO: Delimitar qué se construyó y qué quedó fuera del prototipo sin anticipar
// la evaluación desarrollada en el capítulo de validación.

==== Funcionalidad materializada

// TODO: Resumir las capacidades implementadas y proporcionar trazabilidad hacia
// requisitos y elementos de diseño.

==== Desviaciones respecto al diseño

// TODO: Registrar diferencias justificadas entre el diseño previsto y la
// implementación efectiva, junto con sus consecuencias.

==== Deuda técnica y trabajo diferido

// TODO: Identificar simulaciones, limitaciones conocidas, deuda técnica y
// elementos reservados para una versión posterior al prototipo.

==== Relación con la validación

// TODO: Referir los escenarios, pruebas y resultados que evalúan el prototipo en
// el capítulo siguiente.
