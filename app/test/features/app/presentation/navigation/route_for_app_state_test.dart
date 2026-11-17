import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/navigation/app_state_navigator.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a signed-in person starts on Home while the profile is still being checked', () {
    expect(routeForAppState(AppState.checking), isA<HomeRoute>());
  });

  test('a signed-in person with a finished profile goes to Home', () {
    expect(routeForAppState(AppState.authenticated), isA<HomeRoute>());
  });

  test('a signed-in person without a finished profile goes to the profile step', () {
    expect(routeForAppState(AppState.onboarding), isA<ProfileSetupRoute>());
  });

  test('a lost session shows the expiry page', () {
    expect(routeForAppState(AppState.sessionExpired), isA<SessionExpiredRoute>());
  });

  test('a signed-out person starts on Welcome', () {
    expect(routeForAppState(AppState.unauthenticated), isA<WelcomeRoute>());
  });
}
