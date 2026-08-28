=== Justificación

El subsistema reutilizable que se plantea implementar en este proyecto busca contribuir a la adopción del gobierno electrónico en Bolivia mediante la simplificación de la digitalización de trámites en diferentes instancias públicas.
Al favorecer el acceso a la información, el seguimiento y la trazabilidad de estos procedimientos administrativos, su aplicación podría contribuir a reducir gastos excesivos de tiempo y dinero, así como las oportunidades para prácticas de corrupción, discriminación o clientelismo asociadas al trámite presencial tradicional.
Esto es deseable porque, como se ha mencionado en los antecedentes de este documento, los trámites son una de las herramientas más importantes que tiene el gobierno para comunicarse con la ciudadanía y, por lo tanto, es importante que sean accesibles y fáciles de usar.

Al haber identificado que los trámites tienen muchas similitudes entre sí, este trabajo desea modelar estos procedimientos administrativos de forma general, ante la necesidad de contar con un modelo especializado que represente sus aspectos comunes en el contexto boliviano, utilizando técnicas modernas de modelado de procesos.
Además, se espera aportar una base conceptual que pueda contribuir a la futura armonización de los sistemas de trámites en Bolivia.
Esta abstracción permitirá también que este sistema demuestre cómo se aplica la normativa boliviana en el ámbito de los desarrollos de software gubernamentales, inspirando trabajos futuros en este campo y guiando implementaciones que se vayan a realizar para el aparato estatal.

Si bien cada vez más instancias del estado priorizan el uso del software libre en sus desarrollos propios (en cumplimiento de la normativa vigente), el código fuente de los sistemas resultantes no siempre es accesible al público.
Por ello, el subsistema reutilizable propuesto será abierto y FOSS, de modo que las instituciones puedan inspeccionarlo, modificarlo, desplegarlo y mantenerlo sin depender exclusivamente de un proveedor.
Esta capacidad contribuye a la soberanía tecnológica del país y facilita que el conocimiento producido pueda ser compartido y aprovechado en otras implementaciones.
Asimismo, la publicación del código permite su estudio y favorece la auditoría y el escrutinio independiente.
Aunque su disponibilidad no garantiza por sí sola la transparencia ni demuestra que una instancia desplegada corresponda exactamente con el código publicado, sí crea condiciones técnicas que pueden fortalecer la confianza y la rendición de cuentas en los sistemas gubernamentales que adopten este subsistema.

Como puede percibirse, la característica de software libre tiene mucha importancia en este proyecto.
No sólo atiende a una necesidad y requerimiento del gobierno boliviano mediante la normativa vigente, sino que además, busca contribuir al ecosistema de software libre en Bolivia, particularmente dentro del alma mater donde se realiza este proyecto, incentivando a la realización de más proyectos de este tipo, con un enfoque colaborativo, de comunidad y de crecimiento incluso después de finalizado el proyecto.

Por otra parte, el subsistema reutilizable podría producir un impacto económico positivo al reducir el esfuerzo necesario para implementar las características comunes de nuevos trámites y evitar que cada institución desarrolle una solución completa desde cero.
Medir este impacto en un proyecto de software libre es difícil, pero autores como Sommerville @sommervilleSoftwareEngineering2016 relacionan el costo de desarrollo con el tamaño del software y señalan que la reutilización puede reducir la cantidad de código nuevo que debe escribirse.
Bajo el supuesto simplificado de que los demás factores permanecen constantes, esta relación puede expresarse de la siguiente manera:

$ C prop \L\O\C $
$ \L\O\C_"sr" > \L\O\C_"cr" $
$ therefore C_"sr" > C_"cr" $

Donde:

- $C$ es el costo de desarrollo del software.
- $\L\O\C$ es la cantidad de líneas de código.
- $C_"sr"$ es el costo de desarrollo del software sin reutilización de código.
- $C_"cr"$ es el costo de desarrollo del software con reutilización de código.
- $\L\O\C_"sr"$ es la cantidad de líneas de código del software sin reutilización de código.
- $\L\O\C_"cr"$ es la cantidad de líneas de código del software con reutilización de código.

Esta formulación constituye únicamente una aproximación teórica y no una demostración empírica del ahorro, pues la cantidad de líneas de código no representa por sí sola la complejidad ni incorpora costos de integración, configuración, mantenimiento o capacitación.
Su utilidad en este trabajo se limita a ilustrar el beneficio potencial de reutilizar una base existente.

A su vez, aunque estrechamente relacionado con el factor económico, existe un factor de tiempo que se busca atender con este proyecto.
En este trabajo, la reutilización se entiende principalmente como la adopción de una misma aplicación configurable por distintas instituciones.
Para los casos comunes, los usuarios administrativos podrán definir y configurar trámites de manera interactiva, evitando que cada institución deba desarrollar un sistema independiente desde cero.
Las posibilidades de integrar el subsistema, extenderlo mediante programación o modificar su código fuente complementan esta forma de adopción, pero no constituyen el criterio principal con el que se demostrará su reutilización.

Finalmente, no se puede ignorar que este proyecto también busca validar ciertos patrones, estilos y prácticas de la ingeniería y la arquitectura de software.
Incluso al día de hoy se considera a estas ciencias relativamente nuevas y no existen definiciones claras en muchos aspectos como la modularidad @richardsFundamentalsSoftwareArchitecture2020[pág.
  37], a pesar de su importancia.
Además, en la práctica, los términos usados alrededor del desarrollo del software sufren de una constante evolución.
En este sentido, se busca validar el empleo del concepto de subsistema reutilizable para describir una aplicación configurable que puede funcionar con cierto grado de independencia y, a la vez, integrarse en sistemas pertenecientes a instancias públicas diversas.
Este enfoque busca conciliar la descentralización de la adopción y configuración con la centralización de modelos, lineamientos y capacidades comunes: cada institución conserva la posibilidad de atender su propio modelo de negocio, pero parte de una base compartida que favorece la interoperabilidad y la armonización. De esta manera, Tunkunia plantea para los trámites un enfoque análogo al de otras iniciativas estatales que proporcionan soluciones comunes para que cada institución construya y mantenga su propia presencia digital.
