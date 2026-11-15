import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/navigation/app_state_navigator.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/router/app_router.dart';
import 'package:app/router/pending_route.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRouter() extends Mock implements RootStackRouter;

class _FakeRoute() extends Fake implements PageRouteInfo<Object?>;

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
  setUpAll(() {
    registerFallbackValue(<PageRouteInfo>[]);
    registerFallbackValue(_FakeRoute());
  });

  late _MockRouter router;
  late PendingRoute pending;
  late _FakeInviteCodeStore inviteCodes;
  late AppStateNavigator navigator;

  setUp(() {
    router = _MockRouter();
    pending = PendingRoute();
    inviteCodes = _FakeInviteCodeStore();
    navigator = AppStateNavigator(router: router, pending: pending, inviteCodes: inviteCodes);

    when(() => router.replaceAll(any())).thenAnswer((_) async {});
    when(() => router.pushPath<Object?>(any())).thenAnswer((_) async => null);
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  test('reopens the page sign-in interrupted', () async {
    pending.stash('slip/s1');

    navigator.onStateChanged(AppState.unauthenticated, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.pushPath<Object?>('/slip/s1')).called(1);
    expect(pending.take(), isNull);
  });

  test('lands on the home stack when nothing was interrupted', () async {
    navigator.onStateChanged(AppState.unauthenticated, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.replaceAll(any())).called(1);
    verifyNever(() => router.pushPath<Object?>(any()));
    verifyNever(() => router.push<Object?>(any()));
  });

  test('reopens the invite kept from a signed-out link', () async {
    inviteCodes.code = 'ABCD2345';

    navigator.onStateChanged(AppState.unauthenticated, AppState.authenticated);
    await pumpEventQueue();

    final reopened = verify(() => router.push<Object?>(captureAny())).captured.single;
    expect(reopened, isA<AcceptInviteRoute>());
    expect((reopened as AcceptInviteRoute).args?.code, 'ABCD2345');
  });

  test('reopens a stashed accept path without waiting for the kept code', () async {
    pending.stash(acceptInvitePath);

    navigator.onStateChanged(AppState.unauthenticated, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.pushPath<Object?>(acceptInvitePath)).called(1);
    verifyNever(() => router.push<Object?>(any()));
  });

  test('leaves the interrupted page out of reach after onboarding', () async {
    pending.stash('slip/s1');

    navigator.onStateChanged(AppState.unauthenticated, AppState.onboarding);
    await pumpEventQueue();
    verifyNever(() => router.pushPath<Object?>(any()));

    navigator.onStateChanged(AppState.onboarding, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.pushPath<Object?>('/slip/s1')).called(1);
  });

  test('signing out forgets the interrupted page', () async {
    pending.stash('slip/s1');

    navigator.onStateChanged(AppState.authenticated, AppState.unauthenticated);
    await pumpEventQueue();
    navigator.onStateChanged(AppState.unauthenticated, AppState.authenticated);
    await pumpEventQueue();

    verifyNever(() => router.pushPath<Object?>(any()));
  });

  test('a session that expires is shown, then reopens the interrupted page', () async {
    pending.stash('slip/s1');

    navigator.onStateChanged(AppState.authenticated, AppState.sessionExpired);
    await pumpEventQueue();
    verify(() => router.push<Object?>(any())).called(1);

    navigator.onStateChanged(AppState.sessionExpired, AppState.authenticated);
    await pumpEventQueue();

    verify(() => router.pushPath<Object?>('/slip/s1')).called(1);
  });
}
