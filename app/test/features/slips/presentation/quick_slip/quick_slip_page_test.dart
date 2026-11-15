import 'package:app/features/_shared/presentation/forms/discard_changes.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:app/features/slips/presentation/quick_slip/quick_slip_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(SlipPolarity.liked);
  });

  testWidgets('an unsaved quick slip is guarded before leaving', (tester) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
        polarity: any(named: 'polarity'),
        request: any(named: 'request'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    final cubit = QuickSlipCubit(slipRepository: repository)
      ..start()
      ..onTextChanged('Fez café');
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();

    expect(tester.widget<DirtyFormGuard>(find.byType(DirtyFormGuard)).isDirty, isTrue);
  });

  testWidgets('choosing me incomodou switches the privacy note and shows the request', (
    tester,
  ) async {
    final repository = _MockSlipRepository();
    when(() => repository.readDraft(any())).thenReturn(null);
    when(
      () => repository.saveDraft(
        text: any(named: 'text'),
        now: any(named: 'now'),
        category: any(named: 'category'),
        polarity: any(named: 'polarity'),
        request: any(named: 'request'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    final cubit = QuickSlipCubit(slipRepository: repository)..start();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const QuickSlipPage()));
    await tester.pump();
    expect(find.text('Fica só com você. Um slip assim nunca entra no cartão.'), findsNothing);
    expect(find.text('Um pedido, se quiser'), findsNothing);

    await tester.tap(find.text('Me incomodou'));
    await tester.pump();

    expect(cubit.state.polarity, SlipPolarity.bothered);
    expect(find.text('Fica só com você. Um slip assim nunca entra no cartão.'), findsOneWidget);
    expect(find.text('Um pedido, se quiser'), findsOneWidget);
  });
}
