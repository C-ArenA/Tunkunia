#import "@preview/cetz:0.4.2": canvas, draw, tree

#canvas({
  import draw: *

  // --- Axes ---
  let origin = (0, 0, 0)
  let x = (4, 0, 0)
  let y = (0, 4, 0)
  let z = (0, 0, 4)

  let point(center: (0, 0, 0), leganch: (0, 1, 0), legend: "Hola") = {
    circle(center, fill: black, radius: 0.1)
    content(leganch, text(size: 7pt, legend))
  }
  line(origin, x, stroke: 1.5pt)
  line(origin, y, stroke: 1.5pt)
  line(origin, z, stroke: 1.5pt)
  point(center: (0, 0, 3), leganch: (0, -0.3, 3), legend: "caso")
  point(center: (0, 3, 0), leganch: (0.5, 3.2, 0), legend: "recurso")
  point(center: (3, 0, 0), leganch: (2.6, 0.3, 0), legend: "tarea")
  point(center: (3, 3, 3), leganch: (2.5, 3.3, 3), legend: "actividad")
  point(center: (3, 0, 3), leganch: (3, -0.3, 3), legend: "trabajo")

  content((4, 0, 0))[eje del\ proceso]
  content((0.2, 0, 4.5))[eje de casos]
  content((0, 4.3, 0))[eje de recursos]

  // Cube
  on-xy({
    rect(origin, (3, 3), stroke: 0.5pt)
  })
  on-xy(
    {
      rect(origin, (3, 3), stroke: 0.5pt)
    },
    z: 3,
  )
  on-yz({
    rect(origin, (3, 3), stroke: 0.5pt)
  })
  on-yz(
    {
      rect(origin, (3, 3), stroke: 0.5pt)
    },
    x: 3,
  )
})
