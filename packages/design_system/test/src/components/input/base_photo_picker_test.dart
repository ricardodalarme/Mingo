import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Scaffold;

import '../../../helpers/widget_host.dart';

class const _Launcher({
  required final bool hasPhoto,
  required final bool hasCamera,
  required final ValueChanged<BasePhotoSource?> onResult,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseButton.primary(
        text: 'Open',
        onPressed: () async =>
            onResult(await BasePhotoPicker.show(context, hasPhoto: hasPhoto, hasCamera: hasCamera)),
      ),
    );
  }
}

Future<void> _open(
  WidgetTester tester, {
  required ValueChanged<BasePhotoSource?> onResult,
  bool hasPhoto = false,
  bool hasCamera = true,
}) async {
  setSurface(tester);
  await tester.pumpWidget(
    appFor(
      variant: AppThemeVariant.rose,
      home: Scaffold(
        body: _Launcher(hasPhoto: hasPhoto, hasCamera: hasCamera, onResult: onResult),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows camera, library and initial rows without remove', (tester) async {
    await _open(tester, onResult: (_) {});

    expect(find.text('Take a photo'), findsOneWidget);
    expect(find.text('Choose from library'), findsOneWidget);
    expect(find.text('Use initial and color'), findsOneWidget);
    expect(find.text('Remove photo'), findsNothing);
  });

  testWidgets('hides the camera row when there is no camera and adds remove with a photo', (
    tester,
  ) async {
    await _open(tester, hasPhoto: true, hasCamera: false, onResult: (_) {});

    expect(find.text('Take a photo'), findsNothing);
    expect(find.text('Remove photo'), findsOneWidget);
  });

  testWidgets('a row resolves with its source', (tester) async {
    BasePhotoSource? result;
    await _open(tester, hasPhoto: true, onResult: (value) => result = value);

    await tester.tap(find.text('Remove photo'));
    await tester.pumpAndSettle();
    expect(result, BasePhotoSource.remove);
  });
}
