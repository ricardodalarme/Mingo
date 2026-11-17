# GraphQL and permissions

Read `.work/nhost-docs/docs/products/graphql/` before designing anything. Hasura v2 serves the GraphQL API and authors the metadata.

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
  or view type, or `SETOF` one. A function that returns a scalar or JSON needs a result type: define a table for it. Prefer a tracked function to an Action.
- Function permissions are set per role, explicitly; `inferFunctionPermissions = false` keeps Hasura from inferring them.
  The caller also needs select permission on the returned table; row and column permissions of that table apply to the result.
- `session_argument` receives the session variables as JSON; read `session ->> 'x-hasura-user-id'`. No permission applies to the function's inputs or
  what it does internally, so authorization inside the function is your job.
- **Rows a function creates are not visible to permission filters or relationships in the same statement.** Return a type whose permission is a
  plain column check, or a result payload built inside the function. Examples in this repo: `acceptInvite`, `unpair` and `resolveSharedItems` return
  the caller's profile; `prepareCard` returns `preparedCards` with its items.
- No client-visible error codes: Hasura hides `raise exception` text. Every precondition is readable state
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

## Enums

Closed value sets must reach the client as GraphQL enums. Use an **enum table** (`is_enum: true`, one primary-key column): the engine exposes a GraphQL
enum without any role permission on the table, and adding a value is an insert. This repo creates them with `private.create_enum` in migrations and
tracks them in `spec/enums.mjs`. Do not rely on native Postgres enums unless a test proves the GraphQL enum.

## Naming

Hasura's default is snake_case; this app uses camelCase. It is produced per table with `configuration.custom_name`, `custom_root_fields` and per-column
`column_config.<col>.custom_name`. Root fields are mechanical: `slips`, `slipsByPk`, `insertSlipsOne`, `updateSlipsByPk`,
`updateSlipsMany`, `deleteSlipsByPk`. Do not use `naming_convention`; the app's names come from the custom names above.

## Relationships and files

Foreign-key relationships are inferred from constraints; use `manual_configuration` for views and couple membership. Link rows to files with a real FK to
`storage.files(id)` and track the relationship, so a query returns the file metadata with the row (`references/storage.md`).

## Reads, pagination, aggregates

The engine offers `where`, `order_by`, `limit`, `offset`, `distinct_on`, `_by_pk`, `_aggregate` (when `allow_aggregations`) and `on_conflict` upserts. There
are no Relay connections or opaque cursors: page with `order_by` + `limit`/`offset` or keyset `where`, and ask for one row more than the page to know whether
another page exists. A select permission `limit` caps the rows a role can read; queries still pass their own `limit`.

## Subscriptions

WebSocket `graphql-transport-ws` on `/v1/graphql`, under the same permissions. One top-level field per subscription. Hasura polls
(`liveQueriesMultiplexedRefetchInterval`, default 1000 ms) and multiplexes subscriptions with the same shape into one query. Treat subscriptions as an
addition to the API, not as a notification channel, and test that a partner or an ex-partner cannot subscribe to anything private.
