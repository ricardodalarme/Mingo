import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/preferences/cubit/notification_preferences_cubit.dart';
import 'package:app/features/notifications/presentation/preferences/notification_preferences_page.dart';
import 'package:app/features/reminders/data/models/reminder_preferences.dart';
import 'package:app/features/reminders/data/repositories/reminders_repository.dart';
import 'package:app/features/reminders/data/services/reminder_sync_service.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

class _MockRemindersRepository() extends Mock implements RemindersRepository;

class _MockSyncService() extends Mock implements ReminderSyncService;

void main() {
  late NotificationsRepository notifications;
  late RemindersRepository reminders;
  late ReminderSyncService sync;

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(const NotificationPreferences());
    registerFallbackValue(const ReminderPreferences());
  });

  setUp(() {
    notifications = _MockNotificationsRepository();
    reminders = _MockRemindersRepository();
    sync = _MockSyncService();
    when(notifications.currentAccess).thenAnswer((_) async => NotificationAccess.granted);
    when(notifications.getPreferences).thenAnswer((_) async => const NotificationPreferences());
    when(() => notifications.savePreferences(any())).thenAnswer((_) async {});
    when(reminders.getPreferences).thenReturn(const ReminderPreferences());
    when(() => reminders.savePreferences(any())).thenAnswer((_) async {});
    when(sync.sync).thenAnswer((_) async {});
  });

  Future<NotificationPreferencesCubit> pump(WidgetTester tester) async {
    final cubit = NotificationPreferencesCubit(
      notificationsRepository: notifications,
      remindersRepository: reminders,
      syncService: sync,
    );
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(
      BlocProvider.value(value: cubit, child: const NotificationPreferencesPage()),
    );
    await tester.pump();

    return cubit;
  }

  testWidgets('draws the reminders board: the daily cap, the types and the rule', (tester) async {
    await pump(tester);

    expect(find.text('Lembretes'), findsOneWidget);
    expect(find.text('Por dia'), findsOneWidget);
    expect(find.text('No máximo'), findsOneWidget);
    expect(find.text('Até 2'), findsOneWidget);
    expect(find.text('Tipos'), findsOneWidget);
    expect(find.text('Ideia do dia'), findsOneWidget);
    expect(find.text('Datas e feriados'), findsOneWidget);
    expect(find.text('Cartão semanal'), findsOneWidget);
    expect(find.byType(BaseSwitch), findsNWidgets(notificationTypes.length));
    expect(
      find.text('Limite rígido de 1 a 2 mensagens por dia. Cada tipo pode ser desligado.'),
      findsOneWidget,
    );
  });

  testWidgets('the card day and hour live in the card settings, not here', (tester) async {
    await pump(tester);

    expect(find.text('Cartão de domingo'), findsNothing);
    expect(find.text('Dia'), findsNothing);
    expect(find.text('Horário'), findsNothing);
    expect(find.text('Como a notificação aparece'), findsNothing);
  });

  testWidgets('a lower daily cap is saved', (tester) async {
    await pump(tester);

    await tester.tap(find.text('No máximo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Até 1'));
    await tester.pumpAndSettle();

    verify(() => notifications.savePreferences(const NotificationPreferences(dailyMax: 1)))
        .called(1);
    expect(find.text('Até 1'), findsOneWidget);
  });

  testWidgets('a type switch saves the mute', (tester) async {
    await pump(tester);

    await tester.tap(find.byType(BaseSwitch).first);
    await tester.pump();

    verify(
      () =>
          notifications.savePreferences(const NotificationPreferences(mutedTypes: {'daily_idea'})),
    ).called(1);
  });

  testWidgets('with the phone blocking notifications it says so', (tester) async {
    when(notifications.currentAccess).thenAnswer((_) async => NotificationAccess.denied);

    await pump(tester);

    expect(find.textContaining('As notificações estão desligadas'), findsOneWidget);
    expect(find.text('Abrir configurações'), findsOneWidget);
  });
}
