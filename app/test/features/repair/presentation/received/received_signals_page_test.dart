import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/signal_answer.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/repair/presentation/received/cubit/received_signals_cubit.dart';
import 'package:app/features/repair/presentation/received/received_signals_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockRepairRepository() extends Mock implements RepairRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockRemindersRepository() extends Mock implements RemindersRepository;

class _MockSyncService() extends Mock implements ReminderSyncService;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUpAll(() => registerFallbackValue(DateTime(2026)));

  late RepairRepository repair;
  late ProfileRepository profile;
  late RemindersRepository reminders;
  late ReminderSyncService sync;

  setUp(() {
    repair = _MockRepairRepository();
    profile = _MockProfileRepository();
    reminders = _MockRemindersRepository();
    sync = _MockSyncService();
    when(() => profile.getMyProfile()).thenAnswer(
      (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
    );
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

  Future<ReceivedSignalsCubit> pumpPage(WidgetTester tester, List<ReceivedSignal> signals) async {
    when(() => repair.getReceivedSignals('me')).thenAnswer((_) async => signals);
    final cubit = ReceivedSignalsCubit(
      repairRepository: repair,
      profileRepository: profile,
      remindersRepository: reminders,
      syncService: sync,
    );
    addTearDown(cubit.close);
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const ReceivedSignalsPage()));
    await tester.pumpAndSettle();

    return cubit;
  }

  ReceivedSignal signalOf(SignalKind kind) =>
      ReceivedSignal(id: 's1', kind: kind, createdAt: DateTime(2026, 11, 10));

  testWidgets('a need offers a conversation, a not now and a heart', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.need)]);

    expect(find.text('PRECISO DE…'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsOneWidget);
    expect(find.text('Agora não'), findsOneWidget);
    expect(find.text('Mandar um coração'), findsOneWidget);
    expect(find.text('Entendi'), findsNothing);
  });

  testWidgets('a hug only offers a heart back', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.hug)]);

    expect(find.text('Mandar um coração'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsNothing);
    expect(find.text('Estou aqui'), findsNothing);
    expect(find.text('Entendi'), findsNothing);
  });

  testWidgets('a heavy day offers presence and taking something over', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.heavyDay)]);

    expect(find.text('Estou aqui'), findsOneWidget);
    expect(find.text('Vou fazer'), findsOneWidget);
    expect(find.text('Mandar um coração'), findsNothing);
  });

  testWidgets('missing us offers a plan, a conversation and a heart', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.missUs)]);

    expect(find.text('Planejar algo'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsOneWidget);
    expect(find.text('Mandar um coração'), findsOneWidget);
    expect(find.text('Entendi'), findsOneWidget);
  });

  testWidgets('good news takes a heart or a plain acknowledgement', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.goodNews)]);

    expect(find.text('Mandar um coração'), findsOneWidget);
    expect(find.text('Entendi'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsNothing);
  });

  testWidgets('answering shows the answer on the message and drops the options', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.need)]);

    await tester.tap(find.text('Vamos conversar'));
    await tester.pumpAndSettle();

    expect(find.text('Você respondeu: Vamos conversar'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsNothing);
    expect(find.text('Agora não'), findsNothing);
    expect(find.text('Mandar um coração'), findsNothing);
    expect(find.text('Fechar'), findsOneWidget);
  });

  testWidgets('an acknowledgement shows on the message too', (tester) async {
    await pumpPage(tester, [signalOf(SignalKind.goodNews)]);

    await tester.tap(find.text('Entendi'));
    await tester.pumpAndSettle();

    expect(find.text('Você respondeu: Entendi'), findsOneWidget);
    expect(find.text('Entendi'), findsNothing);
    expect(find.text('Mandar um coração'), findsNothing);
  });

  testWidgets('a failed answer keeps the message unanswered and says so', (tester) async {
    when(
      () => repair.respondToSignal(
        signalId: any(named: 'signalId'),
        response: any(named: 'response'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    await pumpPage(tester, [signalOf(SignalKind.need)]);

    await tester.tap(find.text('Vamos conversar'));
    await tester.pumpAndSettle();

    expect(find.text('Vamos conversar'), findsOneWidget);
    expect(find.text('Agora não'), findsOneWidget);
    expect(find.text('Não deu para responder agora. Tente de novo.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 7));
  });

  testWidgets('an already answered message shows its answer and no options', (tester) async {
    await pumpPage(tester, [
      ReceivedSignal(
        id: 's1',
        kind: SignalKind.need,
        createdAt: DateTime(2026, 11, 10),
        response: RepairResponse.talk,
        respondedAt: DateTime(2026, 11, 10, 20),
        seenAt: DateTime(2026, 11, 10, 20),
      ),
    ]);

    expect(find.text('Você respondeu: Vamos conversar'), findsOneWidget);
    expect(find.text('Vamos conversar'), findsNothing);
    expect(find.text('Agora não'), findsNothing);
    expect(find.text('Entendi'), findsNothing);
  });

  testWidgets('moving on after an answer shows the next message', (tester) async {
    await pumpPage(tester, [
      signalOf(SignalKind.need),
      ReceivedSignal(id: 's2', kind: SignalKind.hug, createdAt: DateTime(2026, 11, 9)),
    ]);

    await tester.tap(find.text('Vamos conversar'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Próxima mensagem'));
    await tester.pumpAndSettle();

    expect(find.text('UM ABRAÇO'), findsOneWidget);
    expect(find.text('Mandar um coração'), findsOneWidget);
    expect(find.text('Você respondeu: Vamos conversar'), findsNothing);
  });
}
