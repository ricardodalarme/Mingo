import 'package:app/router/deep_links/deep_link_handler.dart';
import 'package:auto_route/auto_route.dart';

/// Asks each handler in order which page stack a link opens.
class DeepLinkResolver({required final List<DeepLinkHandler> _handlers}) {
  /// Resolves [uri] with the first handler that knows it, or returns null when none does.
  Future<List<PageRouteInfo>?> resolve(Uri? uri) async {
    if (uri == null) return null;

    for (final handler in _handlers) {
      final routes = await handler.resolve(uri);
      if (routes != null) return routes;
    }

    return null;
  }
}
