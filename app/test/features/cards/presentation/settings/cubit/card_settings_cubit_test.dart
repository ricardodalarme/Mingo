import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:app/features/cards/presentation/settings/cubit/card_settings_cubit.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCardsRepository() extends Mock implements CardsRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

void main() {
  late CardsRepository cards;
  late NotificationsRepository notifications;

  setUpAll(() => registerFallbackValue(const NotificationPreferences()));

  setUp(() {
    cards = _MockCardsRepository();
    notifications = _MockNotificationsRepository();
    when(notifications.getPreferences)
        .thenAnswer((_) async => const NotificationPreferences(cardDay: 5, cardHour: 18));
    when(() => notifications.savePreferences(any())).thenAnswer((_) async {});
    when(cards.getSlipsDefaultForCard).thenAnswer((_) async => true);
    when(() => cards.setSlipsDefaultForCard(value: any(named: 'value'))).thenAnswer((_) async {});
  });

  CardSettingsCubit build() =>
      CardSettingsCubit(cardsRepository: cards, notificationsRepository: notifications);

  test('load reads the day, the hour and the default', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(
      cubit.state.preferences,
      const Success(NotificationPreferences(cardDay: 5, cardHour: 18)),
    );
    expect(cubit.state.slipsDefaultForCard, isTrue);
  });

  test('a failed load shows a failure', () async {
    when(notifications.getPreferences).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.preferences, isA<Failure>());
  });

  test('choosing a day saves the preferences', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.setDay(2);

    verify(
      () => notifications.savePreferences(const NotificationPreferences(cardDay: 2, cardHour: 18)),
    ).called(1);
  });

  test('a failed save goes back to the earlier hour and flags the failure', () async {
    when(() => notifications.savePreferences(any())).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();
    final states = <bool>[];
    cubit.stream.listen((state) => states.add(state.saveFailed));

    await cubit.setHour(9);
    await Future<void>.delayed(Duration.zero);

    expect(
      cubit.state.preferences,
      const Success(NotificationPreferences(cardDay: 5, cardHour: 18)),
    );
    expect(states, contains(true));
  });

  test('the default switches and goes back when saving fails', () async {
    when(() => cards.setSlipsDefaultForCard(value: false)).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.setSlipsDefaultForCard(value: false);

    expect(cubit.state.slipsDefaultForCard, isTrue);
  });
}
