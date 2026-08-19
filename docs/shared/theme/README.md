# UMSA - Ingeniería Electrónica - Typst Template

Este es un template de Typst para crear documentos para la carrera de Ingeniería Electrónica de la Universidad Mayor de San Andrés. Fue creado específicamente pensando en la realización de mi Perfil y Memoria de Proyecto de Grado y transformado en un template reutilizable para cualquier otro estudiante que lo requiera. No existen reglas totalmente claras respecto al formato de presentación de estos documentos y a veces puede depender del docente asignado o del tutor, por lo que algunas decisiones de estilo fueron totalmente personales. Si este template es utilizado por varios estudiantes podría implementar mayor versatilidad al respecto o realizar cambios en base a sugerencias.

## Cómo usar

Al igual que la mayoría de templates básicos de Typst el paquete expone varias funciones de configuración, las cuales ayudan a inicializar el documento.

La función config se encarga de introducir todas las configuraciones base del documento y debe ser llamado de la siguiente forma al inicio del documento:

```typ
#import "../shared/umsa-electronics-engineering-template/lib.typ": appendix, conf, includeAcronyms, makeCover
#show: conf
```

Para facilitar la creación del cover se usan los metadatos de Typst, por lo que lo siguiente en el uso de este paquete será definirlos:

```typ
#set document(
  description: "Perfil de Proyecto de Grado", // Tipo de documento
  title: [TÍTULO],
  author: (
    "Postulante: [TU NOMBRE]", // Los autores se listan uno sobre otro y para lograr versatilidad se incluye la descripción del autor en el documento (Postulante, Asesor, etc)
    "Asesor: [ASESOR]",
    "D.A.M.: [DOCENTE]",
  ),
  date: datetime.today() // O una fecha específica: datetime(day:21, month:5, year:2024)
)
```

Posteriormente se puede añadir la portada o carátula

```typ
#import "../shared/umsa-electronics-engineering-template/lib.typ": appendix, conf, includeAcronyms, makeCover

// ...

#makecover() // No requiere argumentos, ya que los mismos se sacan de los metadatos del documento antes configurados
```

Los demás elementos pueden ser añadidos donde se deseen, su aspecto ya estará configurado si el template fue aplicado con el `#show`. Por ejemplo, para mostrar la tabla de contenidos:

```typ
#outline()
```
