import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/home_widgets/presentation/gallery/cubit/home_widgets_gallery_cubit.dart';
import 'package:app/features/home_widgets/presentation/gallery/home_widgets_gallery_page.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockHomeWidgetsRepository() extends Mock implements HomeWidgetsRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late HomeWidgetsRepository repository;
  late HomeWidgetsGalleryCubit cubit;

  setUp(() {
    repository = _MockHomeWidgetsRepository();
    cubit = HomeWidgetsGalleryCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  Future<void> pumpGallery(WidgetTester tester, HomeWidgetPayload payload) async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => payload);
    await cubit.load();
    tester.view.physicalSize = const Size(390, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const HomeWidgetsGalleryPage()));
  }

  testWidgets('a couple sees every widget in its three groups', (tester) async {
    await pumpGallery(tester, HomeWidgetPayload.fake());

    expect(find.text('OS MAIS QUERIDOS'), findsOneWidget);
    expect(find.text('MAIS PEQUENOS'), findsOneWidget);
    expect(find.text('MÉDIOS'), findsOneWidget);
    expect(find.byType(HomeWidgetPreview), findsNWidgets(15));
    expect(find.text('Humor do parceiro'), findsOneWidget);
    expect(find.text('Namoro à distância'), findsOneWidget);
    expect(find.text('Só aparece o que seu par escolheu compartilhar.'), findsOneWidget);
  });

  testWidgets('someone without a partner only sees the widgets that work alone', (tester) async {
    await pumpGallery(tester, HomeWidgetPayload.fake().sanitizedAlone());

    expect(
      find.text('Os widgets que precisam de um par aparecem quando vocês se conectam.'),
      findsOne,
    );
    expect(find.text('Humor do parceiro'), findsNothing);
    expect(find.text('Saudade de nós'), findsNothing);
    expect(find.text('Namoro à distância'), findsNothing);
    expect(find.text('Contador'), findsOneWidget);
    expect(find.text('Anotar slip'), findsOneWidget);
  });

  testWidgets('there is nothing to configure: no switches and no tappable preview', (tester) async {
    await pumpGallery(tester, HomeWidgetPayload.fake());

    expect(find.byType(BaseSwitch), findsNothing);
    expect(
      find.descendant(of: find.byType(HomeWidgetPreview), matching: find.byType(AppPressable)),
      findsNothing,
    );
    expect(
      find.descendant(of: find.byType(HomeWidgetPreview), matching: find.byType(GestureDetector)),
      findsNothing,
    );
  });

  testWidgets('the how-to-add button opens the guide', (tester) async {
    await pumpGallery(tester, HomeWidgetPayload.fake());

    await tester.ensureVisible(find.text('Como adicionar'));
    await tester.tap(find.text('Como adicionar'));
    await tester.pumpAndSettle();

    expect(find.text('Direto na tela inicial, sem nenhuma permissão extra do Mingo.'), findsOne);
  });

  testWidgets('a failed first load offers a retry', (tester) async {
    when(() => repository.loadAndSync()).thenThrow(Exception('offline'));
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const HomeWidgetsGalleryPage()));

    expect(find.text('Não deu para carregar os widgets'), findsOneWidget);
    expect(find.text('Tentar de novo'), findsOneWidget);
  });
}

extension on HomeWidgetPayload {
  HomeWidgetPayload sanitizedAlone() => HomeWidgetPayload(
    isSignedIn: true,
    isPaired: false,
    updatedAt: updatedAt,
    togetherSince: togetherSince,
    ownName: ownName,
  );
}
