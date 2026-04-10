#import "@preview/acrostiche:0.7.0": print-index

// Incluye Sección de Acrónimos
#let includeAcronyms() = {
  print-index(
    outlined: true,
    title: "Nomenclatura, Símbolos, Acrónimos y Abreviaciones",
    sorted: "up",
    row-gutter: 1.5em,
    used-only: true
  )
}
