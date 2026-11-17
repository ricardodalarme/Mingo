import 'package:app/features/love_style/data/models/love_pattern.dart';
import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/love_style/presentation/exercise/cubit/love_style_cubit.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLoveStyleRepository() extends Mock implements LoveStyleRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockBlocObserver() extends Mock implements BlocObserver;

void main() {
  late LoveStyleRepository repository;
  late PairingRepository pairingRepository;
  late BlocObserver mockObserver;

  const ranked = ['touch', 'time', 'words', 'acts', 'gifts'];

  setUp(() {
    mockObserver = _MockBlocObserver();
  });

  setUpAll(() {
    registerFallbackValue(<String>[]);
    registerFallbackValue(StackTrace.empty);
  });

  setUp(() {
    repository = _MockLoveStyleRepository();
    pairingRepository = _MockPairingRepository();
    when(() => repository.getOverview()).thenAnswer((_) async => const LoveStyleOverview());
    when(() => repository.getManualEntry()).thenAnswer((_) async => null);
    when(() => repository.saveRanked(any())).thenAnswer((_) async => 'q1');
    when(() => repository.saveManualEntry(any())).thenAnswer((_) async {
      return;
    });
    when(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    ).thenAnswer((_) async {
      return;
    });
    when(() => pairingRepository.getPartner()).thenAnswer(
      (_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials, displayName: 'Marina'),
    );
  });

  LoveStyleCubit build() =>
      LoveStyleCubit(repository: repository, pairingRepository: pairingRepository);

  Future<void> answerAll(LoveStyleCubit cubit, String pattern) async {
    for (var question = 0; question < loveStyleQuestionCount; question++) {
      cubit.select(pattern);
      await cubit.next();
    }
  }

  test('a saved result opens straight on the result screen', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => const LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked),
      ),
    );

    final cubit = build();
    await cubit.load();

    expect(cubit.state.isAnswering, isFalse);
    expect(cubit.state.savedResult?.topPattern, 'touch');
    expect(cubit.state.hasPartner, isTrue);
    expect(cubit.state.partnerName, 'Marina');
  });

  test('a shared result and the partner result are hydrated for the comparison', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked, sharedAt: DateTime.utc(2026, 3)),
        partner: const LoveStyleEntry(id: 'q2', ranked: ranked),
      ),
    );

    final cubit = build();
    await cubit.load();

    expect(cubit.state.isShared, isTrue);
    expect(cubit.state.entryId, 'q1');
    expect(cubit.state.partnerRanked, ranked);
    expect(cubit.state.canCompare, isTrue);
  });

  test('an existing manual entry is hydrated on load', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => const LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked),
      ),
    );
    when(() => repository.getManualEntry()).thenAnswer((_) async => 'Descrição salva.');

    final cubit = build();
    await cubit.load();

    expect(cubit.state.isInManual, isTrue);
  });

  test('finishing all answers ranks them and saves once', () async {
    final cubit = build();
    await cubit.load();
    expect(cubit.state.isAnswering, isTrue);

    await answerAll(cubit, 'acts');

    expect(cubit.state.isAnswering, isFalse);
    expect(cubit.state.savedResult?.topPattern, 'acts');
    expect(cubit.state.entryId, 'q1');
    verify(() => repository.saveRanked(any())).called(1);
  });

  test('a tie picks the canonical top', () async {
    final cubit = build();
    await cubit.load();
    final answers = ['time', 'words', 'acts', 'gifts', 'touch', 'time'];
    for (final (index, pattern) in answers.indexed) {
      cubit.select(pattern);
      if (index < loveStyleQuestionCount - 1) await cubit.next();
    }
    await cubit.next();

    final result = cubit.state.savedResult;
    expect(result?.topPattern, 'time');
    expect(result?.ranked, ['time', 'words', 'acts', 'gifts', 'touch']);
  });

  test('a failed saved read shows a failure, not a fresh exercise', () async {
    when(() => repository.getOverview()).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));

    final cubit = build();
    await cubit.load();

    expect(cubit.state.result, isA<Failure>());
    expect(cubit.state.isAnswering, isFalse);
    expect(cubit.state.savedResult, isNull);
  });

  test('retrying after a failed read opens the saved result', () async {
    var reads = 0;
    when(() => repository.getOverview()).thenAnswer((_) async {
      reads++;
      if (reads == 1) throw const LocalizedException(l10nKey: 'NETWORK');

      return const LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked),
      );
    });

    final cubit = build();
    await cubit.load();
    expect(cubit.state.result, isA<Failure>());

    await cubit.load();

    expect(cubit.state.isAnswering, isFalse);
    expect(cubit.state.savedResult?.topPattern, 'touch');
  });

  test('retaking replaces the saved ranking with the latest one', () async {
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'time');

    cubit.retake();
    expect(cubit.state.answers, isEmpty);
    await answerAll(cubit, 'touch');

    expect(cubit.state.savedResult?.topPattern, 'touch');
    final saved = verify(() => repository.saveRanked(captureAny())).captured.cast<List<String>>();
    expect(saved, hasLength(2));
    expect(saved.last, ['touch', 'time', 'words', 'acts', 'gifts']);
  });

  test('retaking a shared result keeps the old share until the new one is saved', () async {
    when(() => repository.getOverview()).thenAnswer(
      (_) async => LoveStyleOverview(
        own: LoveStyleEntry(id: 'q1', ranked: ranked, sharedAt: DateTime.utc(2026, 3)),
      ),
    );
    final cubit = build();
    await cubit.load();
    expect(cubit.state.isShared, isTrue);

    cubit.retake();

    expect(cubit.state.isShared, isTrue);
    expect(cubit.state.isAnswering, isTrue);
    expect(cubit.state.answers, isEmpty);
    verifyNever(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    );

    await answerAll(cubit, 'time');

    expect(cubit.state.isShared, isFalse);
  });

  test('a failed save keeps every answer on the exercise', () async {
    when(() => repository.saveRanked(any()))
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();

    await answerAll(cubit, 'words');

    expect(cubit.state.isAnswering, isTrue);
    expect(cubit.state.answers, hasLength(loveStyleQuestionCount));
    expect(cubit.state.answers.every((answer) => answer == 'words'), isTrue);
    expect(cubit.state.savedResult, isNull);
    expect(cubit.state.saveAction, isA<Initial>());
  });

  test('a failed save is handed to the observer', () async {
    final previousObserver = Bloc.observer;
    Bloc.observer = mockObserver;
    addTearDown(() => Bloc.observer = previousObserver);
    const failure = LocalizedException(l10nKey: 'NETWORK');
    when(() => repository.saveRanked(any())).thenThrow(failure);
    final cubit = build();
    await cubit.load();

    await answerAll(cubit, 'words');

    // ignore: invalid_use_of_protected_member - the test drives the observer the cubit reports to
    verify(() => mockObserver.onError(cubit, failure, any())).called(1);
  });

  test('saving to the manual writes the description once', () async {
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'gifts');

    await cubit.saveToManual('Uma descrição.');
    await cubit.saveToManual('Uma descrição.');

    expect(cubit.state.isInManual, isTrue);
    expect(cubit.state.manualAction, isA<Success<void>>());
    verify(() => repository.saveManualEntry('Uma descrição.')).called(1);
  });

  test('a failed manual save keeps the result on screen', () async {
    when(() => repository.saveManualEntry(any()))
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'gifts');

    await cubit.saveToManual('Uma descrição.');

    expect(cubit.state.savedResult?.topPattern, 'gifts');
    expect(cubit.state.isInManual, isFalse);
    expect(cubit.state.manualAction, isA<Initial>());
  });

  test('sharing shows the saved result only once', () async {
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'words');

    await cubit.share();
    await cubit.share();

    expect(cubit.state.isShared, isTrue);
    verify(() => repository.setShared(id: 'q1', isShared: true)).called(1);
  });

  test('a paired person with no display name can still share', () async {
    when(() => pairingRepository.getPartner())
        .thenAnswer((_) async => const Profile(id: 'p1', avatarKind: AvatarKind.initials));
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'touch');

    expect(cubit.state.hasPartner, isTrue);
    expect(cubit.state.partnerName, isNull);

    await cubit.share();

    expect(cubit.state.isShared, isTrue);
    verify(() => repository.setShared(id: 'q1', isShared: true)).called(1);
  });

  test('a pairing failure is shown instead of looking unpaired', () async {
    when(() => pairingRepository.getPartner())
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();

    expect(cubit.state.hasPartner, isFalse);
    expect(cubit.state.pairingFailed, isTrue);
  });

  test('an unpaired person gets a result without sharing', () async {
    when(() => pairingRepository.getPartner()).thenAnswer((_) async => null);
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'touch');

    await cubit.share();

    expect(cubit.state.hasPartner, isFalse);
    expect(cubit.state.isShared, isFalse);
    verifyNever(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    );
  });

  test('a failed share keeps the result and can be tried again', () async {
    when(
      () => repository.setShared(
        id: any(named: 'id'),
        isShared: any(named: 'isShared'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'acts');

    await cubit.share();

    expect(cubit.state.savedResult?.topPattern, 'acts');
    expect(cubit.state.isShared, isFalse);
    expect(cubit.state.shareAction, isA<Initial>());
  });

  test('revoking hides the result again', () async {
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'acts');
    await cubit.share();

    await cubit.revokeShare();

    expect(cubit.state.isShared, isFalse);
    expect(cubit.state.revokeAction, isA<Success<void>>());
    verify(() => repository.setShared(id: 'q1', isShared: false)).called(1);
  });

  test('a failed revoke keeps the shared state so it can be tried again', () async {
    final cubit = build();
    await cubit.load();
    await answerAll(cubit, 'acts');
    await cubit.share();
    when(() => repository.setShared(id: any(named: 'id'), isShared: false))
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));

    await cubit.revokeShare();

    expect(cubit.state.isShared, isTrue);
    expect(cubit.state.revokeAction, isA<Initial>());
  });
}
