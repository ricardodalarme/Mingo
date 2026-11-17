import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:authentication_service/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthenticationService() extends Mock implements AuthenticationService;

void main() {
  late AuthenticationService service;
  late AuthenticationRepository repository;

  setUp(() {
    service = _MockAuthenticationService();
    repository = AuthenticationRepository(authenticationService: service);
  });

  test('hands out the access token the service renews', () async {
    when(() => service.getFreshAccessToken()).thenAnswer((_) async => 'abc');

    expect(await repository.getFreshAccessToken(), 'abc');
  });

  test('passes the refused token to the renewal and reports its outcome', () async {
    when(() => service.refreshSession(any())).thenAnswer((_) async => true);

    final renewed = await repository.refreshSession('old');

    expect(renewed, isTrue);
    verify(() => service.refreshSession('old')).called(1);
  });

  test('renews without a refused token when none is given', () async {
    when(() => service.refreshSession(any())).thenAnswer((_) async => false);

    expect(await repository.refreshSession(), isFalse);
    verify(() => service.refreshSession(null)).called(1);
  });

  test('the signed-in person id is the service one', () {
    when(() => service.currentUserId).thenReturn('user-1');

    expect(repository.currentUserId, 'user-1');
  });
}
