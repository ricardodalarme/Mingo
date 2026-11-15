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

  test('authenticated deep links resolve to today, card, dates, and discreet settings', () {
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

    final discreetRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://settings/discreet'),
      appState: AppState.authenticated,
    );
    expect(discreetRoutes!.last.routeName, DiscreetModeRoute.name);

    final togetherRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://together?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(togetherRoutes!.first.initialChildren?.first.routeName, TogetherRoute.name);

    final memoriesRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://memories?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(memoriesRoutes!.first.initialChildren?.first.routeName, MemoriesRoute.name);

    final inviteRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://invite?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(inviteRoutes!.last.routeName, InviteRoute.name);
  });

  group('invite code parsing', () {
    test('reads the code from the custom scheme path', () {
      expect(inviteCodeFromUri(Uri.parse('mingo://invite/abcd2345')), 'ABCD2345');
    });

    test('reads the code from the custom scheme query', () {
      expect(inviteCodeFromUri(Uri.parse('mingo://invite?code=abcd2345')), 'ABCD2345');
    });

    test('reads the code from an https path and query', () {
      expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite/abcd2345')), 'ABCD2345');
      expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite?code=abcd2345')), 'ABCD2345');
    });

    test('ignores a trailing slash and surrounding spaces', () {
      expect(inviteCodeFromUri(Uri.parse('mingo://invite/abcd2345/')), 'ABCD2345');
      expect(inviteCodeFromUri(Uri.parse('mingo://invite/%20abcd2345%20')), 'ABCD2345');
    });

    test('a link without an invite target or code has no code', () {
      expect(inviteCodeFromUri(Uri.parse('mingo://today?homeWidget=1')), isNull);
      expect(inviteCodeFromUri(Uri.parse('mingo://invite')), isNull);
      expect(inviteCodeFromUri(Uri.parse('https://mingo.app/invite?code=')), isNull);
    });
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
