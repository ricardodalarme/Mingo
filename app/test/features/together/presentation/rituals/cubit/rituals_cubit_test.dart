import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/together/data/models/ritual.dart';
import 'package:app/features/together/data/models/ritual_cadence.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:app/features/together/data/services/ritual_reminder_service.dart';
import 'package:app/features/together/presentation/ritual_edit/cubit/ritual_edit_cubit.dart';
import 'package:app/features/together/presentation/rituals/cubit/rituals_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTogetherRepository() extends Mock implements TogetherRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockRitualReminderService() extends Mock implements RitualReminderService;

void main() {
  late TogetherRepository together;
  late RitualReminderService reminders;

  const dinner = Ritual(
    id: 'r1',
    title: 'Jantar de sexta',
    cadence: RitualCadence.weekly,
    weekday: 5,
    hasReminder: true,
  );

  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(dinner);
  });

  setUp(() {
    together = _MockTogetherRepository();
    reminders = _MockRitualReminderService();
    when(() => together.getRituals()).thenAnswer((_) async => [dinner]);
    when(() => together.completeRitual(any(), now: any(named: 'now'))).thenAnswer((_) async {
      return;
    });
    when(() => together.saveRitual(any(), isNew: any(named: 'isNew'))).thenAnswer((_) async {
      return;
    });
    when(() => together.archiveRitual(any(), now: any(named: 'now'))).thenAnswer((_) async {
      return;
    });
    when(() => reminders.update(any())).thenAnswer((_) async {
      return;
    });
  });

  group('RitualsCubit', () {
    RitualsCubit build() => RitualsCubit(togetherRepository: together, reminderService: reminders);

    test('load shows the rituals and updates the local reminders', () async {
      final cubit = build();

      await cubit.load();

      expect((cubit.state.rituals as Success<List<Ritual>>).value, [dinner]);
      verify(() => reminders.update([dinner])).called(1);
    });

    test('completing records it and reads again, with no counter kept', () async {
      final cubit = build();
      await cubit.load();

      await cubit.complete(dinner);

      verify(() => together.completeRitual('r1', now: any(named: 'now'))).called(1);
      verify(() => together.getRituals()).called(2);
      expect(cubit.state.completeAction, isA<Initial>());
    });

    test('a failed completion keeps the list', () async {
      when(() => together.completeRitual(any(), now: any(named: 'now')))
          .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
      final cubit = build();
      await cubit.load();

      await cubit.complete(dinner);

      expect((cubit.state.rituals as Success<List<Ritual>>).value, [dinner]);
    });
  });

  group('RitualEditCubit', () {
    late ProfileRepository profile;
    late PairingRepository pairing;

    setUp(() {
      profile = _MockProfileRepository();
      pairing = _MockPairingRepository();
      when(profile.getMyProfile).thenAnswer(
        (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
      );
      when(pairing.getPartner).thenAnswer(
        (_) async => const Profile(id: 'you', avatarKind: AvatarKind.initials, displayName: 'Rui'),
      );
    });

    RitualEditCubit build() => RitualEditCubit(
      togetherRepository: together,
      reminderService: reminders,
      profileRepository: profile,
      pairingRepository: pairing,
    );

    test('a ritual can name who plans it, or nobody', () async {
      final cubit = build();
      await cubit.start(null);

      cubit.onPlannerChosen('you');
      expect(cubit.state.ritual.plannerId, 'you');
      expect(cubit.state.partnerName, 'Rui');

      cubit.onPlannerChosen(null);
      expect(cubit.state.ritual.plannerId, isNull);
    });

    test('a new ritual needs a name', () async {
      final cubit = build();
      await cubit.start(null);

      expect(cubit.state.canSave, isFalse);

      cubit.onTitleChanged('Caminhada de domingo');
      expect(cubit.state.canSave, isTrue);
    });

    test('daily rituals need no weekday', () async {
      final cubit = build();
      await cubit.start(null);
      cubit
        ..onTitleChanged('Café juntos')
        ..onCadenceChosen(RitualCadence.daily);

      expect(cubit.state.ritual.needsWeekday, isFalse);
      expect(cubit.state.canSave, isTrue);
    });

    test('starting with an id loads that ritual', () async {
      final cubit = build();

      await cubit.start('r1');

      expect(cubit.state.ritual, dinner);
      expect(cubit.state.isNew, isFalse);
    });

    test('an unknown id ends as a failure', () async {
      final cubit = build();

      await cubit.start('missing');

      expect(cubit.state.load, isA<Failure>());
    });

    test('saving stores the ritual and updates the reminders', () async {
      final cubit = build();
      await cubit.start(null);
      cubit
        ..onTitleChanged('Caminhada')
        ..onReminderChanged(value: true);

      await cubit.save();

      verify(() => together.saveRitual(any(), isNew: true)).called(1);
      verify(() => reminders.update(any())).called(1);
      expect(cubit.state.saveAction, isA<Success<void>>());
    });

    test('archiving an existing ritual hides it and clears its reminder', () async {
      final cubit = build();
      await cubit.start('r1');

      await cubit.archive();

      verify(() => together.archiveRitual('r1', now: any(named: 'now'))).called(1);
      verify(() => reminders.update(any())).called(1);
    });
  });
}
