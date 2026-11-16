---
name: nhost
description: Works on the Mingo backend on Nhost (Postgres, Hasura GraphQL, Auth, Storage, Functions, Events, Run) with the Nhost CLI. Covers the docs snapshot, the nhost/ layout, nhost.toml, overlays and secrets, the local stack, deployments, GraphQL permissions and functions, auth, storage, functions and events, testing, schema snapshots and Constellation parity. Use for any backend task, before changing nhost.toml, migrations, metadata, functions or deployment settings, or whenever you are about to state how an Nhost feature behaves.
---

# Nhost backend

Never state how Nhost behaves from memory. Open the doc first; if the docs are silent, say so and test it on the local stack.

## Where the truth is

| Need | Look here |
| --- | --- |
| Nhost product docs (Auth, Storage, GraphQL, Events, Functions, Run, CLI, config reference) | `.work/nhost-docs/docs/` (MDX). Start at `docs/products/<product>/`, `docs/platform/`, `docs/reference/configuration/index.mdx` (every `nhost.toml` field with defaults) and `docs/reference/cli/commands.mdx` |
| Constellation (Nhost's GraphQL engine) | `.work/nhost-docs/constellation/` (`README.md`, `KNOWN_DIFFERENCES.md`, `docs/user/hasura-metadata-support.md`, `docs/user/postgres-features.md`) and `changelogs/constellation.md` |
| REST APIs of Auth and Storage | `.work/nhost-docs/api/*.openapi.yaml` |
| Release notes per service | `.work/nhost-docs/changelogs/` |
| Live search | `nhost docs search "<query>"`, `nhost docs show <page>`, or the CLI MCP `search` tool |
| Hasura v2 behavior the Nhost docs do not repeat (metadata API, function tracking rules, enum tables) | Context7 or https://hasura.io/docs/2.0/ ; confirm on the local stack |

The snapshot is pinned (see `.work/nhost-docs/SOURCE.md`). Refresh it from the Nhost documentation repository (see `.work/nhost-docs/SOURCE.md`) when a doc looks stale or a release is newer than the changelogs.

## References

| Area | Read |
| --- | --- |
| GraphQL surface, permissions, functions, computed fields, enums, naming, subscriptions, errors, engines | `references/graphql-and-permissions.md` |
| Apple/Google sign-in, roles, claims, users, profile bootstrap, account deletion | `references/auth.md` |
| Buckets, file permissions, uploads, URLs, images, cleanup | `references/storage.md` |
| Functions, Run, event/cron/one-off triggers, webhooks, secrets | `references/functions-events.md` |
| Clean replay, privacy matrix, schema snapshots, parity, CI | `references/testing.md` |

## Tools you have

- **Nhost CLI** (`nhost`). Needs Docker for the local stack. Check `nhost --help` before using a flag you have not seen.
- **CLI MCP** (`nhost mcp start`, config in `.nhost/mcp-nhost.toml`). Tools: `get-schema`, `graphql-query` (runs as a role and optional user id), `manage-graphql` (metadata, migrations, permissions, remote schemas; needs `admin_secret` and `manage_metadata = true`, local development only in practice), `cloud-graphql-query` (organizations, projects, configuration; mutations need `enable_mutations = true` and a personal access token), `search` (docs). Resources: `schema://nhost-cloud`, `schema://graphql-management`, `schema://nhost.toml` (the CUE schema of the config file).
- Anything the MCP edits must end up as files under `nhost/` and in git. A change that exists only in a database or the dashboard does not exist.

## Layout

```
nhost/
  nhost.toml                      # all service configuration
  overlays/local.json             # per-environment JSON-patch overlays (RFC 6902)
  migrations/default/<ts>_<name>/up.sql (+ down.sql)
  metadata/                       # Hasura metadata: databases/default/tables/*.yaml, functions, cron_triggers.yaml, ...
  seeds/default/*.sql             # reference data, applied with `nhost up --apply-seeds`
  schema/<role>.graphqls          # per-role contract snapshots
  tests/<domain>/                 # backend tests by domain, lib.ts shared, see references/testing.md
  tools/                          # up.sh, reset.sh, build-metadata.mjs, metadata-spec.mjs + spec/<domain>.mjs, dump-schemas.sh, schema-diff.sh
  run/<service>.toml              # Nhost Run services, if any
functions/                        # Nhost Functions (Node): one folder per feature, index.ts is the route, _helpers and _tests are never routed
.secrets                          # local secrets, never committed
.nhost/                           # CLI state, never committed
```

Keep `.secrets` and `.nhost/` in `.gitignore`. Secrets are referenced from `nhost.toml` as `{{ secrets.NAME }}`. The authorization model is generated: edit the domain file in `nhost/tools/spec/` (`<domain>.mjs` holds that domain's tables and tracked functions, `_shared.mjs` the helpers; `metadata-spec.mjs` only composes them), run `node nhost/tools/build-metadata.mjs`, then `nhost/tools/up.sh`. Never hand-edit `nhost/metadata/databases/default/{tables,functions}`.

## Daily commands

| Command | Use |
| --- | --- |
| `nhost/tools/up.sh` | Start or reload the local stack with fixed localhost ports and seeds. |
| `nhost/tools/reset.sh` | Clean replay: `down --volumes`, then up with seeds. |
| `cd nhost && npm test` | Backend suite. |
| `cd functions && npm test` | Functions unit tests. |
| `nhost/tools/dump-schemas.sh` | Re-dump `nhost/schema/{user,public}.graphqls`. |
| `nhost/tools/schema-diff.sh a b` | Compare two SDL dumps. |
| `nhost schema dump --subdomain <s> --role <r>` | Per-role snapshot of a cloud project. |
| `nhost config show/validate/edit/pull/apply [--subdomain <s>]` | Render, validate and sync configuration with overlays applied. |
| `nhost secrets list/create/update/delete` | Cloud secrets. |
| `nhost deployments new --subdomain <s> --ref <git-ref> --message <m> --user <u> --follow` | Manual cloud deployment. |
| `nhost list`, `nhost link`, `nhost login` | Project selection and credentials. |

Local endpoints: Hasura `localhost:8080`, Auth `localhost:4000`, Storage `localhost:8484/v1`, Functions `localhost:3030`, Postgres `localhost:5432` (`postgres://postgres:postgres@localhost:5432/local`). The docs' examples use the admin secret `nhost-admin-secret`; the tests read it from `.secrets`.

## Workflow for any backend change

1. Read the doc page for every Nhost feature you touch.
2. Change it on the local stack, then capture it as files: SQL in `nhost/migrations`, metadata via `nhost/tools/spec/<domain>.mjs`, config in `nhost/nhost.toml`, code in `functions/`.
3. Prove it from a clean state: `nhost/tools/reset.sh`, then the tests (`references/testing.md`).
4. Re-dump the per-role schema snapshots and read the diff; a contract change is intentional or it is a bug.
5. Cloud changes (config apply, deployments, secrets, projects) only after the local proof, and record exactly what changed.

## Environments

Local, a development cloud project and a production cloud project mirror the Flutter flavors (`development`, `production`). One `nhost.toml` is shared; differences live in `nhost/overlays/<subdomain>.json` and secrets. Validate with `nhost config validate --subdomain <s>`.

Cloud deployments apply `nhost.toml`, new migrations, metadata and functions on the deployment ref, or manually with `nhost deployments new`. Migrations are not rolled back by a redeploy: after a migration has been applied anywhere, never edit it; add a new one.

## Gotchas

- The `[hasura]` block, `X-Hasura-*` session variables and the `https://hasura.io/jwt/claims` namespace keep the Hasura name on every engine. Keep them as they are.
- Do not change the schema of `auth.*` tables or the root fields generated for them. You may add relationships and permissions on them.
- Storage tables are owned by the storage service: migrations can insert buckets but cannot create indexes on `storage.files` on cloud. Keep storage cleanup in Functions.
- Functions are bundled JavaScript or TypeScript: no native addons (`sharp`, `bcrypt`, `canvas`, `better-sqlite3`). Use Nhost Run for those. Timeouts: 10 s Starter, 180 s Pro, 600 s Teams; request and response bodies 6 MB.
- The Functions runtime requires a committed lockfile even with zero dependencies; without it the container will not start.
- Cron triggers use UTC. Event and cron retry settings use different field names (`interval_sec`/`timeout_sec` versus `retry_interval_seconds`/`timeout_seconds`).
- Rate limits for GraphQL, Storage and Functions are per client IP and configured per service.
- Permissions that look slow for non-admin roles: compare timing as admin and as a role; disabling Postgres JIT is the documented fix.
- Extensions available on cloud include pg_cron, pgmq, http, pgvector, pg_jsonschema, pg_trgm, pg_search, postgis, timescaledb and pg_durable. pg_net and pgTAP are not in the documented list: do not assume them.
- The documented Hasura engine default in the config schema is `v2.48.10-ce`; Constellation docs compare against Hasura `v2.50.3-ce`. Pin versions explicitly in `nhost.toml` and write them in the decision log.
