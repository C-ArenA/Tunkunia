#let split-marker(source, marker, path) = {
  let parts = source.split(marker)
  assert(
    parts.len() > 1,
    message: "No se encontró el marcador '" + marker + "' en " + path + ".",
  )
  parts
}

#let before-marker(path, marker) = {
  let source = read(path)
  split-marker(source, marker, path).at(0).trim()
}

#let from-marker(path, marker) = {
  let source = read(path)
  let parts = split-marker(source, marker, path)
  (marker + parts.slice(1).join(marker)).trim()
}

#let between-markers(path, start, end) = {
  let source = read(path)
  let after-start = split-marker(source, start, path).slice(1).join(start)
  let before-end = split-marker(after-start, end, path).at(0)
  (start + before-end).trim()
}

#let source-block(source, lang: none) = block(
  width: 100%,
  breakable: true,
  above: 0.6em,
  below: 1em,
  text(size: 7pt, raw(source, block: true, lang: lang)),
)
