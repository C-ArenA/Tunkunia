#import "@preview/timeliney:0.4.0"
#timeliney.timeline(
  show-grid: true,
  spacing: 5pt,
  box-milestones: false,
  {
    import timeliney: *

    headerline(group(([*Semanas 2026*], 20)))
    headerline(group(("Marzo", 3), ("Abril", 5), ("Mayo", 4), ("Junio", 4), ("Julio", 4)))
    headerline(group(..range(11, 31).map(n => text(size: 9pt)[#str(n)])))

    let iterStyle = (stroke: 3pt + gray)
    task([*Inicio*], (0, 6), style: (stroke: 8pt + gray))
    task("i1.1 - i1.6", ..range(0, 6).map(i => (i + 0.1, i + 0.9)), style: iterStyle)
    task([*Elaboración*], (6, 8), style: (stroke: 8pt + gray))
    task("i2.7 - i2.8", ..range(6, 8).map(i => (i + 0.1, i + 0.9)), style: iterStyle)
    task([*Construcción*], (8, 16), style: (stroke: 8pt + gray))
    task("i3.9 - i3.16", ..range(8, 16).map(i => (i + 0.1, i + 0.9)), style: iterStyle)
    task([*Transición*], (16, 20), style: (stroke: 8pt + gray))
    task("i4.17 - i4.20", ..range(16, 20).map(i => (i + 0.1, i + 0.9)), style: iterStyle)
    
    milestone(style: (stroke: (dash: "dashed")), at: 6, align(center)[*Informe 1*])
    milestone(style: (stroke: (dash: "dashed")), at: 8, align(center)[*Informe 2*])
    milestone(style: (stroke: (dash: "dashed")), at: 12, align(center)[*Informe 3*])
    milestone(style: (stroke: (dash: "dashed")), at: 16, spacing: 23pt, align(center)[*Informe 4*])
    milestone(style: (stroke: (dash: "dashed")), at: 20, align(center)[*Informe 5*])
  },
)
