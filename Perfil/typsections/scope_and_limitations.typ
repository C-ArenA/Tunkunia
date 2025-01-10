= Alcances y Limitaciones

De acuerdo a los objetivos planteados es menester delinear el campo de acción del proyecto.

== Alcances

    - Se desarrollará un paquete de software en su primera versión con funcionalidades para facilitar la creación y seguimiento de trámites.
    - Tunkunia será distribuido mediante al menos un repositorio remoto de versionado como _GitHub_.
    - El producto además será publicado en algún repositorio de paquetes de software coherente con la tecnología que use.
    - Se usará una licencia de software libre que permita el uso de esta idea sin restricciones, pero mencionando al autor.
    - El proyecto contará con la implementación de una documentación en línea para facilitar el uso de Tunkunia.
    - Se demostrará el uso del paquete en una implementación de un _fork_ del sistema SIAI.
    - Se usarán buenas prácticas de programación para lograr código legible y sobre el cual sea sencillo colaborar.
    - Los lineamientos, fruto de la creación conceptual de este software serán creados con la ayuda de herramientas para desarrolladores como un CLI.
    - Se recibirá al menos un _pull request_ en el repositorio para demostrar las bondades del software libre y se atenderá al menos un _issue_ reportado.
    - Se adoptarán medidas de _testing_ para entregar un mejor código.

== Limitaciones

    - El desarrollo no será realizado desde cero y de forma completa, sino que siguiendo los mismos lineamientos sobre los cuales se piensa este proyecto de software, se usarán herramientas de software libre como ladrillos de construcción para éste. Esto puede ser considerado un alcance de acuerdo a cómo se lo vea.
    - La versión 1 será funcional, pero no se garantiza que esté libre de bugs, lo cual es natural en muchos desarrollos de software a pesar de la aplicación de las mejores prácticas y el testing.
    - El sistema, si bien podría ser utilizado por un amplio abánico de aplicaciones, en su versión 1, que es la que atañe a este documento, se centrará unicamente en los trámites públicos más comunes y sin cubrir necesariamente las necesidades de cualquier trámite que pueda existir. Se deben tomar como marco los trámites realizados en el sistema SIAI, que es el caso de estudio sobre el cual se desarrollará Tunkunia.
    - Si bien este proyecto puede ser aplicado en distintos entornos de manera conceptual, debe quedar claro que la implementación práctica de cualquier paquete de software suele estar acotada a ciertas tecnologías. En el caso presente esta tecnología será _Laravel_ por su presencia en el sistema SIAI y por su crecimiento reciente en popularidad.