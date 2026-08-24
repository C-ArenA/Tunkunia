# Informe de modificaciones respecto al perfil de proyecto aprobado

## Datos de identificación

| Dato | Información |
| --- | --- |
| **Universidad** | Universidad Mayor de San Andrés |
| **Facultad** | Facultad de Ingeniería |
| **Carrera** | Ingeniería Electrónica |
| **Asignatura** | EN1040 — Proyecto de Grado |
| **Título del proyecto** | *Tunkunia*: Subsistema reutilizable de software libre para la gestión de flujos de trámite orientado al gobierno electrónico en Bolivia |
| **Estudiante / postulante** | Ernesto Carlos Arena Alarcon |
| **Docente asignado** | Jorge Mario León Gómez |
| **Tutor** | Jorge Antonio Nava Amador |
| **Fecha de elaboración** | 24 de agosto de 2026 |

---

## Objeto del informe

El presente informe registra las modificaciones efectuadas durante el desarrollo del proyecto con respecto al perfil de proyecto aprobado. Para cada tema se indica si existieron cambios y, cuando corresponda, se deberá describir su naturaleza, justificación e incidencia sobre el proyecto.

## Relación de modificaciones

### 1. Título del proyecto

No se efectuaron cambios respecto al perfil aprobado.

### 2. Problemática

> Cambio de enfoque, priorizando reutilización, uso consistente de términos, afirmaciones realistas y necesarias

La problemática conservó como punto de partida la existencia de capacidades comunes entre los sistemas de trámites, pero se reformuló para delimitar con mayor precisión el problema atendido por el proyecto. Al comparar la versión actual con la aproximación preservada en `docs/memoria/01-presentation/03-project-definition3.typ`, se identifican los siguientes cambios:

- Se definió como problema central la **repetición de funcionalidades y esfuerzos entre sistemas de gestión de trámites**, asociada a la falta de un modelo común y de una herramienta reutilizable especializada. La versión anterior presentaba de manera más general la falta de herramientas reutilizables y de un modelo claro.
- Se explicitaron las capacidades que suelen repetirse: definición del trámite, participación de actores, ejecución de acciones, registro de información y seguimiento de los casos.
- Se moderó la caracterización de los productos genéricos de gestión de flujos de trabajo. En lugar de afirmar categóricamente que no son reutilizables, cerrados o propietarios, se indicó que pueden atender parte de la necesidad, pero que no siempre se especializan en trámites, se distribuyen como software libre ni se ajustan directamente al contexto institucional y normativo boliviano.
- Se eliminó la discusión sobre la falta de adopción nacional de ventanillas únicas, al no ser necesaria para establecer el problema central. Se conservó, en cambio, la dificultad de sustituir todas las implementaciones por una solución centralizada debido a las particularidades institucionales.
- Los lineamientos normativos comunes se expresaron mediante software libre, interoperabilidad, identidad digital, simplificación, transparencia y control ciudadano. Se retiró la firma digital de esta enumeración y se evitó afirmar que todos los sistemas deban implementar de igual manera cada característica.
- Se redujo el alcance causal atribuido a la falta de reutilización. Esta carencia ya no se presenta como causa directa de la permanencia del trámite tradicional, sino como un factor que incrementa la fricción técnica y económica para su digitalización y que puede contribuir a la persistencia de sus problemas.
- Se conservaron los problemas asociados al trámite tradicional, pero se aclaró que no constituyen por sí mismos el problema central de ingeniería de software que aborda Tunkunia.
- Las desventajas de no reutilizar software se reformularon para evitar afirmaciones difíciles de sustentar: la presión de tiempo se vinculó con la creación o modificación de trámites por cambios normativos; el riesgo de desarrollos fallidos, con la ausencia de un modelo compartido; y la falta de estandarización, con la dificultad de compartir lineamientos y capacidades comunes sin eliminar las particularidades institucionales.
- La afirmación general sobre la mala documentación del código no reutilizado se sustituyó por la duplicación verificable de esfuerzos de documentación, pruebas y mantenimiento para capacidades semejantes.
- El abordaje dejó de proponer indistintamente un «módulo, componente o subsistema» y adoptó de forma consistente el término **subsistema reutilizable de software libre**. Su función se precisó como formalizar los aspectos comunes del trámite y concentrar su definición, ejecución, registro y control.
- Se incorporó como criterio de enfoque la descentralización de las necesidades particulares de cada institución junto con la centralización de modelos, lineamientos y capacidades comunes.
- En los desafíos se reemplazó «módulo FOSS» por «subsistema FOSS» y se moderó la expectativa de uso por numerosos proyectos o de formación de una comunidad, presentando la evolución colaborativa únicamente como una posibilidad.

