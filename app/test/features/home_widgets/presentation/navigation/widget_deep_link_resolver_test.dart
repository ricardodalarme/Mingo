import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/widgets/presentation/navigation/widget_deep_link_resolver.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/pending_route.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeInviteCodeStore() implements InviteCodeStore {
  String? code;

  @override
  String? read() => code;

  @override
  Future<void> save(String value) async => code = value;

  @override
  Future<void> clear() async => code = null;
}

void main() {
  test('signed-out widget tap always resolves to WelcomeRoute + SignInRoute', () {
    final routes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://today?homeWidget=1'),
      appState: AppState.unauthenticated,
    );

    expect(routes, isNotNull);
    expect(routes!.last.routeName, SignInRoute.name);
  });

  test('authenticated deep links resolve to today, card and dates', () {
    final todayRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://today'),
      appState: AppState.authenticated,
    );
    expect(todayRoutes, isNotNull);
    expect(todayRoutes!.first.routeName, HomeRoute.name);

    final cardRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://card'),
      appState: AppState.authenticated,
    );
    expect(cardRoutes!.last.routeName, SundayCardRoute.name);

    final datesRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://dates'),
      appState: AppState.authenticated,
    );
    expect(datesRoutes!.last.routeName, DatesRoute.name);

    final togetherRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://together?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(togetherRoutes!.first.initialChildren?.first.routeName, CoupleRoute.name);

    final memoriesRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://memories?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(memoriesRoutes!.first.initialChildren?.first.routeName, CoupleRoute.name);

    final inviteRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://invite?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(inviteRoutes!.last.routeName, InviteRoute.name);
  });

  group('invite deep link', () {
    test('a signed-in person opens the accept page with the code', () {
      final routes = resolveInviteDeepLinkUri(
        Uri.parse('mingo://invite/abcd2345'),
        appState: AppState.authenticated,
        inviteCodes: _FakeInviteCodeStore(),
        pending: PendingRoute(),
      );

      expect(routes, isNotNull);
      expect(routes!.last.routeName, AcceptInviteRoute.name);
      expect((routes.last as AcceptInviteRoute).args?.code, 'ABCD2345');
    });

    test('a signed-out person keeps the code and goes to sign-in', () {
      final inviteCodes = _FakeInviteCodeStore();
      final pending = PendingRoute();

      final routes = resolveInviteDeepLinkUri(
        Uri.parse('mingo://invite/abcd2345'),
        appState: AppState.unauthenticated,
        inviteCodes: inviteCodes,
        pending: pending,
      );

      expect(routes!.map((route) => route.routeName), [WelcomeRoute.name, SignInRoute.name]);
      expect(inviteCodes.read(), 'ABCD2345');
      expect(pending.take(), acceptInvitePath);
    });

    test('a non-invite link is left to the other resolvers', () {
      final routes = resolveInviteDeepLinkUri(
        Uri.parse('mingo://today?homeWidget=1'),
        appState: AppState.authenticated,
        inviteCodes: _FakeInviteCodeStore(),
        pending: PendingRoute(),
      );

      expect(routes, isNull);
    });
  });
}
