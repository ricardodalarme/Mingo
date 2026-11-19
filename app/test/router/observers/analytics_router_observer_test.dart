import 'package:analytics_service/analytics_service.dart';
import 'package:app/router/observers/analytics_router_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnalyticsService() extends Mock implements AnalyticsService;

Route<dynamic> _routeNamed(String? name) => PageRouteBuilder<void>(
  settings: RouteSettings(name: name),
  pageBuilder: (_, _, _) => const SizedBox.shrink(),
);

void main() {
  late _MockAnalyticsService analytics;
  late AnalyticsRouterObserver observer;

  setUp(() {
    analytics = _MockAnalyticsService();
    observer = AnalyticsRouterObserver(analyticsService: analytics);
  });

  test('logs the name of every route that is pushed', () {
    for (final name in ['HomeRoute', 'GriefSupportRoute', 'UnpairRoute', 'MoodRoute']) {
      observer.didPush(_routeNamed(name), null);

      verify(() => analytics.logScreenView(screenName: name)).called(1);
    }
  });

  test('logs nothing for a route without a name', () {
    observer.didPush(_routeNamed(null), null);

    verifyNever(() => analytics.logScreenView(screenName: any(named: 'screenName')));
  });
}
