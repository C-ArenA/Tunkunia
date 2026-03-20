= Presupuesto Tentativo

El desarrollo de un proyecto de software libre es difícil de presupuestar, ya que no existen gastos emitidos por alguna entidad y son el desarrollador y la comunidad los que aportan desinteresadamente al proyecto.

La figura clave en proyectos de tipo FOSS es el _Project Maintainer_, quien se encarga de liderar y organizar la iniciativa y que en la etapa temprana suele también tomar el trabajo de desarrollador. Normalmente dicha persona está involucrada en temas de desarrollo y trabaja en este ámbito, por lo que su trabajo tiene un costo inherente.

Este proyecto en específico cuenta además con el requerimiento de aplicar el módulo desarrollado en una instancia similar a la real, como caso de estudio sobre una réplica mínima del sistema SIAI y debe tener un sitio de documentación. Para esto se debe incurrir en gastos de infraestructura.

Todo lo anterior, con costos aproximados basados en el mercado actual, se detalla en la @table:budget.

#figure(
  caption: "Presupuesto Tentativo",
  table(
    columns: 3,
    stroke: none,
    align: (left, right, right),
    table.header[#align(center)[Detalle]][#align(center)[Costo/Mes (Bs)]][#align(center)[Costo/Proyecto (Bs)]],
    table.hline(),
    [Project Maintainer], [8000], [48000],
    [Servidor VPS para despliegue (@fig:vps)], [40], [460],
    [Dominio (@fig:domain)], [7], [73],
    table.hline(),
    [], [*Total*], [48533],
  ),
)<table:budget>

#figure(
  image("../assets/domain.png", width: 60%),
  caption: [Costo anual del Dominio en Cloudflare],
)<fig:domain>

#figure(
  image("../assets/vps.png", width: 50%),
  caption: [Costo mensual de VPS en Hostinger],
)<fig:vps>

#import "@preview/chronos:0.2.0"
#chronos.diagram({
  import chronos: *
  _par("Ciudadano")
  _par("Sistema")

  _seq("Sistema", "Ciudadano", comment: "Requerimiento de Información")
  _seq("Ciudadano", "Sistema", comment: "Envío de Información")
  _seq("Sistema", "Sistema", comment: "Revisa Información")
  _seq("Sistema", "Ciudadano", comment: "Notifica Final")
})

Para sacar licencia de conducir

+ Saco ficha solicitando atención | Coloco la URL
+ Espero mi turno | Espero a que abra el portal
+ Me llaman a ventanilla | Ingreso al portal
+ Entrego requisitos | Lleno un formulario
+ Realizan una verificación preliminar | Se hacen validaciones
+ Me entregan una ficha de seguimiento | Se me entrega un código de trámite
+ Espero sentado a que me llamen por pantalla | Hago mis cosas y de vez en cuando reviso el estado de mi trámite usando el código
+ En pantalla se me pide acercarme a otra ventanilla | Me llega un correo
+ Me entregan mi licencia | El correo indica éxito y me manda un documento
+ O Me indican que hubo un problema y debo volver a iniciar el trámite | El correo notifica error y pide volver a intentar

#chronos.diagram({
  import chronos: *
  _par("c", display-name: "Ciudadano", shape: "actor")
  _par("t", display-name: "Oficina de Trámite")
  _par("g", display-name: "Ministerio de Gobierno")

  _seq("g", "c", comment: "Exige registro de vidrios polarizados")
  _seq("c", "g", comment: "Pide Info sobre el procedimiento")
  _seq("g", "c", comment: "Indica requisitos")

  _seq("c", "t", comment: "Entrega Información de trámite")
  _seq("c", "t", comment: "Entrega Información de contacto")
  _seq("t", "t", comment: "Revisión de validación de datos")
  _seq("t", "c", comment: "Proporciona código de trámite")
  _seq("t", "t", comment: "Revisión de información")
  _note("over", [Éxito en revisión], pos: ("c", "t"))
  _seq("t", "c", comment: "Pide pago")
})
