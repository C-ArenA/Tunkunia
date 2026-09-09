// Definiciones compartidas por la memoria. El prefijo gls- evita colisiones
// con las claves de acrónimos; description contiene la definición conceptual.
#let glossary = (
  "gls-tramite": (
    short: "Trámite",
    description: "Conjunto de requisitos, pasos y actuaciones mediante los cuales una persona natural o jurídica presenta una solicitud o información ante una entidad pública para obtener un servicio, ejercer un derecho o cumplir una obligación.",
  ),
  "gls-caso-tramite": (
    short: "Caso de trámite",
    description: "Instancia concreta de ejecución de un trámite. En Tunkunia, cada caso mantiene su propio estado, participantes, datos e historial, conforme a una definición de proceso.",
  ),
  "gls-expediente-tramite": (
    short: "Expediente de trámite",
    description: "Conjunto organizado de datos, documentos y actuaciones asociados a un caso de trámite, que se incorpora y actualiza durante su ejecución y permite consultar sus antecedentes.",
  ),
  "gls-oidc": (
    short: "OIDC",
    long: "OpenID Connect",
    description: "Protocolo de autenticación construido sobre OAuth 2.0 que permite a una aplicación verificar la identidad de un usuario mediante un proveedor de identidad y obtener información sobre él. Utiliza un token de identidad (ID Token) para comunicar el resultado de la autenticación.",
  ),
  "gls-flujo-trabajo": (
    short: "Flujo de trabajo",
    description: "Organización de actividades, condiciones y reglas que determina cómo avanza un proceso y cómo se asigna el trabajo a sus participantes. Puede incluir secuencias, alternativas y actividades concurrentes.",
  ),
  "gls-wfms": (
    short: "WFMS",
    long: "Workflow Management System",
    description: "Sistema de gestión de flujos de trabajo que permite definir procesos, coordinar la ejecución de sus instancias y registrar su avance, de acuerdo con reglas y asignaciones de tareas.",
  ),
  "gls-red-petri": (
    short: "Red de Petri",
    description: "Modelo matemático y gráfico de sistemas con eventos discretos, compuesto por plazas, transiciones y arcos dirigidos. Las fichas distribuidas en las plazas representan el estado, y el disparo de transiciones modifica esa distribución conforme a las reglas de la red.",
  ),
  "gls-interoperabilidad": (
    short: "Interoperabilidad",
    description: "Capacidad de sistemas y organizaciones para intercambiar información y utilizarla de manera coherente mediante interfaces, formatos y acuerdos compartidos. En la gestión de trámites, facilita la coordinación y el aprovechamiento de información entre entidades.",
  ),
  "gls-trazabilidad": (
    short: "Trazabilidad",
    description: "Capacidad de reconstruir el recorrido de un caso y los cambios realizados sobre sus datos a partir de registros que identifican las acciones, sus responsables y el momento en que ocurrieron.",
  ),
  "gls-gobierno-electronico": (
    short: "Gobierno electrónico",
    description: "Uso de tecnologías de la información y la comunicación en las instituciones públicas para mejorar la gestión, la prestación de servicios y la relación con la ciudadanía, apoyando la transparencia, la participación y el intercambio de información.",
  ),
)
