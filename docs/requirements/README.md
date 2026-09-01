# Requisitos de Tunkunia

Los documentos TRS y SyRS especifican el **producto final**. TRS contiene los
requisitos de alto nivel de los interesados; SyRS contiene los requisitos del
sistema derivados. Su alcance no se limita a las capacidades demostradas por el
prototipo.

Notion y `docs/memoria/03-process/02-requirements.typ` fueron fuentes de
elicitación y contexto. Esa procedencia no se almacena como un atributo del
requisito.

Las justificaciones se incorporan al texto normativo cuando sean necesarias; no
se utiliza un atributo separado `rationale`.

El atributo `type` clasifica cada requisito por su naturaleza, por ejemplo:
funcional, rendimiento, interfaz, proceso, calidad, usabilidad, seguridad o
documentación.

El atributo `category` agrupa los requisitos por tema (por ejemplo, `reuse`,
`execution`, `records` o `interoperability`). Sustituye los archivos no
normativos que antes se usaban únicamente para crear encabezados.

## Uso desde Typst

Las exportaciones consolidadas y versionadas de ambos documentos se encuentran
en `requirements/export/`. Después de modificar los elementos Doorstop, se deben
actualizar con:

```sh
go tool task docs:requirements:export
```

La función `requirements` permite insertar el documento completo o filtrarlo por
tipo y categoría. Ambos filtros pueden combinarse y, en ese caso, se aplican de
forma conjunta:

```typst
#import "/shared/requirements.typ": requirements

#requirements("TRS")
#requirements("SyRS", type: "security")
#requirements("SyRS", category: "interoperability")
#requirements("SyRS", type: "security", category: "identity")
```

Solo se muestran requisitos activos, normativos y con texto. Un grupo sin
coincidencias no produce contenido. `go tool task docs:requirements:check`
comprueba que las exportaciones versionadas estén actualizadas.

El documento TRS conserva 59 requisitos de interesados numerados `TRS011`–`TRS069`.
Los objetivos de negocio que iniciaban con «La iniciativa Tunkunia deberá» se
eliminaron del nivel TRS; SyRS enlaza directamente con los requisitos TRS
vigentes.

En TRS solo se distinguen cuatro grupos de interesados: entidad pública,
ciudadano, AGETIC y entidad externa. Los roles internos y las funciones de
usuario se detallan únicamente en los requisitos SyRS cuando resulta necesario.

## Cobertura del prototipo

Cada requisito normativo contiene el atributo escalar `prototype`. Su valor es
texto libre:

- Si el requisito se incluye en el prototipo sin modificaciones, basta con que
  el campo esté presente.
- Si requiere notas, limitaciones o simulaciones, el texto del campo debe
  describir esas consideraciones.
- Si el requisito no se incluye en el prototipo, se elimina el campo.

Los requisitos se dirigen siempre al producto final. `prototype` solo documenta
qué parte de ese requisito se representa en el prototipo y no constituye
evidencia de cumplimiento.

En esta carga inicial todos los requisitos normativos incluyen `prototype: ''`
como marcador editable. Puedes reemplazarlo por las consideraciones del
prototipo o eliminar el atributo cuando decidas excluir el requisito.
