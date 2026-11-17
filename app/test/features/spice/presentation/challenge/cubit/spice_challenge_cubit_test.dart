import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/challenge/cubit/spice_challenge_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

void main() {
  late SpiceRepository spice;
  const fresh = SpiceChallenge(
    text: 'Uma noite sem telas',
    acceptedByMe: false,
    doneByMe: false,
    acceptedByPartner: false,
    swapsLeft: 3,
  );
  const accepted = SpiceChallenge(
    text: 'Uma noite sem telas',
    acceptedByMe: true,
    doneByMe: false,
    acceptedByPartner: false,
    swapsLeft: 3,
  );

  setUp(() {
    spice = _MockSpiceRepository();
    when(spice.getChallenge).thenAnswer((_) async => fresh);
    when(() => spice.actOnChallenge(any())).thenAnswer((_) async => accepted);
  });

  test('load shows this week challenge', () async {
    final cubit = SpiceChallengeCubit(spiceRepository: spice);

    await cubit.load();

    expect(cubit.state.challenge, const Success<SpiceChallenge?>(fresh));
  });

  test('accepting shows the challenge the server returns', () async {
    final cubit = SpiceChallengeCubit(spiceRepository: spice);
    await cubit.load();

    await cubit.act(SpiceChallengeAction.accept);

    verify(() => spice.actOnChallenge(SpiceChallengeAction.accept)).called(1);
    expect(cubit.state.challenge, const Success<SpiceChallenge?>(accepted));
  });

  test('a refused swap keeps the challenge and shows the failure', () async {
    when(() => spice.actOnChallenge(any()))
        .thenThrow(const LocalizedException(l10nKey: 'SWAP_LIMIT'));
    final cubit = SpiceChallengeCubit(spiceRepository: spice);
    await cubit.load();
    final actions = <Resource<void>>[];
    cubit.stream.listen((state) => actions.add(state.actAction));

    await cubit.act(SpiceChallengeAction.swap);
    await pumpEventQueue();

    expect(actions.whereType<Failure>(), isNotEmpty);
    expect(cubit.state.challenge, const Success<SpiceChallenge?>(fresh));
  });
}
