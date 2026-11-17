import 'dart:async';

import 'package:app/features/checkin/data/repositories/checkin_repository.dart';
import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/lists/data/models/list_kind.dart';
import 'package:app/features/lists/data/models/list_models.dart';
import 'package:app/features/lists/data/repositories/lists_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/questions/data/models/question_thread.dart';
import 'package:app/features/questions/data/repositories/questions_repository.dart';
import 'package:app/features/together/presentation/together/cubit/together_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockCheckinRepository() extends Mock implements CheckinRepository;

class _MockListsRepository() extends Mock implements ListsRepository;

class _MockQuestionsRepository() extends Mock implements QuestionsRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockGiftsRepository() extends Mock implements GiftsRepository;

class _MockHistoryRepository() extends Mock implements HistoryRepository;

void main() {
  late PairingRepository pairingRepository;
  late CheckinRepository checkinRepository;
  late ListsRepository listsRepository;
  late QuestionsRepository questionsRepository;
  late ProfileRepository profileRepository;
  late GiftsRepository giftsRepository;
  late HistoryRepository historyRepository;
  late StreamController<AccountSettings> settingsChanges;

  setUp(() {
    pairingRepository = _MockPairingRepository();
    checkinRepository = _MockCheckinRepository();
    listsRepository = _MockListsRepository();
    questionsRepository = _MockQuestionsRepository();
    profileRepository = _MockProfileRepository();
    giftsRepository = _MockGiftsRepository();
    historyRepository = _MockHistoryRepository();
    when(historyRepository.getOverview).thenThrow(Exception());
    settingsChanges = StreamController<AccountSettings>.broadcast();
    when(profileRepository.watchMySettings).thenAnswer((_) => settingsChanges.stream);
    when(profileRepository.getMySettings).thenThrow(Exception('none'));
    when(pairingRepository.getPartner).thenAnswer((_) async => null);
    when(checkinRepository.isCurrentWeekDismissed).thenAnswer((_) async => false);
    when(listsRepository.getLists).thenAnswer((_) async => const []);
    when(giftsRepository.getGiftIdeas).thenAnswer((_) async => const []);
    when(questionsRepository.getPrompt).thenAnswer(
      (_) async => const QuestionPrompt(
        slug: 'first-meeting',
        title: 'What do you remember?',
        isPaired: true,
        selfId: 'me',
      ),
    );
  });

  tearDown(() => settingsChanges.close());

  TogetherCubit build() => TogetherCubit(
    pairingRepository: pairingRepository,
    checkinRepository: checkinRepository,
    listsRepository: listsRepository,
    questionsRepository: questionsRepository,
    profileRepository: profileRepository,
    giftsRepository: giftsRepository,
    historyRepository: historyRepository,
  );

  test('a dismissed week hides the check-in entry', () async {
    when(checkinRepository.isCurrentWeekDismissed).thenAnswer((_) async => true);
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.showCheckin, isFalse);
  });

  test('an unreadable dismissal keeps the entry visible', () async {
    when(checkinRepository.isCurrentWeekDismissed).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.showCheckin, isTrue);
  });

  test('the lists entry shows how many lists the couple has', () async {
    when(listsRepository.getLists).thenAnswer(
      (_) async => const [CoupleList(id: 'l1', title: 'Viagens', kind: ListKind.travel)],
    );
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.listCount, 1);
  });

  test('an unreadable list count leaves the entry without a number', () async {
    when(listsRepository.getLists).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.listCount, 0);
  });

  test('the title keeps the date the couple has been together since', () async {
    when(historyRepository.getOverview).thenAnswer((_) async => HistoryOverview.fake());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.togetherSince, DateTime(2024, 3, 14));
  });

  test('without the date the title shows no duration', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.togetherSince, isNull);
  });

  test('the gifts entry counts the wishes shared with the partner', () async {
    when(giftsRepository.getGiftIdeas).thenAnswer(
      (_) async => const [
        GiftIdea(id: 'g1', title: 'Livro', isShared: true, isMine: true),
        GiftIdea(id: 'g2', title: 'Chá', isMine: true),
        GiftIdea(id: 'g3', title: 'Flor', isShared: true),
      ],
    );
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.sharedGiftCount, 2);
  });

  test('unreadable gifts leave the entry without a shared count', () async {
    when(giftsRepository.getGiftIdeas).thenThrow(Exception());
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.sharedGiftCount, 0);
  });

  test('a phase change from another screen reloads the hub and swaps its variant card', () async {
    when(profileRepository.getMySettings).thenAnswer(
      (_) async => const AccountSettings(theme: .rose, phase: RelationshipPhase.longDistance),
    );
    final cubit = build();
    addTearDown(cubit.close);
    await cubit.load();
    expect(cubit.state.phase, RelationshipPhase.longDistance);
    settingsChanges.add(const AccountSettings(theme: .rose, phase: RelationshipPhase.longDistance));
    await pumpEventQueue();

    when(profileRepository.getMySettings).thenAnswer(
      (_) async => const AccountSettings(theme: .rose, phase: RelationshipPhase.livingTogether),
    );
    settingsChanges.add(
      const AccountSettings(theme: .rose, phase: RelationshipPhase.livingTogether),
    );
    await pumpEventQueue();

    expect(cubit.state.phase, RelationshipPhase.livingTogether);
  });

  test('closing stops listening for settings changes', () async {
    final cubit = build();
    await cubit.close();

    expect(settingsChanges.hasListener, isFalse);
  });
}
