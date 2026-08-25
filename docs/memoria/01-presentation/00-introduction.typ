== Introducción<chap:intro>

Durante el desarrollo del @SIAI del @MDPyEP por parte de la empresa *2IES*,
se identificaron funcionalidades comunes a muchos sistemas de software gubernamentales relacionadas con los procesos administrativos conocidos como trámites,
entendidos en este contexto como el conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas solicitan o entregan información a una entidad pública,
con el fin de obtener un derecho, o para cumplir con una obligación @rosethFinTramiteEterno2018.

Con el propósito de enfrentar nuevos proyectos de este tipo y contribuir al desarrollo del país en su adopción de tecnologías de la información y la mejora de procesos burocráticos con un enfoque de gobierno electrónico,
en este documento se propone la implementación de un *subsistema reutilizable de gestión de flujos de trámite* que modele dichos procesos administrativos utilizando técnicas de modelado de procesos y contribuya a hacerlos más eficientes, robustos y modulares.

Este subsistema tendrá la capacidad de interoperar con otros para permitir la integración con sistemas existentes.
Dada la importancia del término utilizado en este proyecto, es necesario aclarar que aquí se entiende por _subsistema_ un grupo lógico de elementos que puede formar parte de un sistema mayor, pero que también puede operar de manera independiente, pudiendo construirse de distintas formas y estar compuesto, a su vez, por otros subsistemas o módulos @ingenoSoftwareArchitectsHandbook2018.

Lo anterior se llevará a cabo recogiendo principalmente la experiencia adquirida en el desarrollo del @SIAI por parte de 2IES
y atendiendo trámites descritos por el @RASIM u otras normativas como ejemplos de aplicación.

Además, en favor de la soberanía tecnológica y la normativa vigente en Bolivia, se hará uso de software libre y estándares abiertos para la implementación del subsistema y se licenciará al mismo como @FOSS#footnote[
  Este documento emplea terminología técnica propia del desarrollo de software.
  En ciertos casos, se prefiere el uso de términos en inglés para evitar ambigüedades en la traducción o mantener coherencia con las prácticas establecidas en la industria.
].

Con esto, se pretende facilitar y optimizar la implementación de trámites digitales en diversas instituciones públicas, con el objetivo de brindar beneficios al ciudadano mediante la adopción de enfoques de gobierno electrónico.

Con el fin de facilitar su referencia y dotarlo de una identidad propia, se ha asignado al proyecto el nombre de *Tunkunia*, en honor al tradicional juego boliviano que consiste en seguir una secuencia estructurada de movimientos para alcanzar un objetivo, de forma análoga al proceso del trámite.
