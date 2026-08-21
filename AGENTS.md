# Repository Guidelines

## Project Purpose

Tunkunia is a reusable, open-source system for managing and tracking *trámite* workflows in Bolivian public institutions. Account for local e-government, administrative-procedure, and interoperability needs. Keep the workflow model reusable across institutions rather than coupling it to one case study.

## Modular Monolith Architecture

Organize backend code by business capability. Current modules include `catalog`, `user`, and `authn`; add a module under `internal/` when a capability has distinct domain language and behavior.

Each module owns its domain types, services, persistence adapters, and transport mappings. Keep composition and wiring in `cmd/` and `internal/api/`. Cross-module calls use deliberate exported interfaces or types; never expose generated database models as module APIs or reach into another module's implementation.

Share only genuine cross-cutting technical concerns. Avoid generic `utils` packages and abstractions for hypothetical needs. Aim for independently understandable modules within one deployable application.

## Project Structure

- `cmd/`, `main.go`: CLI commands and server startup.
- `internal/`: business modules and API composition.
- `database/`: migrations, seeds, and generated database code.
- `spa/`: Nuxt frontend; `site/`: Astro documentation site.
- `docs/`: Typst documents and supporting assets.

Follow the additional instructions in `site/AGENTS.md` when working inside `site/`.

## Build, Test, and Development Commands

- `go test ./...` — run Go tests; `go build .` — build the backend.
- `go run . serve` — start the backend server locally (the project uses Cobra for the CLI).
- `go generate ./...` — run Go code-generation tasks for SQLC, Jet, and OpenAPI.
- `go tool task server:dev` — run the Go server with hot reload.
- `pnpm --filter spa dev` — start the Nuxt frontend.
- `pnpm --filter site dev` — start the Astro documentation site.
- `pnpm --filter spa lint` and `pnpm --filter spa fmt:check` — lint and check frontend formatting.

## Dependencies and Generated Code

Before the first release, prefer the latest stable Go, Nuxt, Vue, and Typst releases during intentional upgrades. Manifests and lockfiles remain authoritative for reproducible builds. Keep upgrades focused and verify affected builds and tests. Define a fixed support policy at the first release.

Do not manually edit generated files under `database/sqlc/`, `database/jet/`, or `internal/api/v1/oapi/*.gen.go`. Treat the configuration structs and their `envDefault` tags in `internal/config/config.go` as the canonical reference for supported settings and defaults. Use `.env` only for local overrides; never expose or commit secrets or local database files.

## Style and Testing

Use `gofmt` for Go and Oxfmt/Oxlint for the SPA. Follow local patterns. Use Go's `testing` package and existing `testify` assertions; name tests `Test<TypeOrBehavior>`. Add focused tests beside the changed module.

## Commits and Pull Requests

Use the Conventional Commits specification with prefixes such as `feat:`, `fix:`, and `chore:`, consistent with the project history. Pull requests should describe the behavior changed, list relevant tests or checks run, and include screenshots for visible frontend or documentation changes.

When explicitly asked to integrate a feature branch, prefer a squash merge unless the user requests preserving its history. Use a Conventional Commit subject, summarize the branch's important changes in the commit body, and list the most relevant original commits. Do not push unless explicitly requested.
