import 'package:form_inputs/form_inputs.dart';
import 'package:test/test.dart';

void main() {
  group(UrlValidator, () {
    final validator = UrlValidator();

    test('accepts absolute http and https links', () {
      const urls = [
        'https://example.com',
        'https://www.store.com/item/123',
        'http://shop.example.com.br/produto?ref=abc',
        'https://amzn.to/3xYz',
      ];

      for (final url in urls) {
        expect(validator.validate(url), isNull, reason: url);
      }
    });

    test('rejects links without a scheme or a host name', () {
      const urls = [
        '',
        'example.com',
        'www.example.com',
        'ftp://example.com',
        'https://',
        'https://example',
        'not a link',
      ];

      for (final url in urls) {
        expect(validator.validate(url), UrlValidationError.invalid, reason: url);
      }
    });
  });
}
