# GraphQL and permissions

Read `.work/nhost-docs/docs/products/graphql/` and the Constellation files listed in `SKILL.md` before designing anything. Hasura v2 authors
the metadata; Constellation reads the same metadata next to Hasura. Design to the **overlap** and mark anything that only works on one engine.

## Authorization model

- Permissions are enforced by the engine, per role and per table, for select, insert, update and delete. Zero trust: only `admin` has
  access until you grant it. A request resolves **one** role: the user's default role, or the `x-hasura-role` header if it is in the user's
  allowed roles. Unauthenticated requests use `public`.
- Building blocks: select `columns` + `filter` (+ `allow_aggregations`, `computed_fields`); insert `columns` + `check` + `set` (presets);
  update `columns` + `filter` + `check` + `set`; delete `filter`. Use `set` presets for server-owned columns (`author_id`, owner, couple)
  so the client can never send them. Use `check` on update to stop a row from being moved into someone else's scope.
- Session variables: `X-Hasura-User-Id`, `X-Hasura-Role`, and custom claims. **Claims are computed when the token is issued** (15 min by
  default), so never use a claim alone for a rule that must take effect immediately (unpairing, account deletion, revoking a guest link):
  filter through the database (a relationship to the membership table) instead. Claims are fine for rules that tolerate staleness.
- Relationship-based filters (`{ couple: { members: { user_id: { _eq: X-Hasura-User-Id } } } }`) are the main membership tool. Index every
  column they touch. If a role's queries are slow only for non-admin roles, test with Postgres JIT disabled.
- Permission filters are the privacy layer the product rules talk about. Every rule in `AGENTS.md` gets a test at the GraphQL layer, per role
  (`references/testing.md`).

## Writes: permissions first, functions last

1. Who produces the row, who may read it (owner only, owner + partner, couple, public by token), who may change it.
2. If a permission (`filter`/`check`/`set`) expresses it, the table needs **no** function: the client uses plain insert/update/delete mutations.
3. If the write needs several steps, a lookup permissions cannot express, a rate limit or a state machine, write a tracked SQL function.

## SQL functions as API

- A tracked function becomes a query (`STABLE`/`IMMUTABLE`) or a mutation (`VOLATILE`); `exposed_as` overrides it. It must return a tracked table
  or view type, or `SETOF` one. A function that returns a scalar or JSON needs a result type: define a table for it. Do not use Actions (not served
  by Constellation).
- Function permissions are set per role, explicitly. Constellation never infers them; `inferFunctionPermissions = false` makes Hasura behave the same.
  The caller also needs select permission on the returned table; row and column permissions of that table apply to the result.
- `session_argument` receives the session variables as JSON; read `session ->> 'x-hasura-user-id'`. No permission applies to the function's inputs or
  what it does internally, so authorization inside the function is your job.
- **Rows a function creates are not visible to permission filters or relationships in the same statement.** Return a type whose permission is a
  plain column check, or a result payload built inside the function. Examples in this repo: `acceptInvite`, `unpair` and `resolveSharedItems` return
  the caller's profile; `prepareCard` returns `preparedCards` with its items.
- Single-row functions (`RETURNS <table>`) have no `where`, `limit`, `order_by` or `_aggregate` on Constellation. Arguments without a default are
  non-null on Constellation and nullable on Hasura; the schema diff shows it.
- No client-visible error codes: Hasura hides `raise exception` text and Constellation sanitizes database errors. Every precondition is readable state
  (`plusStates`), functions return no row when an action does not apply, and triggers use `private.reject(code)` only for races or abuse.

## Computed fields

Table-owned computed fields call a `STABLE`/`IMMUTABLE` function that takes the table row and optionally a session argument, returning a scalar or
`SETOF` a tracked table (`docs/products/graphql/computed-fields.mdx`).

