import 'package:app/features/mood/presentation/mood/widgets/mood_row.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

void main() {
  testWidgets('reports the tapped face by index', (tester) async {
    int? selected;

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está hoje?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (index) => selected = index,
      ),
    );

    await tester.tap(find.text('Triste'));
    await tester.pump();

    expect(selected, 1);
    expect(find.byType(BaseFace), findsNWidgets(2));
  });

  testWidgets('every mood option takes the same width', (tester) async {
    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.thinking, label: 'Mais ou menos'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (_) {},
      ),
    );

    final widths = [
      for (final pressable in tester.widgetList<AppPressable>(find.byType(AppPressable)))
        tester.getSize(find.byWidget(pressable)).width,
    ];

    expect(widths, hasLength(3));
    expect(widths.toSet(), hasLength(1));
    expect(find.byType(BaseFace), findsNWidgets(3));
  });

  testWidgets('the chosen face reads as selected and every face is a 44pt target', (tester) async {
    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Bem'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        selectedIndex: 0,
        onSelected: (_) {},
      ),
    );

    final pressables = tester.widgetList<AppPressable>(find.byType(AppPressable)).toList();

    expect(pressables.map((widget) => widget.isSelected), [true, false]);
    for (final pressable in pressables) {
      final size = tester.getSize(find.byWidget(pressable));

      expect(size.width, greaterThanOrEqualTo(AppIconSize.touch));
      expect(size.height, greaterThanOrEqualTo(AppIconSize.touch));
    }
    expect(
      find.byWidgetPredicate(
        (widget) => widget is BaseFace && widget.selected && widget.kind == FaceKind.good,
      ),
      findsOneWidget,
    );
  });
}
