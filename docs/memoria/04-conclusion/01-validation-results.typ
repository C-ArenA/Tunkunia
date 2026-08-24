== Validación y resultados

=== Enfoque de validación mediante casos

// TODO: Explicar el propósito, alcance y procedimiento de la validación
// demostrativa, además de los criterios usados para seleccionar los casos.

La validación del prototipo se organiza mediante casos de trámites con características diferentes. Este enfoque busca observar si Tunkunia permite configurar y recorrer los elementos relevantes identificados durante la investigación, como actores, documentos, condiciones, etapas, plazos, reintentos, eventos externos y resultados. No constituye una campaña exhaustiva de pruebas del software.

Para cada caso se distingue su caracterización, la configuración realizada en Tunkunia, el recorrido seguido, las evidencias obtenidas y las limitaciones observadas. Mientras un caso no haya sido ejecutado, sus apartados de configuración y resultados permanecen señalados como pendientes y no se presentan conclusiones sin evidencia.

=== Casos de trámites evaluados

==== Registro Ambiental Industrial

===== Caracterización del caso

El Registro Ambiental Industrial (RAI) es el trámite inicial mediante el cual se recoge información de una industria manufacturera y se determinan las condiciones que afectan sus obligaciones ambientales posteriores. Forma parte de los procedimientos administrativos atendidos por el @SIAI en el marco del @RASIM y se relaciona con la obtención y actualización de los distintos @IRAP:pl. Su contexto institucional y normativo se desarrolla en el capítulo de investigación sobre el modelado de trámites.

Este caso permite valorar la representación de un trámite de registro cuyos datos condicionan otros procedimientos y documentos ambientales.

===== Configuración en Tunkunia

// TODO: Registrar actores, datos, documentos, actividades, condiciones,
// transiciones y resultados configurados para el RAI.

===== Recorrido de validación

// TODO: Describir el caso concreto ejecutado, sus datos de entrada, las acciones
// realizadas por cada actor y el resultado esperado.

===== Evidencias y resultados observados

// TODO: Incorporar capturas, registros o artefactos producidos durante el
// recorrido y contrastar el resultado esperado con el observado.

===== Limitaciones encontradas

// TODO: Registrar aspectos del RAI que el prototipo no pueda representar o que
// requieran simplificaciones.

==== Obtención de cédula de identidad

===== Caracterización del caso

- *Nombre:* Trámite para obtener Cédula de Identidad por Primera Vez.
- *Descripción*: Trámite esencial para el ciudadano boliviano, para ingresar al Registro Único de Identificación.
- *Marco Legal*: DS 4861, DS 4342
- *Tipo de Trámite*: Trámite de Registro y Certificación
- *Características Resaltantes*:
  - La normativa existente alrededor de este trámite solamente especifica los objetivos del trámite y no el trámite en sí mismo dejando esto a criterio de la institución. Este es un antecedente importante para otros trámites que no pueden ser simplificados debido al andamiaje legal que los aprisionan.
  - Para comunicar al ciudadano, se divide el trámite en dos, uno para menores de edad y otro para mayores de edad. Sin embargo, para enriquecer este análisis se consideran ambos como parte del mismo trámite.
- *Involucrados*:
  - Funcionario del SEGIP
  - Ciudadano que desea obtener su Cédula
  - Tercero encargado en caso de que el ciudadano sea menor de edad
- *Dependencias*:
  - SERECI: Certificado de Nacimiento y otros
  - Entidad Bancaria: Pagos
- *Desencadenante*: Ciudadano con intención de obtener su cédula de identidad
- *Modelo*: El trámite fue modelado mediante una red de Petri de tipo WFNet, presentada en la @fig:ci_wfnet.

===== Configuración en Tunkunia

// TODO: Registrar actores, datos, documentos, actividades, condiciones,
// transiciones y resultados configurados para la obtención de la cédula.

===== Recorrido de validación

// TODO: Describir el recorrido ejecutado y distinguir las variantes para una
// persona mayor y una persona menor de edad cuando corresponda.

