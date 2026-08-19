# Tunkunia documents

`memoria/memoria.typ` is the primary thesis entrypoint. The research on trámite
modeling belongs to the thesis and lives in the single foundation file
`memoria/01-foundation/tram-research.typ`.

`supporting/tram-research.typ` is a presentation-only IEEE entrypoint that
consumes that thesis-owned file. Other secondary entrypoints live alongside it
under `supporting/`, while the old project profile and its content are frozen
together under `archive/perfil/`. They remain buildable but are not sources for
current thesis prose.

## Writing workflow

The declared Typst project root is `docs/`, independently of where an
entrypoint lives. When VS Code opens the monorepo root, the repository setting
maps Tinymist's root to `${workspaceFolder}/docs` and loads the bundled fonts.
Other editors should select `docs/` as the Typst root. The repository build
tasks pass the same root explicitly, so nested entrypoints behave identically
in the editor and CLI.

Use paths according to dependency locality:

- use a relative path for a file in the same directory or below it, such as
  `#import "memoria.typ"` inside `shared/theme/lib.typ` or
  `#include "sections/01-introduction.typ"` inside a section aggregator;
- use a docs-root path only when the dependency lives above the current file's
  subtree, such as `image("/assets/figures/example.png")` from a deeply nested
  chapter; and
- never use `../` chains for shared project resources.

This keeps reusable folders internally self-contained while preventing deeply
nested content from depending on its current nesting depth.

Write the trámite research in `memoria/01-foundation/tram-research.typ`; it
appears in both the thesis and the IEEE rendering. Write all other thesis prose
under `memoria/`. Change the supporting IEEE entrypoint only when changing its
presentation or publication metadata.

Portable commands from the repository root are:

```sh
go tool task docs:build:memoria
go tool task docs:build:research
go tool task docs:build:perfil
go tool task docs:build:report
go tool task docs:build:lean
go tool task docs:check
```

The commands use the Typst CLI and bundled fonts. Generated PDFs are written
only to the ignored `docs/build/` directory. Editor previews are optional; the
committed VS Code settings only align Tinymist's compiler root and font inputs
with these CLI commands.

## Adding and citing a source

Zotero and Better BibTeX are the source of truth for references. On each
machine, configure an automatic **Better BibLaTeX** export of the thesis
collection to that checkout's `docs/shared/references.bib` path:

- update the export when the collection changes;
- sort the export by citation key for stable Git diffs;
- exclude attachments and their machine-specific paths;
- keep citation keys stable; and
- configure Better BibTeX Quick Copy to emit citation keys.

Do not edit `references.bib` by hand: the next Zotero export would overwrite
the change. Add or correct the Zotero item, wait for the export, cite it as
`@citationKey`, and commit the bibliography change with the prose that uses it.

## Directory guide

- `memoria/`: primary thesis entrypoint, preamble, chapters, and research prose.
- `shared/`: metadata, acronyms, bibliography, template, and bundled fonts.
- `assets/figures/`: render-ready images used by Typst.
- `assets/sources/`: editable Drawio, Excalidraw, and PlantUML sources.
- `archive/`: frozen documents retained for historical reference.
- `supporting/`: secondary reports and planning documents.
