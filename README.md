# Mingo

A small app for couples. Each person quietly saves good things the partner did ("slips"); Mingo turns them into a weekly
Sunday card, helps repair after a fight, and keeps dates and memories. Portuguese (pt-BR) first, English second.

The repo is a Flutter monorepo (Melos + pub workspaces): the app in `app/`, shared packages in `packages/`, the backend in
`nhost/` (Postgres, GraphQL through Hasura, Auth, Storage and Functions).

## Identifiers

| Thing | Value |
| --- | --- |
| Dart package | `mingo` |
| Android application id | `dev.dalarme.mingo` (development: `dev.dalarme.mingo.dev`) |
| iOS bundle ids | `dev.dalarme.mingo`, `.dev`, `.widgets`, `.dev.widgets` |
| App group | `group.dev.dalarme.mingo` |
| Deep-link scheme | `mingo` |
| Firebase projects | `mingo-app-dev`, `mingo-app-prod` |
| Nhost project | `Mingo` (subdomain `vukuojqsudvjfwowyped`, region `sa-east-1`) |

## Setup

### Pre-requirements

Install the latest stable [Flutter SDK](https://docs.flutter.dev/get-started/install), then check the platform toolchain:

```bash
flutter doctor
```

### Melos

[Melos](https://github.com/invertase/melos) manages the packages in this workspace.

```bash
dart pub global activate melos
```

### Bootstrap

Installs dependencies and the Git hooks.

```bash
melos bootstrap
```

## Running

```bash
cd app && flutter run --dart-define-from-file ../.env.development --flavor development
```

Or pick a device and press F5 in VS Code / the run button in Android Studio.

## Commands

| Command | What it does |
| --- | --- |
| `melos get` | `flutter pub get` in every package |
| `melos gen` | Codegen for routes, GraphQL and assets |
| `melos l10n` | Generate the app and design-system translations |
| `melos lint` | `flutter analyze` plus the format check |
| `melos test` | Tests for every package |
| `cd app && flutter test test/path_test.dart` | One test file |

## Backend

- **Nhost** — Postgres, Hasura GraphQL, Auth, Storage and Functions live in [`nhost/`](nhost/) and [`functions/`](functions/).
  The app reads through the GraphQL contract in `nhost/schema/user.graphqls`; the local stack runs with `nhost/tools/up.sh`.
- **Firebase** — analytics, crash reporting, performance, remote config and messaging. Client configs are committed per
  flavor under `app/android/app/src/{development,production}` and `app/ios/config/{development,production}`.

## Conventions

Architecture, product rules and working agreements are in [`AGENTS.md`](AGENTS.md).
