import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
import 'package:app/features/gifts/data/models/gift_budget.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGiftsDataSource() extends Mock implements GiftsDataSource;

class _MockTogetherRepository() extends Mock implements TogetherRepository;

void main() {
  late GiftsDataSource dataSource;
  late TogetherRepository togetherRepository;
  late GiftsRepository repository;

  setUp(() {
    dataSource = _MockGiftsDataSource();
    togetherRepository = _MockTogetherRepository();
    repository = GiftsRepository(dataSource: dataSource, togetherRepository: togetherRepository);
    when(togetherRepository.getCoupleId).thenAnswer((_) async => 'couple-1');
    when(togetherRepository.getCurrentUserId).thenAnswer((_) async => 'user-1');
  });

  FragmentGiftWishFragment gift({
    String id = 'g1',
    String authorId = 'user-1',
    String? coupleId = 'couple-1',
    String title = 'Livro',
    String? note,
    EnumGiftBudget_enum? budget,
    EnumGiftIdeaStatus_enum status = EnumGiftIdeaStatus_enum.idea,
  }) => FragmentGiftWishFragment(
    id: id,
    authorId: authorId,
    coupleId: coupleId,
    title: title,
    note: note,
    budget: budget,
    status: status,
  );

  test('maps my wishes and my partner shared wishes', () async {
    when(dataSource.getGiftIdeas).thenAnswer(
      (_) async => [
        gift(id: 'g1', title: 'Livro'),
        gift(id: 'g2', authorId: 'user-2', title: 'Vinil'),
      ],
    );

    final gifts = await repository.getGiftIdeas();

    expect(gifts, hasLength(2));
    expect(gifts.first.title, 'Livro');
    expect(gifts.first.isMine, isTrue);
    expect(gifts.first.isShared, isTrue);
    expect(gifts.last.title, 'Vinil');
    expect(gifts.last.isMine, isFalse);
    expect(gifts.last.isShared, isTrue);
  });

  test('a wish from a couple that is no longer current is private', () async {
    when(dataSource.getGiftIdeas).thenAnswer((_) async => [gift(coupleId: null)]);

    final gifts = await repository.getGiftIdeas();

    expect(gifts.single.isShared, isFalse);
  });

  test('a partner private wish never reaches the page', () async {
    when(dataSource.getGiftIdeas)
        .thenAnswer((_) async => [gift(id: 'g1', authorId: 'user-2', coupleId: null)]);

    final gifts = await repository.getGiftIdeas();

    expect(gifts, isEmpty);
  });

  test('reading wishes does not ask for the couple id', () async {
    when(dataSource.getGiftIdeas).thenAnswer((_) async => [gift()]);

    await repository.getGiftIdeas();

    verifyNever(togetherRepository.getCoupleId);
  });

  test('adds a wish with trimmed values and the couple id', () async {
    when(
      () => dataSource.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        budget: any(named: 'budget'),
        coupleId: any(named: 'coupleId'),
      ),
    ).thenAnswer((_) async => gift());

    await repository.addGiftWish(
      id: 'g1',
      title: '  Livro  ',
      note: '  Capa dura  ',
      budget: GiftBudget.low,
      coupleId: 'couple-1',
    );

    verify(
      () => dataSource.addGiftWish(
        id: 'g1',
        title: 'Livro',
        note: 'Capa dura',
        budget: EnumGiftBudget_enum.low,
        coupleId: 'couple-1',
      ),
    ).called(1);
  });

  test('an empty note is sent as null', () async {
    when(
      () => dataSource.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        budget: any(named: 'budget'),
        coupleId: any(named: 'coupleId'),
      ),
    ).thenAnswer((_) async => gift());

    await repository.addGiftWish(id: 'g1', title: 'Livro', note: '   ');

    verify(
      () => dataSource.addGiftWish(
        id: 'g1',
        title: 'Livro',
        note: null,
        budget: null,
        coupleId: null,
      ),
    ).called(1);
  });

  test('updates, deletes and changes visibility by id', () async {
    when(
      () => dataSource.updateGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        budget: any(named: 'budget'),
      ),
    ).thenAnswer((_) async => gift());
    when(() => dataSource.deleteGiftWish(any())).thenAnswer((_) async {
      return;
    });
    when(
      () => dataSource.setGiftWishVisibility(
        id: any(named: 'id'),
        coupleId: any(named: 'coupleId'),
      ),
    ).thenAnswer((_) async => gift());

    await repository.updateGiftWish(id: 'g1', title: ' Livro ', note: ' Capa dura ');
    await repository.deleteGiftWish('g1');
    await repository.setGiftWishVisibility(id: 'g1', coupleId: 'couple-1');
    await repository.setGiftWishVisibility(id: 'g1');

    verify(
      () => dataSource.updateGiftWish(id: 'g1', title: 'Livro', note: 'Capa dura', budget: null),
    ).called(1);
    verify(() => dataSource.deleteGiftWish('g1')).called(1);
    verify(() => dataSource.setGiftWishVisibility(id: 'g1', coupleId: 'couple-1')).called(1);
    verify(() => dataSource.setGiftWishVisibility(id: 'g1', coupleId: null)).called(1);
  });
}
