import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/navigation/app_state_navigator.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/pending_route.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRouter() extends Mock implements RootStackRouter;

class _MockPage() extends Mock implements AutoRoutePage<dynamic>;

class _MockRouteData() extends Mock implements RouteData<dynamic>;

class _FakeRoute() extends Fake implements PageRouteInfo<Object?>;

class _FakeInviteCodeStore() implements InviteCodeStore {
  @override
  String? read() => null;

  @override
  Future<void> save(String value) async {}

  @override
  Future<void> clear() async {}
}

void main() {
  setUpAll(() {
    registerFallbackValue(<PageRouteInfo>[]);
    registerFallbackValue(_FakeRoute());
  });

  late _MockRouter router;
  late AppStateNavigator navigator;

  void stackOf(List<String> names) {
    final pages = <AutoRoutePage<dynamic>>[];
    for (final name in names) {
      final routeData = _MockRouteData();
      final page = _MockPage();
      when(() => routeData.name).thenReturn(name);
      when(() => page.routeData).thenReturn(routeData);
      pages.add(page);
    }
    when(() => router.stack).thenReturn(pages);
  }

  setUp(() {
    router = _MockRouter();
    navigator = AppStateNavigator(
      router: router,
      pending: PendingRoute(),
      inviteCodes: _FakeInviteCodeStore(),
    );

    when(() => router.replaceAll(any())).thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  test('keeps the stack a link built when Home is already in it', () async {
    stackOf([HomeRoute.name, DatesRoute.name]);

    navigator.onStateChanged(AppState.checking, AppState.authenticated);
    await pumpEventQueue();

    verifyNever(() => router.replaceAll(any()));
  });

  test('replaces the sign-in stack with Home once the person is signed in', () async {
    stackOf([WelcomeRoute.name, SignInRoute.name]);

    navigator.onStateChanged(AppState.checking, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.replaceAll(any())).called(1);
  });

  test('replaces the stack for a state that is not Home even when Home is in it', () async {
    stackOf([HomeRoute.name]);

    navigator.onStateChanged(AppState.authenticated, AppState.unauthenticated);
    await pumpEventQueue();

    verify(() => router.replaceAll(any())).called(1);
  });
}
