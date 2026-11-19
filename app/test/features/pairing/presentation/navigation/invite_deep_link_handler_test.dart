import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/presentation/navigation/invite_deep_link_handler.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

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
  late _FakeInviteCodeStore inviteCodes;
  late _MockAuthenticationRepository authentication;
  late InviteDeepLinkHandler handler;

  setUp(() {
    inviteCodes = _FakeInviteCodeStore();
    authentication = _MockAuthenticationRepository();
    handler = InviteDeepLinkHandler(inviteCodes: inviteCodes, authentication: authentication);
  });

  test('opens the accept page with the code on top of Home', () async {
    when(() => authentication.isAuthenticated).thenReturn(true);

    final routes = await handler.resolve(Uri.parse('mingo://invite/abcd2345'));

    expect(routes!.map((route) => route.routeName), [HomeRoute.name, AcceptInviteRoute.name]);
    expect((routes.last as AcceptInviteRoute).args?.code, 'ABCD2345');
  });

  test('keeps nothing for a signed-in person', () async {
    when(() => authentication.isAuthenticated).thenReturn(true);

    await handler.resolve(Uri.parse('mingo://invite/abcd2345'));

    expect(inviteCodes.read(), isNull);
  });

  test('keeps the code for a signed-out person', () async {
    when(() => authentication.isAuthenticated).thenReturn(false);

    await handler.resolve(Uri.parse('mingo://invite?code=wxyz6789'));

    expect(inviteCodes.read(), 'WXYZ6789');
  });

  test('is not handling a link without a code', () async {
    expect(await handler.resolve(Uri.parse('mingo://invite')), isNull);
    expect(await handler.resolve(Uri.parse('mingo://today')), isNull);
  });
}
