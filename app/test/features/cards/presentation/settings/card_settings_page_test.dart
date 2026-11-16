import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:app/features/cards/presentation/settings/card_settings_page.dart';
import 'package:app/features/cards/presentation/settings/cubit/card_settings_cubit.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockCardsRepository() extends Mock implements CardsRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(const NotificationPreferences());
  });

  testWidgets('shows the day, the hour and the default, and saves the default', (tester) async {
    final cards = _MockCardsRepository();
    final notifications = _MockNotificationsRepository();
    when(notifications.getPreferences)
        .thenAnswer((_) async => const NotificationPreferences(cardHour: 18));
    when(cards.getSlipsDefaultForCard).thenAnswer((_) async => false);
    when(() => cards.setSlipsDefaultForCard(value: true)).thenAnswer((_) async {});
    final cubit = CardSettingsCubit(cardsRepository: cards, notificationsRepository: notifications);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const CardSettingsPage()));
    await tester.pump();

    expect(find.text('Cartão semanal'), findsOneWidget);
    expect(find.text('Slips novos entram no cartão'), findsOneWidget);
    expect(find.text('Mudanças valem para o próximo cartão.'), findsOneWidget);

    await tester.tap(find.byType(BaseSwitch));
    await tester.pump();

    verify(() => cards.setSlipsDefaultForCard(value: true)).called(1);
  });
}
