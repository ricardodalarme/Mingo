import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/gifts/presentation/gift_sheet/gift_sheet.dart';
import 'package:app/features/gifts/presentation/gifts/cubit/gifts_cubit.dart';
import 'package:app/features/gifts/presentation/gifts/gifts_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockGiftsRepository() extends Mock implements GiftsRepository;

void main() {
  late GiftsRepository repository;

  const mine = GiftIdea(
    id: 'g1',
    title: 'Livro',
    note: 'Capa dura',
    link: 'https://example.com/livro',
    isMine: true,
  );
  const partner = GiftIdea(id: 'g2', title: 'Vinil');

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockGiftsRepository();
    when(repository.getCoupleId).thenAnswer((_) async => 'couple-1');
    when(repository.getGiftIdeas).thenAnswer((_) async => [mine, partner]);
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

  Future<GiftsCubit> pumpGifts(WidgetTester tester, {List<GiftIdea>? gifts}) async {
    if (gifts != null) when(repository.getGiftIdeas).thenAnswer((_) async => gifts);
    final cubit = GiftsCubit(giftsRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const GiftsPage()));
    await tester.pump();

    return cubit;
  }

  testWidgets('the page shows my wishes and my partner wishes without platform calls', (
    tester,
  ) async {
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (
      call,
    ) async {
      calls.add(call);

      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await pumpGifts(tester);

    expect(find.text('Página de presentes'), findsOneWidget);
    expect(find.text('Livro'), findsOneWidget);
    expect(find.text('Vinil'), findsOneWidget);
    expect(find.text('Meus desejos'), findsOneWidget);
    expect(find.text('Do seu par'), findsOneWidget);
    expect(
      calls.where(
        (call) =>
            call.method == 'HapticFeedback.vibrate' ||
            call.method.toLowerCase().contains('notification'),
      ),
      isEmpty,
    );
  });

  testWidgets('an empty page is calm, not an error, and offers one add button', (tester) async {
    await pumpGifts(tester, gifts: []);

    expect(find.text('Nenhum desejo ainda'), findsOneWidget);
    expect(find.text('Adicione um desejo ou espere seu par adicionar um.'), findsOneWidget);
    expect(find.text('Adicionar'), findsOneWidget);
  });

  testWidgets('a long wish name ellipsizes on one line', (tester) async {
    const longTitle =
        'Um presente com um nome muito comprido que não caberia em uma linha só da lista';
    await pumpGifts(
      tester,
      gifts: [const GiftIdea(id: 'g1', title: longTitle, isMine: true)],
    );

    final title = tester.widget<Text>(find.text(longTitle));
    expect(title.maxLines, 1);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a wish with a buy link offers to open it from my list and my partner list', (
    tester,
  ) async {
    await pumpGifts(
      tester,
      gifts: [
        mine,
        const GiftIdea(id: 'g2', title: 'Vinil', link: 'https://example.com/vinil'),
      ],
    );

    expect(
      find.byWidgetPredicate((widget) => widget is AppIcon && widget.icon == AppIcons.link),
      findsNWidgets(2),
    );
  });

  testWidgets('the page has no visibility switch', (tester) async {
    await pumpGifts(
      tester,
      gifts: [const GiftIdea(id: 'g1', title: 'Livro', isMine: true)],
    );

    expect(find.byType(BaseSwitch), findsNothing);
  });

  testWidgets('editing a wish saves the new title', (tester) async {
    await pumpGifts(tester, gifts: [mine]);

    await tester.tap(find.text('Livro'));
    await tester.pumpAndSettle();
    expect(find.text('Editar desejo'), findsOneWidget);

    tester.widget<BaseTextField>(find.byType(BaseTextField).first).onChanged!('Livro de poemas');
    await tester.pump();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    verify(
      () => repository.updateGiftWish(
        id: 'g1',
        title: 'Livro de poemas',
        note: 'Capa dura',
        link: 'https://example.com/livro',
      ),
    ).called(1);
  });

  testWidgets('deleting a wish asks for confirmation first', (tester) async {
    await pumpGifts(tester, gifts: [mine]);

    await tester.tap(find.text('Livro'));
    await tester.pumpAndSettle();
    final deleteButton = find.text('Excluir');
    await tester.ensureVisible(deleteButton);
    await tester.pumpAndSettle();
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();
    expect(find.text('Excluir este desejo?'), findsOneWidget);

    await tester.tap(find.descendant(of: find.byType(BaseSheet), matching: find.text('Excluir')));
    await tester.pumpAndSettle();

    verify(() => repository.deleteGiftWish('g1')).called(1);
  });

  testWidgets('the add sheet asks for a name instead of closing', (tester) async {
    await tester.pumpApp(const GiftSheet());

    await tester.tap(find.text('Adicionar'));
    await tester.pump();

    expect(find.text('Dê um nome ao presente.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the add sheet rejects a link that is not a web address', (tester) async {
    await tester.pumpApp(const GiftSheet());

    tester.widget<BaseTextField>(find.byType(BaseTextField).first).onChanged!('Livro');
    tester.widget<BaseTextField>(find.byType(BaseTextField).last).onChanged!('example.com');
    await tester.pump();
    await tester.tap(find.text('Adicionar'));
    await tester.pump();

    expect(find.text('Use um link que comece com https://.'), findsOneWidget);
  });
}
