#import "@preview/cmarker:0.1.10"

#let repository-base = "https://github.com/C-ArenA/Tunkunia/blob/master/"
#let repository-link(destination, body) = {
  let resolved = if (
    type(destination) == str
      and not destination.starts-with("https://")
      and not destination.starts-with("http://")
      and not destination.starts-with("mailto:")
  ) {
    repository-base + destination
  } else {
    destination
  }
  link(resolved, body)
}

#let readme-lines = read("repository-readme.md").split("\n")
#assert(
  readme-lines.len() > 0 and readme-lines.at(0) == "# Tunkunia",
  message: "El README del repositorio debe comenzar con '# Tunkunia'.",
)
#let readme-body = (
  readme-lines
    .slice(1)
    .join("\n")
    .replace(
      regex("(?m)^###\\s+[0-9]+\\.\\s+"),
      "### ",
    )
)

= README del repositorio

Este anexo reproduce el archivo `README.md` disponible en el
#link("https://github.com/C-ArenA/Tunkunia")[repositorio público de Tunkunia].

#[
  #show table: set text(size: 9pt)
  #show raw.where(block: true): it => block(
    width: 100%,
    above: 0.5em,
    below: 0.5em,
    text(size: 9pt, it),
  )
  #cmarker.render(
    readme-body,
    h1-level: 1,
    label-prefix: "readme-",
    raw-typst: false,
    scope: (link: repository-link),
  )
]