### 3. Objetivos

> Uso de mejor terminología y mayor definición de objetivos

En el objetivo general se sustituyó la expresión «producto mínimo viable (MVP)» por «prototipo funcional». El cambio responde a una precisión terminológica: «prototipo funcional» describe de manera más adecuada el carácter académico y demostrativo del artefacto de software que se implementará, mientras que «producto mínimo viable» corresponde principalmente al ámbito del desarrollo y la validación comercial de productos. Esta modificación no altera la finalidad ni el alcance del objetivo aprobado.

Además, la frase «mediante adaptación o configuración mínima» se precisó como «mediante su configuración según las necesidades institucionales». Con ello se conserva la finalidad del objetivo general, pero se adopta una sola acepción verificable de reutilización: la aplicación configurable que puede ser utilizada por distintas instituciones.

Se incorporó también un conjunto amplio de objetivos específicos candidatos relacionados con el modelado, los requerimientos, el diseño, la implementación, la validación, la reutilización, la evaluación, la publicación y la documentación. Se mantienen todos en la versión de trabajo para permitir su selección y depuración manual antes de establecer la lista definitiva.

### 4. Justificación

> Eliminadas afirmaciones muy ambiciosas

La justificación conservó sus fundamentos y se realizaron las siguientes precisiones:

- Los beneficios sociales de la digitalización se formularon como contribuciones potenciales relacionadas con el acceso a la información, el seguimiento y la trazabilidad, sin presentarlos como garantías de eliminación de la corrupción, la discriminación o el clientelismo.
- Se otorgó mayor relevancia a la soberanía tecnológica, entendida como la capacidad de inspeccionar, modificar, desplegar y mantener el subsistema sin dependencia exclusiva de un proveedor. La disponibilidad del código se presentó como una condición que facilita la auditoría y el escrutinio, pero que no garantiza por sí sola la transparencia.
- Se delimitó la reutilización como la adopción de una misma aplicación configurable por distintas instituciones. La integración, la extensión mediante programación y la modificación del código fuente se conservaron como propiedades complementarias, no como definiciones alternativas de reutilización.
- Se conservó la relación académica entre tamaño del software, líneas de código y costos como una aproximación teórica simplificada. Se explicitaron sus limitaciones y se aclaró que no constituye una demostración empírica del ahorro ni contempla todos los costos asociados al software.
- Se reemplazó el término «módulo» por «subsistema» para mantener coherencia con la denominación adoptada en el proyecto.

### 5. Alcances y límites

> Define alcances del prototipo

Se precisó la diferencia entre el alcance del producto diseñado y el alcance de la implementación presentada. La arquitectura del producto contempla las capacidades necesarias para la evolución del subsistema como una solución reutilizable; sin embargo, el prototipo funcional implementará únicamente un subconjunto representativo, suficiente para validar el modelo común del trámite, la arquitectura propuesta y su posibilidad de reutilización. Las demás capacidades podrán representarse mediante contratos, interfaces, adaptadores, simulaciones o puntos de extensión, sin considerarse implementaciones completas.

Como resultado de esta delimitación, se efectuaron los siguientes ajustes:

