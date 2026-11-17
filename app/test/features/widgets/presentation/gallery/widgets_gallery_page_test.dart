import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/presentation/gallery/cubit/widgets_gallery_cubit.dart';
import 'package:app/features/widgets/presentation/gallery/widgets_gallery_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockWidgetsRepository() extends Mock implements WidgetsRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(WidgetOverview.fake());
  });

  late WidgetsRepository repository;
  late WidgetsGalleryCubit cubit;

  setUp(() {
    repository = _MockWidgetsRepository();
    cubit = WidgetsGalleryCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  Future<void> pumpGallery(WidgetTester tester, WidgetOverview overview) async {
    when(() => repository.loadAndSync()).thenAnswer((_) async => overview);
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const WidgetsGalleryPage()));
  }

  testWidgets('paired gallery shows the favorites, the medium group and the settings', (
    tester,
  ) async {
    await pumpGallery(tester, WidgetOverview.fake());

    expect(find.text('OS MAIS QUERIDOS'), findsOneWidget);
    expect(find.text('MÉDIOS'), findsOneWidget);
    expect(find.text('SÓ MEUS'), findsOneWidget);
    expect(find.text('Contador'), findsOneWidget);
    expect(find.text('Humor do parceiro'), findsOneWidget);
    expect(find.text('Recado do parceiro'), findsOneWidget);
    expect(find.text('O QUE APARECE NOS WIDGETS'), findsOneWidget);
    expect(find.byType(BaseSwitch), findsNWidgets(2));
  });

  testWidgets('a solo person sees only the personal widgets', (tester) async {
    final payload = WidgetPayload.fake().copyWith(isPaired: false).sanitized();
    await pumpGallery(tester, WidgetOverview.fake().copyWith(payload: payload));

    expect(find.text('OS MAIS QUERIDOS'), findsNothing);
    expect(find.text('MÉDIOS'), findsNothing);
    expect(find.text('SÓ MEUS'), findsOneWidget);
    expect(find.text('Os widgets do casal aparecem quando vocês se conectarem.'), findsOneWidget);
    expect(find.byType(BaseSwitch), findsNothing);
  });

  testWidgets('the names switch saves through the repository', (tester) async {
    final updated = WidgetOverview.fake().copyWith(
      preferences: WidgetOverview.fake().preferences.copyWith(showNames: false),
    );
    when(
      () => repository.savePrivacy(
        showNames: any(named: 'showNames'),
        allowPartnerNotes: any(named: 'allowPartnerNotes'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => updated);

    await pumpGallery(tester, WidgetOverview.fake());
    await tester.ensureVisible(find.byType(BaseSwitch).first);
    await tester.tap(find.byType(BaseSwitch).first);
    await tester.pumpAndSettle();

    verify(() => repository.savePrivacy(showNames: false, allowPartnerNotes: true)).called(1);
  });

  testWidgets('the how-to sheet explains the system step', (tester) async {
    await pumpGallery(tester, WidgetOverview.fake());

    await tester.ensureVisible(find.text('Como adicionar'));
    await tester.tap(find.text('Como adicionar'));
    await tester.pumpAndSettle();

    expect(find.text('Direto da tela inicial, sem permissão extra do Mingo.'), findsOneWidget);
    expect(find.text('Toque e segure em um espaço vazio da tela inicial.'), findsOneWidget);
  });
}
