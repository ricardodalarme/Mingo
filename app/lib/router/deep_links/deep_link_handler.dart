import 'package:auto_route/auto_route.dart';

/// Recognizes one kind of link that needs more than path matching.
abstract interface class DeepLinkHandler() {
  /// Resolves [uri] to a page stack, or returns null when the link is not of this kind.
  Future<List<PageRouteInfo>?> resolve(Uri uri);
}
