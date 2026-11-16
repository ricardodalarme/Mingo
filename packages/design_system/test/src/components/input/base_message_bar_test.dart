import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show TextField;

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('send is disabled while empty and sends trimmed text for ${variant.name}', (
      tester,
    ) async {
      final sent = <String>[];
      await tester.pumpWidget(
        inputHost(
          BaseMessageBar(hint: 'Write a message', onSend: sent.add),
          variant: variant,
        ),
      );

      expect(find.text('Write a message'), findsOneWidget);
      await tester.tap(find.byType(BaseRoundButton), warnIfMissed: false);
      expect(sent, isEmpty);

      await tester.enterText(find.byType(TextField), '  Can we talk tonight?  ');
      await tester.pump();
      await tester.tap(find.byType(BaseRoundButton));
      expect(sent, ['Can we talk tonight?']);
    });
  }

  testWidgets('the primary send button is 50 and labeled Send', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      inputHost(BaseMessageBar(onSend: (_) {}), variant: AppThemeVariant.rose),
    );

    expect(find.bySemanticsLabel('Send'), findsOneWidget);
    expect(
      tester.getSize(
        find.descendant(of: find.byType(BaseRoundButton), matching: find.byType(SizedBox)).first,
      ),
      const Size(50, 50),
    );
    semantics.dispose();
  });

  testWidgets('sending shows dots on the button and keeps the field editable', (tester) async {
    await tester.pumpWidget(
      inputHost(BaseMessageBar(isSending: true, onSend: (_) {}), variant: AppThemeVariant.rose),
    );

    expect(find.byType(BaseLoadingDots), findsOneWidget);
    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isTrue);
  });

  testWidgets('blocked fades the bar and disables the field', (tester) async {
    await tester.pumpWidget(
      inputHost(
        BaseMessageBar(isEnabled: false, hint: "Today's limit reached", onSend: (_) {}),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(tester.widget<TextField>(find.byType(TextField)).enabled, isFalse);
    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, .5);
  });

  testWidgets('a supplied controller keeps the draft and a leading slot shows', (tester) async {
    final controller = TextEditingController(text: 'draft');
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      inputHost(
        BaseMessageBar(controller: controller, leading: const Text('+'), onSend: (_) {}),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.text('draft'), findsOneWidget);
    expect(find.text('+'), findsOneWidget);
  });
}
