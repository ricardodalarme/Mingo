import 'dart:async';

import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/today/data/data_sources/local/today_local_data_source.dart';
import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/data_sources/remote/today_data_source.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockTodayDataSource() extends Mock implements TodayDataSource;

class _MockTodayLocalDataSource() extends Mock implements TodayLocalDataSource;

class _MockTodayRepository() extends Mock implements TodayRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class _MockPairingRepository() extends Mock implements PairingRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockRepairRepository() extends Mock implements RepairRepository;

QueryTodayHome _query({QueryTodayHometoday? today}) =>
    QueryTodayHome(today: today == null ? const [] : [today], question: const [], idea: const []);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const home = TodayHome(
    isPaired: true,
    unopenedCards: 0,
    slipsThisWeek: 2,
    slipsTotal: 2,
    hasPendingInvite: false,
    hasPlus: false,
    partnerName: 'Rui',
  );

  const unpairedHome = TodayHome(
    isPaired: false,
    unopenedCards: 0,
    slipsThisWeek: 2,
    slipsTotal: 2,
    hasPendingInvite: false,
    hasPlus: false,
  );

  TodayResult result({
    TodayHome value = home,
    bool isFromCache = false,
    bool wasUnpaired = false,
    String? previousPartnerName,
  }) => (
    home: value,
    isFromCache: isFromCache,
    wasUnpaired: wasUnpaired,
    previousPartnerName: previousPartnerName,
  );

  setUpAll(() => registerFallbackValue(home));

  group('TodayHome', () {
    test('survives the cache round trip', () {
      expect(TodayHome.fromMap(home.toMap()), home);
    });
  });

  group('TodayRepository', () {
    late TodayDataSource remote;
    late TodayLocalDataSource local;
    late TodayRepository repository;

    setUp(() {
      remote = _MockTodayDataSource();
      local = _MockTodayLocalDataSource();
      repository = TodayRepository(dataSource: remote, localDataSource: local);
      when(() => local.write(any())).thenAnswer((_) async {
        return;
      });
      when(() => local.readRelationship()).thenReturn((wasPaired: false, partnerName: null));
      when(
        () => local.writeRelationship(
          wasPaired: any(named: 'wasPaired'),
          partnerName: any(named: 'partnerName'),
        ),
      ).thenAnswer((_) async {
        return;
      });
    });

    test('offline with a cache returns the cached state', () async {
      when(() => remote.getHome())
          .thenAnswer((_) async => throw const LocalizedException(l10nKey: networkErrorCode));
      when(() => local.read()).thenReturn(home);

      final result = await repository.getToday();

      expect(result.isFromCache, isTrue);
      expect(result.home, home);
      expect(result.wasUnpaired, isFalse);
    });

    test('offline without a cache fails', () {
      when(() => remote.getHome())
          .thenAnswer((_) async => throw const LocalizedException(l10nKey: networkErrorCode));
      when(() => local.read()).thenReturn(null);

      expect(repository.getToday, throwsA(isA<LocalizedException>()));
    });

    test('a server error is not hidden by the cache', () {
      when(() => remote.getHome())
          .thenAnswer((_) async => throw const LocalizedException(l10nKey: 'UNAUTHENTICATED'));
      when(() => local.read()).thenReturn(home);

      expect(repository.getToday, throwsA(isA<LocalizedException>()));
    });

    test('a server row without today fails instead of showing nothing', () {
      when(() => remote.getHome()).thenAnswer((_) async => _query());
      when(() => local.read()).thenReturn(null);

      expect(repository.getToday, throwsA(isA<NoDataException>()));
    });

    test('a paired read remembers the partner name', () async {
      when(() => remote.getHome()).thenAnswer(
        (_) async => _query(
          today: QueryTodayHometoday(partnerId: 'p1', partnerName: 'Rui'),
        ),
      );
      when(() => local.read()).thenReturn(home);

      await repository.getToday();

      verify(() => local.writeRelationship(wasPaired: true, partnerName: 'Rui')).called(1);
    });

    test('an unpair reports the stored partner name once', () async {
      when(() => remote.getHome()).thenAnswer((_) async => _query(today: QueryTodayHometoday()));
      when(() => local.readRelationship()).thenReturn((wasPaired: true, partnerName: 'Rui'));

      final result = await repository.getToday();

      expect(result.wasUnpaired, isTrue);
      expect(result.previousPartnerName, 'Rui');
    });

    test('acknowledging the unpair clears the stored pairing state', () async {
      await repository.acknowledgeUnpair();

      verify(() => local.writeRelationship(wasPaired: false)).called(1);
    });

    test('an unpair already acknowledged is not reported again', () async {
      when(() => remote.getHome()).thenAnswer((_) async => _query(today: QueryTodayHometoday()));

      final result = await repository.getToday();

      expect(result.wasUnpaired, isFalse);
      expect(result.previousPartnerName, isNull);
      verifyNever(
        () => local.writeRelationship(
          wasPaired: any(named: 'wasPaired'),
          partnerName: any(named: 'partnerName'),
        ),
      );
    });
  });

  group('TodayCubit', () {
    late TodayRepository today;
    late ProfileRepository profile;
    late PairingRepository pairing;
    late SlipRepository slip;
    late RepairRepository repair;

    setUp(() {
      today = _MockTodayRepository();
      profile = _MockProfileRepository();
      pairing = _MockPairingRepository();
      slip = _MockSlipRepository();
      repair = _MockRepairRepository();
      when(repair.isInConflict).thenAnswer((_) async => false);
      when(() => pairing.onChanged).thenAnswer((_) => const Stream.empty());
      when(() => profile.onChanged).thenAnswer((_) => const Stream.empty());
      when(() => slip.onChanged).thenAnswer((_) => const Stream.empty());
      when(() => profile.getMyProfile()).thenAnswer(
        (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Ana'),
      );
      when(() => today.acknowledgeUnpair()).thenAnswer((_) async {
        return;
      });
    });

    test('a fight answer in the last day puts Hoje in conflict mode', () async {
      when(repair.isInConflict).thenAnswer((_) async => true);
      when(() => today.getToday()).thenAnswer((_) async => result());
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.isInConflict, isTrue);
    });

    test('load shows the state and the person name', () async {
      when(() => today.getToday()).thenAnswer((_) async => result());
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.home, const Success<TodayHome>(home));
      expect(cubit.state.selfName, 'Ana');
      expect(cubit.state.isOffline, isFalse);
    });

    test('a saved profile name reaches Hoje', () async {
      final changes = StreamController<void>.broadcast();
      when(() => profile.onChanged).thenAnswer((_) => changes.stream);
      when(() => today.getToday()).thenAnswer((_) async => result());
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      unawaited(Future<void>.microtask(cubit.start));
      await pumpEventQueue();
      expect(cubit.state.selfName, 'Ana');

      when(() => profile.getMyProfile()).thenAnswer(
        (_) async => const Profile(id: 'me', avatarKind: AvatarKind.initials, displayName: 'Bia'),
      );
      changes.add(null);
      await pumpEventQueue();

      expect(cubit.state.selfName, 'Bia');
      await cubit.close();
      await changes.close();
    });

    test('a saved slip reads Hoje again', () async {
      final changes = StreamController<void>.broadcast();
      when(() => slip.onChanged).thenAnswer((_) => changes.stream);
      var reads = 0;
      when(() => today.getToday()).thenAnswer((_) async {
        reads++;

        return result();
      });
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      unawaited(Future<void>.microtask(cubit.start));
      await pumpEventQueue();
      expect(reads, 1);

      changes.add(null);
      await pumpEventQueue();

      expect(reads, 2);
      await cubit.close();
      await changes.close();
    });

    test('a foreground refresh reads Hoje again', () async {
      var reads = 0;
      void Function()? tick;
      when(() => today.getToday()).thenAnswer((_) async {
        reads++;

        return result();
      });
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
        refreshInterval: const Duration(seconds: 1),
        timerFactory: (_, onTick) {
          tick = onTick;

          return Timer(const Duration(days: 1), () {});
        },
      );

      unawaited(Future<void>.microtask(cubit.start));
      await pumpEventQueue();
      expect(reads, 1);

      tick!();
      await pumpEventQueue();

      expect(reads, 2);
      await cubit.close();
    });

    test('a foreground refresh clears the invite once the partner joins', () async {
      const pending = TodayHome(
        isPaired: false,
        unopenedCards: 0,
        slipsThisWeek: 0,
        slipsTotal: 0,
        hasPendingInvite: true,
        hasPlus: false,
      );
      var reads = 0;
      void Function()? tick;
      when(() => today.getToday()).thenAnswer((_) async {
        reads++;

        return result(value: reads == 1 ? pending : home);
      });
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
        refreshInterval: const Duration(seconds: 1),
        timerFactory: (_, onTick) {
          tick = onTick;

          return Timer(const Duration(days: 1), () {});
        },
      );

      unawaited(Future<void>.microtask(cubit.start));
      await pumpEventQueue();
      expect((cubit.state.home as Success<TodayHome>).value.hasPendingInvite, isTrue);

      tick!();
      await pumpEventQueue();

      expect(reads, 2);
      expect((cubit.state.home as Success<TodayHome>).value.hasPendingInvite, isFalse);
      await cubit.close();
    });

    test('a cached result sets the offline flag', () async {
      when(() => today.getToday()).thenAnswer((_) async => result(isFromCache: true));
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.isOffline, isTrue);
    });

    test('a failed first load shows a failure', () async {
      when(() => today.getToday()).thenAnswer((_) async => throw Exception());
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.home, isA<Failure>());
    });

    test('a failed refresh keeps what is already on screen', () async {
      when(() => today.getToday()).thenAnswer((_) async => result());
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );
      await cubit.load();

      when(() => today.getToday()).thenAnswer((_) async => throw Exception());
      await cubit.load();

      expect(cubit.state.home, const Success<TodayHome>(home));
    });

    test('an unpair notice shows once with the last partner name', () async {
      when(() => today.getToday()).thenAnswer(
        (_) async => result(value: unpairedHome, wasUnpaired: true, previousPartnerName: 'Rui'),
      );
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.showUnpairNotice, isTrue);
      expect(cubit.state.unpairedPartnerName, 'Rui');

      await cubit.acknowledgeUnpairNotice();
      verify(() => today.acknowledgeUnpair()).called(1);
      expect(cubit.state.showUnpairNotice, isFalse);
      expect(cubit.state.unpairedPartnerName, isNull);

      when(() => today.getToday()).thenAnswer((_) async => result(value: unpairedHome));
      await cubit.load();

      expect(cubit.state.showUnpairNotice, isFalse);
    });

    test('an unpair notice without a stored name uses the neutral copy', () async {
      when(() => today.getToday())
          .thenAnswer((_) async => result(value: unpairedHome, wasUnpaired: true));
      final cubit = TodayCubit(
        todayRepository: today,
        profileRepository: profile,
        pairingRepository: pairing,
        slipRepository: slip,
        repairRepository: repair,
      );

      await cubit.load();

      expect(cubit.state.showUnpairNotice, isTrue);
      expect(cubit.state.unpairedPartnerName, isNull);
    });
  });
}
