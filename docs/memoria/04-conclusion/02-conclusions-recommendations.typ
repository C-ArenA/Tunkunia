== Conclusiones y recomendaciones

=== Conclusiones

Se presentan a continuación las conclusiones en función a los objetivos planteados al principio del proyecto.
Se señala su cumplimiento y se evalúa el mismo a partir de los resultados presentados.

Podemos comenzar afirmando que el objetivo general del proyecto fue satisfactoriamente alcanzado considerando las limitaciones de un prototipo, pero logrando establecer punto a punto lo siguiente.
Se implementó un subsistema porque el software provee una interfaz que permite su interacción con otros subsistemas con los que puede así conformar un sistema mayor en una institución pública.
Se logró que sea reutilizable de tipo "Sistema configurable especializado en un dominio" y además, de forma accidental, y por la naturaleza de las tecnologías utilizadas, logró exponer paquetes públicos para la reutilización de utilidades y funcionalidades core de un sistema de gestión de flujos de trabajo.
Asimismo, el sistema desarrollado presenta el potencial de ser adoptado por instituciones públicas como prototipo inicial que aún no puede ser puesto en producción.
Finalmente, y antes de pasar a la evaluación de los objetivos específicos es importante notar que se tomaron en cuenta los lineamientos de gobierno electrónico en Bolivia.
Si bien es cierto que no se puede afirmar que se hayan atendido todos, lo cual sería imposible sin más iteraciones del producto, se consideraron aspectos primordiales como el uso del servicio de identidad de Ciudadanía Digital y la interoperabilidad.

Con respecto al modelo formal utilizado para describir trámites, se comenzó el proyecto con una aproximación inicial hacia modelos populares como BPMN, Diagramas de Actividad o incluso máquinas de estado.
Sin embargo, en esta primera aproximación también se encontraban las Redes de Petri, respaldadas por el trabajo de Van Der Aalst @vanderaalstAPPLICATIONPETRINETS1998 sobre la aplicación de Redes de Petri en flujos de trabajo.
Tras una investigación sobre los distintos modelos así como intentos por modelar los trámites en distintos paradigmas se halló que el modelo de Petri presentaba ventajas importantes en el modelado del trámite en el caso de este proyecto.
Si bien tienen un componente matemático importante, la transición de modelo matemático a mapa interactivo hace obvia la representación de los trámites en una interfaz de usuario, con la ventaja de contar con pocos elementos y no requerir demasiados conocimientos previos como es el caso de BPMN.
Además, al ser un modelo formal, presenta ventajas que podrían ser aprovechadas en trabajos futuros.
Finalmente, se comprobó que la elección de este modelo presentaba la ventaja de permitir flexibilidad a la hora de detallar acciones dentro de un proceso y se vio que el modelo permitía su extensibilidad de manera sencilla en comparación a otros modelos que son excesivamente complejos en su construcción.

En cuanto al desarrollo del proyecto siguiendo las etapas del ciclo de vida del software, se puso mucho énfasis en elaborar una metodología que permitiese precisamente esto.
Se partió de la metodología RUP y se adecuó atendiendo las características particulares del proyecto.
Finalmente, aunque se tomó un enfoque iterativo, se sintetizó el trabajo y los artefactos en las distintas descripciones que se presentan en este documento tomando como guía conceptual la Guía del Cuerpo de Conocimiento de la Ingeniería de Software v4.0a de la IEEE:

- Los requerimientos se realizaron en conformidad no completa con el ISO 29148, partiendo de una elicitación basada en documentación y brainstorming y concluyendo en la definición de dos de los cuatro elementos de información aconsejados por el estándar y adecuados al proyecto.
- La arquitectura se realizó a partir de tomas de decisiones que en su mayoría quedaron reflejadas en el repositorio de código y se sintetizaron en una descripción de arquitectura del software, brindando una visión general del sistema con los elementos fundamentales del mismo.
- El diseño se separó de la arquitectura en conformidad con la última actualización del SWEBOK que separa estos dos aspectos para poder concentrar el diseño en aspectos mas específicos.
  El diseño del sistema se trabajó de forma independiente para los componentes críticos del sistema y en otros casos se amalgama con la implementación.