| Aspecto modificado | Modificación | Motivo |
| --- | --- | --- |
| Clasificación de funcionalidades | Las capacidades se clasificaron como implementadas, simuladas o contempladas en el diseño arquitectónico. | Establecer con claridad qué elementos serán verificables en el prototipo y cuáles corresponden a la evolución prevista del producto. |
| Naturaleza de la entrega | Se sustituyeron las denominaciones «primera versión (v1.0)» y «producto mínimo viable (MVP)» por «prototipo funcional de carácter académico y demostrativo». | Evitar comunicar un grado de madurez o validación comercial que no corresponde a la entrega del proyecto. |
| Criterio de aceptación | Se eliminó el porcentaje de aprobación de pruebas automatizadas como criterio principal. La validación se centró en la ejecución completa de casos representativos, el registro de sus acciones e historial y la configuración de dos instancias institucionales ficticias. | Ajustar la evaluación al carácter académico y demostrativo del prototipo y priorizar evidencia funcional directamente relacionada con el objetivo. |
| Licencia | Se especificó la licencia MIT y sus condiciones reales de conservación de los avisos de derechos de autor y de permiso; se eliminó la mención obligatoria a la carrera como condición de uso. | Alinear el alcance con la licencia adoptada por el repositorio y evitar condiciones adicionales que no forman parte de ella. |
| Colaboración externa | Se eliminó el compromiso de recibir un _pull request_ y atender un _issue_. | Su cumplimiento depende de la participación de terceros y no constituye un criterio controlable para evaluar el prototipo. |
| Notificaciones por correo electrónico | La arquitectura contempla este mecanismo, pero el prototipo solo deberá generar o simular eventos de notificación, sin exigir la entrega efectiva de correos. | Evitar que la validación dependa de infraestructura SMTP y de condiciones operativas externas al núcleo estudiado. |
| Creación de formularios | El prototipo incluirá una edición interactiva mínima y demostrativa de formularios sencillos, compuestos por un conjunto reducido de campos de entrada y una acción de envío; se excluyó un constructor visual de propósito general. | Demostrar la configuración interactiva prevista para el producto sin convertir un constructor avanzado de formularios en un requisito del prototipo. |
| Reutilización | Se adoptó una sola acepción principal: Tunkunia es una aplicación configurable que puede desplegarse y ajustarse a las necesidades de distintas instituciones. | Simplificar el alcance y fundamentar la reutilización mediante un enfoque reconocido de ingeniería de software, sin exigir varios mecanismos de adopción. |
| Propiedades complementarias | La interoperabilidad, la extensibilidad y la disponibilidad del código fuente se mantuvieron como cualidades del subsistema, pero dejaron de presentarse como formas independientes de reutilización. | Evitar que el objetivo de reutilización obligue a demostrar simultáneamente configuración, consumo de API y adaptación o bifurcación del código. |
| Distribución | Se sustituyó la distribución opcional mediante gestores de paquetes por un repositorio público de código y artefactos desplegables. | Alinear el alcance con la forma de entrega prevista para una aplicación autónoma. |

Estas precisiones no eliminan del diseño general las capacidades previstas para el producto, sino que separan las decisiones arquitectónicas de los compromisos de implementación y evaluación del prototipo.

### 6. Aproximación inicial a la solución propuesta

> Eliminada por redundante

La sección de solución propuesta se retiró de la definición del proyecto en la memoria final, debido a que la solución desarrollada se expone con mayor precisión en los capítulos de requerimientos, arquitectura, diseño, implementación, validación y resultados. Para evitar redundancias, la aproximación incluida en el perfil se conserva únicamente como antecedente de la evolución del proyecto en este informe.

Los principales cambios respecto de esa aproximación inicial son:

- Se mantuvo como identidad central la creación de un subsistema de software libre que concentre las capacidades comunes de los trámites y pueda configurarse para distintas instituciones.
- La idea inicial de especializar un framework web genérico evolucionó hacia un subsistema desplegable cuyo servidor contiene el núcleo reutilizable. El perfil no prescribía Laravel ni otra tecnología específica; Laravel correspondía al SIAI descrito como antecedente.
- La reutilización se delimitó como la adopción de una misma aplicación configurable por distintas instituciones. El consumo de la API y la adaptación del código se consideran posibilidades complementarias de integración y extensión.
- La SPA se incorporó como interfaz de referencia y como parte de la entrega autónoma, sin impedir que otros desarrolladores construyan clientes alternativos sobre la API.
- La arquitectura se definió como un monolito modular con una aplicación cliente separada lógicamente, en reemplazo de la aproximación preliminar basada genéricamente en MVC.
- Go y Nuxt se adoptaron posteriormente como decisiones de diseño e implementación; no constituyen restricciones heredadas del perfil.
- Se distinguieron las capacidades del producto diseñado de aquellas que deben estar materializadas en el prototipo funcional.
- Las integraciones estatales se representaron mediante interfaces y adaptadores; su conexión efectiva quedó fuera de la implementación obligatoria del prototipo.

Las siguientes figuras registran la aproximación inicial incluida en el perfil y se conservan como evidencia de la evolución conceptual del proyecto.

![Aproximación inicial a la distribución y uso de Tunkunia](../assets/figures/tunkunia_dist.excalidraw.png)

![Aproximación inicial basada en la especialización de un framework web](../assets/figures/framework2subsystem.png)

![Aproximación arquitectónica inicial de Tunkunia](../assets/figures/modulegraph.png)

### 7. Temario propuesto

