import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_widget_service/home_widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('home_widget');
  late List<MethodCall> calls;
  late PlatformHomeWidgetService service;

  setUp(() {
    calls = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (call) async {
        calls.add(call);

        return null;
      },
    );
    service = const PlatformHomeWidgetService();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      null,
    );
  });

  test('setAppGroupId sends the shared App Group', () async {
    await service.setAppGroupId('group.com.example');

    expect(calls.single.arguments, {'groupId': 'group.com.example'});
  });

  test('saveString sends the value and clears the key with null', () async {
    await service.saveString('payload', '{"a":1}');
    await service.saveString('payload', null);

    expect((calls.first.arguments as Map)['data'], '{"a":1}');
    expect((calls.last.arguments as Map)['data'], isNull);
  });

  test('updateWidget maps the iOS kind and the Android provider', () async {
    await service.updateWidget(
      iosName: 'MingoOwnSmallWidget',
      androidName: 'widgets.MingoOwnSmallWidgetProvider',
      qualifiedAndroidName: 'com.example.widgets.MingoOwnSmallWidgetProvider',
    );

    expect(calls.single.arguments, {
      'name': null,
      'android': 'widgets.MingoOwnSmallWidgetProvider',
      'ios': 'MingoOwnSmallWidget',
      'qualifiedAndroidName': 'com.example.widgets.MingoOwnSmallWidgetProvider',
    });
  });

  test('scheduleUpdates sends the update times', () async {
    final nextMidnight = DateTime.utc(2026, 11, 14);

    await service.scheduleUpdates(
      [nextMidnight],
      name: 'MingoCoupleCounterWidgetProvider',
      androidName: 'widgets.MingoCoupleCounterWidgetProvider',
      qualifiedAndroidName: 'com.example.widgets.MingoCoupleCounterWidgetProvider',
    );

    expect(calls.single.arguments, {
      'updateTimes': [nextMidnight.millisecondsSinceEpoch],
      'name': 'MingoCoupleCounterWidgetProvider',
      'android': 'widgets.MingoCoupleCounterWidgetProvider',
      'qualifiedAndroidName': 'com.example.widgets.MingoCoupleCounterWidgetProvider',
    });
  });

  test('cancelScheduledUpdates sends the provider name', () async {
    await service.cancelScheduledUpdates(
      name: 'MingoCoupleCounterWidgetProvider',
      androidName: 'widgets.MingoCoupleCounterWidgetProvider',
      qualifiedAndroidName: 'com.example.widgets.MingoCoupleCounterWidgetProvider',
    );

    expect(calls.single.arguments, {
      'name': 'MingoCoupleCounterWidgetProvider',
      'android': 'widgets.MingoCoupleCounterWidgetProvider',
      'qualifiedAndroidName': 'com.example.widgets.MingoCoupleCounterWidgetProvider',
    });
  });
}
