import 'package:network/network.dart';
import 'package:test/test.dart';

void main() {
  test('reads JSON text', () {
    expect(decodeJsonb('[{"a": 1}]'), [
      {'a': 1},
    ]);
  });

  test('keeps a value that is already decoded', () {
    expect(decodeJsonb([1, 2]), [1, 2]);
    expect(decodeJsonb({'a': 1}), {'a': 1});
    expect(decodeJsonb(null), isNull);
  });

  test('keeps text that is not JSON', () {
    expect(decodeJsonb('hello'), 'hello');
  });
}
