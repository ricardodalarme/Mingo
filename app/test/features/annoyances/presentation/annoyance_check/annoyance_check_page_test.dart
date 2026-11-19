import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/annoyance_check_page.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/cubit/annoyance_check_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the annoyance is a quiet large note with its age and when it fades', (tester) async {
    await withClock(Clock.fixed(DateTime(2026, 11, 10, 12)), () async {
      final repository = _MockAnnoyanceRepository();
      when(() => repository.get('a1')).thenAnswer(
        (_) async => Annoyance(
          id: 'a1',
          body: 'Fiquei com a louça sozinha',
          createdAt: DateTime(2026, 11, 7, 12),
          expiresAt: DateTime(2026, 11, 21, 12),
        ),
      );
      final cubit = AnnoyanceCheckCubit(annoyanceRepository: repository);
      addTearDown(cubit.close);
      await cubit.load('a1');

      await tester.pumpApp(
        BlocProvider.value(
          value: cubit,
          child: const AnnoyanceCheckPage(id: 'a1'),
        ),
      );
      await tester.pump();

      final note = tester.widget<BaseSlipNote>(find.byType(BaseSlipNote));
      expect(note.type, SlipNoteType.annoyed);
      expect(note.size, SlipNoteSize.large);
      expect(note.text, 'Fiquei com a louça sozinha');
      expect(find.text('há 3 dias · some em 11 dias'), findsOneWidget);
      expect(find.text('ME INCOMODOU'), findsOneWidget);
    });
  });
}
