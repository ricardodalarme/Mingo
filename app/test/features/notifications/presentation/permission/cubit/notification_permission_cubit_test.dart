import 'dart:async';

import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/permission/cubit/notification_permission_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late NotificationsRepository repository;

  setUp(() {
    repository = _MockNotificationsRepository();
    when(() => repository.requestAccess()).thenAnswer((_) async => NotificationAccess.granted);
    when(repository.registerDevice).thenAnswer((_) async {
      return;
    });
  });

  NotificationPermissionCubit build({
    Duration registrationTimeout = NotificationsRepository.registrationTimeout,
  }) {
    final cubit = NotificationPermissionCubit(
      repository: repository,
      registrationTimeout: registrationTimeout,
    );
    addTearDown(cubit.close);

    return cubit;
  }

  test('reports the access the person gave', () async {
    final cubit = build();

    await cubit.allow();

    expect(
      cubit.state.requestAction,
      const Success<NotificationAccess>(NotificationAccess.granted),
    );
    expect(cubit.state.registrationAction, isA<Success<void>>());
  });

  test('a denial is a normal answer, not a failure', () async {
    when(() => repository.requestAccess()).thenAnswer((_) async => NotificationAccess.denied);
    final cubit = build();

    await cubit.allow();

    expect(cubit.state.requestAction, isA<Success<NotificationAccess>>());
    verifyNever(() => repository.registerDevice());
  });

  test('a failure is reported', () async {
    when(() => repository.requestAccess()).thenAnswer((_) async => throw Exception());
    final cubit = build();

    await cubit.allow();

    expect(cubit.state.requestAction, isA<Failure>());
  });

  test('the answer does not wait for the push token', () async {
    when(repository.registerDevice).thenAnswer((_) => Completer<void>().future);
    final cubit = build(registrationTimeout: const Duration(milliseconds: 20));

    final allowance = cubit.allow();
    await Future<void>.delayed(Duration.zero);

    expect(
      cubit.state.requestAction,
      const Success<NotificationAccess>(NotificationAccess.granted),
    );
    expect(cubit.state.registrationAction, isA<Loading>());

    await allowance;
  });

  test('a registration that never finishes times out and asks for a decision', () async {
    when(repository.registerDevice).thenAnswer((_) => Completer<void>().future);
    final cubit = build(registrationTimeout: const Duration(milliseconds: 20));

    await cubit.allow();

    expect(
      cubit.state.requestAction,
      const Success<NotificationAccess>(NotificationAccess.granted),
    );
    expect(cubit.state.registrationAction, isA<Failure>());
    expect(cubit.state.hasRegistrationFailed, isTrue);
    expect(cubit.state.isBusy, isFalse);
  });

  test('a retry registers the device again and clears the failure', () async {
    when(repository.registerDevice).thenThrow(const LocalizedException(l10nKey: 'registerDevice'));
    final cubit = build();
    await cubit.allow();
    expect(cubit.state.hasRegistrationFailed, isTrue);

    when(repository.registerDevice).thenAnswer((_) async {
      return;
    });
    await cubit.register();

    expect(cubit.state.hasRegistrationFailed, isFalse);
    expect(cubit.state.registrationAction, isA<Success<void>>());
    verify(() => repository.registerDevice()).called(2);
  });
}
