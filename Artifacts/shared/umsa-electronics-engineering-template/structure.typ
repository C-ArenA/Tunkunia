#let partChapter(body) = {
  set outline(indent: n => {
    if n == 0 {
      return 0em
    }
    if n == 1 {
      return 6em
    }
    return 6em + (n - 2) * 1em
  })
  show outline.entry.where(level: 1): it => {
    if it.element.func() == heading {
      v(1.5em, weak: true)
      upper(link(
        it.element.location(),
        grid(
          columns: (6em, 1fr),
          [*#it.prefix()*], [#it.inner()],
        ),
      ))
    } else {
      it
    }
  }
  show outline.entry.where(level: 2): set block(above: 1.5em, below: 1.5em)
  show outline.entry.where(level: 2): set text(weight: "semibold")
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 2): set outline.entry(fill: repeat()[~])
  show outline.entry.where(level: 2): underline
  show outline.entry.where(level: 3): it => {
    if it.prefix() == none {
      text(style: "italic", it)
    } else {
      it
    }
  }
  show selector.or(
    outline.entry.where(level: 2),
  ): upper

  let chapterCounter = counter("chapter-counter")
  show heading.where(level: 2): it => chapterCounter.step() + it

  set heading(numbering: (..nums) => {
    let numsArray = nums.pos()
    if numsArray.len() == 1 {
      "Parte " + numbering("I", ..numsArray)
    } else if numsArray.len() == 2 {
      "Capítulo " + numbering("1", chapterCounter.get().first() + 1)
    } else {
      numbering("1.1.1", ..chapterCounter.get(), ..numsArray.slice(2))
    }
  })

  show heading.where(level: 2): set align(center)
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    it
  }

  show heading.where(level: 1): it => {
    if it.numbering == none {
      align(center, it)
      v(1em)
    } else {
      page(numbering: none)[
        #v(1fr)
        #align(center)[
          #set text(size: 25pt)
          #set par(justify: false)
          #smallcaps()[Parte #str(counter(heading).get().first())]\
          #upper(it.body)
        ]
        #v(2fr)
      ]
    }
  }
  show selector.or(
    heading.where(level: 1),
    heading.where(level: 2),
  ): upper
  body
}
