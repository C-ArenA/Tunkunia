#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [Modelado e identificación de flujos y procedimientos comunes en trámites de Bolivia],
  abstract: [
    Many efforts are made to implement a digital version of different "trámites" in Bolivia. However, most of these bureaucratic procedures can be modeled in similar ways, helping future efforts stop reinventing the wheel. In this article we explore some of these similarities and model them according to 4 aspects: cases, resources, processes and activities.
  ],
  authors: (
    (
      name: "Ernesto Carlos Arena Alarcon",
      organization: [Universidad Mayor de San Andrés],
      location: [La Paz, Bolivia],
      email: "arenacarlos.ca@gmail.com",
    ),
  ),
  index-terms: ("Trámite", "Flujo", "Proceso", "Modelado"),
  bibliography: bibliography("main.bib"),
)

= Introducción
= Metodología

Para lograr identificar patrones en el proceso y en las actividades involucradas en un trámite, se sigue principalmente un enfoque inductivo que permite modelar un número limitado de casos de trámites en Bolivia para buscar generalizar características similares.

La selección de casos se hará a partir de la plataforma gob.bo de la AGETIC y de los trámites resultantes del RASIM para cubrir un amplio espectro de casos con distintos niveles de complejidad. Para elegir los casos de trámites partiremos de la clasificación en cuatro categorías generales de los trámites@rosethFinTramiteEterno2018 y algunos casos particulares adicionales que puedan enriquecer el análisis posterior:

- Trámites de registro
- Trámites de certificaciones y constancias
- Trámites para cumplir con obligaciones
- Trámites para acceder a servicios
- Trámites para obtener permisos
- Trámites comunes o populares
- Trámites muy simples
- Trámites relativamente complejos (múltiples etapas)
- Trámites con conexión a otros trámites

En los primeros cinco casos se contemplarán trámites de dos tipos:
- Digitalizado
- Presencial

Entonces se analizarán un total 14 casos de trámites gubernamentales.


Inductivo:
- Modelo casos
- Identifico similitudes
- Realizo generalización
= Resultados
Se identifican similitudes en los siguientes niveles:
- Casos
- Recursos (Actores)
- Procedimiento o Flujo
- Actividades del Proceso
- Modelo General del Trámite
= Discusión
Este modelo podrá ayudar a implementar trámites y digitalizarlos de forma especializada o incluso servir como generalización para sistemas genéricos de trámites
Ignoramos trámites en otros países, pero pueden ser muy similares

= Conclusión
Se tiene modelado el trámite para casos específicos. Hace un tiempo los pagos digitales no eran una posibilidad y ahora lo son, por lo que se debe estar atento a cómo evolucionan los trámites, lo cual podría tener implicación en los hallazgos de esta investigación
