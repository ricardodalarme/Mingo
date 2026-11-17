import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/fragments/generated/SpiceChallengeFragment.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceNextCard.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceAnswers.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceDesires.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceState.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDataSource() extends Mock implements SpiceDataSource;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late SpiceDataSource dataSource;
  late ProfileRepository profile;
  late AuthenticationRepository authentication;
  late SpiceRepository repository;

  setUp(() {
    dataSource = _MockDataSource();
    profile = _MockProfileRepository();
    authentication = _MockAuthenticationRepository();
    repository = SpiceRepository(
      dataSource: dataSource,
      profileRepository: profile,
      authenticationRepository: authentication,
    );
    when(() => authentication.currentUserId).thenReturn('me');
    when(profile.getMySettings).thenAnswer((_) async => const AccountSettings(theme: .rose));
  });

  test('the state becomes a stage and the levels', () async {
    when(
      dataSource.getState,
    ).thenAnswer((_) async => QuerySpiceStatespiceState(state: 'on', myLevel: 3, coupleLevel: 1));

    final status = await repository.getStatus();

    expect(status.stage, SpiceStage.on);
    expect(status.myLevel, SpiceLevel.hot);
    expect(status.coupleLevel, SpiceLevel.soft);
  });

  test('turning on confirms the adult declaration first', () async {
    when(() => dataSource.grantAdultConsent(any())).thenAnswer((_) async {});
    when(
      () => dataSource.setEnabled(
        userId: any(named: 'userId'),
        enabled: any(named: 'enabled'),
      ),
    ).thenAnswer((_) async {});

    await repository.turnOn();

    verifyInOrder([
      () => dataSource.grantAdultConsent(adultConsentVersion),
      () => dataSource.setEnabled(userId: 'me', enabled: true),
    ]);
  });

  test('a card carries its text and whether the person proposed it', () async {
    when(dataSource.nextCard).thenAnswer(
      (_) async =>
          MutationSpiceNextCardspiceNextCard(id: 'c1', contentSlug: 's1', proposedBy: 'me'),
    );
    when(
      () => dataSource.getTexts(
        slugs: ['s1'],
        locale: any(named: 'locale'),
      ),
    ).thenAnswer((_) async => {'s1': 'Uma massagem'});

    final card = await repository.getNextCard();

    expect(card, const SpiceCard(id: 'c1', text: 'Uma massagem', isMine: true));
  });

  test('a desire carries the answer the person gave', () async {
    when(
      () => dataSource.getDesires(
        locale: any(named: 'locale'),
        maxLevel: any(named: 'maxLevel'),
      ),
    ).thenAnswer(
      (_) async => [QuerySpiceDesirescontentItems(slug: 'd1', title: 'Um jantar', level: 1)],
    );
    when(dataSource.getAnswers).thenAnswer(
      (_) async => [
        QueryMySpiceAnswersspiceDesireAnswers(contentSlug: 'd1', answer: EnumSpiceAnswer_enum.want),
      ],
    );

    final desires = await repository.getDesires(SpiceLevel.warm);

    expect(desires.single.answer, SpiceAnswer.want);
    verify(() => dataSource.getDesires(locale: any(named: 'locale'), maxLevel: 2)).called(1);
  });

  test('the challenge shows who accepted and how many swaps are left', () async {
    when(dataSource.getChallenge).thenAnswer(
      (_) async => FragmentSpiceChallengeFragment(
        id: 'ch',
        contentSlug: 's1',
        acceptedBy: ['me', 'you'],
        doneBy: [],
        swaps: 1,
      ),
    );
    when(
      () => dataSource.getTexts(
        slugs: ['s1'],
        locale: any(named: 'locale'),
      ),
    ).thenAnswer((_) async => {'s1': 'Uma noite sem telas'});

    final challenge = await repository.getChallenge();

    expect(challenge!.acceptedByMe, isTrue);
    expect(challenge.acceptedByPartner, isTrue);
    expect(challenge.doneByMe, isFalse);
    expect(challenge.swapsLeft, 2);
  });
}
