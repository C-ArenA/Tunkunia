= Introducción

Durante el desarrollo del sistema *SIAI* (Sistema de Información Ambiental Industrial) del
“Ministerio de Desarrollo Productivo y Economía Plural” por parte de la empresa *2IES*,
se identificaron funcionalidades comunes a muchos sistemas de software gubernamentales que tienen que ver con los procesos administrativos conocidos localmente como trámites.

En el afán de enfrentar nuevos proyectos de este tipo y de poder colaborar al desarrollo del país en el propósito de adoptar las tecnologías de la información, 
en este documento se propone la implementación de un módulo reutilizable de gestión y seguimiento de trámites que modele dichos procesos administrativos y ayude a hacerlos más eficientes.
Esto se llevará a cabo recogiendo la experiencia existente sobre el desarrollo del SIAI por parte de 2IES y atendiendo a los trámites descritos por el RASIM a manera de caso de estudio.

== Sobre el uso de la palabra Trámite

Existen pocas definiciones para la palabra #quote[trámite], pero llegan a depender de la región en la que se use y hay pocos escritos académicos que ayuden a aclararla.
En este documento se adopta principalmente la definición realizada por el Banco de Desarrollo Interamericano mediante una de sus publicaciones @rosethFinTramiteEterno2018
y el Gobierno de México en uno de sus portales web @epnQueEsTramite, ya que estos se asemejan más a la acepción que se maneja comúnmente en la región de Latinoamérica, particularmente en Bolivia.

== Notas y Aclaraciones Preliminares

Como se verá más adelante una vez realizado el análisis de la solución propuesta, la identidad de este proyecto gira en torno a los flujos de trabajo que, en el caso de los trámites, implican la secuencia de una serie de pasos. 
De esta manera, para referenciar al proyecto de manera sencilla nos referimos al mismo de ahora en adelante como *Tunkunia*.

Este documento emplea términos técnicos relativos al desarrollo de software. En algunos casos, se preferirá el uso de términos en inglés para evitar ambigüedades en la traducción o para apegarse a las prácticas y términos usados en la industria.
Un ejemplo de esto es el término _software library_, cuya traducción es tema de debate en la comunidad de desarrollo que no se decide entre #quote[librería de software] y #quote[biblioteca de software].
