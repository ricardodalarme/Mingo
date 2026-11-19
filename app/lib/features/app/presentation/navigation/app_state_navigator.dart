import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/utils/pending_route.dart';
import 'package:auto_route/auto_route.dart';

/// The root route an app state should show.
PageRouteInfo<void> routeForAppState(AppState state) => switch (state) {
  .authenticated || .checking => const HomeRoute(),
  .onboarding => const ProfileSetupRoute(),
  .sessionExpired => SessionExpiredRoute(),
  .unauthenticated => const WelcomeRoute(),
};

/// Turns app auth states into navigation without discarding the stack on expiry.
class AppStateNavigator({
  required final RootStackRouter _router,
  required final PendingRoute _pending,
  required final InviteCodeStore _inviteCodes,
}) {
  bool _expiryPresented = false;

  void onStateChanged(AppState previous, AppState current) {
    if (current == AppState.checking) return;

    if (current == AppState.sessionExpired) {
      if (_expiryPresented) return;
      _expiryPresented = true;
      unawaited(_router.push(SessionExpiredRoute()));
      return;
    }

    if (current == AppState.authenticated &&
        (previous == AppState.sessionExpired || _expiryPresented)) {
      _expiryPresented = false;
      unawaited(_returnToTheInterruptedPage());
      return;
    }

    if (current == AppState.unauthenticated && previous == AppState.authenticated) {
      _pending.clear();
    }

    _expiryPresented = false;
    unawaited(_show(routeForAppState(current)));
  }

  /// Replaces the stack with [route], reopening the page sign-in interrupted.
  Future<void> _show(PageRouteInfo<void> route) async {
    final interrupted = route is HomeRoute ? _pending.take() : null;
    final pendingInvite = route is HomeRoute ? _inviteCodes.read() : null;
    if (!(route is HomeRoute && _hasHome)) await _router.replaceAll([route]);
    if (interrupted != null) {
      await _router.pushPath(interrupted);

      return;
    }
    if (pendingInvite != null) await _router.push(AcceptInviteRoute(code: pendingInvite));
  }

  bool get _hasHome => _router.stack.any((page) => page.routeData.name == HomeRoute.name);

  Future<void> _returnToTheInterruptedPage() async {
    final interrupted = _pending.take();
    _router.popUntil(
      (route) =>
          route.settings.name != SessionExpiredRoute.name &&
          route.settings.name != SignInRoute.name,
    );
    if (interrupted != null) await _router.pushPath(interrupted);
  }
}
