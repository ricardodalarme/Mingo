import 'dart:async';

import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/jar/cubit/jar_cubit.dart';
import 'package:app/features/memories/presentation/jar/jar_page.dart';
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

double _revealOpacity(WidgetTester tester, int index) => tester
    .widget<Opacity>(
      find.descendant(of: find.byType(Reveal).at(index), matching: find.byType(Opacity)).first,
    )
    .opacity;

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NotFoundRoute.page, initial: true),
    AutoRoute(page: JarRoute.page, path: '/jar'),
    AutoRoute(page: SlipDetailRoute.page, path: '/slip/:id'),
  ];
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late MemoriesRepository repository;

  setUp(() {
    repository = _MockMemoriesRepository();
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));
  });

  Future<JarCubit> build() async {
    final cubit = JarCubit(memoriesRepository: repository);
    addTearDown(cubit.close);
    await cubit.draw();

    return cubit;
  }

  testWidgets('an empty jar says so and offers the slips', (tester) async {
    when(() => repository.drawFromJar()).thenAnswer((_) async => null);
    final cubit = await build();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const JarPage()));
    await tester.pump();

    expect(find.text('O potinho está vazio'), findsOneWidget);
    expect(find.text('Ver meus slips'), findsOneWidget);
  });

  testWidgets('tapping the slip drawn from the jar opens its detail', (tester) async {
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
    AppInjector.instance.registerFactory<JarCubit>(() => JarCubit(memoriesRepository: repository));
    AppInjector.instance.registerFactory<SlipDetailCubit>(
      () => SlipDetailCubit(slipRepository: slipRepository),
    );
    addTearDown(() {
      AppInjector.instance.unregister<JarCubit>();
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
    unawaited(router.push(const JarRoute()));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    await tester.tap(find.text('Fez café'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(router.stack.last.name, SlipDetailRoute.name);
    expect(router.stack.last.routeData.argsAs<SlipDetailRouteArgs>().id, 's1');
  });

  testWidgets('the drawn slip rises into place instead of popping in', (tester) async {
    final cubit = await build();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const JarPage()));
    await tester.pump();

    expect(find.text('Fez café'), findsOneWidget);
    expect(_revealOpacity(tester, 0), 0);

    await tester.pump(AppMotion.base);

    expect(_revealOpacity(tester, 0), 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion shows the drawn slip at rest', (tester) async {
    final cubit = await build();

    await tester.pumpApp(
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: BlocProvider.value(value: cubit, child: const JarPage()),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Fez café'), findsOneWidget);
    expect(_revealOpacity(tester, 0), 1);
    expect(tester.takeException(), isNull);
  });
}
