# Nhost Auth

Docs: `.work/nhost-docs/docs/products/auth/` (`providers/idtokens.mdx`, `providers/sign-in-apple.mdx`, `providers/sign-in-google.mdx`, `jwt.mdx`,
`users.mdx`, `controlling-user-creation.mdx`), the `auth` section of `docs/reference/configuration/index.mdx`, and the REST API in
`.work/nhost-docs/api/auth.openapi.yaml`. Auth is a separate service (`<sub>.auth.<region>.nhost.run/v1`) with its own tables in the `auth` schema.

## Sign in with Apple and Google (native)

The app signs in with the platform SDKs and sends the provider's ID token to Auth: `POST /signin/idtoken` (and `/signup/idtoken`, `/link/idtoken`).
The Dart SDK exposes `signInIdToken(provider: 'apple' | 'google', idToken:, nonce:)` and `linkIdToken(...)`.

```toml
[auth.method.oauth.apple]
enabled = true
clientId = "..."          # Services ID for the web/redirect flow
teamId = "..."
keyId = "{{ secrets.APPLE_KEY_ID }}"
privateKey = "{{ secrets.APPLE_PRIVATE_KEY }}"
audience = "dev.dalarme.mingo,dev.dalarme.mingo.dev"

[auth.method.oauth.google]
enabled = true
clientId = "..."
clientSecret = "{{ secrets.GOOGLE_CLIENT_SECRET }}"
audience = "<ios client id>,<android/web client id>"
```

- `audience` **must** match the `aud` claim of the tokens the app sends (Apple: the app bundle id of each flavor; Google: the client id the SDK used).
  Without it ID-token sign-in is rejected. Verify field names against the config reference before writing them.
- Pass the `nonce` the app used when requesting the token. Apple returns the user's name only on the first sign-in: persist it right away.
- Keep provider credentials in secrets, never in `nhost.toml`. Providers without credentials stay disabled; the app maps `provider_not_configured` to
  the localized "not available" message.

## Per-environment methods

`nhost.toml` is production-like and overlays patch a single environment. Email/password is configured once and may be relaxed locally; verification and
HIBP stay on where the environment can send mail. Check with `nhost config show --subdomain <s>`. `auth.signUp` has `enabled`, `disableNewUsers` and
`disableAutoSignup`; with `disableAutoSignup` the app must call the explicit `/signup/*` endpoints.

## Roles, session and claims

- Every user has a default role (`user`) and allowed roles. This app has only `user` and `public`; the client picks `user` with the JWT and anonymous
  requests resolve to `public`. There is no `me` role.
- The access token (900 s) carries `x-hasura-user-id`, `x-hasura-default-role`, `x-hasura-allowed-roles` and custom claims; the refresh token lasts 30 days.
  Custom claims are computed at issuance: see the staleness rule in `references/graphql-and-permissions.md`.
- Custom claim example (path does not start with `user`):

```toml
[[auth.session.accessToken.customClaims]]
key = 'couple-id'
value = 'profile.couple_id'
default = '00000000-0000-0000-0000-000000000000'
```

## Users and profile bootstrap

- Do not create users through GraphQL, do not alter `auth.users`' schema, do not change the generated root fields for `auth` tables. You may add relationships,
  permissions and your own tables that reference `auth.users(id)`.
- Product profile data lives in `public.profiles`, keyed by `auth.users.id`; settings live in `public.user_settings`, and notification settings are created
  with the profile. A trigger on `auth.users` bootstraps them, so the app never creates a profile itself.
- Keep `display_name`, locale, time zone and onboarding state in the typed tables; do not use `auth.users.metadata` for data the app queries.

## Account deletion

The Auth REST API has no self-service delete endpoint. Account deletion is a public row: inserting `deletion_requests` ends the couple and schedules a purge;
deleting the row cancels. The `purge_accounts` job calls `private.erase_account`, which queues every file the person uploaded and deletes the `auth.users` row
with all cascades. Test that the token stops working (access tokens live up to 15 minutes) and that the partner loses access immediately.

## Rate limits and abuse

Auth has its own rate-limit table (`docs/platform/cloud/rate-limits.mdx`): sign-in/verify and sign-up endpoints 10 per 5 minutes per client IP, any endpoint
100 per minute, email and SMS 10 per hour. Configure `auth.rateLimit` for the app's real flows. Bot protection (Cloudflare Turnstile) is available in
`auth.signUp.turnstile` (`bot-protection.mdx`).

## Client contract

The app uses `nhost_auth_dart` behind `AuthenticationService`; the SDK owns token refresh and auth-state callbacks, and the session `Session.toJson()` is
persisted through `SecureStorageService`. `StorageService` receives the same `UserSession`, so uploads and downloads use the live token. Record Auth base URL,
the sign-in calls (ID token for Apple and Google), the session shape and the refresh behaviour in the handoff.
