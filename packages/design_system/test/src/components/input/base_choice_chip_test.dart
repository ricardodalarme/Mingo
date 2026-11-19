import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('choice chips render in ${variant.name}', (tester) async {
      await tester.pumpWidget(
        inputHost(
          Wrap(
            spacing: AppSpace.s8,
            runSpacing: AppSpace.s8,
            children: [
              const BaseChoiceChip(label: 'Said something'),
              BaseChoiceChip(label: 'Did something', isSelected: true, onTap: () {}),
              const BaseChoiceChip(label: 'Noticed me', icon: AppIcons.heart_filled),
            ],
          ),
          variant: variant,
        ),
      );
      await tester.pump();

      expect(find.byType(BaseChoiceChip), findsNWidgets(3));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a long label ellipsizes instead of overflowing', (tester) async {
    await tester.pumpWidget(
      inputHost(
        const SizedBox(
          width: 120,
          child: BaseChoiceChip(label: 'A very long choice label that cannot fit'),
        ),
        variant: AppThemeVariant.rose,
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('A very long choice label that cannot fit'), findsOneWidget);
  });

  testWidgets('a selected chip takes the paper and ink of its slip note type', (tester) async {
    await tester.pumpWidget(
      inputHost(
        const BaseChoiceChip(label: 'Me ajudou', isSelected: true, slipNoteType: SlipNoteType.help),
        variant: AppThemeVariant.rose,
      ),
    );

    final tone = AppSlipNoteColors.standard.help;
    final box = tester.widget<Container>(find.byType(Container).first);
    expect((box.decoration! as BoxDecoration).color, tone.background);
    expect(tester.widget<Text>(find.text('Me ajudou')).style?.color, tone.ink);
  });
}
