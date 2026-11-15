import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/signal_answer.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/repair/presentation/received/cubit/received_signals_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepairRepository() extends Mock implements RepairRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockRemindersRepository() extends Mock implements RemindersRepository;

class _MockSyncService() extends Mock implements ReminderSyncService;

void main() {
  late RepairRepository repair;
  late ProfileRepository profile;
  late RemindersRepository reminders;
  late ReminderSyncService sync;

  final first = ReceivedSignal(
    id: 's1',
    kind: SignalKind.repair,
    createdAt: DateTime(2026, 11, 10),
    body: 'Podemos recomeçar?',
  );
  final second = ReceivedSignal(id: 's2', kind: SignalKind.hug, createdAt: DateTime(2026, 11, 10));

  setUpAll(() => registerFallbackValue(DateTime(2026)));

  setUp(() {
    repair = _MockRepairRepository();
    profile = _MockProfileRepository();
    reminders = _MockRemindersRepository();
    sync = _MockSyncService();
    when(() => profile.getMyProfile()).thenAnswer(
      (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
    );
    when(() => repair.getReceivedSignals('me')).thenAnswer((_) async => [first, second]);
    when(
      () => repair.respondToSignal(
        signalId: any(named: 'signalId'),
        response: any(named: 'response'),
      ),
    ).thenAnswer((invocation) async {
      final response = invocation.namedArguments[#response] as RepairResponse?;

      return SignalAnswer(
        response: response,
        respondedAt: response == null ? null : DateTime(2026, 11, 10, 20),
        seenAt: DateTime(2026, 11, 10, 20),
      );
    });
    when(() => reminders.addFollowUp(any(), now: any(named: 'now'))).thenAnswer((_) async {
      return;
    });
    when(() => sync.sync()).thenAnswer((_) async {
      return;
    });
  });

  ReceivedSignalsCubit build() => ReceivedSignalsCubit(
    repairRepository: repair,
    profileRepository: profile,
    remindersRepository: reminders,
    syncService: sync,
  );

  List<ReceivedSignal> items(ReceivedSignalsCubit cubit) =>
      (cubit.state.signals as Success<List<ReceivedSignal>>).value;

  test('load reads the unanswered messages for the person', () async {
    final cubit = build();

    await cubit.load();

    expect(items(cubit), [first, second]);
  });

  test('answering stores the answer on the message without dropping it', () async {
    final cubit = build();
    await cubit.load();

    await cubit.respond(first, response: RepairResponse.talk);

    verify(() => repair.respondToSignal(signalId: 's1', response: RepairResponse.talk)).called(1);
    expect(items(cubit), hasLength(2));
    expect(items(cubit).first.response, RepairResponse.talk);
    expect(items(cubit).first.respondedAt, DateTime(2026, 11, 10, 20));
    expect(items(cubit).first.isAnswered, isTrue);
    expect(cubit.state.answeredCount, 1);
    expect(cubit.state.hasNext, isTrue);
    verifyNever(() => reminders.addFollowUp(any(), now: any(named: 'now')));
  });

  test('an answered message cannot be answered again', () async {
    final cubit = build();
    await cubit.load();
    await cubit.respond(first, response: RepairResponse.talk);

    await cubit.respond(items(cubit).first, response: RepairResponse.heart);

    verifyNever(() => repair.respondToSignal(signalId: 's1', response: RepairResponse.heart));
    expect(items(cubit).first.response, RepairResponse.talk);
    expect(cubit.state.answeredCount, 1);
  });

  test('moving on leaves the answered message behind', () async {
    final cubit = build();
    await cubit.load();
    await cubit.respond(first, response: RepairResponse.talk);

    cubit.next();

    expect(items(cubit), [second]);
    expect(cubit.state.hasNext, isFalse);
  });

  test('later schedules a generic reminder', () async {
    final cubit = build();
    await cubit.load();

    await cubit.respond(first, response: RepairResponse.later);

    verify(() => reminders.addFollowUp(any(), now: any(named: 'now'))).called(1);
    verify(() => sync.sync()).called(1);
  });

  test('a message with no answer is only marked seen', () async {
    final cubit = build();
    await cubit.load();

    await cubit.respond(second);

    verify(() => repair.respondToSignal(signalId: 's2', response: null)).called(1);
    expect(items(cubit).last.isAnswered, isTrue);
    expect(items(cubit).last.response, isNull);
    verifyNever(() => reminders.addFollowUp(any(), now: any(named: 'now')));
  });

  test('a failed answer keeps the message unanswered', () async {
    when(
      () => repair.respondToSignal(
        signalId: any(named: 'signalId'),
        response: any(named: 'response'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();

    await cubit.respond(first, response: RepairResponse.talk);

    expect(items(cubit), [first, second]);
    expect(items(cubit).first.isAnswered, isFalse);
    expect(cubit.state.respondAction, isA<Initial>());
  });
}
