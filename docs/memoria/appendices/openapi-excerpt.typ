#import "source-excerpt.typ": before-marker, source-block

= Fragmento de la especificación OpenAPI

Este anexo presenta el inicio representativo del contrato OpenAPI ensamblado de
Tunkunia. El fragmento comprende los metadatos, los servidores, las etiquetas,
el recurso de salud y las operaciones de consulta y creación de trámites. La
#link(
  "https://github.com/C-ArenA/Tunkunia/blob/master/specs/v1.openapi.yaml",
)[especificación completa]
se encuentra disponible en el repositorio público. Se ajustan únicamente
algunos saltos de línea para facilitar su lectura en estas páginas.

#let openapi-fragment = (
  before-marker(
    "technical-openapi.yaml",
    "  /tramites/{id}:",
  )
    .replace(
      "      - [Documentación](https://docs.stripe.com/api-v2-overview) y [Referencia](https://docs.stripe.com/api/v2/core/accounts) de la API de Stripe v2",
      "      - Documentación de Stripe v2: https://docs.stripe.com/api-v2-overview\n        Referencia: https://docs.stripe.com/api/v2/core/accounts",
    )
    .replace(
      "      - Guías de diseño de APIs de [Google](https://docs.cloud.google.com/apis/design) y de [Microsoft](https://github.com/microsoft/api-guidelines) (Azure y Legacy)",
      "      - Guía de Google: https://docs.cloud.google.com/apis/design\n        Guía de Microsoft (Azure y Legacy):\n        https://github.com/microsoft/api-guidelines",
    )
    .replace(
      "      description: Permite a usuarios con rol de administración la creación de nuevos trámites en el catálogo de trámites. Los mismos nacerán con estado draft y pueden contener un procedimiento vacío",
      "      description: >-\n        Permite a usuarios con rol de administración la creación de nuevos\n        trámites en el catálogo. Estos nacen con estado draft y pueden contener\n        un procedimiento vacío.",
    )
)
#source-block(openapi-fragment, lang: "yaml")
