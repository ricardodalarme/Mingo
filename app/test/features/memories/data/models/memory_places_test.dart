import 'package:app/features/memories/data/models/memory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a place that reads like an address is noticed, a plain name is not', () {
    expect(looksLikeAddress('Rua das Flores, 120'), isTrue);
    expect(looksLikeAddress('Avenida Paulista'), isTrue);
    expect(looksLikeAddress('221B Baker Street'), isTrue);
    expect(looksLikeAddress('Paraty'), isFalse);
    expect(looksLikeAddress('Praia do Forte'), isFalse);
  });
}
