import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/together/data/data_sources/remote/together_data_source.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTogetherDataSource() extends Mock implements TogetherDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late TogetherDataSource dataSource;
  late AuthenticationRepository authentication;
  late StreamController<String?> couple;
  late StreamController<bool> authState;
  late TogetherRepository repository;
  var subscriptions = 0;

  setUp(() {
    subscriptions = 0;
    dataSource = _MockTogetherDataSource();
    authentication = _MockAuthenticationRepository();
    couple = StreamController<String?>.broadcast();
    authState = StreamController<bool>.broadcast();
    addTearDown(couple.close);
    addTearDown(authState.close);
    when(() => authentication.isAuthenticatedStream).thenAnswer((_) => authState.stream);
    when(() => authentication.currentUserId).thenReturn('user-1');
    when(dataSource.watchCoupleId).thenAnswer((_) {
      subscriptions++;

      return couple.stream;
    });
    repository = TogetherRepository(
      dataSource: dataSource,
      authenticationRepository: authentication,
    );
  });

  test('the person id comes from the session without a request', () async {
    expect(await repository.getCurrentUserId(), 'user-1');
    verifyNever(dataSource.watchCoupleId);
  });

  test('the couple id is read once and then kept', () async {
    final first = repository.getCoupleId();
    couple.add('couple-1');

    expect(await first, 'couple-1');
    expect(await repository.getCoupleId(), 'couple-1');
    expect(await repository.getCoupleId(), 'couple-1');
    expect(subscriptions, 1);
  });

  test('a change the server pushes replaces the kept couple id', () async {
    final first = repository.getCoupleId();
    couple.add(null);
    expect(await first, isNull);

    couple.add('couple-1');
    await pumpEventQueue();

    expect(await repository.getCoupleId(), 'couple-1');
  });

  test('a failed first read is reported and the next call tries again', () async {
    final first = repository.getCoupleId();
    couple.addError(Exception('offline'));
    await expectLater(first, throwsException);

    final second = repository.getCoupleId();
    couple.add('couple-1');

    expect(await second, 'couple-1');
    expect(subscriptions, 2);
  });

  test('signing out forgets the couple', () async {
    final first = repository.getCoupleId();
    couple.add('couple-1');
    await first;

    authState.add(false);
    await pumpEventQueue();
    final next = repository.getCoupleId();
    couple.add('couple-2');

    expect(await next, 'couple-2');
    expect(subscriptions, 2);
  });
}
