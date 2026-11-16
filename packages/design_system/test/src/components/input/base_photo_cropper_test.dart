import 'dart:convert';
import 'dart:typed_data';

import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Scaffold;

import '../../../helpers/widget_host.dart';

final Uint8List _png = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

Widget _cropper({
  ValueChanged<Uint8List>? onDone,
  VoidCallback? onChooseAnother,
  bool isSaving = false,
}) {
  return appFor(
    variant: AppThemeVariant.rose,
    home: Scaffold(
      body: BasePhotoCropper(
        image: MemoryImage(_png),
        onDone: onDone ?? (_) {},
        onChooseAnother: onChooseAnother ?? () {},
        isSaving: isSaving,
      ),
    ),
  );
}

void main() {
  testWidgets('shows a 300 viewport, the hint and both actions', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(_cropper());

    expect(find.text('Drag and pinch to adjust the photo'), findsOneWidget);
    expect(find.text('Use this photo'), findsOneWidget);
    expect(find.text('Choose another'), findsOneWidget);
    expect(tester.getSize(find.byType(InteractiveViewer)), const Size(300, 300));
  });

  testWidgets('zoom and nudge buttons exist for people who cannot drag', (tester) async {
    setSurface(tester);
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(_cropper());

    for (final label in [
      'Zoom in',
      'Zoom out',
      'Move left',
      'Move right',
      'Move up',
      'Move down',
    ]) {
      expect(find.bySemanticsLabel(label), findsOneWidget, reason: label);
    }
    semantics.dispose();
  });

  testWidgets('zoom in scales the image and zoom out cannot go below fit', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(_cropper());
    final viewer = tester.widget<InteractiveViewer>(find.byType(InteractiveViewer));
    final controller = viewer.transformationController!;

    await tester.tap(find.byIcon(AppIcons.plus));
    expect(controller.value.getMaxScaleOnAxis(), closeTo(1.25, .001));

    await tester.tap(find.byIcon(AppIcons.square_minus));
    await tester.tap(find.byIcon(AppIcons.square_minus));
    expect(controller.value.getMaxScaleOnAxis(), 1);
  });

  testWidgets('double tap toggles fit and 2x', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(_cropper());
    final controller = tester
        .widget<InteractiveViewer>(find.byType(InteractiveViewer))
        .transformationController!;

    await tester.tap(find.byType(InteractiveViewer));
    await tester.pump(const Duration(milliseconds: 40));
    await tester.tap(find.byType(InteractiveViewer));
    await tester.pumpAndSettle();
    expect(controller.value.getMaxScaleOnAxis(), 2);
  });

  testWidgets('choose another reports and saving shows dots', (tester) async {
    setSurface(tester);
    var again = 0;
    await tester.pumpWidget(_cropper(onChooseAnother: () => again++, isSaving: true));

    expect(find.byType(BaseLoadingDots), findsOneWidget);
    await tester.tap(find.text('Choose another'));
    expect(again, 1);
  });
}
