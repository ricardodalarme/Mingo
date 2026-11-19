---
name: routing
description: Adds pages and navigation with auto_route in this app. Covers annotating pages with @RoutePage, registering routes and the four-tab Home shell in app_router.dart, the global AuthGuard and its public-route allowlist, page arguments, root routing by app state and widget deep links, and regenerating routes. Use when creating a screen or route, navigating between pages, adding a tab, passing a page argument, making a page reachable while signed out, or touching deep links.
---

# Routing

Navigation is type-safe auto_route. `app/lib/router/app_router.dart` is hand-written (`AppRouter extends RootStackRouter`, the
`routes` list); `app_router.gr.dart` is generated, committed and never edited. Codegen scans only
`lib/features/**/presentation/**.dart` (`app/build.yaml`), so a page outside that tree gets no `XRoute`. Import route classes from
`package:app/router/app_router.dart`, which re-exports the generated file. There is one router and one
`@AutoRouterConfig`; never use `Navigator.push` or `MaterialPageRoute`.

General auto_route behavior (push, replace, navigate, pop, nested routers, transitions) is documented upstream; this file covers
only what is specific to this app.

## Adding a page

1. Annotate the page `@RoutePage()`, declare its arguments in the primary constructor, and implement `AutoRouteWrapper` when it
   owns a cubit (`wrappedRoute` creates it; see `new-feature`).
2. Add `AutoRoute(page: XRoute.page)` to `AppRouter.routes`. Nearly every page is a flat root route; `HomeRoute` is first with
   `path: '/'` and holds the tabs as children, and `NotFoundRoute` is last with `path: '*'`. Keep that order: the matcher keeps every
   earlier route that is a prefix of the path, so Home first is what puts Home under any page opened from a link.
3. Run `melos gen`. The generated class is `<PageClassWithoutPage>Route`.
4. Navigate with `context.pushRoute(XRoute(...))`, which covers almost all forward navigation in the app. `context.router.push`
   is for a nested stack; `context.router.replaceAll([...])` resets the stack.

A page cubit takes no runtime arguments, so a route argument stays on the page and is passed into cubit methods.

### Arguments

| Kind | Declaration | Example |
| --- | --- | --- |
| Path | `@PathParam('id') required final String id` | `SlipDetailPage` |
| Query, optional or defaulted | `@QueryParam('kind') final String kind = 'specific'` | `SlipKindPage`, `RitualEditPage` |
| Typed object or enum | an unannotated constructor parameter | in-app only; cannot come from a deep link |

Prefer an id plus a fetch over passing a whole model, so the page works from a deep link and after a process restart.

## The Home shell

`HomePage` (`features/home/presentation/home/home_page.dart`) is an `AutoTabsRouter` with four tabs, **Today, Slips, Together,
Memories**, and a capture button between the second and third that pushes `QuickSlipRoute` on the root router. A tab is three
things that must stay in the same order: the child `AutoRoute` under `HomeRoute` in `app_router.dart`, the entry in `HomePage`'s
`AutoTabsRouter.routes`, and its icon and label (`homeTabIcons` and the `tabs` l10n keys). The capture index (`_captureIndex`)
sits in the tab bar but is not a tab route. A page inside a tab must not add the bottom or keyboard inset again: `HomePage`
and `BaseTabBar` own them.

## Signed-out access

`AuthGuard` (`router/guards/auth_guard.dart`) is a global guard that runs for every route of a stack, in order. A signed-out person
can open only the routes in `publicRouteNames` (welcome, the onboarding steps, sign-in, existing account, debug sign-in, session
expired, not found). Any other route stops the navigation, the last pending route (the real destination, not Home) is stashed in
`PendingRoute`, the person is sent to `SignInRoute`, and sign-in resumes the stashed path. The guard never stashes Home or a public
route.

- A page that must work signed out (a new onboarding step, say) needs `meta: publicRouteMeta` on its `AutoRoute`, or the guard redirects it; `test/router/app_router_test.dart` pins the full list.
- Do not check authentication inside a page; leave it to the guard.

## Root routing and deep links

- `AppCubit` holds the app state, and `routeForAppState` (`features/app/presentation/navigation/app_state_navigator.dart`) maps it to
  the root route (onboarding, sign-in, home). `AppStateNavigator` replaces the stack with `replaceAll` when the state changes,
  except when Home is already in the stack (a cold start link already built it). Add a new app-level state there, not as a
  navigation call from a feature.
- A link is matched by path. `transformDeepLinkUri` rewrites `mingo://<host>/<path>` into `/<host>/<path>`, so a link host is just a
  route path: `mingo://card` is `/card`. With prefix matching on (the default on mobile), a page opened from a link gets Home under
  it for free, on a cold start and while the app runs, and the link pops to the existing Home instead of rebuilding it.
- To make a page reachable from a link, give its route an explicit short `path:` (the generated default is ugly, like
  `/sunday-card-route`). A route whose path is also a prefix of a deeper sibling (`/card` and `/card/:id`) needs `fullMatch: true`,
  or the shallow page is pushed under the deeper one. A tab is a child path of Home (`/slips`, `/couple`); an alias is a
  `RedirectRoute` (`/together` to `/couple`).
- A link that needs more than a path (the invite code) is a `DeepLinkHandler` in `router/deep_links/`: `resolve(uri)` returns a
  page stack or null, and `DeepLinkResolver` asks the handlers in order. Register handlers in `AppInjectionModule`. A handler
  returns the stack only; the guard does the signed-out redirect and resume.
- `App._deepLinkBuilder` runs the resolver, then lets the platform link through. A plain `/` launch uses the root route for the app
  state; a link whose destination is a public page drops the Home prefix, because the guard would block Home first. Widget taps
  go through `navigatePath(..., includePrefixMatches: true)`, never `replaceAll`.
- Widgets send `mingo://<host>?src=widget`. The hosts in `MingoLink.swift` and `MingoLink.kt` must match each other and open a
  route; `test/router/app_router_test.dart` reads both files and fails on drift.
- Router observers (`router/observers/`: logging and analytics) are lazy singletons in `shared_injection_module.dart` and are wired
  in `app.dart`. Add a new observer there, never inside a page.

## Gotchas

- "Undefined name XRoute" means `melos gen` has not run since the page or `AutoRoute` was added.
- Home's empty path redirects to `today` (`RedirectRoute`); removing that redirect breaks the stack at startup.
- `pushPath`, `navigatePath` and `replacePath` default to no prefix matching, `DeepLink.path` and platform links default to it.
- An unknown link path reaches `NotFoundRoute` through `*`; without it the initial route cannot resolve and the app throws.
- `wrappedRoute` returns the provider wrapping `this`, not a rebuilt page.
- Never edit `*.gr.dart`, and do not create a second router config.
