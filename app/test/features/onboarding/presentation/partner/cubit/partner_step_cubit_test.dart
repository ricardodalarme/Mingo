import 'package:app/features/onboarding/presentation/partner/cubit/partner_step_cubit.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/partner_intent.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late ProfileRepository profile;
  late PartnerStepCubit cubit;

  setUp(() {
    profile = _MockProfileRepository();
    cubit = PartnerStepCubit(profileRepository: profile);
    when(() => profile.getMyProfile())
        .thenAnswer((_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials));
    when(
      () => profile.updatePartnerIntent(
        profileId: any(named: 'profileId'),
        intent: any(named: 'intent'),
      ),
    ).thenAnswer((_) async {});
  });

  test('starts on inviting now', () {
    expect(cubit.state, PartnerChoice.invite);
  });

  test('saves the chosen intent', () async {
    cubit.choose(PartnerChoice.soloOnly);
    await cubit.save();

    verify(() => profile.updatePartnerIntent(profileId: 'p1', intent: PartnerIntent.soloOnly))
        .called(1);
  });

  test('a failed save does not stop the person', () async {
    when(
      () => profile.updatePartnerIntent(
        profileId: any(named: 'profileId'),
        intent: any(named: 'intent'),
      ),
    ).thenThrow(Exception('offline'));

    await cubit.save();

    expect(cubit.state, PartnerChoice.invite);
  });
}
