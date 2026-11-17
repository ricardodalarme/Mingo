import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:app/features/spice/presentation/spice/cubit/spice_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceRepository() extends Mock implements SpiceRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

void main() {
  late SpiceRepository spice;
  late PairingRepository pairing;

  const off = SpiceStatus(stage: SpiceStage.off, myLevel: SpiceLevel.soft);

  setUp(() {
    spice = _MockSpiceRepository();
    pairing = _MockPairingRepository();
    when(spice.getStatus).thenAnswer((_) async => off);
    when(pairing.getPartner).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );
    when(spice.turnOn).thenAnswer((_) async {});
    when(spice.turnOff).thenAnswer((_) async {});
  });

  SpiceCubit build() => SpiceCubit(spiceRepository: spice, pairingRepository: pairing);

  test('load reads the mode and whether there is a partner', () async {
    final cubit = build();

    await cubit.load();

    expect(cubit.state.status, const Success(off));
    expect(cubit.state.hasPartner, isTrue);
  });

  test('turning on without saying the person is an adult asks for it', () async {
    final cubit = build();

    await cubit.turnOn();

    expect(cubit.state.showAdultError, isTrue);
    verifyNever(spice.turnOn);
  });

  test('turning on after the adult confirmation switches the mode on and reads it again', () async {
    final cubit = build();
    await cubit.load();
    cubit.onAdultChanged(isAdult: true);

    await cubit.turnOn();

    verify(spice.turnOn).called(1);
    verify(spice.getStatus).called(2);
  });

  test('a failed switch shows the failure and keeps the status', () async {
    when(spice.turnOff).thenThrow(Exception('offline'));
    final cubit = build();
    await cubit.load();
    final actions = <Resource<void>>[];
    cubit.stream.listen((state) => actions.add(state.changeAction));

    await cubit.turnOff();
    await pumpEventQueue();

    expect(actions.whereType<Failure>(), isNotEmpty);
    expect(cubit.state.status, const Success(off));
  });
}
