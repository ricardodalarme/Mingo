import 'package:app/router/deep_links/deep_link_transformer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('moves the host into the path', () {
    final uri = transformDeepLinkUri(Uri.parse('mingo://slip/123'));

    expect(uri.toString(), '/slip/123');
  });

  test('keeps the query and adds nothing to it', () {
    final uri = transformDeepLinkUri(Uri.parse('mingo://card?src=widget'));

    expect(uri.path, '/card');
    expect(uri.queryParameters, {'src': 'widget'});
  });

  test('leaves other schemes untouched', () {
    final original = Uri.parse('https://example.com/invite/ABCD');

    expect(transformDeepLinkUri(original), original);
  });
}
