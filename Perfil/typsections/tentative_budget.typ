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
    [Project Maintainer],[8000],[48000],
    [Servidor VPS para despliegue (@fig:vps)],[40],[460],
    [Dominio (@fig:domain)],[7],[73],
    table.hline(),
    [],[*Total*],[48533]
  )
)<table:budget>

#figure(
  image("../assets/domain.png", width: 60%),
  caption: [Costo anual del Dominio en Cloudflare]
)<fig:domain>

#figure(
  image("../assets/vps.png", width: 50%),
  caption: [Costo mensual de VPS en Hostinger]
)<fig:vps>
