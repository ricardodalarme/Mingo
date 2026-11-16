import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

const _options = [
  BaseFaceOption(kind: .good, label: 'Good'),
  BaseFaceOption(kind: .tired, label: 'Tired'),
  BaseFaceOption(kind: .sad, label: 'Sad'),
];

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('labeled selector reports and clears the value for ${variant.name}', (
      tester,
    ) async {
      final values = <FaceKind?>[];
      const value = FaceKind.tired;
      await tester.pumpWidget(
        galleryHost(
          BaseFaceSelector(options: _options, value: value, onChanged: values.add),
          variant: variant,
        ),
      );

      await tester.tap(find.text('Good'));
      await tester.tap(find.text('Tired'));
      expect(values, [FaceKind.good, null]);
      expect(tester.widgetList<BaseFace>(find.byType(BaseFace)).map((f) => f.selected), [
        false,
        true,
        false,
      ]);
      expect(tester.widgetList<BaseFace>(find.byType(BaseFace)).first.size, FaceSize.large);
    });
  }

  testWidgets('allowClear false keeps the selected face', (tester) async {
    final values = <FaceKind?>[];
    await tester.pumpWidget(
      galleryHost(
        BaseFaceSelector(
          options: _options,
          value: FaceKind.good,
          allowClear: false,
          onChanged: values.add,
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.tap(find.text('Good'));
    expect(values, [FaceKind.good]);
  });

  testWidgets('unlabeled reactions use 56 faces and read their emotion', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      galleryHost(
        BaseFaceSelector(
          options: const [
            BaseFaceOption(kind: .affectionate),
            BaseFaceOption(kind: .smile),
            BaseFaceOption(kind: .thinking),
          ],
          value: null,
          isLabeled: false,
          onChanged: (_) {},
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(tester.widgetList<BaseFace>(find.byType(BaseFace)).first.size, FaceSize.reaction);
    expect(find.bySemanticsLabel('Affectionate'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('disabled selector does not report', (tester) async {
    final values = <FaceKind?>[];
    await tester.pumpWidget(
      galleryHost(
        BaseFaceSelector(options: _options, value: null, isEnabled: false, onChanged: values.add),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.tap(find.text('Good'));
    expect(values, isEmpty);
  });
}
