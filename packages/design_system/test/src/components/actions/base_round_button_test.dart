import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('round button keeps the 40pt visual and 44pt target for ${variant.name}', (
      tester,
    ) async {
      setSurface(tester);
      var taps = 0;

      await tester.pumpWidget(
        appFor(
          variant: variant,
          home: Scaffold(
            body: Center(
              child: BaseRoundButton(
                icon: AppIcons.chevron_left,
                onPressed: () => taps++,
                semanticLabel: 'Back',
              ),
            ),
          ),
        ),
      );

      final box = tester.getSize(
        find.descendant(of: find.byType(BaseRoundButton), matching: find.byType(DecoratedBox)),
      );
      expect(box.width, 40);
      expect(box.height, 40);
      expect(tester.getSize(find.byType(BaseRoundButton)).width, AppIconSize.touch);
      expect(tester.widget<AppIcon>(find.byType(AppIcon)).size, 20);
      expect(tester.widget<AppPressable>(find.byType(AppPressable)).enforceMinTapTarget, isTrue);

      await tester.tap(find.byType(BaseRoundButton));
      expect(taps, 1);
    });
  }

  testWidgets('the badge dot shows only when asked and stays out of the semantics', (tester) async {
    setSurface(tester);

    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: Scaffold(
          body: Center(
            child: Column(
              children: [
                BaseRoundButton(icon: AppIcons.bell, onPressed: () {}, semanticLabel: 'Plain'),
                BaseRoundButton(
                  icon: AppIcons.bell,
                  onPressed: () {},
                  semanticLabel: 'Unread',
                  hasBadge: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final plain = find.ancestor(
      of: find.bySemanticsLabel('Plain'),
      matching: find.byType(BaseRoundButton),
    );
    final unread = find.ancestor(
      of: find.bySemanticsLabel('Unread'),
      matching: find.byType(BaseRoundButton),
    );

    Finder dot(Finder button) => find.descendant(
      of: button,
      matching: find.byWidgetPredicate(
        (widget) => widget is Container && widget.constraints?.maxWidth == 10,
      ),
    );

    expect(dot(plain), findsNothing);
    expect(dot(unread), findsOneWidget);
  });
}
