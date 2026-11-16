import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSpiceDataSource() extends Mock implements SpiceDataSource;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockPlusRepository() extends Mock implements PlusRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late SpiceDataSource dataSource;
  late ProfileRepository profile;
  late PlusRepository plus;
  late AuthenticationRepository authenticationRepository;
  late SpiceRepository repository;

  setUpAll(() => registerFallbackValue(''));

  setUp(() {
    dataSource = _MockSpiceDataSource();
    profile = _MockProfileRepository();
    plus = _MockPlusRepository();
    authenticationRepository = _MockAuthenticationRepository();
    repository = SpiceRepository(
      dataSource: dataSource,
      profileRepository: profile,
      plusRepository: plus,
      authenticationRepository: authenticationRepository,
    );

    when(() => authenticationRepository.currentUserId).thenReturn('u1');
    when(() => plus.getPlus()).thenAnswer((_) async => const PlusState(hasPlus: true));
    when(profile.getMySettings)
        .thenAnswer((_) async => const AccountSettings(theme: .rose, locale: 'pt-BR'));
  });

  test('a free person gets the Plus entry without reading cards', () async {
    when(() => plus.getPlus()).thenAnswer((_) async => const PlusState(hasPlus: false));

    final view = await repository.getView();

    expect(view.stage, SpiceStage.plusLocked);
    verifyNever(() => dataSource.getEnabled(any()));
    verifyNever(() => dataSource.getCards(any()));
  });

  test('a person who has not opted in sees the off stage without cards', () async {
    when(() => dataSource.getEnabled('u1')).thenAnswer((_) async => false);

    final view = await repository.getView();

    expect(view.stage, SpiceStage.off);
    verifyNever(() => dataSource.getCards(any()));
  });

  test('opted in without cards stays waiting', () async {
    when(() => dataSource.getEnabled('u1')).thenAnswer((_) async => true);
    when(() => dataSource.getCards('pt-BR')).thenAnswer((_) async => []);

    final view = await repository.getView();

    expect(view.stage, SpiceStage.waiting);
    expect(view.cards, isEmpty);
  });

  test('both opted in with cards is ready', () async {
    when(() => dataSource.getEnabled('u1')).thenAnswer((_) async => true);
    when(() => dataSource.getCards('pt-BR')).thenAnswer((_) async => ['Uma carta']);

    final view = await repository.getView();

    expect(view.stage, SpiceStage.ready);
    expect(view.cards, ['Uma carta']);
  });

  test('a change that matched no row is a failure', () async {
    when(
      () => dataSource.setEnabled(
        userId: any(named: 'userId'),
        enabled: any(named: 'enabled'),
      ),
    ).thenAnswer((_) async => 0);

    await expectLater(
      repository.setEnabled(enabled: true),
      throwsA(
        isA<LocalizedException>().having(
          (exception) => exception.l10nKey,
          'l10nKey',
          'UPDATE_FAILED',
        ),
      ),
    );
  });

  test('a change that matched the saved row succeeds', () async {
    when(
      () => dataSource.setEnabled(
        userId: any(named: 'userId'),
        enabled: any(named: 'enabled'),
      ),
    ).thenAnswer((_) async => 1);

    await repository.setEnabled(enabled: true);

    verify(() => dataSource.setEnabled(userId: 'u1', enabled: true)).called(1);
  });
}
