# Testing the Nhost backend

The proof lives at the GraphQL layer, where the authorization is. A change is not done until a test proves it.

## Layers

1. **Clean replay.** `nhost/tools/reset.sh` must succeed from nothing, with migrations, metadata and seeds. Run it before every commit that touches
   `nhost/`. Check `nhost config validate` for every overlay too.
2. **Permission and privacy matrix (the core).** For every table, function and subscription, and for each actor (owner, partner, stranger, ex-partner, solo
   user, anonymous `public`), assert exactly what is allowed and denied for select, insert, update, delete and function calls. Include the cases that leak:
   relationships that join to private rows, computed fields, aggregates, mutation `returning`, `on_conflict` upserts, presets that must override client
   input, an update that tries to move a row to another scope, subscriptions. Each rule in `AGENTS.md` ("whoever produces data decides who sees it", "never
   score the relationship", "no partner activity history", "safety content stays on the device") gets at least one test that would fail if it broke.
3. **Function and trigger tests.** SQL functions: valid and invalid inputs, authorization failures, limits, retention. Call them through GraphQL as the role,
   and with SQL for internals.
4. **Functions and events.** Unit-test handlers (input validation, idempotency, secret check, outcomes) with mocks for third parties; integration-test the
   delivery locally (insert a row, see the handler run; replay the event, see no duplicate effect). Check the logs with `nhost logs`.
5. **Contract snapshots.** For each role, `nhost/tools/dump-schemas.sh` writes `nhost/schema/<role>.graphqls`; commit them. The diff of a pull request is the
   contract change; review it like code.
6. **Engine parity gate.** If Constellation is enabled: dump each role from Hasura and Constellation and run `nhost/tools/schema-diff.sh`; every difference
   must be listed in `.work/nhost-docs/constellation/KNOWN_DIFFERENCES.md` or be fixed. Then run layers 2 to 4 against both endpoints; behavior that differs
   (error format, subscriptions, computed fields) goes in `decisions.md`.
7. **Performance.** `EXPLAIN (ANALYZE, BUFFERS)` the hot queries (Today, lists, shared tables) as a non-admin role on seeded data of realistic size; check that
   every column used by a permission filter or foreign key is indexed. Compare admin versus role timing (JIT note in `references/graphql-and-permissions.md`).

## How to act as a user in tests

- Real flow: sign up or sign in test users through the local Auth service and use their access tokens. Use it for end-to-end tests and for token-lifetime,
  claims and refresh behavior.
- Fast matrix: Hasura accepts the admin secret together with `x-hasura-role` and `x-hasura-user-id` headers to run a request as any role and user. Confirm it
  on the local stack for both engines before building on it. Use real tokens for checks that depend on claims.

## Tooling

- Backend: TypeScript with the Node test runner under `nhost/tests/<domain>/` (same domains as `nhost/tools/spec/`), no dependencies; `lib.ts` creates people, pairs them, runs GraphQL as a role and asserts
  allowed/denied/exact rows. `cd nhost && npm test` runs the suite.
- Functions: TypeScript with the Node test runner next to the code in `functions/<feature>/_tests/`; `cd functions && npm test`.
- The suite reads the local endpoints and the admin/webhook secrets from `.secrets`; it never runs against cloud.

## CI

`.github/workflows/nhost.yml` starts the stack from migrations, metadata and seeds, runs the Functions unit tests and the backend suite, regenerates the
metadata and role schemas, and fails on `git diff --exit-code`. The parity gate is local because Constellation and the test stack both need Docker.

## Done means

Clean replay green, matrix green, snapshots current, parity gate clean or explained, no `.only`/skipped tests, and the commit message names what the tests prove.
