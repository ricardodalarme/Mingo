import 'package:app/features/mood/presentation/mood/widgets/mood_row.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/services.dart';
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

  testWidgets('a hold reports the held face and leaves the tap alone', (tester) async {
    int? selected;
    int? held;

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        selectedIndex: 1,
        onSelected: (index) => selected = index,
        onLongPressed: (index) => held = index,
      ),
    );

    await tester.longPress(find.text('Feliz'));
    await tester.pump();

    expect(held, 0);
    expect(selected, isNull);
    expect(
      tester.widgetList<AppPressable>(find.byType(AppPressable)).map((widget) => widget.isSelected),
      [false, true],
    );
  });

  testWidgets('a tap still reports the tap when the row also answers holds', (tester) async {
    int? selected;
    int? held;

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (index) => selected = index,
        onLongPressed: (index) => held = index,
      ),
    );

    await tester.tap(find.text('Triste'));
    await tester.pump();

    expect(selected, 1);
    expect(held, isNull);
  });

  testWidgets('a hold answers with a light haptic', (tester) async {
    final calls = <MethodCall>[];

    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (
      call,
    ) async {
      calls.add(call);

      return null;
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (_) {},
        onLongPressed: (_) {},
      ),
    );

    await tester.longPress(find.text('Triste'));
    await tester.pump();

    expect(
      calls.where(
        (call) =>
            call.method == 'HapticFeedback.vibrate' &&
            call.arguments == 'HapticFeedbackType.lightImpact',
      ),
      hasLength(1),
    );
  });

  testWidgets('the action line opens the details and reads as a button', (tester) async {
    final semantics = tester.ensureSemantics();
    var opened = 0;

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        actionLabel: 'Só você vê',
        onAction: () => opened++,
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (_) {},
        onLongPressed: (_) {},
        longPressHint: 'Segure para abrir os detalhes',
      ),
    );

    await tester.tap(find.text('Só você vê'));
    await tester.pump();

    expect(opened, 1);
    expect(
      tester.getSemantics(find.text('Só você vê')),
      matchesSemantics(label: 'Só você vê', isButton: true, hasTapAction: true),
    );
    semantics.dispose();
  });

  testWidgets('a hold is announced to the screen reader with what it does', (tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpApp(
      MoodRow(
        title: 'Como você está?',
        options: const [
          MoodRowOption(face: FaceKind.good, label: 'Feliz'),
          MoodRowOption(face: FaceKind.sad, label: 'Triste'),
        ],
        onSelected: (_) {},
        onLongPressed: (_) {},
        longPressHint: 'Segure para abrir os detalhes',
      ),
    );

    final node = tester.getSemantics(find.text('Triste'));

    expect(node.label, 'Triste');
    expect(node.hint, 'Segure para abrir os detalhes');
    semantics.dispose();
  });
}
