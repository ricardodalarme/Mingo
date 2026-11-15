import 'dart:async';

import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/features/slips/presentation/slips/slips_page.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

double _rowOpacity(WidgetTester tester, int index) => tester
    .widget<Opacity>(
      find.descendant(of: find.byType(Reveal).at(index), matching: find.byType(Opacity)).first,
    )
    .opacity;

Future<void> _pumpReducedMotionPage(WidgetTester tester, SlipsListCubit cubit) async {
  await tester.pumpApp(
    Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: true),
        child: BlocProvider.value(value: cubit, child: const SlipsPage()),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late SlipRepository repository;
  late StreamController<void> changes;

  setUp(() {
    repository = _MockSlipRepository();
    changes = StreamController<void>.broadcast();
    when(() => repository.onChanged).thenAnswer((_) => changes.stream);
  });

  tearDown(() => changes.close());

  void stubPage(List<SlipEntry> items) {
    when(
      () => repository.getSlips(
        after: any(named: 'after'),
        since: any(named: 'since'),
        archived: any(named: 'archived'),
        pageSize: any(named: 'pageSize'),
      ),
    ).thenAnswer((_) async => SlipPage(items: items, hasNext: false));
  }

  Future<SlipsListCubit> build() async {
    final cubit = SlipsListCubit(slipRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    return cubit;
  }

  Future<void> pumpPage(WidgetTester tester, SlipsListCubit cubit) async {
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const SlipsPage()));
    await tester.pump();
  }

  testWidgets('an empty list shows the title, search and the empty invitation', (tester) async {
    stubPage(const []);
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(BaseEmptyState), findsOneWidget);
    expect(find.byType(BaseChoiceChip), findsNWidgets(3));
    expect(find.text('Arquivados'), findsOneWidget);
    expect(find.byType(BaseTextLink), findsNothing);
    expect(find.byType(BaseRoundButton), findsOneWidget);
    expect(find.byType(SlipsGroups), findsNothing);
    expect(find.text('Slips'), findsOneWidget);
  });

  testWidgets('a populated list keeps the scopes, search and the history link', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.byType(BaseEmptyState), findsNothing);
      expect(find.byType(BaseChoiceChip), findsNWidgets(3));
      expect(find.text('Arquivados'), findsOneWidget);
      expect(find.byType(BaseTextLink), findsNothing);
      expect(find.text('Cartões anteriores'), findsOneWidget);
      expect(find.byType(BaseRoundButton), findsOneWidget);
      expect(find.byType(SlipsGroups), findsOneWidget);
      expect(find.text('Fez café sem eu pedir'), findsOneWidget);
    });
  });

  testWidgets('search filters the loaded slips and reports no matches', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await pumpPage(tester, cubit);
      cubit
        ..openSearch()
        ..onQueryChanged('café');
      await tester.pump();
      await tester.pump();

      expect(find.text('Fez café sem eu pedir'), findsOneWidget);

      cubit.onQueryChanged('xyz');
      await tester.pump();
      await tester.pump();

      expect(find.byType(SlipsGroups), findsNothing);
      expect(find.byType(BaseEmptyState), findsOneWidget);
      expect(find.text('Nada encontrado'), findsOneWidget);
      expect(find.text('Limpar busca'), findsOneWidget);
    });
  });

  testWidgets('search without a single slip still reports no matches', (tester) async {
    stubPage(const []);
    final cubit = await build();

    await pumpPage(tester, cubit);
    cubit
      ..openSearch()
      ..onQueryChanged('xyz');
    await tester.pump();
    await tester.pump();

    expect(find.text('Nada encontrado'), findsOneWidget);
    expect(find.text('Nada ainda'), findsNothing);
    expect(find.text('Limpar busca'), findsOneWidget);
  });

  testWidgets('a detailed slip shows its kind on the list row', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(
          id: 'a',
          body: 'Deixou um bilhete no espelho',
          kind: SlipKind.specific,
          createdAt: clock.now(),
        ),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.text('Ter · Específico'), findsOneWidget);
    });
  });

  testWidgets('the week rows fade in one after another and settle at rest', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now()),
        SlipEntry(id: 'b', body: 'Deixou um bilhete no espelho', createdAt: clock.now()),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.byType(Reveal), findsNWidgets(2));
      expect(_rowOpacity(tester, 0), 0);
      expect(_rowOpacity(tester, 1), 0);

      await tester.pump(AppMotion.stagger);

      expect(_rowOpacity(tester, 0), greaterThan(.5));
      expect(_rowOpacity(tester, 1), lessThan(.01));

      await tester.pump(AppMotion.stagger);
      await tester.pump(AppMotion.fast);

      expect(_rowOpacity(tester, 0), 1);
      expect(_rowOpacity(tester, 1), 1);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('reduced motion shows the week rows at rest', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await _pumpReducedMotionPage(tester, cubit);

      expect(_rowOpacity(tester, 0), 1);
      expect(find.text('Fez café sem eu pedir'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
