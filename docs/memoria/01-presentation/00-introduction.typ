== Introducción<chap:intro>

Durante el desarrollo del @SIAI del @MDPyEP por parte de la empresa *2IES*,
se identificaron funcionalidades comunes a muchos sistemas de software gubernamentales relacionadas con los procesos administrativos conocidos como trámites,
entendidos en este contexto como el conjunto de requisitos, pasos o acciones a través de los cuales los individuos o las empresas solicitan o entregan información a una entidad pública,
con el fin de obtener un derecho, o para cumplir con una obligación @rosethFinTramiteEterno2018.

Con el propósito de brindar una herramienta que se pueda volver a usar en nuevos proyectos de este tipo y contribuir al desarrollo del gobierno electrónico en Bolivia *facilitando* el paso de trámites en papel a procesos en línea @agenciadegobiernoelectronicoytecnologiasdeinformacionycomunicacionAGETICFirmaConvenio2026, se propone la implementación de un *subsistema reutilizable de gestión de flujos de trámite* que modele dichos procesos administrativos utilizando un gestor de flujos de trabajo especializado y adaptado al entorno nacional. A este artefacto se denomina *Tunkunia*, para facilitar su referencia y dotarlo de una identidad propia, en honor al tradicional juego boliviano que consiste en seguir una secuencia estructurada de movimientos para alcanzar un objetivo, de forma análoga al proceso del trámite.

Tunkunia se entiende como un _subsistema_ porque puede formar parte de un sistema mayor, pero también puede operar de manera independiente, pudiendo construirse de distintas formas y estar compuesto, a su vez, por otros subsistemas o módulos @ingenoSoftwareArchitectsHandbook2018. Además, en favor de la soberanía tecnológica y la normativa vigente en Bolivia, hace uso de software libre y estándares abiertos, pero también se licencia como @FOSS#footnote[
  Este documento emplea terminología técnica propia del desarrollo de software.
  En ciertos casos, se prefiere el uso de términos en inglés para evitar ambigüedades en la traducción o mantener coherencia con las prácticas establecidas en la industria.
].
