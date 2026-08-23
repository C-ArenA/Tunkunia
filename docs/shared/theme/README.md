# Tema de Memoria de Ingeniería Electrónica de la UMSA

Tema opinionado de Typst para la memoria de Proyecto de Grado de Ingeniería
Electrónica de la UMSA. La API describe la materia del documento; las decisiones
visuales permanecen en el módulo que las implementa.

Consulta [ARCHITECTURE.md](ARCHITECTURE.md) para leer y modificar el código.

## Uso

`lib.typ` expone `memoria` y los elementos personalizados del tema. El título y
los autores son obligatorios. El cuerpo continúa siendo la estructura que escribe
el usuario después del `show`:

```typ
#import "/shared/theme/lib.typ": memoria

#show: memoria.with(
  title: "Título del proyecto",
  authors: ("Postulante: Nombre", "Tutor: Nombre"),
  acronyms: acronyms,
  bibliography: bibliography("/shared/references.bib"),
  glossary: (),
  appendices: [
    #include "appendices/primer-anexo.typ"
  ],
)

= Primera parte
== Primer capítulo
```

### Figuras con fuente

`img-fig` crea una figura de imagen con una leyenda uniforme que separa la
descripción de su fuente. La etiqueta es un valor `label` de Typst; por ello puede
referenciarse normalmente con `@fig:ejemplo`.

```typ
#import "/shared/theme/lib.typ": img-fig

#img-fig(
  "/assets/figures/ejemplo.png",
  [Descripción de la figura],
  <fig:ejemplo>,
  source: [Elaboración propia],
  width: 60%,
  placement: top,
)
```

`source` es opcional y usa `Elaboración propia` por defecto. `width` es opcional
y usa `100%`; `placement` también es opcional y usa `none`.

`mmd-fig` ofrece la misma leyenda, fuente, etiqueta, anchura y colocación para
diagramas. La función selecciona el renderizador según la extensión de la ruta:
los archivos `.mmd` se renderizan con Mermaid y cualquier otra extensión se
trata como una imagen precompilada.

```typ
#import "/shared/theme/lib.typ": mmd-fig

#mmd-fig(
  "/assets/sources/diagrama.mmd",
  [Descripción del diagrama],
  <fig:diagrama>,
  source: [Elaboración propia],
  width: 80%,
  placement: top,
)
```

Cuando exista una versión precompilada, basta con cambiar la ruta y conservar los
demás argumentos:

```typ
#mmd-fig(
  "/assets/figures/diagrama.svg",
  [Descripción del diagrama],
  <fig:diagrama>,
  width: 80%,
)
```

La función no comprueba anticipadamente si la ruta existe: un archivo ausente,
una extensión incorrecta o contenido inválido producen el error normal de Typst.

`typ-fig` envuelve diagramas construidos directamente como contenido Typst, por
ejemplo mediante CeTZ. Comparte con las demás funciones la leyenda, fuente,
etiqueta, anchura y colocación.

```typ
#import "@preview/cetz:0.4.2": canvas, draw
#import "/shared/theme/lib.typ": typ-fig

#typ-fig(
  canvas({
    draw.circle((0, 0), radius: 1)
  }),
  [Descripción del diagrama],
  <fig:diagrama-typst>,
  source: [Elaboración propia],
  width: 70%,
  placement: top,
)
```

El argumento `body` puede ser cualquier contenido Typst renderizable. `width`
controla el bloque que lo contiene; no modifica internamente las dimensiones ni
la escala del diagrama.

Los acrónimos y términos de glosario son diccionarios de Glossy separados porque
aparecen en lugares diferentes:

```typ
#let acronyms = (
  API: "Application Programming Interface",
  IRAP: (
    short: "IRAP",
    plural: "IRAPs",
    long: "Instrumento de Regulación Ambiental Particular",
    longplural: "Instrumentos de Regulación Ambiental Particular",
  ),
)

#let glossary = (
  "gls-tramite": (short: "trámite", description: "Procedimiento administrativo."),
)
```

Después de registrar ambos diccionarios mediante la plantilla, el texto puede usar
`@API`, `@IRAP:pl` y `@gls-tramite`. La primera referencia presenta la forma larga
cuando existe; las siguientes presentan la forma corta.

Los acrónimos usan directamente su forma corta como clave y se distinguen por sus
mayúsculas. Los términos del glosario conservan el prefijo `gls-`; el guion evita
conflictos con los dos puntos que Glossy reserva para modificadores como `:pl`.

Los argumentos opcionales son `date`, `copyright`, `dedication`,
`acknowledgements`, `abstract`, `acronyms`, `bibliography`, `glossary`,
`appendices` y `font`. Todos los bloques documentales son opcionales. El glosario
es un diccionario compatible con
[Glossy](https://typst.app/universe/package/glossy/). `acronyms` usa el mismo
formato. Los acrónimos quedan en el grupo vacío y la plantilla asigna
automáticamente el grupo `glossary` a todos los términos del glosario; las claves
de ambos diccionarios deben ser únicas. El tema usa Glossy 0.9.2 y requiere Typst
0.14.0 o posterior.

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
5. `memoria.typ` valida datos, combina ambos diccionarios, instala una sola
   instancia de Glossy y ensambla las cuatro etapas.

## Regla para modificar el tema

Modifica el módulo dueño del resultado visible. Márgenes y texto pertenecen a
`global.typ`; portada, preliminares e índices a `frontmatter.typ`; Partes y
Capítulos a `mainmatter.typ`; bibliografía, glosario y anexos a
`backmatter.typ`. `memoria.typ` sólo debe decidir el orden y pasar datos.

La plantilla soporta únicamente la memoria. El Perfil archivado queda fuera de
este tema y podrá recibir una plantilla separada en el futuro.
