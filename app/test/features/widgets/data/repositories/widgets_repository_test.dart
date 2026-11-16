import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/widgets/data/data_sources/local/widgets_local_data_source.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/widgets_data_source.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/data/repositories/couple_photo_repository.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockWidgetsDataSource() extends Mock implements WidgetsDataSource;

class _MockWidgetsLocalDataSource() extends Mock implements WidgetsLocalDataSource;

class _MockWidgetDataService() extends Mock implements WidgetDataService;

class _MockCouplePhotoRepository() extends Mock implements CouplePhotoRepository;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

void main() {
  late WidgetsDataSource dataSource;
  late WidgetsLocalDataSource localDataSource;
  late WidgetDataService widgetDataService;
  late CouplePhotoRepository couplePhotoRepository;
  late AuthenticationRepository authenticationRepository;
  late WidgetsRepository repository;
  late List<WidgetPayload> writes;
  WidgetPayload? cached;

  final now = DateTime.utc(2026, 11, 11, 12);

  WidgetOverviewResponse response({bool paired = true}) => (
    cardStatus: 'sent',
    overview: QueryWidgetOverview.fromJson(<String, dynamic>{
      'today': <dynamic>[
        <String, dynamic>{
          'userId': 'profile-1',
          'coupleId': paired ? 'couple-1' : null,
          'partnerId': 'profile-2',
          'partnerName': 'Marina',
          'unopenedCards': 0,
          '__typename': 'Today',
        },
      ],
      'settings': <String, dynamic>{
        'userId': 'profile-1',
        'widgetAllowPartnerNotes': true,
        'widgetOnLockScreen': false,
        'widgetShowNames': true,
        '__typename': 'UserSettings',
      },
      'plusStates': <dynamic>[
        <String, dynamic>{'hasPlus': true, '__typename': 'PlusStates'},
      ],
      'partnerNote': <dynamic>[],
      'partnerMood': <dynamic>[],
      'myMood': <dynamic>[],
      'rituals': <dynamic>[],
      'idea': <dynamic>[],
      '__typename': 'Query',
    }),
  );

  setUpAll(() {
    registerFallbackValue(WidgetPayload.signedOut());
    registerFallbackValue(WidgetContentSource.favorites);
    registerFallbackValue(WidgetRotationCadence.daily);
  });

  setUp(() {
    dataSource = _MockWidgetsDataSource();
    localDataSource = _MockWidgetsLocalDataSource();
    widgetDataService = _MockWidgetDataService();
    couplePhotoRepository = _MockCouplePhotoRepository();
    authenticationRepository = _MockAuthenticationRepository();
    repository = WidgetsRepository(
      dataSource: dataSource,
      localDataSource: localDataSource,
      widgetDataService: widgetDataService,
      couplePhotoRepository: couplePhotoRepository,
      authenticationRepository: authenticationRepository,
    );
    writes = <WidgetPayload>[];
    cached = WidgetPayload.fake();

    when(() => authenticationRepository.currentUserId).thenReturn('profile-1');
    when(() => localDataSource.contentSource).thenReturn(WidgetContentSource.favorites);
    when(() => localDataSource.rotationCadence).thenReturn(WidgetRotationCadence.daily);
    when(() => localDataSource.readCachedPayload()).thenAnswer((_) => cached);
    when(() => localDataSource.writeCachedPayload(any())).thenAnswer((invocation) async {
      cached = invocation.positionalArguments.first as WidgetPayload;
      return;
    });
    when(() => localDataSource.clear()).thenAnswer((_) async {
      cached = null;
      return;
    });
    when(() => localDataSource.setContentSource(any())).thenAnswer((_) async {
      return;
    });
    when(() => localDataSource.setRotationCadence(any())).thenAnswer((_) async {
      return;
    });
    when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
        .thenAnswer((_) async => null);
    when(() => couplePhotoRepository.syncWidgetCache(cacheAllowed: any(named: 'cacheAllowed')))
        .thenAnswer((_) async => false);
    when(() => widgetDataService.clearCouplePhoto()).thenAnswer((_) async {
      return;
    });
    when(() => widgetDataService.readStoredPayload()).thenAnswer((_) async => cached);
    when(() => widgetDataService.writePayload(any(), referenceNow: any(named: 'referenceNow')))
        .thenAnswer((invocation) async {
          final payload = invocation.positionalArguments.first as WidgetPayload;
          writes.add(payload);
          cached = payload;
          return payload;
        });
    when(() => widgetDataService.clearForSignOut(referenceNow: any(named: 'referenceNow')))
        .thenAnswer((_) async => WidgetPayload.signedOut());
  });

  test('a delayed sync cannot overwrite a newer sign-out payload', () async {
    final delayed = Completer<WidgetOverviewResponse>();
    when(() => dataSource.getOverview(any())).thenAnswer((_) => delayed.future);

    final sync = repository.loadAndSync(now: now);
    await repository.clearOnSignOut(now: now);
    delayed.complete(response());
    await sync;

    expect(writes, isEmpty);
    expect(cached?.isSignedIn ?? false, isFalse);
  });

  test('loadAndSync reads the couple photo row and exposes it on the overview', () async {
    when(() => dataSource.getOverview(any())).thenAnswer((_) async => response());
    when(() => couplePhotoRepository.syncWidgetCache(cacheAllowed: any(named: 'cacheAllowed')))
        .thenAnswer((_) async => true);
    when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
        .thenAnswer((_) async => '/tmp/mingo_widget_photo.png');

    final overview = await repository.loadAndSync(now: now);

    expect(overview.hasPhoto, isTrue);
    expect(overview.payload.cachedPhotoPath, '/tmp/mingo_widget_photo.png');
    verify(() => couplePhotoRepository.syncWidgetCache(cacheAllowed: true)).called(1);
  });

  test('loadAndSync clears the photo cache when the couple is unpaired', () async {
    when(() => dataSource.getOverview(any())).thenAnswer((_) async => response(paired: false));

    final overview = await repository.loadAndSync(now: now);

    expect(overview.hasPhoto, isFalse);
    verify(() => widgetDataService.clearCouplePhoto()).called(1);
    verifyNever(
      () => couplePhotoRepository.syncWidgetCache(cacheAllowed: any(named: 'cacheAllowed')),
    );
  });
}
