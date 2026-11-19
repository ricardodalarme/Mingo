import 'package:design_system/design_system.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

Widget _note({
  SlipNoteType type = SlipNoteType.good,
  SlipNoteSize size = SlipNoteSize.wall,
  String text = 'Fez café sem eu pedir',
  VoidCallback? onTap,
  bool animatesEntrance = false,
  double textScale = 1,
  bool reduceMotion = false,
}) => materialAppFor(
  Padding(
    padding: const EdgeInsets.all(20),
    child: BaseSlipNote(
      text: text,
      type: type,
      typeLabel: 'Fez algo',
      dayLabel: 'Seg',
      tilt: 1,
      size: size,
      onTap: onTap,
      animatesEntrance: animatesEntrance,
    ),
  ),
  variant: AppThemeVariant.rose,
  textScale: textScale,
  reduceMotion: reduceMotion,
);

void main() {
  const icons = {
    SlipNoteType.good: AppIcons.check,
    SlipNoteType.help: AppIcons.heart,
    SlipNoteType.notice: AppIcons.eye,
    SlipNoteType.said: AppIcons.message,
    SlipNoteType.annoyed: AppIcons.cloud,
  };

  for (final type in SlipNoteType.values) {
    testWidgets('${type.name} note paints its paper, ink and icon', (tester) async {
      await tester.pumpWidget(_note(type: type));

      final tone = AppSlipNoteColors.standard.of(type);
      final decorated = tester
          .widgetList<DecoratedBox>(find.byType(DecoratedBox))
          .map((box) => box.decoration)
          .whereType<BoxDecoration>();
      expect(decorated.any((decoration) => decoration.color == tone.background), isTrue);

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, icons[type]);
      expect(icon.color, tone.ink);
      expect(tester.widget<Text>(find.text('FEZ ALGO')).style?.color, tone.ink);
    });
  }

  testWidgets('wall size clamps the text at five lines and large shows it all', (tester) async {
    final text = List.filled(40, 'palavra').join(' ');

    await tester.pumpWidget(_note(text: text));
    expect(tester.widget<Text>(find.text(text)).maxLines, 5);
    expect(tester.widget<Text>(find.text(text)).overflow, TextOverflow.ellipsis);

    await tester.pumpWidget(_note(text: text, size: SlipNoteSize.large));
    expect(tester.widget<Text>(find.text(text)).maxLines, isNull);
  });

  testWidgets('the day label never wraps', (tester) async {
    await tester.pumpWidget(_note());

    final day = tester.widget<Text>(find.text('Seg'));
    expect(day.softWrap, isFalse);
    expect(day.maxLines, 1);
  });

  testWidgets('the note text stops growing at 1.3x while the footer keeps scaling', (tester) async {
    await tester.pumpWidget(_note(textScale: 2));

    final body = tester.widget<Text>(find.text('Fez café sem eu pedir'));
    expect(body.textScaler!.scale(10), closeTo(13, .001));
    expect(tester.widget<Text>(find.text('Seg')).textScaler, isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('semantics merge text, type and day into one button', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_note(onTap: () {}));

    expect(find.bySemanticsLabel('Fez café sem eu pedir, Fez algo, Seg'), findsOneWidget);
    expect(find.bySemanticsLabel('FEZ ALGO'), findsNothing);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Fez café sem eu pedir, Fez algo, Seg')),
      matchesSemantics(
        label: 'Fez café sem eu pedir, Fez algo, Seg',
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
        isFocusable: true,
        hasTapAction: true,
        hasFocusAction: true,
      ),
    );
    handle.dispose();
  });

  testWidgets('tap fires', (tester) async {
    var taps = 0;
    await tester.pumpWidget(_note(onTap: () => taps++));

    await tester.tap(find.byType(BaseSlipNote));
    expect(taps, 1);
  });

  testWidgets('an entrance fades the note in and lifts it 8 px', (tester) async {
    await tester.pumpWidget(_note(animatesEntrance: true));

    final opacity = tester.widget<Opacity>(find.byType(Opacity).first);
    expect(opacity.opacity, 0);

    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, 1);
  });

  testWidgets('reduced motion shows the note at once', (tester) async {
    await tester.pumpWidget(_note(animatesEntrance: true, reduceMotion: true));

    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, 1);
  });

  testWidgets('a note without the flag does not animate', (tester) async {
    await tester.pumpWidget(_note());

    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, 1);
  });

  testWidgets('the tilt rotates the paper by the given degrees', (tester) async {
    await tester.pumpWidget(_note());

    final rotation = tester
        .widgetList<Transform>(find.byType(Transform))
        .map((transform) => transform.transform.getRotation().storage[1])
        .any((sin) => (sin - 0.01745).abs() < .0005);
    expect(rotation, isTrue);
  });

  testWidgets('the semantic tree has one node for the whole note', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_note(onTap: () {}));

    final node = tester.getSemantics(find.bySemanticsLabel('Fez café sem eu pedir, Fez algo, Seg'));
    final children = <SemanticsNode>[];
    node.visitChildren((child) {
      children.add(child);
      return true;
    });
    expect(children, isEmpty);
    handle.dispose();
  });
}
