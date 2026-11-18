import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/services/home_widget_data_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_widget_service/home_widget_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeWidgetService() extends Mock implements HomeWidgetService;

void main() {
  late HomeWidgetService homeWidget;
  late HomeWidgetDataService service;
  late List<String> savedValues;

  final now = DateTime(2026, 11, 11, 12);

  setUpAll(() => registerFallbackValue(<DateTime>[]));

  setUp(() {
    homeWidget = _MockHomeWidgetService();
    service = HomeWidgetDataService(homeWidget: homeWidget);
    savedValues = [];
    when(() => homeWidget.setAppGroupId(any())).thenAnswer((_) async {});
    when(() => homeWidget.saveString(any(), any())).thenAnswer((invocation) async {
      savedValues.add(invocation.positionalArguments[1] as String);
    });
    when(
      () => homeWidget.updateWidget(
        name: any(named: 'name'),
        androidName: any(named: 'androidName'),
        iosName: any(named: 'iosName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => homeWidget.scheduleUpdates(
        any(),
        name: any(named: 'name'),
        androidName: any(named: 'androidName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => homeWidget.cancelScheduledUpdates(
        name: any(named: 'name'),
        androidName: any(named: 'androidName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).thenAnswer((_) async {});
  });

  test('every widget has a WidgetKit kind and a Glance receiver named after it', () {
    expect(HomeWidgetKind.counter.iosKind, 'MingoCounterWidget');
    expect(HomeWidgetKind.partnerMood.androidReceiver, 'MingoPartnerMoodWidgetReceiver');
    expect(
      HomeWidgetKind.idea.qualifiedAndroidReceiver,
      'dev.dalarme.mingo.widgets.MingoIdeaWidgetReceiver',
    );
  });

  test('writing saves the sanitized payload in the app group and reloads every widget', () async {
    final written = await service.writePayload(
      const HomeWidgetPayload(isSignedIn: true, isPaired: false, updatedAt: '', partnerName: 'Sam'),
      referenceNow: now,
    );

    verify(() => homeWidget.setAppGroupId(HomeWidgetDataService.appGroupId)).called(1);
    verify(() => homeWidget.saveString(HomeWidgetDataService.payloadStorageKey, any())).called(1);
    expect(HomeWidgetPayload.fromJsonString(savedValues.single), written);
    expect(written.partnerName, isNull);
    verify(
      () => homeWidget.updateWidget(
        iosName: any(named: 'iosName'),
        androidName: any(named: 'androidName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).called(HomeWidgetKind.values.length);
  });

  test('widgets that show days or clocks are scheduled for the next midnight', () async {
    await service.writePayload(
      const HomeWidgetPayload(isSignedIn: true, isPaired: true, updatedAt: ''),
      referenceNow: now,
    );

    final captured = verify(
      () => homeWidget.scheduleUpdates(
        captureAny(),
        name: any(named: 'name'),
        androidName: any(named: 'androidName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).captured;
    final midnight = DateTime(2026, 11, 12);

    expect(captured.length, HomeWidgetKind.values.where((kind) => kind.refreshesAtMidnight).length);
    expect(captured.every((dates) => (dates as List<DateTime>).single == midnight), isTrue);
  });

  test('signing out stores the neutral payload and cancels the midnight refresh', () async {
    final neutral = await service.clearForSignOut(referenceNow: now);

    expect(neutral.isSignedIn, isFalse);
    expect(HomeWidgetPayload.fromJsonString(savedValues.single).isSignedIn, isFalse);
    verify(
      () => homeWidget.cancelScheduledUpdates(
        name: any(named: 'name'),
        androidName: any(named: 'androidName'),
        qualifiedAndroidName: any(named: 'qualifiedAndroidName'),
      ),
    ).called(HomeWidgetKind.values.where((kind) => kind.refreshesAtMidnight).length);
  });

  test('a host without the native plugin is tolerated', () async {
    when(() => homeWidget.saveString(any(), any())).thenThrow(MissingPluginException());

    final written = await service.writePayload(
      const HomeWidgetPayload(isSignedIn: true, isPaired: false, updatedAt: ''),
      referenceNow: now,
    );

    expect(written.isSignedIn, isTrue);
  });

  test('the launching deep link is null when the platform cannot answer', () async {
    when(() => homeWidget.initiallyLaunched()).thenThrow(PlatformException(code: 'x'));

    expect(await service.initiallyLaunchedFromHomeWidget(), isNull);
  });
}
