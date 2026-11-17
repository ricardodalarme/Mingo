import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/infrastructure/initializers/query_cache_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late GQLClient client;
  late StreamController<bool> authState;

  setUp(() {
    client = _MockGQLClient();
    authState = StreamController<bool>.broadcast();
    addTearDown(authState.close);
    final authentication = _MockAuthenticationRepository();
    when(() => authentication.isAuthenticatedStream).thenAnswer((_) => authState.stream);
    QueryCacheInitializer(gqlClient: client, authenticationRepository: authentication).initialize();
  });

  test('signing out drops the cached results', () async {
    authState.add(false);
    await pumpEventQueue();

    verify(() => client.resetCache()).called(1);
  });

  test('signing in keeps the cache', () async {
    authState.add(true);
    await pumpEventQueue();

    verifyNever(() => client.resetCache());
  });
}
