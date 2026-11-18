# Functions, Run and Events

Docs: `.work/nhost-docs/docs/products/functions/`, `docs/products/events/`, `docs/products/run/`, `docs/platform/cloud/secrets.mdx`, `docs/reference/kriti.mdx`.

## Choose the runtime

| Need | Use |
| --- | --- |
| Short HTTP handler, webhook receiver, glue code in JavaScript or TypeScript | **Function**: a `.ts` file in `functions/` is an endpoint at `https://<sub>.functions.<region>.nhost.run/v1/<path>` (Express `req`/`res`; files and folders starting with `_` are not exposed) |
| Native dependencies, another language, long-running or streaming work, a custom image | **Nhost Run** service (any container, configured by a TOML file, run locally with `nhost up --run-service <file>`) |
| React to a row change | **Event trigger** (insert, update, delete, manual; payload has old and new row and the session variables) |
| Run on a schedule | **Cron trigger** (UTC cron expression, custom payload, `tolerance_seconds`) |
| Run once at a time that is only known at runtime (reminder, expiry, undo window, deferred deletion) | **One-off scheduled event** |

Function limits: JavaScript or TypeScript only, native addons stripped; execution timeout 10 s Starter, 180 s Pro, 600 s Teams; request and response bodies
6 MB. Node 24 via `[functions.node] version`. The runtime requires a committed lockfile even with zero dependencies.

Functions get these variables: `NHOST_ADMIN_SECRET`, `NHOST_WEBHOOK_SECRET`, `NHOST_JWT_SECRET`, `NHOST_SUBDOMAIN`, `NHOST_REGION`, `NHOST_HASURA_URL`,
`NHOST_AUTH_URL`, `NHOST_GRAPHQL_URL`, `NHOST_STORAGE_URL`, `NHOST_FUNCTIONS_URL`, plus your own environment variables and secrets.

## Events

- Defined as metadata (`nhost/metadata/databases/default/tables/*.yaml` under `event_triggers`, `nhost/metadata/cron_triggers.yaml`), delivered as HTTP
  requests to `{{NHOST_FUNCTIONS_URL}}/...` or any URL, with retries (`retry_conf`: event triggers use `interval_sec` and `timeout_sec`, cron triggers use
  `retry_interval_seconds` and `timeout_seconds`) and custom headers. One-off events are created from the dashboard or the Hasura metadata API
  (`create_scheduled_event`); they do not support transformations.
- Delivery is at least once: every handler must be idempotent (use the event `id` or your own key, and a unique constraint).
- Always send the shared secret header (`nhost-webhook-secret: {{ NHOST_WEBHOOK_SECRET }}` via `value_from_env`) and verify it in the handler
  (`docs/products/events/guides/webhook-security.mdx`). A public function without it is an open door.
- Request and payload transformations use Kriti templates (`reference/kriti.mdx`).
- Events, cron triggers and Actions are executed by Hasura.

## This backend

- `events/push.ts`: claims a `private.notifications` row, sends a data-only FCM v1 message and settles it; `events/jobs.ts` runs the scheduled SQL jobs and
  retries queued file deletions; `events/delete-file.ts` deletes the Storage object and clears the queue; `purchases/` applies RevenueCat events; `chat/`
  streams the mascot reply as SSE (the prompts are in `chat/_prompts/`, one file per piece with its text in both languages); `export/` builds the data export. Each feature is a folder (`index.ts` is the route) with its helpers and tests under
  underscore names (`_relay.ts`, `_tests/`), which the runtime never routes; a helper without the underscore would become an endpoint. Code shared by
  several features lives in `functions/_lib/`.
- Function code conventions: every route is `export default handler({ method, guard }, run)` from `_lib/handler.ts`, which answers the wrong method,
  a caller the guard refuses and a throw (logged, then 500), so a route holds only its own logic. GraphQL documents are typed `operation<Data, Variables>()`
  values in the feature's `_operations.ts`, run with `asAdmin` or `asCaller`; payloads from outside (triggers, webhooks) are parsed with valibot
  schemas, never cast. Error codes are the `ErrorCode` union in `_lib/http.ts`, each tied to one status; environment variables go through `_lib/env.ts`
  (`requireEnv` fails with a clear error); timeouts and limits are named constants in `_lib/config.ts` or at the top of the file that owns them; log with
  `log.info`, `log.warn` or `log.error`, which sets the level the platform records. Relative imports end in `.ts`. `pnpm check` runs the typecheck, Biome
  and the tests; handler tests stub `fetch` with the helpers in `_lib/_testing.ts`.
- Streams from Functions are not documented. SSE was verified on the local stack (first byte ~100 ms, deltas in step with the upstream, no buffering); if a
  future runtime buffers or times out, move the chat to a Run service and record the decision.

## Calling the backend from code

Functions and Run services talk to GraphQL as admin with the admin secret and the internal URLs (`NHOST_GRAPHQL_URL`, `NHOST_HASURA_URL`), or as the user by
forwarding the caller's `Authorization` header so permissions still apply. Prefer acting as the user whenever the action is the user's; use admin only for
system work (notifications, entitlements, cleanup). The Nhost JS SDK is documented in `docs/products/functions/guides/nhost-sdk.mdx`; verifying a caller's JWT
is in `jwt-verification.mdx`.

## Rules

- A function validates its input, returns stable outcomes, logs without secrets and has a test (`references/testing.md`).
- Anything that writes on behalf of the system uses the admin secret inside the function only; the secret never reaches the app.
- Cron and one-off times are UTC. Convert from the user's time zone in code and test day boundaries.
- Retry and timeout values are part of the design: write them next to each trigger and say what happens when the final retry fails.
