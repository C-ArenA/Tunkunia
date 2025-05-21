#import "@preview/slydst:0.1.3": *
#import "@preview/timeliney:0.1.0"

#show: slides.with(
  title: [_TUNKUNIA_],
  subtitle: "Subsistema Reutilizable de Software Libre para la Gestión de Flujos de Trámite Orientado al Gobierno Electrónico en Bolivia",
  date: none,
  authors: ("Ernesto Carlos Arena Alarcon", "Jorge Antonio Nava Amador"),
  layout: "medium",
  ratio: 4 / 3,
  title-color: none,
)

= Presentación del Perfil de Proyecto

== Contexto
#figure(image("../assets/background.png"))

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

Distintas instituciones públicas o instancias del estado que desean digitalizar sus trámites, realizan implementaciones propias desde cero (tanto por cuenta propia, como mediante el lanzamiento de licitaciones públicas), cada una por su lado, de forma independiente, sin seguir los mismos lineamientos y estándares ni responder de forma estricta a la normativa boliviana.

El desarrollo de sistemas alrededor de los trámites en entornos gubernamentales enfrenta desafíos significativos debido a la falta de herramientas reutilizables especializadas.

#v(1fr)

== Solución

#v(1fr)
#image("../assets/tunkunia_dist.excalidraw.png")

#v(1fr)
#image("../assets/modulegraph.png")

#v(1fr)

== Objetivo

#v(1fr)
*Implementar*, como producto mínimo viable (MVP), un *subsistema reutilizable de software libre* especializado en la gestión de flujos de *trámite* que, mediante el uso de técnicas de modelado de sistemas y procesos, represente e implemente los aspectos *comunes* del trámite y pueda ser adoptado por *distintas instituciones públicas* del estado *boliviano* mediante adaptación o configuración mínima y siguiendo los lineamientos establecidos por la normativa nacional sobre gobierno electrónico.
#v(1fr)


