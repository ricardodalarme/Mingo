import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/pending_route.dart';
import 'package:auto_route/auto_route.dart';

/// Pages a signed-out person may open, and the routes the app lands on itself.
const Set<String> publicRouteNames = {
  WelcomeRoute.name,
  IntroPhaseRoute.name,
  IntroGoalsRoute.name,
  IntroThemeRoute.name,
  FirstSlipRoute.name,
  PartnerStepRoute.name,
  SignInRoute.name,
  ExistingAccountRoute.name,
  DebugSignInRoute.name,
  SessionExpiredRoute.name,
  NotFoundRoute.name,
  SettingsHomeRoute.name,
  SettingsThemeRoute.name,
  LanguageRoute.name,
  HelpRoute.name,
  SupportRoute.name,
};

/// Keeps signed-out people out of pages that need a session and remembers
/// where they were going, so sign-in can take them there.
class AuthGuard({
  required final AuthenticationRepository _authentication,
  required final PendingRoute _pending,
}) extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (publicRouteNames.contains(resolver.routeName) || _authentication.isAuthenticated) {
      resolver.next();

      return;
    }

    _pending.stash(resolver.route.stringMatch);
    unawaited(router.push(const SignInRoute()));
    resolver.next(false);
  }
}
