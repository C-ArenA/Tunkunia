# Tunkunia SPA

The Nuxt application is organized around route-level pages and small feature components. Pages coordinate routes, queries, and mutations; reusable UI belongs in `app/components`; API-to-UI transformations live in `app/utils` and use the generated types.

The procedure canvas is shared by read-only diagrams and the admin editor. Its API adapter preserves node coordinates, roles, arcs, and start/end places while keeping Vue Flow viewport state local to the browser.

The API client is generated from `../specs/v1.openapi.yaml`:

```bash
pnpm --filter spa openapi-ts
pnpm --filter spa lint
pnpm --filter spa fmt:check
pnpm --filter spa build
```

Run the development app with `pnpm --filter spa dev`.
