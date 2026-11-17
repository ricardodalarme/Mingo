import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/desires/cubit/spice_desires_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

void main() {
  late SpiceRepository spice;
  const desire = SpiceDesire(slug: 'd1', title: 'Um jantar', level: SpiceLevel.soft);

  setUp(() {
    spice = _MockSpiceRepository();
    when(spice.getStatus).thenAnswer(
      (_) async => const SpiceStatus(
        stage: SpiceStage.on,
        myLevel: SpiceLevel.warm,
        coupleLevel: SpiceLevel.soft,
      ),
    );
    when(() => spice.getDesires(any())).thenAnswer((_) async => [desire]);
    when(spice.getMatches)
        .thenAnswer((_) async => const [SpiceMatch(slug: 'd1', title: 'Um jantar')]);
    when(
      () => spice.answerDesire(
        slug: any(named: 'slug'),
        answer: any(named: 'answer'),
      ),
    ).thenAnswer((_) async {});
  });

  List<SpiceDesire> desiresOf(SpiceDesiresCubit cubit) =>
      (cubit.state.desires as Success<List<SpiceDesire>>).value;

  test('the desires follow the level the couple shares', () async {
    final cubit = SpiceDesiresCubit(spiceRepository: spice);

    await cubit.load();

    verify(() => spice.getDesires(SpiceLevel.soft)).called(1);
    expect(desiresOf(cubit), [desire]);
    expect(cubit.state.matches, hasLength(1));
  });

  test('the free plan sees the desires without the matches', () async {
    when(spice.getMatches).thenThrow(const LocalizedException(l10nKey: 'PLUS_REQUIRED'));
    final cubit = SpiceDesiresCubit(spiceRepository: spice);

    await cubit.load();

    expect(cubit.state.desires, isA<Success<List<SpiceDesire>>>());
    expect(cubit.state.matches, isNull);
  });

  test('an answer shows at once and is put back when the server refuses it', () async {
    final cubit = SpiceDesiresCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.answer(desire, SpiceAnswer.want);
    expect(desiresOf(cubit).single.answer, SpiceAnswer.want);

    when(
      () => spice.answerDesire(
        slug: any(named: 'slug'),
        answer: any(named: 'answer'),
      ),
    ).thenThrow(Exception('plus'));
    await cubit.answer(desiresOf(cubit).single, SpiceAnswer.maybe);
    expect(desiresOf(cubit).single.answer, SpiceAnswer.want);
  });
}
