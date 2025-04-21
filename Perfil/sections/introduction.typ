#import "@preview/acrostiche:0.5.1": *

= Introducción

Durante el desarrollo del #acr("SIAI") del #acr("MDPyEP") por parte de la empresa *2IES*,
se identificaron funcionalidades comunes a muchos sistemas de software gubernamentales relacionadas con los procesos administrativos conocidos localmente como trámites,
entendidos en este contexto como el conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas solicitan o entregan información a una entidad pública,
con el fin de obtener un derecho —como la generación de un registro, el acceso a un servicio o la obtención de un permiso—, o para cumplir con una obligación @rosethFinTramiteEterno2018.

Con el objetivo de enfrentar nuevos proyectos de este tipo y contribuir al desarrollo del país mediante la adopción de tecnologías de la información y la mejora de procesos burocráticos,
en este documento se propone la implementación de un *subsistema reutilizable de gestión y seguimiento de trámites* que modele dichos procesos administrativos y contribuya a hacerlos más eficientes, robustos y modulares.

Aquí se entiende por _subsistema_ un grupo lógico de elementos que puede formar parte de un sistema mayor, pero que también puede operar de manera independiente, pudiendo construirse de distintas formas y estar compuesto, a su vez, por otros subsistemas o módulos @ingenoSoftwareArchitectsHandbook2018.

Lo anterior se llevará a cabo recogiendo principalmente la experiencia adquirida en el desarrollo del #acr("SIAI") por parte de 2IES
y atendiendo trámites descritos por el #acr("RASIM") u otras normativas como ejemplos de aplicación.

Se propone el uso de técnicas de modelado inspiradas en los #acrpl("WFMS"), como las redes de Petri, las máquinas de estados finitos y los diagramas de actividad UML. Además, se busca que dicho modelado resalte características comunes de de los procesos administrativos tipo trámite. Una de estas características es la validación de documentos, para lo cual se plantea también el uso de grandes modelos de lenguaje que asistan al funcionario público en la toma de decisiones, así como capacidades de interoperabilidad que permitan adaptarse a distintos flujos de trabajo y métodos de validación documental.

Con esto, se pretende facilitar y optimizar la implementación de trámites digitales en diversas instituciones públicas, con el objetivo de brindar beneficios al ciudadano mediante la adopción de enfoques de gobierno electrónico.

== Notas y Aclaraciones Preliminares

La identidad de este proyecto gira en torno a los *flujos de trabajo*, los cuales, en el contexto de los trámites, se entienden como la secuencia ordenada de pasos o actividades necesarias para completar un proceso administrativo.

Con el fin de facilitar su referencia y dotarlo de una identidad propia, se ha asignado al proyecto el nombre de *Tunkunia*, en honor al tradicional juego boliviano que también consiste en seguir una secuencia estructurada de movimientos para alcanzar un objetivo.

Este documento emplea terminología técnica propia del desarrollo de software. En ciertos casos, se prefiere el uso de términos en inglés para evitar ambigüedades en la traducción o mantener coherencia con las prácticas establecidas en la industria.
