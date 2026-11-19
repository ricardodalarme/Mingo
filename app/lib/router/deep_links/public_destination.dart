import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';

/// Pages a signed-out person may open, and the routes the app lands on itself.
const Set<String> publicRouteNames = {
  WelcomeRoute.name,
  IntroPhaseRoute.name,
  IntroGoalsRoute.name,
  IntroThemeRoute.name,
  FirstSlipRoute.name,
  PartnerStepRoute.name,
  SignInRoute.name,
  CreateAccountRoute.name,
  ExistingAccountRoute.name,
  DebugSignInRoute.name,
  SessionExpiredRoute.name,
  NotFoundRoute.name,
  SettingsHomeRoute.name,
  SettingsThemeRoute.name,
  LanguageRoute.name,
  HelpRoute.name,
  SupportRoute.name,
};

/// The page to open alone when [matches] end on a page a signed-out person may see, or null otherwise.
///
/// Prefix matching puts the guarded Home under every page, and the guard would stop there.
PageRouteInfo? publicDestinationOf(List<RouteMatch<dynamic>> matches) {
  final destination = matches.lastOrNull;
  if (destination == null || !publicRouteNames.contains(destination.name)) return null;

  return destination.toPageRouteInfo();
}
