import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/held_reason.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:app/features/cards/presentation/draft/cubit/sunday_card_cubit.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCardsRepository() extends Mock implements CardsRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

void main() {
  late CardsRepository cards;
  late ProfileRepository profile;
  late PairingRepository pairing;
  late NotificationsRepository notifications;

  final card = SundayCard(
    id: 'c1',
    status: CardStatus.draft,
    weekStart: DateTime(2026, 11, 9),
    items: const [
      CardItem(id: 'a', body: 'Um'),
      CardItem(id: 'b', body: 'Dois'),
      CardItem(id: 'c', body: 'Três'),
    ],
  );

  setUpAll(() => registerFallbackValue(card));

  setUpAll(() => registerFallbackValue(const NotificationPreferences()));

  setUp(() {
    cards = _MockCardsRepository();
    profile = _MockProfileRepository();
    pairing = _MockPairingRepository();
    notifications = _MockNotificationsRepository();
    when(notifications.getPreferences).thenAnswer((_) async => const NotificationPreferences());
    when(() => notifications.savePreferences(any())).thenAnswer((_) async {});
    when(() => pairing.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
    when(() => cards.getDraft()).thenAnswer((_) async => card);
    when(() => profile.getMyProfile()).thenAnswer(
      (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
    );
    when(() => profile.getMySettings())
        .thenAnswer((_) async => const AccountSettings(theme: .rose, partnerName: 'Rui'));
  });

  SundayCardCubit build() => SundayCardCubit(
    cardsRepository: cards,
    profileRepository: profile,
    pairingRepository: pairing,
    notificationsRepository: notifications,
  );

  Future<SundayCardCubit> loaded() async {
    final cubit = build();
    await cubit.load();
    return cubit;
  }

  test('load shows the draft with both names', () async {
    final cubit = await loaded();

    expect(cubit.state.card, Success(card));
    expect(cubit.state.selfName, 'Ana');
    expect(cubit.state.partnerName, 'Rui');
  });

  test('a failed first load shows a failure', () async {
    when(() => cards.getDraft()).thenAnswer((_) async => throw Exception());
    final cubit = build();
    await cubit.load();

    expect(cubit.state.card, isA<Failure>());
  });

  test('editing works on a copy and cancelling drops it', () async {
    final cubit = await loaded()
      ..startEditing()
      ..removeItem(0);

    expect(cubit.state.draft!.items.map((item) => item.id), ['b', 'c']);
    expect((cubit.state.card as Success<SundayCard>).value.items, hasLength(3));

    cubit.cancelEditing();
    expect(cubit.state.isEditing, isFalse);
  });

  test('a sent card cannot be edited', () async {
    when(() => cards.getDraft()).thenAnswer(
      (_) async => SundayCard(
        id: 'c1',
        status: CardStatus.sent,
        weekStart: DateTime(2026, 11, 9),
        items: const [],
      ),
    );
    final cubit = await loaded()
      ..startEditing();

    expect(cubit.state.isEditing, isFalse);
  });

  test('items move one place and stay inside the list', () async {
    final cubit = await loaded()
      ..startEditing()
      ..moveItem(0, -1)
      ..moveItem(0, 1);

    expect(cubit.state.draft!.items.map((item) => item.id), ['b', 'a', 'c']);

    cubit.moveItem(2, 1);
    expect(cubit.state.draft!.items.map((item) => item.id), ['b', 'a', 'c']);
  });

  test('the closing note is capped', () async {
    final cubit = await loaded()
      ..startEditing()
      ..onNoteChanged('a' * (cardNoteMaxLength + 20));

    expect(cubit.state.draft!.note!.length, cardNoteMaxLength);
  });

  test('save sends the edited card and leaves edit mode', () async {
    final saved = card.copyWith(items: [card.items[1]], note: 'Obrigada');
    List<String>? removed;
    when(() => cards.saveDraft(any(), removedItemIds: any(named: 'removedItemIds')))
        .thenAnswer((invocation) async {
          removed = invocation.namedArguments[#removedItemIds] as List<String>?;
          return saved;
        });
    final cubit = await loaded()
      ..startEditing()
      ..removeItem(0)
      ..removeItem(1)
      ..onNoteChanged('Obrigada');
    await cubit.save();

    verify(() => cards.saveDraft(any(), removedItemIds: any(named: 'removedItemIds'))).called(1);
    expect(removed, ['a', 'c']);
    expect(cubit.state.card, Success(saved));
    expect(cubit.state.isEditing, isFalse);
  });

  test('a failed save keeps the edits so nothing is lost', () async {
    when(() => cards.saveDraft(any(), removedItemIds: any(named: 'removedItemIds')))
        .thenAnswer((_) async => throw Exception());
    final cubit = await loaded()
      ..startEditing()
      ..removeItem(0);
    await cubit.save();

    expect(cubit.state.isEditing, isTrue);
    expect(cubit.state.draft!.items, hasLength(2));
  });

  test('a connected partner is detected', () async {
    final cubit = await loaded();

    expect(cubit.state.isPaired, isTrue);
  });

  test('without a partner the card cannot be marked as connected', () async {
    when(() => pairing.getPartner()).thenAnswer((_) async => null);
    final cubit = await loaded();

    expect(cubit.state.isPaired, isFalse);
  });

  test('send marks the card as sent', () async {
    final sent = SundayCard(
      id: 'c1',
      status: CardStatus.sent,
      weekStart: card.weekStart,
      items: card.items,
    );
    when(() => cards.send('c1')).thenAnswer((_) async => sent);
    final cubit = await loaded();

    await cubit.send();

    expect(cubit.state.card, Success(sent));
  });

  test('a double tap on send sends once', () async {
    final sent = SundayCard(
      id: 'c1',
      status: CardStatus.sent,
      weekStart: card.weekStart,
      items: card.items,
    );
    when(() => cards.send('c1')).thenAnswer((_) async => sent);
    final cubit = await loaded();

    await Future.wait([cubit.send(), cubit.send()]);

    verify(() => cards.send('c1')).called(1);
  });

  test('a failed send leaves the draft in place to retry', () async {
    when(() => cards.send('c1')).thenAnswer((_) async => throw Exception());
    final cubit = await loaded();

    await cubit.send();

    expect(cubit.state.card, Success(card));
    expect(cubit.state.deliverAction, const Initial());
  });

  test('hold keeps the card and can be followed by a send', () async {
    final held = SundayCard(
      id: 'c1',
      status: CardStatus.held,
      weekStart: card.weekStart,
      items: card.items,
    );
    final sent = SundayCard(
      id: 'c1',
      status: CardStatus.sent,
      weekStart: card.weekStart,
      items: card.items,
    );
    when(() => cards.hold('c1')).thenAnswer((_) async => held);
    when(() => cards.send('c1')).thenAnswer((_) async => sent);
    final cubit = await loaded();

    await cubit.hold();
    expect((cubit.state.card as Success<SundayCard>).value.isHeld, isTrue);

    await cubit.send();
    expect((cubit.state.card as Success<SundayCard>).value.isSent, isTrue);
  });

  test('a sent card is never sent again', () async {
    final sent = SundayCard(
      id: 'c1',
      status: CardStatus.sent,
      weekStart: card.weekStart,
      items: card.items,
    );
    when(() => cards.getDraft()).thenAnswer((_) async => sent);
    final cubit = await loaded();

    await cubit.send();

    verifyNever(() => cards.send(any()));
  });

  test('send anyway passes the choice on, for a card held for its wording', () async {
    final sent = SundayCard(
      id: 'c1',
      status: CardStatus.sent,
      weekStart: card.weekStart,
      items: card.items,
    );
    when(() => cards.send('c1', anyway: true)).thenAnswer((_) async => sent);
    final cubit = await loaded();

    await cubit.send(anyway: true);

    expect(cubit.state.card, Success(sent));
  });

  test('a card held for its wording says so, unlike one the person chose to hold', () {
    final byRule = SundayCard(
      id: 'c1',
      status: CardStatus.held,
      weekStart: card.weekStart,
      items: card.items,
      heldReason: HeldReason.blame,
    );
    final byChoice = SundayCard(
      id: 'c1',
      status: CardStatus.held,
      weekStart: card.weekStart,
      items: card.items,
    );

    expect(byRule.isHeldByRule, isTrue);
    expect(byChoice.isHeldByRule, isFalse);
  });

  test('rewriting reopens the card as a draft and starts editing it', () async {
    final held = SundayCard(
      id: 'c1',
      status: CardStatus.held,
      weekStart: card.weekStart,
      items: card.items,
      heldReason: HeldReason.absolute,
    );
    when(() => cards.getDraft()).thenAnswer((_) async => held);
    when(() => cards.reopen('c1')).thenAnswer((_) async => card);
    final cubit = await loaded();

    await cubit.reopen();

    expect(cubit.state.isEditing, isTrue);
    verify(() => cards.reopen('c1')).called(1);
  });

  group('send day', () {
    test('load reads the day the card is sent', () async {
      when(notifications.getPreferences)
          .thenAnswer((_) async => const NotificationPreferences(cardDay: 5));

      final cubit = await loaded();

      expect(cubit.state.sendDay, 5);
    });

    test('choosing a day saves it for the next card', () async {
      final cubit = await loaded();

      await cubit.setSendDay(3);

      expect(cubit.state.sendDay, 3);
      verify(() => notifications.savePreferences(const NotificationPreferences(cardDay: 3)))
          .called(1);
    });

    test('a failed save goes back to the earlier day', () async {
      when(() => notifications.savePreferences(any())).thenThrow(Exception('offline'));
      final cubit = await loaded();

      await cubit.setSendDay(3);

      expect(cubit.state.sendDay, 0);
    });
  });
}
