= Alcances y Limitaciones

De acuerdo a los objetivos planteados es menester delinear el campo de acción del proyecto.

== Alcances

- Se desarrollará un módulo de software en su primera versión con funcionalidades para facilitar la gestión y seguimiento de trámites.
- Se propondrá al menos un modelo completo del trámite, que aglutine las características comunes a los mismos.
- Tunkunia será distribuido mediante al menos un repositorio remoto de versionado como _GitHub_.
- El producto además será publicado en medios para su fácil distribución y reutilización.
- Se usará una licencia de software libre que permita el uso de esta idea sin restricciones, pero mencionando al autor.
- El proyecto contará con la implementación de una documentación en línea para facilitar el uso de Tunkunia. Dicha documentación contará con las especificaciones de interoperabilidad.
- Se demostrará el uso del subsistema en una implementación de un clon con características reducidas del sistema SIAI.
- Se usarán buenas prácticas de programación para lograr código legible y sobre el cual sea sencillo colaborar.
- Los lineamientos, fruto de la creación conceptual de este software serán creados con la ayuda de herramientas para desarrolladores como un CLI.
- Se recibirá al menos un _pull request_ en el repositorio para demostrar las bondades del software libre y se atenderá al menos un _issue_ reportado.
- Se adoptarán medidas de _testing_ para entregar un mejor código, debiendo pasar al menos el 80% de tests para la aceptación de la versión 1.0.0.
- Se buscará la interoperabilidad con servicios de ciudadanía digital. Sin embargo, no se garantiza esta funcionalidad de forma completa, debido a que depende fuertemente del aparato burocrático estatal y puede ser necesario el uso de servicios similares o simulados que se aproximen.
- Se podrá ver el módulo en funcionamiento mediante una aplicación web.

== Limitaciones

- El desarrollo usará herramientas de software libre como ladrillos de construcción cuando sea posible y con su debido análisis. Esto puede ser considerado un alcance de acuerdo a cómo se lo vea.
- La versión 1.0.0 será funcional, pero no se garantiza que esté libre de bugs, lo cual es natural en muchos desarrollos de software a pesar de la aplicación de las mejores prácticas y el testing.
- El sistema, si bien podría ser utilizado por un amplio abánico de aplicaciones, en su primera versión, que es la que atañe a este documento, se centrará unicamente en los trámites públicos más comunes y sin cubrir necesariamente las necesidades de cualquier trámite que pueda existir. Se deben tomar como marco los trámites realizados en el sistema SIAI, que es el caso de estudio sobre el cual se desarrollará Tunkunia.
- Si bien este proyecto puede ser aplicado en distintos entornos de manera conceptual, debe quedar claro que la implementación práctica de cualquier módulo de software puede estar acotada por las tecnologías subyacentes.
- El uso de LLMs será mediante APIs disponibles en el mercado, siendo una funcionalidad aún experimental.
- La creación de trámites no será necesariamente mediante una GUI y puede ser mediante definiciones puramente programáticas, únicamente entendidas por otros desarrolladores de código.
- La interfaz de usuario que acompaña al módulo Tunkunia será a modo de ejemplo y no se implementará necesariamente con el enfoque de uso en producción.
- Los métodos de despliegue de proyectos de software existentes hoy en día son varios. Para el despliegue de lo indicado en los alcances, el autor elegirá uno de forma arbitraria, pero documentará el proceso de despliegue.
- No se debe confundir este módulo con un sistema completo, ya que su utilidad yace precisamente en la capacidad de reutilización, por lo que cualquier implementación que sirva como herramienta para demostrar su funcionalidad, se debe considerar un artefacto secundario.
