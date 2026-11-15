import 'dart:async';

import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late MoodRepository repository;
  late SlipRepository slips;

  final day = DateTime(2026, 11, 11);
  final entry = MoodEntry(
    id: 'm1',
    day: day,
    mood: MoodKind.tired,
    need: NeedKind.hug,
    share: MoodShare.moodNeed,
  );
  final partnerMood = PartnerMood(day: day, mood: MoodKind.stressed, need: NeedKind.space);
  MoodToday today({MoodEntry? value, PartnerMood? partner, String? partnerName = 'Marina'}) =>
      (entry: value, partnerMood: partner, partnerName: partnerName);

  setUpAll(() {
    registerFallbackValue(MoodKind.happy);
    registerFallbackValue(MoodShare.none);
    registerFallbackValue(NeedKind.hug);
  });

  setUp(() {
    repository = _MockMoodRepository();
    slips = _MockSlipRepository();
    when(() => repository.readCachedTodayMood()).thenReturn(null);
    when(() => repository.getTodayMood()).thenAnswer((_) async => today(value: entry));
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((invocation) async {
      final mood = invocation.namedArguments[#mood] as MoodKind;
      final need = invocation.namedArguments[#need] as NeedKind?;
      final share = invocation.namedArguments[#share] as MoodShare;

      return MoodEntry(id: 'm1', day: day, mood: mood, need: need, share: share);
    });
    when(() => slips.sendHug()).thenAnswer((_) async {});
  });

  MoodCubit build() => MoodCubit(moodRepository: repository, slipRepository: slips);

  test('loading starts the form from the saved row and partner name', () async {
    final cubit = build();

    await cubit.load();

    expect(cubit.state.entry, isA<Success<MoodEntry?>>());
    expect(cubit.state.mood, MoodKind.tired);
    expect(cubit.state.need, NeedKind.hug);
    expect(cubit.state.share, MoodShare.moodNeed);
    expect(cubit.state.partnerName, 'Marina');
  });

  test('the partner shared mood reaches the state and clears on the next read', () async {
    when(() => repository.getTodayMood()).thenAnswer((_) async => today(partner: partnerMood));
    final cubit = build();

    await cubit.load();
    expect(cubit.state.partnerMood, partnerMood);

    when(() => repository.getTodayMood()).thenAnswer((_) async => today());
    await cubit.load();

    expect(cubit.state.partnerMood, isNull);
  });

  test("today's cached mood paints before the fresh read returns", () async {
    final pending = Completer<MoodToday>();
    when(() => repository.readCachedTodayMood()).thenReturn(entry);
    when(() => repository.getTodayMood()).thenAnswer((_) => pending.future);
    final cubit = build();

    final load = cubit.load();

    expect(cubit.state.entry, Success<MoodEntry?>(entry));
    expect(cubit.state.mood, MoodKind.tired);
    expect(cubit.state.need, NeedKind.hug);

    pending.complete(today(value: null));
    await load;

    expect(cubit.state.entry, const Success<MoodEntry?>(null));
    expect(cubit.state.mood, isNull);
  });

  test('without a cache the read starts as loading', () async {
    final pending = Completer<MoodToday>();
    when(() => repository.getTodayMood()).thenAnswer((_) => pending.future);
    final cubit = build();

    final load = cubit.load();

    expect(cubit.state.entry, isA<Loading>());
    pending.complete(today());
    await load;
  });

  test('a failed read keeps the cached mood instead of showing a failure', () async {
    when(() => repository.readCachedTodayMood()).thenReturn(entry);
    when(() => repository.getTodayMood())
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.entry, Success<MoodEntry?>(entry));
  });

  test('a missing row starts private and shares nothing by default', () async {
    when(() => repository.getTodayMood()).thenAnswer((_) async => today());
    final cubit = build();

    await cubit.load();
    expect(cubit.state.share, MoodShare.none);
    expect(cubit.state.canSave, isFalse);

    cubit.selectMood(MoodKind.happy);
    await cubit.save();

    verify(() => repository.saveMood(mood: MoodKind.happy, need: null, share: MoodShare.none))
        .called(1);
  });

  test('saving twice keeps one row and the latest values win', () async {
    final cubit = build();
    await cubit.load();

    cubit
      ..selectMood(MoodKind.happy)
      ..selectShare(MoodShare.mood);
    await cubit.save();

    cubit.selectMood(MoodKind.playful);
    await cubit.save();

    verify(
      () => repository.saveMood(mood: MoodKind.happy, need: NeedKind.hug, share: MoodShare.mood),
    ).called(1);
    verify(
      () => repository.saveMood(mood: MoodKind.playful, need: NeedKind.hug, share: MoodShare.mood),
    ).called(1);
    expect((cubit.state.entry as Success<MoodEntry?>).value?.mood, MoodKind.playful);
  });

  test('save success re-emits the values the server actually saved', () async {
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer(
      (_) async =>
          MoodEntry(id: 'm1', day: day, mood: MoodKind.loving, need: null, share: MoodShare.none),
    );
    final cubit = build()
      ..selectMood(MoodKind.playful)
      ..selectShare(MoodShare.mood);

    await cubit.save();

    expect(cubit.state.mood, MoodKind.loving);
    expect(cubit.state.need, isNull);
    expect(cubit.state.share, MoodShare.none);
  });

  test('clearing the need also drops the need-only share', () async {
    final cubit = build();
    await cubit.load();

    cubit.toggleNeed(NeedKind.hug);

    expect(cubit.state.need, isNull);
    expect(cubit.state.share, MoodShare.mood);
  });

  test('the need-only share waits for a need', () async {
    when(() => repository.getTodayMood()).thenAnswer((_) async => today());
    final cubit = build();
    await cubit.load();

    cubit.selectShare(MoodShare.moodNeed);
    expect(cubit.state.share, MoodShare.none);

    cubit
      ..selectMood(MoodKind.happy)
      ..toggleNeed(NeedKind.listen)
      ..selectShare(MoodShare.moodNeed);
    expect(cubit.state.share, MoodShare.moodNeed);
  });

  test('a load failure becomes a failure resource', () async {
    when(() => repository.getTodayMood())
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.entry, isA<Failure>());
  });

  test('a save failure keeps the choice and returns to idle', () async {
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build()..selectMood(MoodKind.sad);

    await cubit.save();

    expect(cubit.state.mood, MoodKind.sad);
    expect(cubit.state.saveAction, isA<Initial>());
  });

  test('a face tap saves the mood and paints it before the write returns', () async {
    final pending = Completer<MoodEntry>();
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) => pending.future);
    final cubit = build();
    await cubit.load();

    final save = cubit.saveTodayMood(MoodKind.happy);

    expect(cubit.state.mood, MoodKind.happy);
    expect(cubit.state.saveAction, isA<Loading>());

    pending.complete(
      MoodEntry(
        id: 'm1',
        day: day,
        mood: MoodKind.happy,
        need: NeedKind.hug,
        share: MoodShare.mood,
      ),
    );
    await save;

    verify(
      () =>
          repository.saveMood(mood: MoodKind.happy, need: NeedKind.hug, share: MoodShare.moodNeed),
    ).called(1);
    expect(cubit.state.mood, MoodKind.happy);
    expect(cubit.state.saveAction, isA<Success<void>>());
  });

  test('a tap on the mood already saved writes nothing', () async {
    final cubit = build();
    await cubit.load();

    await cubit.saveTodayMood(MoodKind.tired);

    verifyNever(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    );
  });

  test('a failed face tap puts back the mood on screen', () async {
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    await cubit.load();
    final actions = <Resource<void>>[];
    final subscription = cubit.stream.listen((state) => actions.add(state.saveAction));

    await cubit.saveTodayMood(MoodKind.happy);
    await pumpEventQueue();
    await subscription.cancel();

    expect(cubit.state.mood, MoodKind.tired);
    expect(actions, [isA<Loading>(), isA<Failure>(), isA<Initial>()]);
  });

  test('saving a need keeps the mood and audience already on screen', () async {
    final cubit = build();
    await cubit.load();

    await cubit.saveNeed(mood: MoodKind.happy, need: NeedKind.chocolate);

    verify(
      () => repository.saveMood(
        mood: MoodKind.happy,
        need: NeedKind.chocolate,
        share: MoodShare.moodNeed,
      ),
    ).called(1);
    expect(cubit.state.need, NeedKind.chocolate);
    expect(cubit.state.needAction, isA<Success<void>>());
  });

  test('clearing the need while sharing it falls back to sharing only the mood', () async {
    final cubit = build();
    await cubit.load();

    await cubit.saveNeed(mood: MoodKind.tired, need: null);

    verify(() => repository.saveMood(mood: MoodKind.tired, need: null, share: MoodShare.mood))
        .called(1);
    expect(cubit.state.share, MoodShare.mood);
  });

  test('a failed need save reports a failure and returns to idle', () async {
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    await cubit.load();

    await cubit.saveNeed(mood: MoodKind.tired, need: NeedKind.rest);

    expect(cubit.state.needAction, isA<Initial>());
    expect(cubit.state.need, NeedKind.hug);
  });

  test('reacting sends one hug and returns to idle', () async {
    final cubit = build();

    await cubit.reactToPartner();

    verify(() => slips.sendHug()).called(1);
    expect(cubit.state.reactAction, isA<Initial>());
  });

  test('a second tap while the hug is in flight sends one', () async {
    final pending = Completer<void>();
    when(() => slips.sendHug()).thenAnswer((_) => pending.future);
    final cubit = build();

    final first = cubit.reactToPartner();
    final second = cubit.reactToPartner();

    pending.complete();
    await Future.wait([first, second]);

    verify(() => slips.sendHug()).called(1);
  });

  test('a failed hug reports a failure and returns to idle', () async {
    when(() => slips.sendHug()).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    final actions = <Resource<void>>[];
    final subscription = cubit.stream.listen((state) => actions.add(state.reactAction));

    await cubit.reactToPartner();
    await pumpEventQueue();
    await subscription.cancel();

    expect(actions, [isA<Loading>(), isA<Failure>(), isA<Initial>()]);
  });

  test('asking to talk sends one ask and returns to idle', () async {
    when(() => slips.askToTalk()).thenAnswer((_) async {});
    final cubit = build();

    await cubit.askToTalk();

    verify(() => slips.askToTalk()).called(1);
    expect(cubit.state.talkAction, isA<Initial>());
  });

  test('a failed ask reports a failure and returns to idle', () async {
    when(() => slips.askToTalk()).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    final actions = <Resource<void>>[];
    final subscription = cubit.stream.listen((state) => actions.add(state.talkAction));

    await cubit.askToTalk();
    await pumpEventQueue();
    await subscription.cancel();

    expect(actions, [isA<Loading>(), isA<Failure>(), isA<Initial>()]);
  });

  test('the short message is sent with its body', () async {
    when(() => slips.sendSweetMessage(any())).thenAnswer((_) async {});
    final cubit = build();

    await cubit.sendSweetMessage('Sem pressa. Estou por aqui.');

    verify(() => slips.sendSweetMessage('Sem pressa. Estou por aqui.')).called(1);
    expect(cubit.state.messageAction, isA<Initial>());
  });

  test('a closed cubit ignores a load that finishes later', () async {
    final pending = Completer<MoodToday>();
    when(() => repository.getTodayMood()).thenAnswer((_) => pending.future);
    final cubit = build();

    final load = cubit.load();
    await cubit.close();
    pending.complete(today(value: entry));

    await expectLater(load, completes);
  });

  test('a closed cubit ignores a save that finishes later', () async {
    final pending = Completer<MoodEntry>();
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) => pending.future);
    final cubit = build()..selectMood(MoodKind.happy);

    final save = cubit.save();
    await cubit.close();
    pending.complete(entry);

    await expectLater(save, completes);
  });
}