> Reestructuración mínima

Los capítulos se agruparon en cuatro partes para distinguir la presentación del proyecto, sus fundamentos e investigación, el proceso de ingeniería de software y la etapa conclusiva. Al comparar la estructura actual con el nivel de profundidad definido en el temario propuesto, se identifican los siguientes cambios:

- Las *Generalidades del proyecto* se reorganizaron: el capítulo de *Introducción* se amplió mediante las secciones de introducción, antecedentes, situación actual y definición del proyecto, mientras que los marcos de referencia y teórico se trasladaron a la parte de *Fundamentos e investigación*.
- Se añadió un capítulo de *Investigación sobre el modelado de trámites* dentro de *Fundamentos e investigación*, con el fin de documentar separadamente el estudio empleado para identificar aspectos comunes entre distintos trámites.
- El *Proceso del software* se especializó como *Proceso de ingeniería de software*. Se incorporó un capítulo de metodología y gestión del desarrollo; la especificación de requerimientos se mantuvo como ingeniería de requerimientos; el modelado y el diseño se separaron en arquitectura y diseño del software; y el desarrollo y la construcción se concretaron como implementación del prototipo.
- El capítulo *Aplicación del subsistema* tuvo un cambio menor de denominación y enfoque a *Validación y resultados*, donde se documentan los casos evaluados y los resultados de la aplicación del prototipo.
- *Resultados y conclusiones* se especializó como *Conclusiones y recomendaciones*, debido a que los resultados de la aplicación se presentan en el capítulo anterior.
- La bibliografía y los anexos se conservaron.

### 8. Bibliografía considerada

No se efectuaron cambios respecto al perfil aprobado, pero se añadieron fuentes de información relevantes en el modelado de procesos y estándares.

### 10. Antecedentes

> Reducción de contenido, reelocalización
 
Se reorganizó el contenido para presentar con mayor claridad la evolución desde los problemas del trámite tradicional hasta la experiencia del SIAI y la identificación de características comunes que originan el proyecto. Las definiciones, la normativa detallada y la descripción técnica se trasladaron a las secciones correspondientes, sin perder información sustantiva.

| Contenido reorganizado | Destino principal | Tratamiento |
| --- | --- | --- |
| Estado, gobierno, administración pública y definición del trámite | Marco de referencia | Traslado del desarrollo conceptual |
| Trámite tradicional, sus problemas y el caso de Domitila Murillo | Antecedentes | Conservación como origen de la problemática |
| Evolución del gobierno electrónico y normativa boliviana | Antecedentes y Marco de referencia | Mención histórica y desarrollo normativo separado |
| Origen del SIAI, participación de 2IES y experiencia de implementación | Antecedentes | Reordenamiento como antecedente directo |
| Arquitectura y tecnologías empleadas por el SIAI | Situación actual | Traslado como descripción de una solución existente |
| RASIM, actores y documentos IRAP | Marco de referencia | Traslado al contexto institucional |
| Similitudes observadas entre trámites | Antecedentes | Conservación como enlace con el problema del proyecto |

### 11. Situación actual

> Relocalización

Se reorganizó la sección en adopción digital, sistemas y soluciones existentes, tendencias tecnológicas, trabajos académicos relacionados y brechas identificadas. Los desarrollos normativos y teóricos se trasladaron a sus marcos respectivos, conservando los datos, casos y referencias existentes.

| Contenido reorganizado | Destino principal | Tratamiento |
| --- | --- | --- |
| Adopción de Internet, plataformas digitales y gobierno electrónico | Situación actual | Conservación como diagnóstico contemporáneo |
| Normativa sobre trámites, interoperabilidad y software libre | Marco de referencia | Traslado del desarrollo normativo |
| Reutilización, WFMS/BPM, arquitectura y modularidad | Marco teórico y Situación actual | Desarrollo conceptual en el Marco teórico y mención como tendencia actual |
| Lenguajes y técnicas de modelado de procesos | Marco teórico | Traslado de definiciones y formalizaciones |
| Software libre e inteligencia artificial | Marco teórico y Situación actual | Separación entre fundamentos y tendencias o aplicaciones actuales |
| Sistemas, productos y experiencias institucionales | Situación actual | Agrupación como soluciones existentes |
| Tesis y proyectos de grado relacionados | Situación actual | Agrupación como trabajos académicos relacionados |
| Limitaciones y necesidades aún no resueltas | Situación actual | Síntesis final de brechas ya identificadas |

---
