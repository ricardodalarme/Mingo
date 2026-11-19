import 'package:design_system/design_system.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show TextField;

import '../../../helpers/widget_host.dart';

Widget _field({String? text, ValueChanged<String>? onChanged, double textScale = 1}) =>
    materialAppFor(
      Padding(
        padding: const EdgeInsets.all(20),
        child: BaseSlipNoteField(
          type: SlipNoteType.help,
          typeLabel: 'Me ajudou',
          text: text,
          hint: 'O que foi?',
          onChanged: onChanged,
        ),
      ),
      variant: AppThemeVariant.rose,
      textScale: textScale,
    );

void main() {
  testWidgets('limits the text to 140 characters and counts them', (tester) async {
    String? last;
    await tester.pumpWidget(_field(onChanged: (value) => last = value));

    await tester.enterText(find.byType(TextField), 'a' * 200);
    await tester.pump();

    expect(last!.length, 140);
    expect(find.text('140/140'), findsOneWidget);
  });

  testWidgets('the counter starts at zero', (tester) async {
    await tester.pumpWidget(_field());

    expect(find.text('0/140'), findsOneWidget);
  });

  testWidgets('the caret uses the accent colour', (tester) async {
    await tester.pumpWidget(_field());

    final field = tester.widget<TextField>(find.byType(TextField));
    final colors = AppColors.forVariant(AppThemeVariant.rose);
    expect(field.cursorColor, colors.accentHighlight);
  });

  testWidgets('follows a text the parent changes', (tester) async {
    await tester.pumpWidget(_field(text: 'um'));
    expect(find.text('um'), findsOneWidget);

    await tester.pumpWidget(_field(text: 'dois'));
    await tester.pump();
    expect(find.text('dois'), findsOneWidget);
    expect(find.text('4/140'), findsOneWidget);
  });

  testWidgets('long text at a large text scale does not overflow', (tester) async {
    await tester.pumpWidget(_field(text: 'palavra ' * 17, textScale: 3));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('shows an error under the note', (tester) async {
    await tester.pumpWidget(
      materialAppFor(
        const BaseSlipNoteField(
          type: SlipNoteType.good,
          typeLabel: 'Fez algo',
          errorText: 'Escreva algo',
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.text('Escreva algo'), findsOneWidget);
  });

  testWidgets('type shows in the footer', (tester) async {
    await tester.pumpWidget(_field());

    expect(find.text('ME AJUDOU'), findsOneWidget);
    expect(find.text('Seg'), findsNothing);
    expect(SystemChannels.textInput, isNotNull);
  });
}
