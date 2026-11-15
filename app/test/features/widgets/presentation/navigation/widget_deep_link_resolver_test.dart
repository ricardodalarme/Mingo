import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/widgets/presentation/navigation/widget_deep_link_resolver.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('signed-out widget tap always resolves to WelcomeRoute + SignInRoute', () {
    final routes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://today?homeWidget=1'),
      appState: AppState.unauthenticated,
    );

    expect(routes, isNotNull);
    expect(routes!.last.routeName, SignInRoute.name);
  });

  test('authenticated deep links resolve to today, card, dates, and discreet settings', () {
    final todayRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://today'),
      appState: AppState.authenticated,
    );
    expect(todayRoutes, isNotNull);
    expect(todayRoutes!.first.routeName, HomeRoute.name);

    final cardRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://card'),
      appState: AppState.authenticated,
    );
    expect(cardRoutes!.last.routeName, SundayCardRoute.name);

    final datesRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://dates'),
      appState: AppState.authenticated,
    );
    expect(datesRoutes!.last.routeName, DatesRoute.name);

    final discreetRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://settings/discreet'),
      appState: AppState.authenticated,
    );
    expect(discreetRoutes!.last.routeName, DiscreetModeRoute.name);

    final togetherRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://together?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(togetherRoutes!.first.initialChildren?.first.routeName, TogetherRoute.name);

    final memoriesRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://memories?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(memoriesRoutes!.first.initialChildren?.first.routeName, MemoriesRoute.name);

    final inviteRoutes = resolveWidgetDeepLinkUri(
      Uri.parse('mingo://invite?homeWidget=1'),
      appState: AppState.authenticated,
    );
    expect(inviteRoutes!.last.routeName, InviteRoute.name);
  });
}
