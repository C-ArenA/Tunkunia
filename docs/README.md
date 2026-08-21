# Tunkunia documents

`memoria/memoria.typ` is the primary thesis entrypoint. The research on trámite
modeling belongs to the thesis and lives in the single foundation file
`memoria/02-foundations-research/03-tram-research.typ`.

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
  `#include "introduction.typ"` inside a large chapter's primary file;
- use a docs-root path only when the dependency lives above the current file's
  subtree, such as `image("/assets/figures/example.png")` from a deeply nested
  chapter; and
- never use `../` chains for shared project resources.

This keeps reusable folders internally self-contained while preventing deeply
nested content from depending on its current nesting depth.

Within each numbered part, keep chapter entrypoints as numbered `.typ` files
directly under the part directory. Restart numbering in every directory so the
prefix expresses local reading order rather than the chapter number rendered in
the thesis. The exceptional `01-presentation/00-introduction.typ` contains the
unheaded prose that opens its part.

Only a chapter that has grown enough to need several cohesive source files gets
a same-numbered companion directory. Its entrypoint remains at the part root so
all chapters stay visible together in the file explorer. For example,
`03-definition-design/01-development-methodology.typ` owns the locally numbered
fragments under `03-definition-design/01-development-methodology/`.

Do not create generic intermediate folders such as `sections/`, `analysis/`,
or `design/` merely to group fragments. First write the chapter in its direct
numbered file, and split it only when its actual size makes that easier to edit.

The thesis follows an artifact-centered argument:

1. `01-presentation/` establishes the historical and current context, then
   defines the problem, objectives, scope, and proposal.
2. `02-foundations-research/` establishes the reference and theoretical bases,
   then derives a general trámite model through research.
3. `03-definition-design/` explains the development method, requirements,
   domain analysis, architecture, and design.
4. `04-construction-evaluation/` documents the prototype and evaluates it with
   representative cases and tests.
5. `05-conclusion/` relates the results back to the objectives and records
   limitations and future work.

Detailed schedules and repository procedures live in `appendices/` instead of
interrupting the main argument. Write the trámite research in
`memoria/02-foundations-research/03-tram-research.typ`; it appears in both the
thesis and IEEE rendering. Change the supporting IEEE entrypoint only when
changing presentation or publication metadata.

A practical writing order is research, requirements, architecture,
implementation, validation, focused foundations, introduction, and finally
conclusions. This allows each chapter to consume evidence established by the
previous one.

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

- `memoria/`: thesis entrypoint, five numbered parts, preamble, and appendices.
- `shared/`: metadata, acronyms, bibliography, template, and bundled fonts.
- `assets/figures/`: render-ready images used by Typst.
- `assets/sources/`: editable Drawio, Excalidraw, and PlantUML sources.
- `archive/`: frozen documents retained for historical reference.
- `supporting/`: secondary reports and planning documents.
