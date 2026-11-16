import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('primary round button is a dark 50pt circle for ${variant.name}', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        galleryHost(
          BaseRoundButton.primary(
            icon: AppIcons.send,
            semanticLabel: 'Send',
            onPressed: () => taps++,
          ),
          variant: variant,
        ),
      );

      final box = tester.getSize(
        find
            .descendant(of: find.byType(BaseRoundButton), matching: find.byType(DecoratedBox))
            .first,
      );
      expect(box, const Size(50, 50));
      expect(tester.widget<AppIcon>(find.byType(AppIcon)).size, AppIconSize.lg);
      final decoration =
          tester
                  .widget<DecoratedBox>(
                    find
                        .descendant(
                          of: find.byType(BaseRoundButton),
                          matching: find.byType(DecoratedBox),
                        )
                        .first,
                  )
                  .decoration
              as BoxDecoration;
      expect(decoration.color, colorsOf(variant).actionPrimary);

      await tester.tap(find.byType(BaseRoundButton));
      expect(taps, 1);
    });
  }

  testWidgets('loading replaces the icon with dots and ignores taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseRoundButton.primary(icon: AppIcons.send, isLoading: true, onPressed: () => taps++),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.byType(BaseLoadingDots), findsOneWidget);
    expect(find.byType(AppIcon), findsNothing);
    await tester.tap(find.byType(BaseRoundButton), warnIfMissed: false);
    expect(taps, 0);
  });

  testWidgets('disabled round button is dimmed and does not fire', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        const BaseRoundButton.primary(icon: AppIcons.send, onPressed: null),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity).first).opacity, .4);
  });
}
