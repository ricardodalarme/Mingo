import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
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
    when(togetherRepository.getCurrentUserId).thenAnswer((_) async => 'user-1');
  });

  FragmentGiftWishFragment gift({
    String id = 'g1',
    String authorId = 'user-1',
    String title = 'Livro',
    String? note,
    String? link,
  }) => FragmentGiftWishFragment(
    id: id,
    authorId: authorId,
    title: title,
    note: note,
    link: link,
    status: EnumGiftIdeaStatus_enum.idea,
  );

  test('maps my wishes and my partner wishes', () async {
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
    expect(gifts.last.title, 'Vinil');
    expect(gifts.last.isMine, isFalse);
  });

  test('adds a wish with trimmed values and the link', () async {
    when(
      () => dataSource.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer((_) async => gift());

    await repository.addGiftWish(
      id: 'g1',
      title: '  Livro  ',
      note: '  Capa dura  ',
      link: '  https://example.com/livro  ',
    );

    verify(
      () => dataSource.addGiftWish(
        id: 'g1',
        title: 'Livro',
        note: 'Capa dura',
        link: 'https://example.com/livro',
      ),
    ).called(1);
  });

  test('an empty note and link are sent as null', () async {
    when(
      () => dataSource.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer((_) async => gift());

    await repository.addGiftWish(id: 'g1', title: 'Livro', note: '   ', link: '');

    verify(() => dataSource.addGiftWish(id: 'g1', title: 'Livro', note: null, link: null))
        .called(1);
  });

  test('updates and deletes by id', () async {
    when(
      () => dataSource.updateGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer((_) async => gift());
    when(() => dataSource.deleteGiftWish(any())).thenAnswer((_) async {
      return;
    });

    await repository.updateGiftWish(id: 'g1', title: ' Livro ', note: ' Capa dura ');
    await repository.deleteGiftWish('g1');

    verify(() => dataSource.updateGiftWish(id: 'g1', title: 'Livro', note: 'Capa dura', link: null))
        .called(1);
    verify(() => dataSource.deleteGiftWish('g1')).called(1);
  });
}