```sql
create function public.slip_is_mine(slip_row public.slips, session json)
returns boolean language sql stable as $$
  select slip_row.author_id = (session ->> 'x-hasura-user-id')::uuid
$$;
```

- Scalar fields are enabled per role in the select permission; table-returning fields follow the returned table's permissions and must **not** be listed.
  Extra arguments go under an `args` input.
- Constellation serves computed fields since 0.8.0, partially: scalar and table selections, aggregates, argument-free filters and ordering. Custom
  argument types are passed as strings, invalid definitions are dropped as inconsistencies. Hasura authors the metadata, so after every change dump
  each role's schema from both engines and check the field exists.

## Enums

Closed value sets must reach the client as GraphQL enums. Use an **enum table** (`is_enum: true`, one primary-key column): the engine exposes a GraphQL
enum without any role permission on the table, and adding a value is an insert. This repo creates them with `private.create_enum` in migrations and
tracks them in `spec/enums.mjs`. Do not rely on native Postgres enums unless a test proves the GraphQL enum on both engines.

## Naming

Hasura's default is snake_case; this app uses camelCase. It is produced per table with `configuration.custom_name`, `custom_root_fields` and per-column
`column_config.<col>.custom_name` (Constellation honors all of them). Root fields are mechanical: `slips`, `slipsByPk`, `insertSlipsOne`, `updateSlipsByPk`,
`updateSlipsMany`, `deleteSlipsByPk`. `naming_convention` is ignored by Constellation; do not use it.

## Relationships and files

Foreign-key relationships are inferred from constraints; use `manual_configuration` for views and couple membership. Link rows to files with a real FK to
`storage.files(id)` and track the relationship, so a query returns the file metadata with the row (`references/storage.md`). Remote relationships cannot be
selected in subscriptions on Constellation.

## Reads, pagination, aggregates

The engine offers `where`, `order_by`, `limit`, `offset`, `distinct_on`, `_by_pk`, `_aggregate` (when `allow_aggregations`) and `on_conflict` upserts. There
are no Relay connections or opaque cursors: page with `order_by` + `limit`/`offset` or keyset `where`, and ask for one row more than the page to know whether
another page exists. A select permission `limit` is **not enforced by Constellation**: cap rows in queries and, where it matters, in a function.

## Subscriptions

WebSocket `graphql-transport-ws` on `/v1/graphql`, under the same permissions. One top-level field per subscription. Constellation polls
(`subscriptionPollInterval`, default 1 s) and shares a poller for identical query shapes across sessions: two clients with the same subscription shape do
not both receive updates. Hasura also polls (`liveQueriesMultiplexedRefetchInterval`, default 1000 ms). Treat subscriptions as an addition to the API, not
as a notification channel, and test that a partner or an ex-partner cannot subscribe to anything private.

## Engine strategy

- Hasura is always deployed (it authors metadata and runs events, cron and Actions). Constellation is enabled with
  `[experimental.constellation] version = "<latest in changelogs/constellation.md>"`; endpoints are `<sub>.graphql.<region>.nhost.run` (Constellation) and
  `<sub>.hasura.<region>.nhost.run` (Hasura). Removing the block returns to Hasura.
- Not served by Constellation (silently ignored, never rejected): Actions, event and cron triggers, REST endpoints, allowlists, query collections, inherited
  roles, native queries, API limits, per-role introspection settings, select permission `limit`, `query_root_fields`, `backend_only`, `validate_input`,
  `pool_settings`, `naming_convention`. Avoid or isolate every one of them.
- Gate: for each role (`public`, `user`, any custom role) run `nhost schema dump --role <r>` against both engines and `nhost schema diff`; every difference
  must be in `KNOWN_DIFFERENCES.md` or be fixed. Keep the dumps as the contract snapshots (`references/testing.md`).
- This app targets Hasura today; the metadata avoids Hasura-only features so a switch is a configuration change. `_exists` is used once (spice gating) and
  is supported by Constellation.
