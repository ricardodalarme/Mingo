import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every widget kind appears in the gallery', () {
    final shown = {
      for (final group in HomeWidgetGalleryGroup.values)
        for (final variant in group.variants) variant.kind,
    };

    expect(shown, HomeWidgetKind.values.toSet());
  });

  test('no widget is listed twice', () {
    final variants = [for (final group in HomeWidgetGalleryGroup.values) ...group.variants];

    expect(variants.toSet().length, variants.length);
  });

  test('only the widgets about the partner need one', () {
    final needing = HomeWidgetKind.values.where((kind) => kind.needsPartner).toSet();

    expect(needing, {
      HomeWidgetKind.partnerMood,
      HomeWidgetKind.longing,
      HomeWidgetKind.partnerNote,
      HomeWidgetKind.distance,
    });
  });

  test('a variant label key joins the kind and the size', () {
    expect((kind: HomeWidgetKind.counter, size: HomeWidgetSize.medium).labelKey, 'counterMedium');
    expect((kind: HomeWidgetKind.slip, size: HomeWidgetSize.small).labelKey, 'slipSmall');
  });
}
