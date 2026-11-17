import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/features/slips/presentation/slips_search/cubit/slips_search_cubit.dart';
import 'package:app/features/slips/presentation/slips_search/slips_search_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  setUpAll(() {
    registerFallbackValue(const SlipFilter());
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  late SlipRepository repository;

  setUp(() {
    repository = _MockSlipRepository();
    when(() => repository.getSlips(filter: any(named: 'filter')))
        .thenAnswer((_) async => const SlipPage(items: [], hasNext: false));
  });

  void stubPage(List<SlipEntry> items) {
    when(() => repository.getSlips(filter: any(named: 'filter')))
        .thenAnswer((_) async => SlipPage(items: items, hasNext: false));
  }

  Future<SlipsSearchCubit> build({bool search = true}) async {
    final cubit = SlipsSearchCubit(slipRepository: repository);
    addTearDown(cubit.close);
    if (search) await cubit.start();

    return cubit;
  }

  Future<void> pumpPage(WidgetTester tester, SlipsSearchCubit cubit) async {
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const SlipsSearchPage()));
    await tester.pump();
  }

  testWidgets('the board filters and a matching result are on the page', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 11, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.text('Este mês'), findsOneWidget);
      expect(find.text('Privado'), findsOneWidget);
      expect(find.text('Em um cartão'), findsOneWidget);
      expect(find.text('Trabalho invisível'), findsOneWidget);
      expect(find.text('Fez café sem eu pedir'), findsOneWidget);
      expect(find.byType(BaseSectionHeader), findsNothing);
    });
  });

  testWidgets('an empty search with no slips invites the first slip', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.text('Nada ainda'), findsOneWidget);
    expect(find.text('Adicionar um slip'), findsOneWidget);
  });

  testWidgets('a typed search with no match says to try another word', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);
    cubit.onQueryChanged('xyz');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();

    expect(find.text('Nada encontrado'), findsOneWidget);
    expect(find.text('Tente outra palavra.'), findsOneWidget);
  });

  testWidgets('a filter with no match says to adjust the filters', (tester) async {
    final cubit = await build();

    await pumpPage(tester, cubit);
    await cubit.toggle(SlipsSearchFilter.invisible);
    await tester.pump();

    expect(find.text('Nada encontrado'), findsOneWidget);
    expect(find.text('Ajuste a busca ou os filtros.'), findsOneWidget);
  });

  testWidgets('a failed search shows the shared error with a retry', (tester) async {
    when(() => repository.getSlips(filter: any(named: 'filter')))
        .thenAnswer((_) async => throw Exception());
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(AppErrorView), findsOneWidget);
  });

  testWidgets('results fit at 200% text', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 11, 12)), () async {
      stubPage([
        SlipEntry(
          id: 'a',
          body: 'Ela ficou acordada para me levar ao aeroporto de madrugada',
          createdAt: clock.now(),
        ),
      ]);
      final cubit = await build();

      await tester.pumpApp(
        Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)),
            child: BlocProvider.value(value: cubit, child: const SlipsSearchPage()),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(SlipsGroups), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
