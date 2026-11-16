import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/cards/data/data_sources/remote/cards_data_source.dart';
import 'package:app/features/cards/data/data_sources/remote/queries/generated/CardDetail.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/queries/generated/MyCards.graphql.dart';
import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCardsDataSource() extends Mock implements CardsDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late CardsDataSource dataSource;
  late AuthenticationRepository authentication;
  late CardsRepository repository;

  final weekStart = DateTime(2026, 11, 9);

  QueryMyCardscards card({required String id, required String authorId, DateTime? sentAt}) =>
      QueryMyCardscards(
        id: id,
        authorId: authorId,
        sentAt: sentAt,
        weekStart: weekStart,
        items: const [],
      );

  setUp(() {
    dataSource = _MockCardsDataSource();
    authentication = _MockAuthenticationRepository();
    repository = CardsRepository(dataSource: dataSource, authenticationRepository: authentication);
    when(() => authentication.currentUserId).thenReturn('me');
  });

  test('the history reads each card ownership from its author', () async {
    when(
      () => dataSource.getCards(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer(
      (_) async => [card(id: 'mine', authorId: 'me'), card(id: 'theirs', authorId: 'you')],
    );

    final page = await repository.getHistory();

    expect(page.items.map((card) => card.id), ['mine', 'theirs']);
    expect(page.items.map((card) => card.isMine), [true, false]);
    expect(page.hasNext, isFalse);
  });

  test('a card whose author is unknown is not treated as the person own', () async {
    when(() => authentication.currentUserId).thenReturn(null);
    when(
      () => dataSource.getCards(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer((_) async => [card(id: 'unknown', authorId: 'someone')]);

    final page = await repository.getHistory();

    expect(page.items.single.isMine, isFalse);
  });

  test('a full page says there is more and starts the next one after it', () async {
    when(
      () => dataSource.getCards(
        limit: any(named: 'limit'),
        offset: any(named: 'offset'),
      ),
    ).thenAnswer(
      (_) async => [
        for (var index = 0; index <= cardPageSize; index++) card(id: 'c$index', authorId: 'me'),
      ],
    );

    final page = await repository.getHistory(offset: 20);

    expect(page.items.length, cardPageSize);
    expect(page.hasNext, isTrue);
    expect(page.offset, 20 + cardPageSize);
  });

  test('the detail reads ownership from the author', () async {
    when(() => dataSource.getCard('c1')).thenAnswer(
      (_) async => QueryCardDetailcardsByPk(
        id: 'c1',
        status: EnumCardStatus_enum.sent,
        weekStart: weekStart,
        authorId: 'you',
        author: QueryCardDetailcardsByPkauthor(displayName: 'You'),
        items: const [],
      ),
    );

    final detail = await repository.getDetail(id: 'c1');

    expect(detail.isMine, isFalse);
    expect(detail.card.id, 'c1');
  });

  test('a card the server does not return is a not-found failure', () async {
    when(() => dataSource.getCard('gone')).thenAnswer((_) async => null);

    await expectLater(
      repository.getDetail(id: 'gone'),
      throwsA(
        isA<LocalizedException>().having(
          (exception) => exception.l10nKey,
          'l10nKey',
          'CARD_NOT_FOUND',
        ),
      ),
    );
  });

  test('the card default is read and saved for the signed in person', () async {
    when(() => dataSource.getSlipsDefaultForCard('me')).thenAnswer((_) async => true);
    when(() => dataSource.setSlipsDefaultForCard(userId: 'me', value: false))
        .thenAnswer((_) async {});

    expect(await repository.getSlipsDefaultForCard(), isTrue);
    await repository.setSlipsDefaultForCard(value: false);

    verify(() => dataSource.setSlipsDefaultForCard(userId: 'me', value: false)).called(1);
  });

  test('the card default without a signed in person is refused', () {
    when(() => authentication.currentUserId).thenReturn(null);

    expect(repository.getSlipsDefaultForCard(), throwsA(isA<LocalizedException>()));
  });
}
