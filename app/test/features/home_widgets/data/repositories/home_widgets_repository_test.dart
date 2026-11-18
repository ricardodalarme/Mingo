import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/home_widgets/data/data_sources/local/home_widgets_local_data_source.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/home_widgets_data_source.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/queries/generated/HomeWidgetOverview.graphql.dart';
import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/home_widgets/data/services/home_widget_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeWidgetsDataSource() extends Mock implements HomeWidgetsDataSource;

class _MockHomeWidgetsLocalDataSource() extends Mock implements HomeWidgetsLocalDataSource;

class _MockHomeWidgetDataService() extends Mock implements HomeWidgetDataService;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

class _MockDistanceRepository() extends Mock implements DistanceRepository;

void main() {
  late HomeWidgetsDataSource dataSource;
  late HomeWidgetsLocalDataSource localDataSource;
  late HomeWidgetDataService homeWidgetDataService;
  late AuthenticationRepository authenticationRepository;
  late DistanceRepository distanceRepository;
  late HomeWidgetsRepository repository;

  final now = DateTime.utc(2026, 11, 11, 12);

  HomeWidgetOverviewResponse response({bool paired = true}) => (
    cardStatus: 'sent',
    overview: QueryHomeWidgetOverview.fromJson(<String, dynamic>{
      'today': <dynamic>[
        <String, dynamic>{
          'userId': 'profile-1',
          'coupleId': paired ? 'couple-1' : null,
          'partnerName': 'Sam',
          'unopenedCards': 0,
          '__typename': 'Today',
        },
      ],
      'milestones': <dynamic>[],
      'partnerNote': <dynamic>[],
      'partnerMood': <dynamic>[],
      'partnerMiss': <dynamic>[],
      'rituals': <dynamic>[],
      'idea': <dynamic>[],
      '__typename': 'query_root',
    }),
  );

  setUpAll(() {
    registerFallbackValue(HomeWidgetPayload.signedOut());
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    dataSource = _MockHomeWidgetsDataSource();
    localDataSource = _MockHomeWidgetsLocalDataSource();
    homeWidgetDataService = _MockHomeWidgetDataService();
    authenticationRepository = _MockAuthenticationRepository();
    distanceRepository = _MockDistanceRepository();
    repository = HomeWidgetsRepository(
      dataSource: dataSource,
      localDataSource: localDataSource,
      homeWidgetDataService: homeWidgetDataService,
      authenticationRepository: authenticationRepository,
      distanceRepository: distanceRepository,
    );

    when(() => authenticationRepository.currentUserId).thenReturn('profile-1');
    when(
      () => dataSource.getOverview(
        userId: any(named: 'userId'),
        today: any(named: 'today'),
      ),
    ).thenAnswer((_) async => response());
    when(() => distanceRepository.getDistance(now: any(named: 'now'))).thenAnswer(
      (_) async => DistanceInfo(
        own: ZoneClock(zone: 'America/Sao_Paulo', time: DateTime(2026, 11, 11, 9)),
        partner: ZoneClock(zone: 'Europe/Lisbon', time: DateTime(2026, 11, 11, 12)),
      ),
    );
    when(
      () => homeWidgetDataService.writePayload(any(), referenceNow: any(named: 'referenceNow')),
    ).thenAnswer((invocation) async => invocation.positionalArguments.first as HomeWidgetPayload);
    when(() => localDataSource.writeCachedPayload(any())).thenAnswer((_) async {});
    when(() => localDataSource.readCachedPayload()).thenReturn(null);
    when(() => localDataSource.clear()).thenAnswer((_) async {});
    when(() => homeWidgetDataService.clearForSignOut(referenceNow: any(named: 'referenceNow')))
        .thenAnswer((_) async => HomeWidgetPayload.signedOut());
  });

  test('loading writes the payload for the native widgets and caches it', () async {
    final payload = await repository.loadAndSync(now: now);

    expect(payload.isPaired, isTrue);
    expect(payload.partnerName, 'Sam');
    expect(payload.partnerZone, 'Europe/Lisbon');
    expect(payload.cardState, HomeWidgetCardState.sent);
    verify(() => homeWidgetDataService.writePayload(any(), referenceNow: now)).called(1);
    verify(() => localDataSource.writeCachedPayload(payload)).called(1);
  });

  test('a person without a partner never asks for the distance', () async {
    when(
      () => dataSource.getOverview(
        userId: any(named: 'userId'),
        today: any(named: 'today'),
      ),
    ).thenAnswer((_) async => response(paired: false));

    await repository.loadAndSync(now: now);

    verifyNever(() => distanceRepository.getDistance(now: any(named: 'now')));
  });

  test('a failed distance read still writes the rest', () async {
    when(() => distanceRepository.getDistance(now: any(named: 'now')))
        .thenThrow(Exception('offline'));

    final payload = await repository.loadAndSync(now: now);

    expect(payload.partnerZone, isNull);
    expect(payload.partnerName, 'Sam');
  });

  test('offline it falls back to the cached payload without writing', () async {
    final cached = HomeWidgetPayload.fake();
    when(
      () => dataSource.getOverview(
        userId: any(named: 'userId'),
        today: any(named: 'today'),
      ),
    ).thenThrow(Exception('offline'));
    when(() => localDataSource.readCachedPayload()).thenReturn(cached);

    final payload = await repository.loadAndSync(now: DateTime(2026, 11, 11));

    expect(payload.partnerName, cached.partnerName);
    verifyNever(
      () => homeWidgetDataService.writePayload(any(), referenceNow: any(named: 'referenceNow')),
    );
  });

  test('offline with nothing cached rethrows', () {
    when(
      () => dataSource.getOverview(
        userId: any(named: 'userId'),
        today: any(named: 'today'),
      ),
    ).thenThrow(Exception('offline'));

    expect(() => repository.loadAndSync(now: now), throwsException);
  });

  test('syncing quietly swallows a failure', () async {
    when(() => authenticationRepository.currentUserId).thenReturn(null);

    await expectLater(repository.syncQuietly(now: now), completes);
  });

  test('signing out forgets the cache and writes the neutral payload', () async {
    final payload = await repository.clearOnSignOut(now: now);

    expect(payload.isSignedIn, isFalse);
    verify(() => localDataSource.clear()).called(1);
    verify(() => homeWidgetDataService.clearForSignOut(referenceNow: now)).called(1);
  });
}
