import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('chip is 40 high with a 30 circle for ${variant.name}', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        galleryHost(
          Column(
            children: [
              BaseChip.icon(
                label: '2 years and 7 months',
                icon: AppIcons.heart,
                onTap: () => taps++,
              ),
              BaseChip.avatar(label: 'Invite someone', initials: 'M', onTap: () => taps++),
            ],
          ),
          variant: variant,
        ),
      );

      final chip = find
          .ancestor(of: find.text('2 years and 7 months'), matching: find.byType(Container))
          .first;
      expect(tester.getSize(chip).height, 40);

      await tester.tap(find.text('2 years and 7 months'));
      await tester.tap(find.text('Invite someone'));
      expect(taps, 2);
    });
  }

  testWidgets('a long label stays on one line', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        BaseChip.icon(
          label: 'A very long label that would otherwise wrap onto a second line',
          icon: AppIcons.heart,
        ),
        variant: AppThemeVariant.rose,
        width: 200,
      ),
    );

    expect(tester.widget<Text>(find.byType(Text)).maxLines, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disabled chip ignores taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseChip.icon(label: 'Off', icon: AppIcons.heart, isEnabled: false, onTap: () => taps++),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.tap(find.text('Off'));
    expect(taps, 0);
  });
}
