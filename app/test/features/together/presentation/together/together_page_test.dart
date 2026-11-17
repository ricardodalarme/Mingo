import 'dart:async';

import 'package:app/features/checkin/data/repositories/checkin_repository.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/lists/data/repositories/lists_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/questions/data/repositories/questions_repository.dart';
import 'package:app/features/together/presentation/together/cubit/together_cubit.dart';
import 'package:app/features/together/presentation/together/together_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockCheckinRepository() extends Mock implements CheckinRepository;

class _MockListsRepository() extends Mock implements ListsRepository;

class _MockQuestionsRepository() extends Mock implements QuestionsRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockGiftsRepository() extends Mock implements GiftsRepository;

class _MockHistoryRepository() extends Mock implements HistoryRepository;

void main() {
  late PairingRepository pairingRepository;
  late ProfileRepository profileRepository;
  late StreamController<AccountSettings> settingsChanges;
  late TogetherCubit cubit;

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    pairingRepository = _MockPairingRepository();
    final checkinRepository = _MockCheckinRepository();
    final listsRepository = _MockListsRepository();
    final questionsRepository = _MockQuestionsRepository();
    profileRepository = _MockProfileRepository();
    final giftsRepository = _MockGiftsRepository();
    final historyRepository = _MockHistoryRepository();
    when(historyRepository.getOverview).thenThrow(Exception());
    settingsChanges = StreamController<AccountSettings>.broadcast();
    when(profileRepository.watchMySettings).thenAnswer((_) => settingsChanges.stream);
    when(profileRepository.getMySettings).thenThrow(Exception('none'));
    when(checkinRepository.isCurrentWeekDismissed).thenAnswer((_) async => false);
    when(listsRepository.getLists).thenAnswer((_) async => const []);
    when(giftsRepository.getGiftIdeas).thenAnswer((_) async => const []);
    when(questionsRepository.getPrompt).thenThrow(Exception('none'));
    cubit = TogetherCubit(
      pairingRepository: pairingRepository,
      checkinRepository: checkinRepository,
      listsRepository: listsRepository,
      questionsRepository: questionsRepository,
      profileRepository: profileRepository,
      giftsRepository: giftsRepository,
      historyRepository: historyRepository,
    );
  });

  tearDown(() async {
    await cubit.close();
    await settingsChanges.close();
  });

  Future<void> pumpTogether(WidgetTester tester) async {
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const TogetherPage()));
    await tester.pump();
  }

  testWidgets('a person without a partner sees the connect entry', (tester) async {
    when(pairingRepository.getPartner).thenAnswer((_) async => null);

    await pumpTogether(tester);

    expect(find.text('Conectar com código'), findsOneWidget);
  });

  testWidgets('a person with a partner does not see the connect entry', (tester) async {
    when(pairingRepository.getPartner).thenAnswer(
      (_) async => const Profile(id: 'p', avatarKind: AvatarKind.initials, displayName: 'Rui'),
    );

    await pumpTogether(tester);

    expect(find.text('Conectar com código'), findsNothing);
  });
}
