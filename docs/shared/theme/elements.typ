#import "@preview/mmdr:0.2.2": mermaid-svg

#let figure-caption(source, it) = block[
  #it.supplement #context it.counter.display()#it.separator#it.body
  #linebreak()
  #if source != none {
    [Fuente: #source]
  } else {
    [Fuente: Elaboración propia]
  }
]

#let img-fig(
  path,
  caption,
  lbl,
  source: none,
  width: 100%,
  placement: none,
) = {
  show figure.caption: figure-caption.with(source)
  [#figure(
      image(path, width: width),
      caption: caption,
      placement: placement,
    ) #lbl]
}

#let mmd-fig(
  path,
  caption,
  lbl,
  source: none,
  width: 100%,
  placement: none,
) = {
  if not lower(path).ends-with(".mmd") {
    return img-fig(
      path,
      caption,
      lbl,
      source: source,
      width: width,
      placement: placement,
    )
  }

  show figure.caption: figure-caption.with(source)
  [#figure(
      image(
        bytes(mermaid-svg(read(path))),
        format: "svg",
        width: width,
      ),
      caption: caption,
      placement: placement,
    ) #lbl
  ]
}

#let typ-fig(
  body,
  caption,
  lbl,
  source: none,
  width: 100%,
  placement: none,
) = {
  show figure.caption: figure-caption.with(source)
  [#figure(
      block(width: width, body),
      caption: caption,
      placement: placement,
    ) #lbl]
}
