= Índice Tentativo

Para el temario del documento final de proyecto se considerará una estructura que describa bien la naturaleza del proyecto y que por lo tanto tome en cuenta la ingeniería de software, de acuerdo a la cual, el software tiene un ciclo de vida, o de manera más precisa, un "proceso del software", que se modela de acuerdo a la metodología de desarrollo sobre la cual se realice. Sin embargo, varios autores concuerdan en que existen ciertas etapas estructurales ajenas a cualquier metodología. Según _Pressman_ @pressmanSoftwareEngineeringPractitioner2010[pág. 13], estas etapas serían las indicadas en la @fig:proceso_pressman. Mientras tanto, _Sommerville_ las simplifica en las 4 etapas mostradas en la @fig:proceso_sommerville.

#figure(
  image("../assets/proceso_pressman_white.png", height: 13%),
  caption: [Proceso del Software - Pressman],
  placement: top
)<fig:proceso_pressman>


#figure(
  image("../assets/proceso_sommerville_white.png", height: 13%),
  caption: [Proceso del Software - Sommerville],
  placement: auto
)<fig:proceso_sommerville>

El temario del documento final del proyecto, mostrado en la @fig:syllabus obedecerá entonces a estas definiciones del proceso de software para no depender estrictamente de la metodología usada, tomando en cuenta que es tentativo y pueden surgir cambios durante la realización del proyecto.

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
        - Glosario y Acrónimos
      + *Generalidades del Proyecto*
        + *Introducción:* Describirá los antecedentes del proyecto, así como la problemática que se ha identificado, para la cual se plantea una solución a través del objetivo. De igual modo se hará referencia a la justificación del proyecto y los alcances y límites que se plantearon durante su gestación.
        + *Marco Referencial:* Se proporciona el contexto general en el cual se sitúa el proyecto. Se describen temas relevantes al tópico principal y que buscan delimitarlo en varios aspectos que pueden ser históricos, geográficos, sociales, políticos, económicos, tecnológicos, etc.
        + *Marco Teórico:* Se proporcionan las bases teóricas sobre las cuales se fundamenta el proyecto. se presentarán todos los conceptos, definiciones, técnicas y/o procedimientos que se han de tomar en cuenta para el desarrollo del proyecto y para su correcta comprensión.
      + *Proceso del Software:* Como se explica al inicio de esta sección, esta parte del temario reflejará el ciclo de vida común del software. El orden no refleja el orden que se adopte realmente, el cual no será de tipo cascada, sino iterativo, pero como bloques fundamentales del proceso del software, tendrán la información relevante a cada etapa o cada esfuerzo realizado dentro de cada etapa.
        + Especificación de requerimientos de software @pressmanSoftwareEngineeringPractitioner2010, pág. 104
        + Modelado y Diseño
        + Desarrollo y Construcción
        + Pruebas y Validaciones (Tests)
        + Publicación y Despliegue
      + *Aplicación del subsistema:* El subsistema ya publicado se aplicará a trámites correspondientes al RASIM u otros casos reales. En este apartado se hará una bitácora del proceso y se expondrán los resultados de dicha aplicación.
      + *Resultados y Conclusiones:* El resultado general del proyecto y algunas recomendaciones para seguir trabajando en él, siendo especialmente importante considerando la naturaleza _open source_ y colaborativa del subsistema. Se deben dar algunas ideas y pautas para seguir desarrollando las siguientes versiones del software, así como recomendaciones para su uso y aplicación.
      - *Bibliografía y Referencias*
      - *Anexos*
    ],
    left,
  ),
)<fig:syllabus>



