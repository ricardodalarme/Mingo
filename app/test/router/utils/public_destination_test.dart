import 'package:app/router/app_router.dart';
import 'package:app/router/utils/public_destination.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';

class _AllowAll() extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) => resolver.next();
}

void main() {
  final router = AppRouter(guard: _AllowAll());

  List<RouteMatch<dynamic>> matches(String path) =>
      router.matcher.match(path, includePrefixMatches: true)!;

  test('a public page opens without the Home under it', () {
    final page = publicDestinationOf(matches('/sign-in'));

    expect(matches('/sign-in').map((match) => match.name), [HomeRoute.name, SignInRoute.name]);
    expect(page!.routeName, SignInRoute.name);
  });

  test('a guarded page opens with its stack', () {
    expect(publicDestinationOf(matches('/card')), isNull);
    expect(publicDestinationOf(matches('/dates')), isNull);
  });

  test('not found opens alone', () {
    expect(publicDestinationOf(matches('/typo'))!.routeName, NotFoundRoute.name);
  });

  test('no matches open nothing', () {
    expect(publicDestinationOf(const []), isNull);
  });

  test('a route with the public meta is public', () {
    expect(isPublicRoute(publicRouteMeta), isTrue);
  });

  test('a route without meta is guarded', () {
    expect(isPublicRoute(const {}), isFalse);
  });

  test('a route whose public meta is not true is guarded', () {
    expect(isPublicRoute(const {'public': false}), isFalse);
    expect(isPublicRoute(const {'public': 'yes'}), isFalse);
  });
}
