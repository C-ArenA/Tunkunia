= Introducción

Durante el desarrollo del sistema *SIAI* (Sistema de Información Ambiental Industrial) del
“Ministerio de Desarrollo Productivo y Economía Plural” por parte de la empresa *2IES*,
se identificaron funcionalidades comunes a muchos sistemas de software gubernamentales que tienen que ver con los procesos administrativos conocidos localmente como trámites.

En el afán de enfrentar nuevos proyectos de este tipo y de poder colaborar al desarrollo del país en el propósito de adoptar las tecnologías de la información y la mejora de procesos burocráticos, 
en este documento se propone la implementación de un módulo reutilizable de gestión y seguimiento de trámites que modele dichos procesos administrativos y ayude a hacerlos más eficientes.
Esto se llevará a cabo recogiendo la experiencia existente sobre el desarrollo del SIAI por parte de 2IES y atendiendo a los trámites descritos por el RASIM a manera de caso de estudio.

Se propone el uso de técnicas de modelado distintas y pertenecientes a sistemas de flujo de trabajo (WFMS), como son las redes de Petri, máquinas de estado finitas y diagramas de actividad UML. Además, se propone que dicho modelado resalte características comunes y específicas a los procesos administrativos de tipo trámite. Una de estas características es la validación de documentos, para lo cual se propone también el uso de grandes modelos de lenguaje para asistir al funcionario público en la toma de decisiones.

Con esto se pretende hacer más eficiente y sencilla la implementación de trámites digitales en distintas instituciones públicas, buscando brindar ventajas para el ciudadano con la adopción de enfoques de gobierno electrónico.

== Notas y Aclaraciones Preliminares

Como se verá más adelante, una vez realizado el análisis de la solución propuesta, la identidad de este proyecto gira en torno a los *flujos de trabajo (WF)* que, en el caso de los trámites, implican la secuencia de una serie de pasos. 
De esta manera, para referenciar al proyecto de manera sencilla y darle identidad, se le asigna el nombre de *Tunkunia*.

Este documento emplea términos técnicos relativos al desarrollo de software. En algunos casos, se preferirá el uso de términos en inglés para evitar ambigüedades en la traducción o para apegarse a las prácticas y términos usados en la industria.

=== Sobre el uso de la palabra "Módulo"

Si uno busca en la red puede encontrar definiciones ligeramente distintas de lo que es un "módulo". Para efectos de este trabajo se parte de la definición de Joseph Ingeno @ingenoSoftwareArchitectsHandbook2018, expuesta en la sección de términos clave, pero esto no quiere decir que el producto realizado no pueda evolucionar a adoptar ciertas características de un "subsistema", dependiendo de las decisiones tomadas durante la implementación.

=== Sobre el uso de la palabra "Trámite"

Existen pocas definiciones para la palabra "trámite", pero pueden llegar a depender de la región en la que se use y hay pocos escritos académicos que ayuden a aclararla.
En este documento se adopta principalmente la definición realizada por el Banco de Desarrollo Interamericano mediante una de sus publicaciones @rosethFinTramiteEterno2018 (incluida en la sección de términos clave)
y el Gobierno de México en uno de sus portales web @epnQueEsTramite, ya que estos se asemejan más a la acepción que se maneja comúnmente en la región de Latinoamérica, particularmente en Bolivia. Además, se usará de forma casi indistinta, aunque con menor frecuencia, el término "Proceso administrativo", tomándose en cuenta que este último es más amplio, pero poco empleado por el ciudadano.
