import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/mood_page.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late MoodRepository repository;

  final day = DateTime(2026, 11, 10);

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockMoodRepository();
    when(() => repository.readCachedTodayMood()).thenReturn(null);
  });

  MoodCubit build({
    MoodShare share = MoodShare.none,
    bool hasPartner = true,
    String? partnerName = 'Marina',
  }) {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => (
        entry: MoodEntry(id: 'm1', day: day, mood: MoodKind.tired, share: share),
        partnerMood: null,
        partnerName: partnerName,
        hasPartner: hasPartner,
      ),
    );
    final cubit = MoodCubit(moodRepository: repository, slipRepository: _MockSlipRepository());
    addTearDown(cubit.close);

    return cubit;
  }

  Future<void> pumpPage(WidgetTester tester, MoodCubit cubit) async {
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const MoodPage()));
    await tester.pump();
  }

  testWidgets('a private mood says only you see it', (tester) async {
    await pumpPage(tester, build());

    expect(find.text('só você vê'), findsOneWidget);
  });

  testWidgets('a shared mood says who sees it', (tester) async {
    await pumpPage(tester, build(share: MoodShare.moodNeed));

    expect(find.text('compartilhado com Marina'), findsOneWidget);
    expect(find.text('só você vê'), findsNothing);
  });

  testWidgets('a shared row with no partner still reads as private', (tester) async {
    await pumpPage(tester, build(share: MoodShare.mood, hasPartner: false, partnerName: null));

    expect(find.text('só você vê'), findsOneWidget);
  });

  testWidgets('a long partner name fits the app bar', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await pumpPage(
      tester,
      build(share: MoodShare.mood, partnerName: 'Ana Beatriz de Albuquerque Nascimento'),
    );

    expect(tester.takeException(), isNull);
  });
}
