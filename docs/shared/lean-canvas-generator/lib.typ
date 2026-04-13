#let generateCanvas(
  problem: [== Problem],
  customerSegments: [== Customer Segments],
  uniqueValueProposition: [== Unique Value Proposition],
  solution: [== Solution],
  channels: [== Channels],
  costStructure: [== Cost Structure],
  revenueStreams: [== Revenue Streams],
  keyMetrics: [== Key Metrics],
  unfairAdvantage: [== Unfair Advantage],
) = {
  set rect(
    width: 100%,
    height: 100%,
  )
  grid(
    columns: (1fr,) * 10,
    rows: (1fr, 1fr),
    gutter: 3pt,
    grid.cell(
      rowspan: 2,
      colspan: 2,
      rect()[
        #problem
      ],
    ),
    grid.cell(
      rowspan: 1,
      colspan: 2,
      rect()[
        #solution
      ],
    ),
    grid.cell(
      rowspan: 2,
      colspan: 2,
      rect()[#uniqueValueProposition],
    ),
    grid.cell(
      rowspan: 1,
      colspan: 2,
      rect()[#unfairAdvantage],
    ),
    grid.cell(
      rowspan: 2,
      colspan: 2,
      rect()[#customerSegments],
    ),
    grid.cell(
      rowspan: 1,
      colspan: 2,
      rect()[#keyMetrics],
    ),
    grid.cell(
      rowspan: 1,
      colspan: 2,
      rect()[#channels],
    ),
  )
}
