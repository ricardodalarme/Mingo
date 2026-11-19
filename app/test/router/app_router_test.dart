import 'dart:io';

import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';

class _AllowAll() extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) => resolver.next();
}

void main() {
  final router = AppRouter(guard: _AllowAll());

  List<String> names(String path) {
    final matches = router.matcher.match(path, includePrefixMatches: true)!;

    return [
      for (final match in matches) ...[match.name, ...?match.children?.map((child) => child.name)],
    ];
  }

  group('links the widgets send', () {
    test('tabs open inside Home', () {
      expect(names('/today'), [HomeRoute.name, TodayRoute.name]);
      expect(names('/slips'), [HomeRoute.name, SlipsRoute.name]);
      expect(names('/couple'), [HomeRoute.name, CoupleRoute.name]);
    });

    test('together opens the couple tab', () {
      expect(names('/together'), [HomeRoute.name, CoupleRoute.name]);
    });

    test('a page opens on top of Home', () {
      for (final (path, page) in [
        ('/card', SundayCardRoute.name),
        ('/capture', QuickSlipRoute.name),
        ('/mood', MoodRoute.name),
        ('/invite', InviteRoute.name),
        ('/widgets', HomeWidgetsGalleryRoute.name),
        ('/dates', DatesRoute.name),
        ('/rituals', RitualsRoute.name),
        ('/distance', DistanceRoute.name),
      ]) {
        expect(names(path), [HomeRoute.name, page], reason: path);
      }
    });

    test('sign-in is a page of its own', () {
      expect(router.matcher.match('/sign-in')!.last.name, SignInRoute.name);
    });
  });

  group('hosts the native widgets send', () {
    final swift = RegExp(r'case (\w+)(?: = "([\w-]+)")?')
        .allMatches(File('ios/MingoWidgets/Core/MingoLink.swift').readAsStringSync())
        .map((match) => match.group(2) ?? match.group(1)!)
        .toSet();
    final kotlin = RegExp(r'\w+\("([\w-]+)"\)')
        .allMatches(
          File('android/app/src/main/kotlin/dev/dalarme/mingo/widgets/core/MingoLink.kt')
              .readAsStringSync(),
        )
        .map((match) => match.group(1)!)
        .toSet();

    test('the two platforms send the same hosts', () {
      expect(swift, isNotEmpty);
      expect(kotlin, swift);
    });

    test('every host opens a page', () {
      for (final host in swift) {
        expect(names('/$host'), isNot(contains(NotFoundRoute.name)), reason: host);
      }
    });
  });

  group('prefix matching', () {
    test('puts Home under a page that has no link of its own', () {
      expect(names('/distance'), [HomeRoute.name, DistanceRoute.name]);
    });

    test('keeps a page with deeper siblings out of their stack', () {
      expect(names('/card/abc'), [HomeRoute.name, CardDetailRoute.name]);
    });

    test('shows not found for a path that names nothing', () {
      expect(names('/typo'), [NotFoundRoute.name]);
    });
  });

  test('the first path is Welcome only at /welcome', () {
    expect(router.matcher.match('/welcome')!.last.name, WelcomeRoute.name);
    expect(names('/'), [HomeRoute.name, TodayRoute.name]);
  });
}
