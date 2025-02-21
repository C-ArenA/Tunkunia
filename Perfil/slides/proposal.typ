#import "@preview/slydst:0.1.3": *
#import "@preview/timeliney:0.1.0"

#show: slides.with(
  title: [_TUNKUNIA_: Desarrollo de un módulo de gestión y seguimiento de flujos de trámite],
  subtitle: "Caso de Estudio: Trámites del SIAI",
  date: none,
  authors: ("Ernesto Carlos Arena Alarcon", "Jorge Antonio Nava Amador"),
  layout: "medium",
  ratio: 4 / 3,
  title-color: none,
)

= Presentación del Perfil de Proyecto

== Introducción
#figure(
  image("../assets/bg.png")
)

=== El trámite
#v(1fr)
#set quote(block: true)
#quote(
  attribution: [BID, El Fin del Trámite Eterno],
)[Los trámites constituyen el conjunto de requisitos, pasos o acciones a través
  de los cuales los individuos o las empresas piden o entregan información
  a una entidad pública, con el fin de obtener un derecho -generación de un
  registro, acceso a un servicio, obtención de un permiso- o para cumplir con
  una obligación]
#v(1fr)
== Problema

#v(1fr)

La ubicuidad del trámite en distintos espacios del estado y la cantidad de los mismos implican el desarrollo de características o funcionalidades similares en muchos proyectos de software de la administración pública.

- Mayores costos de desarrollo
- Tiempos de Desarrollo elevados
- Falta de robustez ante un enfoque no modular

#v(1fr)

== Objetivo

#v(1fr)
Modularizar funcionalidades comunes a los procesos de trámite gubernamental en base al "Sistema de Información Ambiental Industrial" utilizando software de tipo FOSS y a partir del modelado de algunos de sus flujos para agilizar la integración de sistemas de gestión y seguimiento de trámites y así colaborar con la digitalización del país.
#v(1fr)

== Solución

#v(1fr)
#image("../assets/modulegraph.png")

#v(1fr)
#image("../assets/stateprocedureexample.png")
