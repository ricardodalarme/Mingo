import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('stats render in every size for ${variant.name}', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        galleryHost(
          const Column(
            children: [
              BaseStatRow(
                children: [
                  BaseStat(value: '969', caption: 'days'),
                  BaseStat(value: '138', caption: 'weekends'),
                  BaseStat(value: '2', caption: 'Christmases'),
                ],
              ),
              BaseStat(value: '42', caption: 'days until you meet', size: .large),
              BaseStat(value: '2', caption: 'years', size: .hero),
            ],
          ),
          variant: variant,
        ),
      );

      expect(find.bySemanticsLabel('969 days'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(tester.takeException(), isNull);
      semantics.dispose();
    });
  }

  testWidgets('a missing value shows an em dash, never zero', (tester) async {
    await tester.pumpWidget(
      galleryHost(const BaseStat(value: null, caption: 'days'), variant: AppThemeVariant.rose),
    );

    expect(find.text('—'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}
