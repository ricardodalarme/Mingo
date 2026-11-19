import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/gifts/presentation/gifts/cubit/gifts_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGiftsRepository() extends Mock implements GiftsRepository;

void main() {
  late GiftsRepository repository;

  const mine = GiftIdea(id: 'g1', title: 'Livro', isMine: true);
  const partner = GiftIdea(id: 'g2', title: 'Vinil');

  setUp(() {
    repository = _MockGiftsRepository();
    when(repository.getCoupleId).thenAnswer((_) async => 'couple-1');
    when(repository.getGiftIdeas).thenAnswer((_) async => [mine, partner]);
    when(
      () => repository.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer(
      (invocation) async => GiftIdea(
        id: invocation.namedArguments[#id] as String,
        title: invocation.namedArguments[#title] as String,
        note: invocation.namedArguments[#note] as String?,
        link: invocation.namedArguments[#link] as String?,
        isMine: true,
      ),
    );
    when(
      () => repository.updateGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer(
      (invocation) async => [mine, partner]
          .firstWhere((gift) => gift.id == invocation.namedArguments[#id])
          .withDetails(
            title: invocation.namedArguments[#title] as String,
            note: invocation.namedArguments[#note] as String?,
            link: invocation.namedArguments[#link] as String?,
          ),
    );
    when(() => repository.deleteGiftWish(any())).thenAnswer((_) async {
      return;
    });
  });

  GiftsCubit build() => GiftsCubit(giftsRepository: repository);

  test('load reads the wishes and the couple id', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.currentGifts, [mine, partner]);
    expect(cubit.state.myGifts, [mine]);
    expect(cubit.state.partnerGifts, [partner]);
    expect(cubit.state.coupleId, 'couple-1');
    expect(cubit.state.hasPartner, isTrue);
  });

  test('a reload after unpair clears the couple id', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();
    expect(cubit.state.hasPartner, isTrue);

    when(repository.getCoupleId).thenAnswer((_) async => null);
    await cubit.load();

    expect(cubit.state.coupleId, isNull);
    expect(cubit.state.hasPartner, isFalse);
  });

  test('copyWith can clear the couple id', () {
    const state = GiftsState(coupleId: 'couple-1');

    expect(state.copyWith().coupleId, 'couple-1');
    expect(state.copyWith(coupleId: null).coupleId, isNull);
  });

  test('a new wish is saved without choosing who sees it', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: '  Fone  ');

    final created = cubit.state.currentGifts.first;
    expect(created.title, 'Fone');
    expect(created.isMine, isTrue);
    verify(() => repository.addGiftWish(id: created.id, title: 'Fone', note: null, link: null))
        .called(1);
  });

  test('a wish stores its note and where to buy it', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: 'Fone', note: '  Sem fio  ', link: '  https://example.com/fone  ');

    final created = cubit.state.currentGifts.first;
    expect(created.note, 'Sem fio');
    expect(created.link, 'https://example.com/fone');
    verify(
      () => repository.addGiftWish(
        id: created.id,
        title: 'Fone',
        note: 'Sem fio',
        link: 'https://example.com/fone',
      ),
    ).called(1);
  });

  test('a wish is saved while the person is on their own', () async {
    when(repository.getCoupleId).thenAnswer((_) async => null);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: 'Fone');

    expect(cubit.state.currentGifts.first.title, 'Fone');
    verify(
      () => repository.addGiftWish(
        id: any(named: 'id'),
        title: 'Fone',
        note: null,
        link: null,
      ),
    ).called(1);
  });

  test('an empty title is not added', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: '   ');

    verifyNever(
      () => repository.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    );
  });

  test('editing changes the details and the link', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.edit(
      mine,
      title: '  Livro de poemas  ',
      note: 'Capa dura',
      link: 'https://example.com/livro',
    );

    final edited = cubit.state.currentGifts.first;
    expect(edited.title, 'Livro de poemas');
    expect(edited.note, 'Capa dura');
    expect(edited.link, 'https://example.com/livro');
    verify(
      () => repository.updateGiftWish(
        id: 'g1',
        title: 'Livro de poemas',
        note: 'Capa dura',
        link: 'https://example.com/livro',
      ),
    ).called(1);
  });

  test('a partner wish cannot be edited', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.edit(partner, title: 'Outro');

    verifyNever(
      () => repository.updateGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    );
  });

  test('delete removes the wish and puts it back on failure', () async {
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.delete(mine);
    expect(cubit.state.currentGifts, [partner]);

    await cubit.load();
    when(() => repository.deleteGiftWish(any()))
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    await cubit.delete(mine);
    expect(cubit.state.currentGifts, [mine, partner]);
  });

  test('a failed add restores the previous wishes and reports it', () async {
    when(
      () => repository.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: 'Fone');

    expect(cubit.state.currentGifts, [mine, partner]);
    expect(cubit.state.saveAction, isA<Initial>());
  });

  test('a failed load is reported', () async {
    when(repository.getGiftIdeas).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.gifts, isA<Failure>());
  });

  test('the stored wish replaces the one shown while the request was running', () async {
    when(
      () => repository.addGiftWish(
        id: any(named: 'id'),
        title: any(named: 'title'),
        note: any(named: 'note'),
        link: any(named: 'link'),
      ),
    ).thenAnswer(
      (invocation) async => GiftIdea(
        id: invocation.namedArguments[#id] as String,
        title: 'Fone (servidor)',
        isMine: true,
      ),
    );
    when(repository.getGiftIdeas).thenAnswer((_) async => [mine]);
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.add(title: 'Fone');

    expect(cubit.state.currentGifts.first.title, 'Fone (servidor)');
  });
}
