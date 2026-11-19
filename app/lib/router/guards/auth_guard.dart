import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/deep_links/public_destination.dart';
import 'package:app/router/pending_route.dart';
import 'package:auto_route/auto_route.dart';

/// Keeps signed-out people out of pages that need a session and remembers
/// where they were going, so sign-in can take them there.
class AuthGuard({
  required final AuthenticationRepository _authentication,
  required final PendingRoute _pending,
}) extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (publicRouteNames.contains(resolver.routeName) || _authentication.isAuthenticated) {
      return resolver.next();
    }

    final destination = resolver.pendingRoutes.lastOrNull ?? resolver.route;
    if (destination.name != HomeRoute.name && !publicRouteNames.contains(destination.name)) {
      _pending.stash(destination.stringMatch);
    }
    unawaited(router.push(const SignInRoute()));
    resolver.next(false);
  }
}
