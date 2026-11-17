import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/presentation/inbox/cubit/inbox_cubit.dart';
import 'package:app/features/notifications/presentation/inbox/inbox_page.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockInboxRepository() extends Mock implements InboxRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late InboxRepository inbox;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    inbox = _MockInboxRepository();
    final profile = _MockProfileRepository();
    when(profile.getMySettings).thenAnswer(
      (_) async => const AccountSettings(theme: AppThemeVariant.rose, partnerName: 'Luanna'),
    );
    when(inbox.markAllRead).thenAnswer((_) async {});
  });

  Future<InboxCubit> pump(WidgetTester tester, List<InboxItem> items) async {
    when(inbox.getItems).thenAnswer((_) async => items);
    final profile = _MockProfileRepository();
    when(profile.getMySettings).thenAnswer(
      (_) async => const AccountSettings(theme: AppThemeVariant.rose, partnerName: 'Luanna'),
    );
    final cubit = InboxCubit(inboxRepository: inbox, profileRepository: profile);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const InboxPage()));
    await tester.pump();

    return cubit;
  }

  InboxItem item(NotificationKind kind, {DateTime? createdAt, bool isRead = false}) => InboxItem(
    id: kind.name,
    kind: kind,
    createdAt: createdAt ?? clock.now(),
    readAt: isRead ? clock.now() : null,
  );

  testWidgets('groups today and the week, with the rule as a note', (tester) async {
    await pump(tester, [
      item(NotificationKind.cardReceived),
      item(NotificationKind.cardReaction),
      item(NotificationKind.ritual, isRead: true),
      item(NotificationKind.dateComing, createdAt: clock.now().subtract(const Duration(days: 2))),
      item(NotificationKind.dailyIdea, createdAt: clock.now().subtract(const Duration(days: 3))),
    ]);

    expect(find.text('Hoje'), findsOneWidget);
    expect(find.text('Esta semana'), findsOneWidget);
    expect(find.text('Luanna te mandou um cartão'), findsOneWidget);
    expect(find.text('Luanna reagiu ao seu cartão'), findsOneWidget);
    expect(find.text('Marcar como lidas'), findsOneWidget);
    expect(find.text('Uma data está chegando'), findsOneWidget);
    expect(
      find.text('No máximo 2 avisos por dia chegam como notificação. O resto fica só aqui.'),
      findsOneWidget,
    );
    expect(find.text('Notificações'), findsOneWidget);
  });

  testWidgets('marking everything read asks the server and reads again', (tester) async {
    await pump(tester, [item(NotificationKind.cardReceived)]);

    await tester.tap(find.text('Marcar como lidas'));
    await tester.pump();
    await tester.pump();

    verify(inbox.markAllRead).called(1);
  });

  testWidgets('an empty inbox explains itself and offers the settings', (tester) async {
    await pump(tester, []);

    expect(find.text('Nada novo por aqui'), findsOneWidget);
    expect(
      find.text('Quando alguém mandar um cartão ou responder, aparece aqui.'),
      findsOneWidget,
    );
    expect(find.text('Ajustes de notificação'), findsOneWidget);
  });

  testWidgets('the failed read keeps a way back', (tester) async {
    when(inbox.getItems).thenThrow(Exception());
    final profile = _MockProfileRepository();
    when(profile.getMySettings).thenAnswer(
      (_) async => const AccountSettings(theme: AppThemeVariant.rose),
    );
    final cubit = InboxCubit(inboxRepository: inbox, profileRepository: profile);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const InboxPage()));
    await tester.pump();

    expect(find.text('Não deu para carregar as notificações'), findsOneWidget);
    expect(find.byType(BaseEmptyState), findsOneWidget);
  });
}