===== Evidencias y resultados observados

// TODO: Incorporar las evidencias producidas y contrastar el comportamiento
// esperado con el observado.

===== Limitaciones encontradas

// TODO: Registrar las simplificaciones y los elementos no cubiertos por el
// prototipo, incluidas las dependencias con SERECI y la entidad bancaria.

==== Solicitud de patente SENAPI

===== Caracterización del caso

- *Características Resaltantes*:
  - Respaldado por la Decisión 486 de La Comisión de la Comunidad Andina en sus capítulos III y IV
  - Se detallan características de los plazos: días hábiles
  - Existen condiciones claras para el inicio de la solicitud: Condiciones de sí o no
  - Existen requisitos obligatorios cuya ausencia imposibilita el inicio del trámite (Artículo 33)
  - La solicitud debe contener:
    - 1 comprobante de pago (g)
    - 1 elemento de texto plano (e)
    - 2 formularios (a, b)
    - 1 colección de elementos de texto plano (c)
    - 1 colección de elementos multimedia (d)
    - 3 copias de documentos existentes (h,i,k)
    - 1 colección de documentos originales de certificación existente (f, j)
  - Existen requisitos opcionales que sólo son necesarios si se cumplen otras condiciones. Esto sugiere que pueden pertenecer a otras subetapas
  - El trámite inicia con la presentación de requisitos de solicitud. Es decir, cuando el solicitante lo desee
  - El trámite parece ser de tipo servicio
  - El solicitante puede modificar su información de solicitud durante el trámite e incluso la naturaleza del trámite. Esto sugiere un cambio de trámite (mismo caso o diferente caso) que pueda heredar información del anterior.
  - Existe una etapa de examen de documentos
  - Existe un plazo de 30 días para examinar la solicitud
  - Existe una etapa de reparación de solicitud con plazo de 2 meses
  - La etapa de reparación de solicitud tiene un número máximo de reintentos
  - La "oficina" debe notificar al "solicitante" cada decisión
  - Tras cumplir el primer examen de forma, se publican los resultados y sólo entonces se pasa a una segunda ronda de examen de patentabilidad
  - El segundo examen debe ser inicializado por el solicitante
  - Actores externos pueden influir con oposiciones a la solicitud de patentado
  - Tras el segundo examen se toma una decisión que se convierte en un título de patente (un certificado)
  - Al conjunto de información que se va recolectando se le llama expediente, similar a como se hace en juzgados
- *Modelo*: Las etapas principales del trámite se presentan en la @fig:senapiblocks.

===== Configuración en Tunkunia

// TODO: Registrar actores, requisitos documentales, etapas, condiciones, plazos,
// reintentos, oposiciones y resultados configurados para la solicitud de patente.

===== Recorrido de validación

// TODO: Describir al menos un recorrido satisfactorio y uno que active la
// reparación de la solicitud o una oposición externa.

===== Evidencias y resultados observados

// TODO: Incorporar las evidencias producidas y contrastar cada recorrido esperado
// con el comportamiento observado.

===== Limitaciones encontradas

// TODO: Registrar las reglas temporales, documentales o de participación externa
// que no puedan representarse completamente en el prototipo.

=== Resultados comparativos

// TODO: Comparar los tres casos mediante una tabla que incluya actores,
// documentos, condiciones, etapas, plazos, reintentos, eventos externos,
// resultados y grado de representación alcanzado en Tunkunia.

==== Cobertura de mecanismos del trámite

// TODO: Identificar qué mecanismos del modelo general fueron ejercitados por cada
// caso y señalar aquellos que no llegaron a validarse.

==== Diferencias y limitaciones comunes

// TODO: Consolidar las limitaciones observadas sin ocultar las simplificaciones
// realizadas para el prototipo.

=== Síntesis de la validación

// TODO: Determinar, únicamente a partir de las evidencias registradas, en qué
// medida los casos respaldan la aplicabilidad y reutilización del prototipo.
