import 'package:app/features/_shared/presentation/forms/discard_changes.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:app/features/slips/presentation/quick_slip/quick_slip_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  testWidgets('an unsaved quick slip is guarded before leaving', (tester) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    final cubit =
        QuickSlipCubit(slipRepository: repository, annoyanceRepository: _MockAnnoyanceRepository())
          ..start()
          ..onTextChanged('Fez café');
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(tester.widget<DirtyFormGuard>(find.byType(DirtyFormGuard)).isDirty, isTrue);
  });

  testWidgets('a new slip starts as a good thing, with the switch to what bothered', (
    tester,
  ) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    final cubit = QuickSlipCubit(
      slipRepository: repository,
      annoyanceRepository: _MockAnnoyanceRepository(),
    )..start();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(find.text('Gostei'), findsOneWidget);
    expect(find.text('Me incomodou'), findsOneWidget);
    expect(cubit.state.mode, QuickSlipMode.liked);
  });
}
