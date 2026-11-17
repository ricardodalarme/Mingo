import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/profile/data/data_sources/remote/fragments/generated/ProfileFragment.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/profile_data_source.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockProfileDataSource() extends Mock implements ProfileDataSource;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late ProfileDataSource dataSource;
  late ProfileRepository repository;

  setUp(() {
    dataSource = _MockProfileDataSource();
    final authenticationRepository = _MockAuthenticationRepository();
    when(() => authenticationRepository.currentUserId).thenReturn('p1');
    repository = ProfileRepository(
      profileDataSource: dataSource,
      authenticationRepository: authenticationRepository,
    );
  });

  test('a mutation that updates zero rows fails', () async {
    when(
      () => dataSource.updateDisplayName(
        profileId: any(named: 'profileId'),
        displayName: any(named: 'displayName'),
      ),
    ).thenAnswer((_) async => 0);

    await expectLater(
      repository.updateDisplayName(profileId: 'p1', displayName: 'Marina'),
      throwsA(isA<LocalizedException>()),
    );
  });

  test('a saved name goes to the server for the profile', () async {
    when(() => dataSource.updateDisplayName(profileId: 'p1', displayName: 'Marina'))
        .thenAnswer((_) async => 1);

    await repository.updateDisplayName(profileId: 'p1', displayName: 'Marina');

    verify(() => dataSource.updateDisplayName(profileId: 'p1', displayName: 'Marina')).called(1);
  });

  test('a theme goes to the server in the server spelling', () async {
    when(() => dataSource.updateTheme(profileId: 'p1', theme: EnumAppTheme_enum.azul))
        .thenAnswer((_) async => 1);

    await repository.updateTheme(profileId: 'p1', theme: AppThemeVariant.blue);

    verify(() => dataSource.updateTheme(profileId: 'p1', theme: EnumAppTheme_enum.azul)).called(1);
  });

  test('a theme that updates zero rows fails', () async {
    when(
      () => dataSource.updateTheme(
        profileId: 'p1',
        theme: any(named: 'theme'),
      ),
    ).thenAnswer((_) async => 0);

    await expectLater(
      repository.updateTheme(profileId: 'p1', theme: AppThemeVariant.rose),
      throwsA(isA<LocalizedException>()),
    );
  });

  test('watching the profile maps each result to the model', () async {
    when(() => dataSource.watchMyProfile('p1')).thenAnswer(
      (_) => Stream.value(
        FragmentProfileFragment(
          id: 'p1',
          displayName: 'Marina',
          avatarKind: EnumAvatarKind_enum.initials,
        ),
      ),
    );

    final profile = await repository.watchMyProfile().first;

    expect(profile.displayName, 'Marina');
  });

  test('watching while signed out emits nothing', () async {
    final authentication = _MockAuthenticationRepository();
    when(() => authentication.currentUserId).thenReturn(null);
    final signedOut = ProfileRepository(
      profileDataSource: dataSource,
      authenticationRepository: authentication,
    );

    expect(await signedOut.watchMyProfile().toList(), isEmpty);
    expect(await signedOut.watchMySettings().toList(), isEmpty);
    verifyNever(() => dataSource.watchMyProfile(any()));
  });

  test('a failed watch is passed on', () {
    when(() => dataSource.watchMyProfile('p1')).thenAnswer((_) => Stream.error(Exception()));

    expect(repository.watchMyProfile(), emitsError(isA<Exception>()));
  });
}
