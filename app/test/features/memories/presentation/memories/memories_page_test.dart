import 'dart:async';

import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/memories/cubit/memories_cubit.dart';
import 'package:app/features/memories/presentation/memories/memories_page.dart';
import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slip_detail/cubit/slip_detail_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockMemoriesRepository() extends Mock implements MemoriesRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockTabsRouter() extends Mock implements TabsRouter;

double _revealOpacity(WidgetTester tester, int index) => tester
    .widget<Opacity>(
      find.descendant(of: find.byType(Reveal).at(index), matching: find.byType(Opacity)).first,
    )
    .opacity;

Future<void> _pumpReducedMotionPage(WidgetTester tester, MemoriesCubit cubit) async {
  await tester.pumpApp(
    Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: true),
        child: BlocProvider.value(value: cubit, child: const MemoriesPage()),
      ),
    ),
  );
  await tester.pump();
}

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NotFoundRoute.page, initial: true),
    AutoRoute(page: MemoriesRoute.page, path: '/memories'),
    AutoRoute(page: SlipDetailRoute.page, path: '/slip/:id'),
  ];
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late MemoriesRepository repository;

  setUp(() {
    repository = _MockMemoriesRepository();
    when(() => repository.getMemories()).thenAnswer((_) async => []);
    when(() => repository.deleteMemory(any())).thenAnswer((_) async {
      return;
    });
    when(() => repository.drawFromJar()).thenAnswer((_) async => null);
    when(
      () => repository.addMemory(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        place: any(named: 'place'),
        happenedOn: any(named: 'happenedOn'),
      ),
    ).thenAnswer((_) async {
      return;
    });
  });

  setUpAll(() => registerFallbackValue(DateTime(2026)));

  Future<MemoriesCubit> build() async {
    final cubit = MemoriesCubit(memoriesRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    return cubit;
  }

  Future<void> pumpPage(WidgetTester tester, MemoriesCubit cubit) async {
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const MemoriesPage()));
    await tester.pump();
  }

  testWidgets('adding a memory opens the form in a sheet and saves it', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(BaseEmptyState), findsOneWidget);
    expect(find.text('Adicionar memória'), findsOneWidget);

    await tester.tap(find.text('Adicionar memória'));
    await tester.pumpAndSettle();

    expect(find.text('Uma memória'), findsOneWidget);
    expect(find.text('Guardar memória'), findsOneWidget);

    await tester.enterText(find.byType(BaseTextField).first, 'Primeiro jantar');
    await tester.tap(find.text('Guardar memória'));
    await tester.pumpAndSettle();

    verify(
      () => repository.addMemory(
        id: any(named: 'id'),
        title: 'Primeiro jantar',
        body: '',
        place: '',
        happenedOn: any(named: 'happenedOn'),
      ),
    ).called(1);
  });

  testWidgets('an empty title keeps the sheet open with the field error', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);
    await tester.tap(find.text('Adicionar memória'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Guardar memória'));
    await tester.pumpAndSettle();

    expect(find.text('Dê um título a esta memória'), findsOneWidget);
    expect(find.text('Guardar memória'), findsOneWidget);
    verifyNever(
      () => repository.addMemory(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        place: any(named: 'place'),
        happenedOn: any(named: 'happenedOn'),
      ),
    );
  });

  testWidgets('tapping a memory shows its place and story', (tester) async {
    when(() => repository.getMemories()).thenAnswer(
      (_) async => [
        Memory(
          id: 'm1',
          title: 'Primeiro jantar',
          happenedOn: DateTime(2026, 5, 12),
          place: 'Paraty',
          body: 'Foi lindo',
        ),
      ],
    );
    final cubit = await build();

    await pumpPage(tester, cubit);
    await tester.tap(find.text('Primeiro jantar'));
    await tester.pumpAndSettle();

    expect(find.text('Lugar'), findsOneWidget);
    expect(find.text('Paraty'), findsOneWidget);
    expect(find.text('Como foi'), findsOneWidget);
    expect(find.text('Foi lindo'), findsOneWidget);
  });

  testWidgets('an empty timeline offers no image to share', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.text('Compartilhar imagem'), findsNothing);
    expect(find.byType(ShareImageEntry), findsNothing);
  });

  testWidgets('the timeline offers an image with the latest moments', (tester) async {
    when(() => repository.getMemories()).thenAnswer(
      (_) async => [
        Memory(
          id: 'm1',
          title: 'Primeiro jantar',
          happenedOn: DateTime(2026, 5, 12),
          place: 'Paraty',
        ),
        Memory(id: 'm2', title: 'Nosso show', happenedOn: DateTime(2026, 2, 3)),
      ],
    );
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.text('Compartilhar imagem'), findsOneWidget);
    expect(find.text('Uma linha do tempo com os momentos que vocês guardaram.'), findsOneWidget);

    final entry = tester.widget<ShareImageEntry>(find.byType(ShareImageEntry));
    final card = entry.cards.single as ShareTimelineCard;
    expect(card.entries.map((entry) => entry.title), ['Primeiro jantar', 'Nosso show']);
    expect(card.entries.first.place, 'Paraty');
  });

  testWidgets('deleting a memory asks before removing it', (tester) async {
    when(() => repository.getMemories()).thenAnswer(
      (_) async => [Memory(id: 'm1', title: 'Primeiro jantar', happenedOn: DateTime(2026, 5, 12))],
    );
    final cubit = await build();

    await pumpPage(tester, cubit);
    await tester.tap(find.text('Apagar'));
    await tester.pumpAndSettle();

    expect(find.text('Apagar esta memória?'), findsOneWidget);
    verifyNever(() => repository.deleteMemory(any()));

    await tester.tap(
      find.descendant(of: find.byType(BaseConfirmSheet), matching: find.text('Apagar')),
    );
    await tester.pumpAndSettle();

    verify(() => repository.deleteMemory('m1')).called(1);
  });

  testWidgets('the empty jar opens the slips tab instead of the timeline', (tester) async {
    final cubit = await build();
    await cubit.onViewChanged(MemoriesView.jar);

    final tabs = _MockTabsRouter();
    when(() => tabs.routeCollection).thenReturn(
      RouteCollection.fromList([
        AutoRoute(page: TodayRoute.page),
        AutoRoute(page: SlipsRoute.page),
      ]),
    );
    when(() => tabs.setActiveIndex(any())).thenAnswer((_) {});

    await tester.pumpApp(
      TabsRouterScope(
        controller: tabs,
        stateHash: 0,
        child: BlocProvider.value(value: cubit, child: const MemoriesPage()),
      ),
    );
    await tester.pump();

    expect(find.text('O potinho está vazio'), findsOneWidget);
    await tester.tap(find.text('Ver meus slips'));
    await tester.pump();

    verify(() => tabs.setActiveIndex(1)).called(1);
    expect(cubit.state.view, MemoriesView.timeline);
  });

  testWidgets('tapping the slip drawn from the jar opens its detail', (tester) async {
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));

    final slipRepository = _MockSlipRepository();
    when(() => slipRepository.getSlip('s1')).thenAnswer(
      (_) async => SlipDetail(
        id: 's1',
        body: 'Fez café',
        kind: SlipKind.quick,
        createdAt: DateTime(2026),
        forCard: true,
      ),
    );

    AppInjector.instance.registerFactory<MemoriesCubit>(
      () => MemoriesCubit(memoriesRepository: repository),
    );
    AppInjector.instance.registerFactory<SlipDetailCubit>(
      () => SlipDetailCubit(slipRepository: slipRepository),
    );
    addTearDown(() {
      AppInjector.instance.unregister<MemoriesCubit>();
      AppInjector.instance.unregister<SlipDetailCubit>();
    });

    final router = _TestRouter();
    await tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: Builder(
            builder: (context) => BaseApp.router(
              routerConfig: router.config(),
              theme: AppTheme.light(AppThemeScope.of(context)),
              supportedLocales: AppLocaleUtils.supportedLocales,
            ),
          ),
        ),
      ),
    );
    unawaited(router.push(const MemoriesRoute()));
    await tester.pump();
    await tester.pump();

    final cubit = tester.element(find.byType(MemoriesPage)).read<MemoriesCubit>();
    await cubit.onViewChanged(MemoriesView.jar);
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Fez café'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(router.stack.last.name, SlipDetailRoute.name);
    expect(router.stack.last.routeData.argsAs<SlipDetailRouteArgs>().id, 's1');
  });

  testWidgets('the memory rows fade in one after another and settle at rest', (tester) async {
    when(() => repository.getMemories()).thenAnswer(
      (_) async => [
        Memory(id: 'm1', title: 'Primeiro jantar', happenedOn: DateTime(2026, 5, 12)),
        Memory(id: 'm2', title: 'Nosso show', happenedOn: DateTime(2026, 2, 3)),
      ],
    );
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(Reveal), findsNWidgets(2));
    expect(_revealOpacity(tester, 0), 0);

    await tester.pump(AppMotion.stagger);

    expect(_revealOpacity(tester, 0), greaterThan(.5));
    expect(_revealOpacity(tester, 1), lessThan(.01));

    await tester.pump(AppMotion.stagger);
    await tester.pump(AppMotion.fast);

    expect(_revealOpacity(tester, 0), 1);
    expect(_revealOpacity(tester, 1), 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the drawn slip rises into place instead of popping in', (tester) async {
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));
    final cubit = await build();
    await cubit.onViewChanged(MemoriesView.jar);

    await pumpPage(tester, cubit);

    expect(find.text('Fez café'), findsOneWidget);
    expect(_revealOpacity(tester, 0), 0);

    await tester.pump(AppMotion.base);

    expect(_revealOpacity(tester, 0), 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion shows the drawn slip at rest', (tester) async {
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));
    final cubit = await build();
    await cubit.onViewChanged(MemoriesView.jar);

    await _pumpReducedMotionPage(tester, cubit);

    expect(find.text('Fez café'), findsOneWidget);
    expect(_revealOpacity(tester, 0), 1);
    expect(tester.takeException(), isNull);
  });
}
