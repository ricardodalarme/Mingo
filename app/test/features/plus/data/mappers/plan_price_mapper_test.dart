import 'package:app/features/plus/data/mappers/plan_price_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchase_service/purchase_service.dart';

void main() {
  Package package(PackageType type, {String price = r'R$ 19,90'}) => Package(
    'pkg-${type.name}',
    type,
    StoreProduct('product', 'descrição', 'Mingo Plus', 19.9, price, 'BRL'),
    const PresentedOfferingContext('default', null, null),
  );

  test('a monthly package is a monthly price with the store text', () {
    final price = package(PackageType.monthly).toPlanPrice()!;

    expect(price.id, 'pkg-monthly');
    expect(price.price, r'R$ 19,90');
    expect(price.isYearly, isFalse);
  });

  test('an annual package is a yearly price', () {
    expect(package(PackageType.annual, price: r'R$ 199,00').toPlanPrice()!.isYearly, isTrue);
  });

  test('any other package has no plan price', () {
    expect(package(PackageType.lifetime).toPlanPrice(), isNull);
    expect(package(PackageType.weekly).toPlanPrice(), isNull);
  });
}
