import 'dart:async';

import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_form.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  setUpAll(() {
    registerFallbackValue(MoodKind.happy);
    registerFallbackValue(MoodShare.none);
    registerFallbackValue(NeedKind.hug);
  });

  testWidgets('the share step is disabled while a save is in flight', (tester) async {
    final repository = _MockMoodRepository();
    final pending = Completer<MoodEntry>();
    when(repository.getTodayMood).thenAnswer((_) async {
      return (entry: null, partnerMood: null, partnerName: 'Marina');
    });
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) => pending.future);
    final cubit = MoodCubit(moodRepository: repository, slipRepository: _MockSlipRepository());
    await cubit.load();
    cubit.selectMood(MoodKind.happy);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const MoodForm()));

    expect(find.text('Próximo'), findsOneWidget);

    await tester.tap(find.text('Próximo'));
    await tester.pump();

    expect(cubit.state.isChoosingShare, isTrue);
    expect(find.text('Manter privado'), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pump();
    expect(cubit.state.saveAction.isLoading, isTrue);

    final shareOption = find.text('Só meu humor');
    await tester.tap(shareOption);
    await tester.pump();

    expect(cubit.state.mood, MoodKind.happy);
    expect(cubit.state.share, MoodShare.none);

    pending.complete(
      MoodEntry(id: 'm1', day: DateTime(2026, 11, 11), mood: MoodKind.happy, share: MoodShare.none),
    );
    await tester.pump();
    await cubit.close();
  });

  testWidgets('every mood card takes the same width', (tester) async {
    final repository = _MockMoodRepository();
    when(repository.getTodayMood)
        .thenAnswer((_) async => (entry: null, partnerMood: null, partnerName: 'Marina'));
    final cubit = MoodCubit(moodRepository: repository, slipRepository: _MockSlipRepository());
    await cubit.load();
    addTearDown(cubit.close);

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const MoodForm()));

    final widths = [
      for (final label in ['Feliz', 'Cansado(a)', 'Estressado(a)', 'Brincalhão(ona)'])
        tester
            .getSize(
              find.ancestor(of: find.text(label), matching: find.byType(AnimatedContainer)).first,
            )
            .width,
    ];

    expect(widths, hasLength(4));
    expect(widths.toSet(), hasLength(1));
  });

  testWidgets('the next step waits for a mood and the back button returns to it', (tester) async {
    final repository = _MockMoodRepository();
    when(repository.getTodayMood)
        .thenAnswer((_) async => (entry: null, partnerMood: null, partnerName: 'Marina'));
    final cubit = MoodCubit(moodRepository: repository, slipRepository: _MockSlipRepository());
    await cubit.load();
    addTearDown(cubit.close);

    cubit.next();

    expect(cubit.state.isChoosingShare, isFalse);

    cubit
      ..selectMood(MoodKind.tired)
      ..next();

    expect(cubit.state.isChoosingShare, isTrue);

    cubit.back();

    expect(cubit.state.isChoosingShare, isFalse);
  });
}
