import 'package:app/router/app_router.dart';
import 'package:app/router/deep_links/deep_link_handler.dart';
import 'package:app/router/deep_links/deep_link_resolver.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubHandler({required final String host, required final List<PageRouteInfo> routes})
    implements DeepLinkHandler {
  @override
  Future<List<PageRouteInfo>?> resolve(Uri uri) async => uri.host == host ? routes : null;
}

void main() {
  const first = [SlipsRoute()];
  const second = [DatesRoute()];

  test('returns the routes of the first handler that knows the link', () async {
    final resolver = DeepLinkResolver(
      handlers: [
        _StubHandler(host: 'a', routes: first),
        _StubHandler(host: 'a', routes: second),
      ],
    );

    expect(await resolver.resolve(Uri.parse('mingo://a')), first);
  });

  test('asks the next handler when one does not know the link', () async {
    final resolver = DeepLinkResolver(
      handlers: [
        _StubHandler(host: 'a', routes: first),
        _StubHandler(host: 'b', routes: second),
      ],
    );

    expect(await resolver.resolve(Uri.parse('mingo://b')), second);
  });

  test('returns null when no handler knows the link', () async {
    final resolver = DeepLinkResolver(
      handlers: [_StubHandler(host: 'a', routes: first)],
    );

    expect(await resolver.resolve(Uri.parse('mingo://z')), isNull);
  });

  test('returns null for a missing link', () async {
    final resolver = DeepLinkResolver(
      handlers: [_StubHandler(host: 'a', routes: first)],
    );

    expect(await resolver.resolve(null), isNull);
  });
}
