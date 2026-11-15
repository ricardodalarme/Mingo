import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:app/features/cycle/data/repositories/cycle_repository.dart';
import 'package:app/features/cycle/presentation/sensitive_days/cubit/sensitive_days_cubit.dart';
import 'package:app/features/cycle/presentation/sensitive_days/sensitive_days_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockCycleRepository() extends Mock implements CycleRepository;

void main() {
  late CycleRepository repository;

  final today = DateTime(2026, 11, 15);

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(today);
  });

  setUp(() {
    repository = _MockCycleRepository();
    when(() => repository.getSensitiveDays())
        .thenAnswer((_) async => SensitiveDays(today: today, days: const []));
    when(() => repository.markDay(any())).thenAnswer((_) async {});
    when(() => repository.unmarkDay(any())).thenAnswer((_) async {});
  });

  Future<SensitiveDaysCubit> pumpPage(WidgetTester tester) async {
    final cubit = SensitiveDaysCubit(cycleRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const SensitiveDaysPage()));
    await tester.pump();

    return cubit;
  }

  testWidgets('the switch says today is not marked yet', (tester) async {
    await pumpPage(tester);

    expect(find.text('Hoje é um dia sensível'), findsOneWidget);
    expect(find.text('Não marcado'), findsOneWidget);
    expect(find.text('Seus dias marcados'), findsOneWidget);
  });

  testWidgets('turning the switch on marks today', (tester) async {
    final cubit = await pumpPage(tester);

    await tester.tap(find.byType(BaseSwitch));
    await tester.pump();

    verify(() => repository.markDay(today)).called(1);
    expect(cubit.state.currentDays?.isTodayMarked, isTrue);
    expect(find.text('Marcado'), findsOneWidget);
  });

  testWidgets('the screen keeps the partner out of the copy', (tester) async {
    await pumpPage(tester);

    expect(find.textContaining('Seu par não vê esta tela'), findsOneWidget);
    expect(find.text('Avisar meu par'), findsOneWidget);
  });
}
