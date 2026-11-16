import 'dart:async';

import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockInboxRepository() extends Mock implements InboxRepository;

void main() {
  late InboxRepository inbox;
  late StreamController<int> counts;

  setUp(() {
    inbox = _MockInboxRepository();
    counts = StreamController<int>();
    addTearDown(() {
      unawaited(counts.close());
    });
    when(() => inbox.watchUnreadCount()).thenAnswer((_) => counts.stream);
  });

  test('starts at zero and follows the unread count', () async {
    final cubit = InboxBadgeCubit(inboxRepository: inbox);
    addTearDown(cubit.close);

    expect(cubit.state, 0);

    cubit.start();
    counts.add(3);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, 3);

    counts.add(0);
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, 0);
  });

  test('starting twice listens once', () {
    final cubit = InboxBadgeCubit(inboxRepository: inbox)
      ..start()
      ..start();
    addTearDown(cubit.close);

    verify(() => inbox.watchUnreadCount()).called(1);
  });

  test('a failing subscription keeps the last count', () async {
    final cubit = InboxBadgeCubit(inboxRepository: inbox)..start();
    addTearDown(cubit.close);
    counts
      ..add(2)
      ..addError(Exception('offline'));
    await Future<void>.delayed(Duration.zero);

    expect(cubit.state, 2);
  });
}
