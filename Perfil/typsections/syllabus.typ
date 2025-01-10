= Índice Tentativo

#figure(
  image("../assets/horastramite.png", width: 70%),
  caption: [Proceso del Software - Pressman],
)<fig:proceso_pressman>

Para el temario del documento final de proyecto se considerará una estructura que describa bien la naturaleza del proyecto y que además se adecúe a este que, después de todo, será un producto de software.

De acuerdo a la ingeniería de software, el software tiene un ciclo de vida o un #quote[proceso del software], el cual se modela de acuerdo a la metodología de desarrollo sobre la cual se realice. Sin embargo, varios autores concuerdan en que existen ciertas etapas estructurales ajenas a cualquier metodología. Según _Pressman_ @pressmanSoftwareEngineeringPractitioner2010[pág. 13], estas etapas serían las indicadas en la figura @fig:proceso_pressman.

Por su lado, _Sommerville_ las simplifica en las 4 etapas mostradas en la figura @fig:proceso_sommerville.

#figure(
  image("../assets/horastramite.png", width: 70%),
  caption: [Proceso del Software - Sommerville],
)<fig:proceso_sommerville>

El temario del documento final del proyecto obedecerá entonces a esta definiciones del proceso de software para no depender estrictamente de la metodología usada, como se ve en la @fig:syllabus.

Nótese, sin embargo, que este temario es tentativo, lo cual quiere decir que pueden surgir cambios durante la realización del proyecto.
#v(1.5em)
#show figure: set block(breakable: true)
#figure(
  caption: [Temario Tentativo],
  align(
    block(width: 100%, fill: rgb("#f2f2f2"), radius: 15pt, inset: 15pt, stroke: { 1pt + black })[
      #text(size: 1.5em, weight: "bold")[Índice]\
      #set enum(numbering: "1.1.", start: 1, full: true)
      0. *Apartados Preliminares*
        - Presentación
        - Agradecimientos
        - Resumen
        - Índice
        - Glosario
      + *Generalidades del Proyecto*
        + *Introducción:* Describirá los antecedentes del proyecto, así como la problemática que se ha identificado, para la cual se plantea una solución a través del objetivo. De igual modo se hará referencia a la justificación del proyecto y los alcances y límites que se plantearon durante su gestación.
        + *Marco Referencial:* Se proporciona el contexto general en el cual se sitúa el proyecto. Se describen temas relevantes al tópico principal y que buscan delimitarlo en varios aspectos que pueden ser históricos, geográficos, sociales, políticos, económicos, tecnológicos, etc.
        + *Marco Teórico:* Se proporcionan las bases teóricas sobre las cuales se fundamenta el proyecto. se presentarán todos los conceptos, definiciones, técnicas y/o procedimientos que se han de tomar en cuenta para el desarrollo del proyecto y para su correcta comprensión.
      + *Proceso del Software:* Como se explica al inicio de esta sección, esta parte del temario reflejará el ciclo de vida común del software. El orden no refleja el orden que se adopte realmente, el cual no será de tipo cascada, sino iterativo, pero como bloques fundamentales del proceso del software, tendrán la información relevante a cada etapa o cada esfuerzo realizado dentro de cada etapa.
        + Especificación de requerimientos de software @pressmanSoftwareEngineeringPractitioner2010, pág. 104
        + Modelado y Diseño
        + Desarrollo y Construcción
        + Pruebas y Validaciones (Tests)
        + Despliegue
      + *Integración en el SIAI:* El paquete ya desplegado se integrará en un _fork_ del SIAI. En este apartado se hará una bitácora del proceso y se expondrán los resultados del mismo.
      + *Resultados y Conclusiones:* El resultado general del proyecto y algunas recomendaciones para seguir trabajando en él, siendo especialmente importante considerando la naturaleza _open source_ y colaborativa del paquete a desarrollar. Se deben dar algunas ideas para seguir desarrollando las siguientes versiones del software.
      - *Bibliografía y Referencias*
      - *Anexos*
    ],
    left,
  ),
)<fig:syllabus>



