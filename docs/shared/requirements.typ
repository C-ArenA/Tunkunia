#let requirement-documents = (
  "TRS": yaml("/requirements/export/TRS.yml"),
  "SyRS": yaml("/requirements/export/SyRS.yml"),
)

#let requirements(document, type: none, category: none) = {
  assert(
    requirement-documents.keys().contains(document),
    message: "unknown requirement document: " + document,
  )

  let matches = requirement-documents
    .at(document)
    .pairs()
    .filter(pair => {
      let item = pair.at(1)
      let text = item.at("text", default: "").trim()

      (
        item.at("active", default: false)
          and item.at("normative", default: false)
          and text != ""
          and (type == none or item.at("type", default: none) == type)
          and (
            category == none or item.at("category", default: none) == category
          )
      )
    })

  if matches.len() > 0 {
    list(
      ..matches.map(pair => {
        let uid = pair.at(0)
        let text = pair.at(1).at("text").trim()
        [#strong(uid + ":") #text]
      }),
    )
  }
}
