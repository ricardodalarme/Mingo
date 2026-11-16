import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart' show Scaffold;

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('empty state renders both actions at 200% text for ${variant.name}', (
      tester,
    ) async {
      await tester.pumpWidget(
        scaffoldHost(
          const SingleChildScrollView(
            padding: EdgeInsets.all(AppSpace.s20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseEmptyState(
                  title: 'No slips yet',
                  text: 'A slip is one good thing, in one line.',
                  actionText: 'Write a slip',
                  faceLabel: 'A smiling face',
                ),
                BaseEmptyState(
                  title: 'Nothing here',
                  text: 'When it happens it will show up here.',
                  actionText: 'Go back',
                  isSecondaryAction: true,
                ),
              ],
            ),
          ),
          variant: variant,
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('No slips yet'), findsOneWidget);
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Write a slip'), findsOneWidget);
      expect(find.text('Go back'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets('empty state can show the full supporting copy', (tester) async {
    const text =
        'This is a longer consent explanation that must not be cut off before the person can read it.';

    setSurface(tester, height: 1600);
    await tester.pumpWidget(
      scaffoldHost(
        const BaseEmptyState(title: 'A private trail', text: text, textMaxLines: null),
        variant: AppThemeVariant.rose,
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));

    final rendered = tester.widget<Text>(find.text(text));
    expect(rendered.maxLines, isNull);
    expect(rendered.overflow, TextOverflow.visible);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('empty state has no container and starts 80 from the top', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: const Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: BaseEmptyState(
              title: 'No slips yet',
              text: 'One good thing.',
              actionText: 'Write',
            ),
          ),
        ),
      ),
    );

    expect(tester.getTopLeft(find.byType(BaseFace)).dy, 80);
    expect(tester.getSize(find.byType(BaseFace)).width, 64);
  });
}
