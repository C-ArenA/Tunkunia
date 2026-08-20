# Tema de Memoria de Ingeniería Electrónica de la UMSA

Tema opinionado de Typst para la memoria de Proyecto de Grado de Ingeniería
Electrónica de la UMSA. La API describe la materia del documento; las decisiones
visuales permanecen en el módulo que las implementa.

Consulta [ARCHITECTURE.md](ARCHITECTURE.md) para leer y modificar el código.

## Uso

`lib.typ` expone solamente `memoria`. El título y los autores son obligatorios.
El cuerpo continúa siendo la estructura que escribe el usuario después del
`show`:

```typ
#import "/shared/theme/lib.typ": memoria

#show: memoria.with(
  title: "Título del proyecto",
  authors: ("Postulante: Nombre", "Tutor: Nombre"),
  bibliography: bibliography("/shared/references.bib"),
  glossary: (),
  appendices: [
    #include "appendices/primer-anexo.typ"
  ],
)

= Primera parte
== Primer capítulo
```

En una memoria grande, los parámetros deben reunirse en `config.typ`:

```typ
#import "/shared/theme/lib.typ": memoria
#import "config.typ": settings

#show: memoria.with(..settings)
```

Los argumentos opcionales son `date`, `copyright`, `dedication`,
`acknowledgements`, `abstract`, `acronyms`, `bibliography`, `glossary`,
`appendices` y `font`. Todos los bloques documentales son opcionales. El glosario
es una lista de diccionarios compatible con
[Glossarium](https://typst.app/universe/package/glossarium/); los acrónimos
existentes continúan usando Acrostiche.

Los archivos suministrados en `appendices` deben comenzar con un encabezado de
nivel uno (`=`). La plantilla lo convierte en `Anexo A`, reinicia cada anexo en
una página y numera sus descendientes como `A.1`, `A.1.1`, etc.

## Ciclo del documento

1. `global.typ` instala papel, márgenes, texto, párrafos, listas, bibliografía,
   figuras y tablas para toda la memoria.
2. `frontmatter.typ` crea la portada de forma aislada, las páginas preliminares
   sin numeración y los índices con numeración romana desde `i`. Los acrónimos
   pertenecen a esta materia.
3. `mainmatter.typ` reinicia la numeración arábiga en `1` y aplica solamente al
   cuerpo el sistema visual de Partes y Capítulos.
4. `backmatter.typ` conserva la numeración arábiga y, cuando fueron suministrados,
   presenta bibliografía, glosario y anexos en ese orden, sin numeración de
   encabezados ordinarios.
5. `memoria.typ` valida datos y ensambla esas cuatro etapas.

## Regla para modificar el tema

Modifica el módulo dueño del resultado visible. Márgenes y texto pertenecen a
`global.typ`; portada, preliminares e índices a `frontmatter.typ`; Partes y
Capítulos a `mainmatter.typ`; bibliografía, glosario y anexos a
`backmatter.typ`. `memoria.typ` sólo debe decidir el orden y pasar datos.

La plantilla soporta únicamente la memoria. El Perfil archivado queda fuera de
este tema y podrá recibir una plantilla separada en el futuro.
