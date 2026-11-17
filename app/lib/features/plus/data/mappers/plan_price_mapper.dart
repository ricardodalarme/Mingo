import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:purchase_service/purchase_service.dart';

extension PlanPriceMapper on Package {
  /// The price of a monthly or yearly plan as the store writes it; null for any other package.
  PlanPrice? toPlanPrice() {
    if (packageType != PackageType.monthly && packageType != PackageType.annual) return null;

    return PlanPrice(
      id: identifier,
      price: storeProduct.priceString,
      isYearly: packageType == PackageType.annual,
    );
  }
}
