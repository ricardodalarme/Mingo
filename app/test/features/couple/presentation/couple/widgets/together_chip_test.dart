import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/couple/presentation/couple/widgets/together_chip.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockHistoryRepository() extends Mock implements HistoryRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('alone the chip only names the story', (tester) async {
    final cubit = CoupleCubit(
      historyRepository: _MockHistoryRepository(),
      pairingRepository: _MockPairingRepository(),
    );
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const TogetherChip()));

    expect(find.text('Nossa história'), findsOneWidget);
  });

  testWidgets('together the chip shows how long the couple has been together', (tester) async {
    final cubit = CoupleCubit(
      historyRepository: _MockHistoryRepository(),
      pairingRepository: _MockPairingRepository(),
    )..emit(CoupleState(togetherSince: DateTime(2024, 11, 17), hasPartner: true));
    addTearDown(cubit.close);

    await withClock(Clock.fixed(DateTime(2026, 11, 17)), () async {
      await tester.pumpApp(BlocProvider.value(value: cubit, child: const TogetherChip()));
    });

    expect(find.textContaining('2'), findsWidgets);
    expect(find.text('Nossa história'), findsNothing);
  });
}
