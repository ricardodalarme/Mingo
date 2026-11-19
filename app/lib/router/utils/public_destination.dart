import 'package:auto_route/auto_route.dart';

/// The route `meta` that lets a signed-out person open a page.
const Map<String, dynamic> publicRouteMeta = {'public': true};

/// Whether a route with [meta] may be opened without a session.
bool isPublicRoute(Map<String, dynamic> meta) => meta['public'] == true;

/// The page to open alone when [matches] end on a page a signed-out person may see, or null otherwise.
///
/// Prefix matching puts the guarded Home under every page, and the guard would stop there.
PageRouteInfo? publicDestinationOf(List<RouteMatch<dynamic>> matches) {
  final destination = matches.lastOrNull;
  if (destination == null || !isPublicRoute(destination.meta)) return null;

  return destination.toPageRouteInfo();
}
