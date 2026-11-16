import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/mappers/invite_code_mapper.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/pending_route.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

/// Intercepts `mingo://<host>/<path>` deep links before AutoRoute matches them and
/// normalizes the custom-scheme host + path into a canonical `/target` path.
Future<Uri> transformWidgetDeepLinkUri(Uri uri) {
  if (uri.scheme != 'mingo') return SynchronousFuture(uri);
  final target = _extractNormalizedTarget(uri);
  final normalizedPath = target.isEmpty ? '/today' : '/$target';
  final updatedQuery = <String, String>{
    ...uri.queryParameters,
    'homeWidget': uri.queryParameters['homeWidget'] ?? '1',
  };
  return SynchronousFuture(
    uri.replace(host: '', path: normalizedPath, queryParameters: updatedQuery),
  );
}

/// Resolves `mingo://` or normalized `?homeWidget=` deep-link URIs to auto_route page stacks.
///
/// When the user is signed out, every widget tap opens the sign-in flow.
List<PageRouteInfo<void>>? resolveWidgetDeepLinkUri(Uri? uri, {required AppState appState}) {
  if (uri == null) return null;
  final isWidgetUri = uri.scheme == 'mingo' || uri.queryParameters.containsKey('homeWidget');
  if (!isWidgetUri) return null;

  if (appState != AppState.authenticated) {
    return [const WelcomeRoute(), const SignInRoute()];
  }

  final target = _extractNormalizedTarget(uri);

  return switch (target) {
    'sign-in' || 'signin' => [const WelcomeRoute(), const SignInRoute()],
    'today' || '' => [
      const HomeRoute(children: [TodayRoute()]),
    ],
    'together' || 'juntos' => [
      HomeRoute(children: [CoupleRoute()]),
    ],
    'memories' || 'memorias' => [
      HomeRoute(children: [CoupleRoute(section: CoupleSection.memories)]),
    ],
    'card' || 'cards' => [
      const HomeRoute(children: [TodayRoute()]),
      const SundayCardRoute(),
    ],
    'dates' => [
      HomeRoute(children: [CoupleRoute()]),
      const DatesRoute(),
    ],
    'capture' || 'slip' => [
      const HomeRoute(children: [TodayRoute()]),
      const QuickSlipRoute(),
    ],
    'mood' => [
      const HomeRoute(children: [TodayRoute()]),
      MoodRoute(),
    ],
    'rituals' => [
      HomeRoute(children: [CoupleRoute()]),
      const RitualsRoute(),
    ],
    'jar' || 'slips' => [
      const HomeRoute(children: [SlipsRoute()]),
    ],
    'invite' => [
      const HomeRoute(children: [TodayRoute()]),
      const InviteRoute(),
    ],
    'widgets' => [
      const HomeRoute(children: [TodayRoute()]),
      const WidgetsGalleryRoute(),
    ],
    _ => [
      const HomeRoute(children: [TodayRoute()]),
    ],
  };
}

String _extractNormalizedTarget(Uri uri) {
  final host = uri.host.toLowerCase().trim();
  final rawPath = uri.path.toLowerCase().trim();
  final trimmedPath = rawPath.replaceFirst(RegExp('^/+'), '').replaceFirst(RegExp(r'/+$'), '');
  if (host.isEmpty) return trimmedPath;
  if (trimmedPath.isEmpty) return host;
  return '$host/$trimmedPath';
}

/// Resolves an invite link to its pages, keeping the code for a signed-out person.
List<PageRouteInfo>? resolveInviteDeepLinkUri(
  Uri uri, {
  required AppState appState,
  required InviteCodeStore inviteCodes,
  required PendingRoute pending,
}) {
  final code = inviteCodeFromUri(uri);
  if (code == null) return null;

  if (appState != AppState.authenticated) {
    unawaited(inviteCodes.save(code));
    pending.stash(acceptInvitePath);

    return [const WelcomeRoute(), const SignInRoute()];
  }

  return [
    const HomeRoute(children: [TodayRoute()]),
    AcceptInviteRoute(code: code),
  ];
}
