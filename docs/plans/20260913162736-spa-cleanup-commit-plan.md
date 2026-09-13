# SPA cleanup commit plan

This plan tracks the implementation from the SPA cleanup. Check a commit only after its staged diff has been reviewed and the commit has been created. The current `AGENTS.md` edit predates this plan and remains excluded from all groups.

- [x] `feat: add institution settings and user lookup API`
  - Add the institution migration, SQLite repository, validation, admin authorization, and API wiring.
  - Add admin `GET /users/{id}`.
  - Update source OpenAPI, SQLC configuration, generated Go API models/handlers, and migration coverage.
  - Files: `database/migrations/20260912100000_institution.sql`, `database/migrate_test.go`, `sqlc.yaml`, `database/sqlc/`, `internal/institution/`, `internal/user/strict_handler.go`, `internal/api/v1/`, `cmd/serve.go`, `specs/v1/`.
  - Validation: `GOCACHE=/tmp/tunkunia-go-cache go test ./...`, `go build .`, `pnpm exec redocly lint ./specs/v1.openapi.yaml`.

- [ ] `feat: replace procedure diagrams with Vue Flow`
  - Replace SVG rendering and the coordinate editor with the shared Vue Flow canvas.
  - Add custom place/transition nodes, typed API/flow adapters, dragging, connection validation, edge deletion, selection, and workflow highlighting.
  - Files: `spa/app/components/ProcedureDiagram.vue`, `spa/app/components/ProcedureEditor.vue`, `spa/app/components/procedure/`, `spa/app/utils/procedure.ts`, `spa/app/assets/css/main.css`.
  - Validation: SPA lint, formatting, and production build.

- [ ] `feat: load institution identity from the API`
  - Replace browser-only demo persistence with the institution query and admin mutation.
  - Update public/admin branding and institution editing; remove obsolete demo composable and duplicate types.
  - Refresh the SPA README with the component and generation conventions.
  - Files: `spa/app/composables/useInstitution.ts`, `spa/app/pages/admin/institucion.vue`, `spa/app/layouts/`, `spa/app/pages/index.vue`, `spa/app/composables/useTunkuniaDemo.ts`, `spa/app/types/tunkunia.ts`, `spa/README.md`.
  - Validation: SPA lint, formatting, and production build.

- [ ] `refactor: standardize SPA queries and mutation errors`
  - Move catalogue, user, case, inbox, and case-detail reads to generated Pinia Colada queries.
  - Improve loading, empty, failure, conflict, and mutation-success handling while preserving existing routes and behavior.
  - Files: `spa/app/pages/admin/tramites/`, `spa/app/pages/admin/usuarios/`, `spa/app/pages/app/bandeja/`, `spa/app/pages/app/casos/`.
  - Validation: SPA lint, formatting, and production build.

## Current position

The first group has been committed as `3b19424`. The second group is staged for review; no second commit has been created yet. After approval, update this file’s second checkbox and stage the next group before proposing its commit message.