- La implementación del prototipo se realizó seleccionando las tecnologías que mejor respondan a los requerimientos y al diseño, además de contar con un sistema de versionado.
  Al ser un prototipo, sólo se usaron pruebas automatizadas como herramienta auxiliar.
  Se definió un entorno de desarrollo local robusto que simule un sistema desplegado y se usó DEX para simular el servicio de identificación de Ciudadanía Digital.
  Se debe destacar por transparencia que se hizo uso de modelos de lenguaje para la generación de código de componentes comunes y no críticos como CRUDs y lo que se conoce en el mundo del desarrollo de software como "boilerplate", es decir, código de relleno.
  El repositorio cuenta con un AGENTS.md y un README.md que documentan el proyecto para mantenimiento.
  Además, se expone un sitio que alberga algunos detalles del sistema así como una vista a la especificación de la API.

En cuanto a la funcionalidad del prototipo, se realizaron pruebas de casos previamente definidos para comprobar si el sistema es capaz de expresar sus procesos con Redes de Petri en un motor de gestión de flujos de trabajo.
Se encontró que, si bien se puede simular el proceso de los trámites, aún quedarían muchas decisiones institucionales para poder adoptar un sistema reutilizable, es decir, se deben hacer cambios a la naturaleza del trámite para adaptarlo a un sistema digital, la traducción no es inmediata.

En cuanto a la publicación del proyecto como software libre, se puede comprobar accediendo al siguiente enlace: #link(
  "https://github.com/C-ArenA/Tunkunia",
), el cual alberga el proyecto en un repositorio que cuenta con una licencia MIT que es una de las licencias más permisivas.
La naturaleza de la tecnología principal elegida hace que el simple repositorio permita la reutilización del proyecto.
Incluso este documento y su versionado se encuentran en el mismo repositorio de código

De este modo, se describió de qué modo el proyecto cumplió con los objetivos planteados y en qué medida, considerando las limitaciones correspondientes.

=== Recomendaciones

Se plantean las siguientes recomendaciones habiendo descrito las conclusiones

- No todos los trámites pueden ser representados por este sistema de forma sencilla.
  En casos de trámites con excesiva cantidad de pasos o que no estén bien definidos se recomienda primero hacer un trabajo de simplificación del trámite y definición rigurosa del proceso.

- Algunos trámites pueden adecuarse a este sistema si se describen como múltiples trámites.

- Este sistema, en su estado actual, está pensado en facilitar su adopción y simplificar su despliegue, empleando tecnologías que son muy eficientes para correr en un solo servidor y con un solo binario.
  En caso de que un trámite tenga mucho uso, es decir, un trámite con mucha concurrencia, como el de la emisión de una cédula de identidad, se recomienda optar por desarrollos hechos a medida.
  Sin embargo, pueden emplearse los conceptos de este trabajo para su realización.

- Las Redes de Petri pueden llegar a representarse de forma fácil de entender por el participante de un trámite, sin requerir entender los conceptos detrás del modelo matemático, pero el gestor de flujos de trámite, es decir el administrador de la institución, debe tener nociones básicas del mismo.

- Las Redes de Petri tienen constructos muy básicos que hacen compleja la descripción de ciertos flujos de trabajo.
  Las Redes de Petri de alto nivel pueden ayudar a mitigar este problema.

- Dada la naturaleza de despliegue único del sistema diseñado, no se recomienda ejecutar múltiples instancias del mismo.

- En función al diseño del sistema, se recomienda que cada institución tenga una sola instancia del software.

- El sistema incluye acciones comunes de trámites en forma de transiciones de alto nivel en Redes de Petri, pero estas acciones no son todas las posibles y futuros desarrollos pueden completar las acciones a partir de los puntos de extensión provistos mediante el uso de interfaces de GO.

- El sistema utiliza el concepto de Redes de Petri coloreadas que en futuras versiones del proyecto pueden usarse para otorgar reportes de cuellos de botella en trámites.

- Las metodologías de desarrollo de software deben ser usadas como una guía que evoluciona con el proyecto y se adapta al mismo.

- La arquitectura de implementación de acciones junto a los nuevos desarrollos en inteligencia artificial soberana de la AGETIC abren la posibilidad a que siguientes iteraciones implementen la automatización de revisión de documentos con modelos de lenguaje.
