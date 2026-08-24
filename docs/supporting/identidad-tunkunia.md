# Identidad de Tunkunia

## Resumen

Tunkunia es un subsistema reutilizable de software libre que permite a instituciones públicas bolivianas digitalizar y gestionar distintos trámites a partir de un modelo común de procesos. Puede utilizarse como una solución autónoma, configurarse para casos habituales y extenderse para atender necesidades institucionales específicas.

## Propósito

Tunkunia busca reducir la necesidad de desarrollar un sistema independiente para cada trámite. Parte de que distintos trámites comparten acciones y estructuras recurrentes que pueden modelarse, sistematizarse y reutilizarse.

El proyecto atiende principalmente la repetición de funcionalidades entre sistemas de la administración pública. Su respuesta consiste en identificar los aspectos comunes de los trámites y materializarlos en un sistema especializado que pueda ser adoptado por distintas instituciones.

Tunkunia no pretende representar todos los trámites posibles ni eliminar sus particularidades. Busca atender una parte significativa de ellos mediante capacidades comunes y permitir extensiones cuando un caso exceda lo previsto.

## Contribución central

La identidad de Tunkunia se organiza, en orden de importancia, alrededor de tres elementos:

1. **Modelado del trámite:** formalización de los aspectos comunes de distintos trámites mediante técnicas de modelado de procesos.
2. **Motor de procesos:** definición y ejecución de flujos a partir del modelo obtenido.
3. **Gestión de trámites:** utilización del motor para iniciar, desarrollar, registrar, seguir y concluir casos concretos.

La base de código libre complementa estos elementos al favorecer la reutilización, la soberanía tecnológica y el cumplimiento de los lineamientos bolivianos sobre software libre y gobierno electrónico.

## El proceso como elemento permanente

El elemento que permanece ante la diversidad y evolución de los trámites es el proceso. Formularios, documentos, pagos, reportes y otras acciones pueden cambiar entre instituciones o incorporarse en versiones posteriores, pero todos se sitúan dentro de un flujo compuesto por estados, acciones, participantes y decisiones.

El núcleo conceptual de Tunkunia comprende:

- la definición de flujos de trámite;
- la ejecución de casos conforme a esos flujos;
- el registro de las acciones realizadas;
- el historial y estado de cada caso;
- la posibilidad de incorporar nuevas acciones sin reemplazar el motor.

Acciones recurrentes como llenar formularios, revisar información, generar documentos o tomar decisiones permiten demostrar que diferentes trámites pueden expresarse mediante un mismo modelo general. Las acciones particulares no alteran necesariamente el modelo: amplían las operaciones que este puede ejecutar.

## Sistema especializado

Tunkunia no es un gestor genérico de flujos de trabajo. Se especializa en trámites y evita incorporar complejidad que no resulte necesaria para ese dominio. Esta especialización permite considerar el lenguaje, los participantes, las acciones comunes y las obligaciones propias de los procedimientos administrativos públicos.

Tampoco está vinculado a un trámite o una institución determinados. Los casos concretos se definen sobre capacidades comunes y pueden incorporar particularidades sin exigir la construcción de un sistema completamente nuevo.

## Formas de reutilización

La reutilización tiene cuatro manifestaciones complementarias:

- **Configuración:** una institución puede definir y operar casos comunes sin modificar el sistema.
- **Extensión:** pueden añadirse acciones y comportamientos específicos conservando el motor y las capacidades existentes.
- **Integración:** Tunkunia puede formar parte de un sistema institucional mayor e intercambiar información con otros subsistemas.
- **Software libre:** una institución puede estudiar, adaptar, mantener o bifurcar el código fuente de acuerdo con sus necesidades.

La extensibilidad forma parte de la identidad del producto; los mecanismos técnicos utilizados para conseguirla pertenecen al diseño y a la implementación. Tunkunia no se define por una tecnología, una forma de distribución ni un método único de despliegue.

## Sistema y subsistema

Tunkunia se estudia como un sistema de software y puede funcionar de manera autónoma. Se denomina **subsistema** porque también puede integrarse como una unidad funcional dentro de sistemas institucionales de mayor alcance.

