import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/chat/data/data_sources/remote/chat_data_source.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockChatDataSource() extends Mock implements ChatDataSource;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockPlusRepository() extends Mock implements PlusRepository;

void main() {
  late ChatDataSource dataSource;
  late ProfileRepository profileRepository;
  late AuthenticationRepository authenticationRepository;
  late SlipRepository slipRepository;
  late PlusRepository plusRepository;
  late ChatRepository repository;

  setUpAll(() => registerFallbackValue(ChatMode.free));

  setUp(() {
    dataSource = _MockChatDataSource();
    profileRepository = _MockProfileRepository();
    authenticationRepository = _MockAuthenticationRepository();
    slipRepository = _MockSlipRepository();
    plusRepository = _MockPlusRepository();
    repository = ChatRepository(
      dataSource: dataSource,
      profileRepository: profileRepository,
      authenticationRepository: authenticationRepository,
      slipRepository: slipRepository,
      plusRepository: plusRepository,
    );
    when(() => profileRepository.getMySettings()).thenAnswer(
      (_) async => AccountSettings(theme: AppThemeVariant.rose, onboardedAt: DateTime(2026)),
    );
    when(() => dataSource.getStatus(any()))
        .thenAnswer((_) async => (messagesLeft: 3, isEnabled: true, plusLimit: 20, freeLimit: 0));
    when(plusRepository.getPlus).thenAnswer((_) async => const PlusState(hasPlus: true));
    when(() => authenticationRepository.getAccessToken()).thenReturn('token');
  });

  test('the status joins the server count with the person plan', () async {
    final status = await repository.getStatus();

    expect(status.messagesLeft, 3);
    expect(status.isEnabled, isTrue);
    expect(status.hasPlus, isTrue);
  });
}
