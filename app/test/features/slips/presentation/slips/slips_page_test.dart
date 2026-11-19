import 'dart:async';

import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_filter.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/features/slips/presentation/slips/slips_page.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

double _noteOpacity(WidgetTester tester, int index) => tester
    .widget<Opacity>(
      find
          .descendant(of: find.byType(BaseSlipNote).at(index), matching: find.byType(Opacity))
          .first,
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
  setUpAll(() => registerFallbackValue(const SlipFilter()));

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late SlipRepository repository;

  setUp(() {
    repository = _MockSlipRepository();
  });

  void stubPage(List<SlipEntry> items) {
    when(
      () => repository.watchSlips(
        count: any(named: 'count'),
        filter: any(named: 'filter'),
      ),
    ).thenAnswer((_) => Stream.value(PageInfo<SlipEntry>(items: items, hasNext: false)));
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

  testWidgets('an empty list shows the title, the filters and the empty invitation', (
    tester,
  ) async {
    stubPage(const []);
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(BaseEmptyState), findsOneWidget);
    expect(find.byType(BaseChoiceChip), findsNWidgets(4));
    expect(find.text('Privado'), findsOneWidget);
    expect(find.byType(BaseRoundButton), findsOneWidget);
    expect(find.byType(SlipsGroups), findsNothing);
    expect(find.text('Slips'), findsOneWidget);
  });

  testWidgets('a populated list shows the slips', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.byType(BaseEmptyState), findsNothing);
      expect(find.byType(BaseChoiceChip), findsNWidgets(4));
      expect(find.byType(SlipsGroups), findsOneWidget);
      expect(find.text('Fez café sem eu pedir'), findsOneWidget);
      expect(find.text('Slips são sempre livres.'), findsNothing);
    });
  });

  testWidgets('a detailed slip shows its kind and day on the note', (tester) async {
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

      expect(find.text('ESPECÍFICO'), findsOneWidget);
      expect(find.text('Ter'), findsOneWidget);
    });
  });

  testWidgets('a slip with a category takes that type on its note', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(
          id: 'a',
          body: 'Me ouviu até o fim',
          category: SlipCategory.said,
          createdAt: clock.now(),
        ),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.text('DISSE ALGO'), findsOneWidget);
      expect(find.byIcon(AppIcons.message), findsOneWidget);
    });
  });

  testWidgets('the week line counts the notes and says only the person sees them', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now()),
        SlipEntry(id: 'b', body: 'Deixou um bilhete', createdAt: clock.now()),
        SlipEntry(id: 'c', body: 'Buscou o pão', createdAt: clock.now()),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.text('3 coisas boas desta semana. Só você vê.'), findsOneWidget);
    });
  });

  testWidgets('the add card is the last item of the week and opens nothing else', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now()),
        SlipEntry(id: 'b', body: 'Deixou um bilhete', createdAt: clock.now()),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.byType(BaseSlipNote), findsNWidgets(2));
      expect(find.text('Anotar mais um'), findsOneWidget);
      final addTop = tester.getTopLeft(find.byType(BaseSlipNoteAdd)).dy;
      final lastNoteTop = tester.getTopLeft(find.byType(BaseSlipNote).last).dy;
      expect(addTop, greaterThanOrEqualTo(lastNoteTop - 40));
    });
  });

  testWidgets('the notes fade in on the first load and settle at rest', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now()),
        SlipEntry(id: 'b', body: 'Deixou um bilhete no espelho', createdAt: clock.now()),
      ]);
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(_noteOpacity(tester, 0), 0);
      expect(_noteOpacity(tester, 1), 0);

      await tester.pump(const Duration(milliseconds: 250));

      expect(_noteOpacity(tester, 0), 1);
      expect(_noteOpacity(tester, 1), 1);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('reduced motion shows the notes at rest', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([SlipEntry(id: 'a', body: 'Fez café sem eu pedir', createdAt: clock.now())]);
      final cubit = await build();

      await _pumpReducedMotionPage(tester, cubit);

      expect(_noteOpacity(tester, 0), 1);
      expect(find.text('Fez café sem eu pedir'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('a long list builds lazily and asks for the next page near the end', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      final items = [
        for (var i = 0; i < 40; i++)
          SlipEntry(id: 'id-$i', body: 'Slip número $i', createdAt: clock.now()),
      ];
      when(
        () => repository.watchSlips(
          count: any(named: 'count'),
          filter: any(named: 'filter'),
        ),
      ).thenAnswer((_) => Stream.value(PageInfo<SlipEntry>(items: items, hasNext: true)));
      final cubit = await build();

      await pumpPage(tester, cubit);

      expect(find.byType(BaseSlipNote).evaluate().length, lessThan(20));
      expect(find.text('Slip número 39'), findsNothing);

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -20000));
      await tester.pump(const Duration(milliseconds: 300));

      verify(
        () => repository.watchSlips(
          count: 2 * slipPageSize,
          filter: any(named: 'filter'),
        ),
      ).called(greaterThanOrEqualTo(1));
    });
  });

  testWidgets('the private scope with nothing in it says so', (tester) async {
    stubPage(const []);
    final cubit = await build();
    await cubit.changeScope(SlipsScope.private);

    await pumpPage(tester, cubit);

    expect(find.text('Nada privado por aqui'), findsOneWidget);
    expect(find.text('Nada ainda'), findsNothing);
  });

  testWidgets('a failed read shows the shared error with a retry', (tester) async {
    when(
      () => repository.watchSlips(
        count: any(named: 'count'),
        filter: any(named: 'filter'),
      ),
    ).thenAnswer((_) => Stream.error(Exception()));
    final cubit = await build();

    await pumpPage(tester, cubit);

    expect(find.byType(AppErrorView), findsOneWidget);
  });

  testWidgets('rows and filters fit at 200% text', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 3, 10, 12)), () async {
      stubPage([
        SlipEntry(
          id: 'a',
          body: 'Ela ficou acordada para me levar ao aeroporto de madrugada',
          createdAt: clock.now(),
          forCard: false,
        ),
      ]);
      final cubit = await build();

      await tester.pumpApp(
        Builder(
          builder: (context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(2)),
            child: BlocProvider.value(value: cubit, child: const SlipsPage()),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });
  });
}
