import 'package:app/features/together/data/models/logistic_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const proposed = LogisticItem(id: 'i', title: 'x', authorId: 'you', isShared: true);

  test('an item the partner proposed waits for the person', () {
    expect(proposed.needsConfirmationFrom('me'), isTrue);
    expect(proposed.isWaitingFor('me'), isFalse);
  });

  test('an item the person proposed waits for the partner', () {
    expect(proposed.needsConfirmationFrom('you'), isFalse);
    expect(proposed.isWaitingFor('you'), isTrue);
  });

  test('a private or confirmed item waits for nobody', () {
    const private = LogisticItem(id: 'i', title: 'x', authorId: 'you');
    const confirmed = LogisticItem(
      id: 'i',
      title: 'x',
      authorId: 'you',
      isShared: true,
      isConfirmed: true,
    );

    expect(private.needsConfirmationFrom('me'), isFalse);
    expect(confirmed.needsConfirmationFrom('me'), isFalse);
    expect(confirmed.isWaitingFor('you'), isFalse);
  });
}
