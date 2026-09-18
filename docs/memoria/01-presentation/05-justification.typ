=== Justificación

El subsistema reutilizable que se plantea implementar en este proyecto busca contribuir al desarrollo del gobierno electrónico en Bolivia mediante la simplificación en la digitalización de trámites en diferentes instancias públicas. Esto es deseable porque, como se ha mencionado en los antecedentes de este documento, los trámites son una de las herramientas más importantes que tiene el gobierno para interactuar con la ciudadanía y, por lo tanto, es importante que sean accesibles y fáciles de usar.

Al haber identificado que los trámites tienen muchas similitudes entre sí, este trabajo desea modelar estos procedimientos administrativos de forma general, ante la falta de otras definiciones formales en el ámbito académico, utilizando técnicas de modelado de procesos modernos.
Además, se espera sentar las bases para la creación de estándares alrededor de los sistemas de trámites en Bolivia.
Esta abstracción permitirá también que este sistema demuestre cómo se aplica la normativa boliviana en el ámbito de los desarrollos de software gubernamentales, inspirando trabajos futuros en este campo y guiando implementaciones que se vayan a realizar para el aparato estatal.

Si bien cada vez más instancias del estado priorizan el uso del software libre en sus desarrollos propios (en cumplimiento de la normativa vigente), el código fuente de los sistemas resultantes no es accesible al público.
Es por esto que el subsistema reutilizable propuesto, al ser totalmente abierto y FOSS, en caso de aplicarse en trámites reales del gobierno, se busca que pueda permitir que el motor que corra detrás de estos procedimientos administrativos gubernamentales no venga del gobierno sino de la población.
Esto permitirá que la ciudadanía tenga acceso al núcleo de los diferentes sistemas de gestión de trámites implementados, que pueda estudiarlos, analizarlos, agregar funcionalidades, probarlos, etc.
De este modo habrá mayor confianza en los sistemas de trámites de gobierno que utilicen este elemento reutilizable.
Se desea que la aplicación de este proyecto sea una garantía para el ciudadano de que sus trámites usan un código que es abierto y que puede ser auditado por cualquier persona.
Esto es un paso hacia la transparencia del gobierno y la confianza de la ciudadanía en el mismo y debería ser un enfoque común en el software gubernamental que, más allá del uso del software libre, el software resultante sea abierto al público en gran medida.

Como puede percibirse, la característica de software libre tiene mucha importancia en este proyecto.
No sólo atiende a una necesidad y requerimiento del gobierno boliviano mediante la normativa vigente, sino que además, busca contribuir al ecosistema de software libre en Bolivia, particularmente dentro del alma mater donde se realiza este proyecto, incentivando a la realización de más proyectos de este tipo, con un enfoque colaborativo, de comunidad y de crecimiento incluso después de finalizado el proyecto.

/*
Cuando se habla de digitalización de procesos administrativos, suele hablarse del impacto positivo que tiene en el medio ambiente. Esto es cierto, ya que la digitalización de los trámites permite reducir el uso de papel y otros recursos físicos. Sin embargo, no se puede ignorar el impacto negativo que tiene la digitalización en el medio ambiente, ya que la producción de dispositivos electrónicos y su desecho también tienen un impacto negativo en el medio ambiente. Por lo tanto, si bien se menciona este posible impacto, promovido por este proyecto, no se considerará una justificación válida para este trabajo.
*/

Por otra parte, el impacto económico positivo que se espera lograr con el proyecto es muy importante de mencionar, ya que se espera que el módulo de software reutilizable permita a las instituciones públicas implementar nuevos trámites de forma rápida y sencilla, lo que a su vez permitirá reducir costos y mejorar la eficiencia en la gestión de los trámites.

A su vez, aunque estrechamente relacionado con el factor económico, existe un factor de tiempo que se busca atender con este proyecto.
Un sistema que digitalice trámites en base a una implementación reutilizable inicial que requiera tan sólo algunas configuraciones para adaptarse a cada caso específico, es un sistema que toma menos tiempo de implementar.
Las instituciones públicas están en constante cambio y muchas veces aparecen nuevos trámites que requieren ser implementados rápidamente.
Este proyecto busca ser una solución a este problema, permitiendo que las instituciones públicas puedan implementar nuevos trámites de forma rápida y sencilla, sin necesidad de desarrollar un sistema desde cero.

Finalmente, no se puede ignorar que este proyecto también busca validar ciertos patrones, estilos y prácticas de la ingeniería y la arquitectura de software.
Incluso al día de hoy se considera a estas ciencias relativamente nuevas y no existen definiciones claras en muchos aspectos como la modularidad @richardsFundamentalsSoftwareArchitecture2020[pág.
  37], a pesar de su importancia.
Además, en la práctica, los términos usados alrededor del desarrollo del software sufren de una constante evolución.
En este sentido, se busca validar el empleo del concepto de subsistema reutilizable para abarcar lo que también podría referirse a un marco de trabajo (framework) especializado, pero que además contemple cierta independencia y pueda integrarse en sistemas más grandes, pertenecientes a instancias públicas diversas.
A partir de esto, también se desea desafiar el enfoque de ventanilla única que se hizo popular en años recientes, considerando que los trámites muchas veces deben integrarse a modelos de negocio específicos a cada entidad y en opinión del autor no deberían centralizarse en su totalidad.