Su condición de subsistema no significa que dependa necesariamente de otro sistema para operar. Expresa su vocación de integración y su capacidad de concentrar la gestión de trámites dentro de una solución pública más amplia.

## Aplicación autónoma y núcleo reutilizable

Tunkunia se concibe como una aplicación completa de gestión de trámites, no únicamente como un modelo o motor aislado. Debe permitir que una institución adopte sus capacidades comunes sin realizar un desarrollo desde cero.

Sin embargo, la identidad del sistema reside principalmente en el modelo y el motor. La experiencia de uso predeterminada hace posible su funcionamiento autónomo, pero puede adaptarse o reemplazarse sin que el núcleo deje de ser Tunkunia. Por el contrario, conservar solamente la apariencia de la aplicación y reemplazar el modelo y el motor implicaría dejar de utilizar Tunkunia.

## Actores

Tunkunia considera tres categorías generales de actores:

- **Administradores:** definen trámites y gestionan los aspectos generales del sistema.
- **Servidores públicos:** participan en los procedimientos mediante las acciones y responsabilidades definidas en cada flujo.
- **Ciudadanos:** inician trámites, realizan las acciones que les corresponden y dan seguimiento a sus casos.

Estas categorías no buscan imponer la estructura organizacional de una institución. Constituyen una base que puede especializarse según las responsabilidades de cada trámite.

## Contexto boliviano

Tunkunia se orienta a instituciones públicas bolivianas y toma la normativa nacional como contexto, fuente de requisitos y restricción para su diseño. Entre los principios relevantes se encuentran:

- uso de software libre y estándares abiertos;
- soberanía tecnológica;
- interoperabilidad;
- simplificación y digitalización de trámites;
- transparencia y trazabilidad;
- participación y control social;
- integración con servicios estatales de identidad y gobierno electrónico.

El proyecto no pretende materializar exhaustivamente toda la normativa en su primer prototipo. Prioriza un conjunto representativo de principios y contempla otros en el diseño general del producto.

La transparencia no implica publicar indiscriminadamente los datos personales o expedientes de los ciudadanos. Se expresa mediante procedimientos claros, trazabilidad de actuaciones, acceso del interesado a su información y mecanismos adecuados de rendición de cuentas.

## Producto diseñado y prototipo funcional

El producto diseñado representa la visión completa de Tunkunia y contempla las capacidades necesarias para gestionar trámites de manera autónoma y extensible.

El prototipo funcional es una materialización limitada que permite validar dos resultados fundamentales:

1. que diferentes trámites pueden formalizarse mediante un modelo de procesos común; y
2. que ese modelo puede implementarse en un sistema capaz de definir y ejecutar múltiples trámites.

La ausencia de una capacidad completa en el prototipo no significa necesariamente que esta sea ajena al producto diseñado. Las simulaciones y acciones representativas permiten validar la estructura general sin afirmar que el sistema se encuentra listo para producción.

## Límites de la identidad

Tunkunia no se define por:

- una tecnología o lenguaje de programación;
- una interfaz de usuario específica;
- un único mecanismo de instalación o distribución;
- un trámite concreto;
- una institución determinada;
- la presencia de pagos, reportes u otra acción especializada;
- el cumplimiento exhaustivo de toda la normativa desde su primera versión.

Estas decisiones y capacidades pueden evolucionar mientras se conserven el modelo común, el motor de procesos, la gestión de casos y la posibilidad de reutilización y extensión.

## Formulación canónica

> **Tunkunia es un subsistema reutilizable de software libre, especializado en el modelado y la gestión de flujos de trámite, que permite a instituciones públicas bolivianas definir y ejecutar distintos trámites a partir de capacidades comunes, con posibilidad de configuración, integración y extensión para necesidades particulares.**

En términos del proyecto, su resultado central puede expresarse de la siguiente manera:

> Los aspectos comunes de distintos tipos de trámite pueden formalizarse mediante modelado de procesos y materializarse en un sistema especializado capaz de definir y ejecutar múltiples trámites sin desarrollar un sistema independiente para cada uno.
