import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('preview tile uses radius 26 and a 74 by 86 slot for ${variant.name}', (
      tester,
    ) async {
      final semantics = tester.ensureSemantics();
      var taps = 0;
      await tester.pumpWidget(
        galleryHost(
          BaseOptionTile(
            title: 'Soft rose',
            support: 'Warm and delicate',
            preview: const ColoredBox(color: AppPalette.neutral100),
            isSelected: true,
            onTap: () => taps++,
          ),
          variant: variant,
        ),
      );

      final tile = tester.widget<Container>(
        find.descendant(of: find.byType(BaseOptionTile), matching: find.byType(Container)).first,
      );
      final decoration = tile.decoration! as BoxDecoration;
      expect((decoration.borderRadius! as BorderRadius).topLeft.x, 26);
      expect(decoration.boxShadow, AppShadows.selected);

      final slot = find
          .ancestor(of: find.byType(ColoredBox).last, matching: find.byType(SizedBox))
          .first;
      expect(tester.getSize(slot), const Size(74, 86));
      expect(find.bySemanticsLabel('Soft rose'), findsOneWidget);

      await tester.tap(find.text('Soft rose'));
      expect(taps, 1);
      semantics.dispose();
    });
  }

  testWidgets('a tile without a preview keeps radius 18', (tester) async {
    await tester.pumpWidget(
      galleryHost(const BaseOptionTile(title: 'Every Sunday'), variant: AppThemeVariant.rose),
    );

    final tile = tester.widget<Container>(
      find.descendant(of: find.byType(BaseOptionTile), matching: find.byType(Container)).first,
    );
    expect(((tile.decoration! as BoxDecoration).borderRadius! as BorderRadius).topLeft.x, 18);
  });
}
