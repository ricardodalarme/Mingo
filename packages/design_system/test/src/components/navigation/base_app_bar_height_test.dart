import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('a single-line bar is 40 high for ${variant.name}', (tester) async {
      setSurface(tester);
      await tester.pumpWidget(
        appFor(
          variant: variant,
          home: const Scaffold(
            body: Column(
              children: [BaseAppBar(title: 'Our story', onClose: _noop)],
            ),
          ),
        ),
      );

      expect(
        tester
            .getSize(
              find
                  .descendant(of: find.byType(BaseAppBar), matching: find.byType(AnimatedContainer))
                  .first,
            )
            .height,
        40,
      );
    });
  }

  testWidgets('the round button keeps a 44 point touch target inside the 40 point bar', (
    tester,
  ) async {
    setSurface(tester);
    var closes = 0;
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 14),
              BaseAppBar(title: 'Our story', onClose: () => closes++),
            ],
          ),
        ),
      ),
    );

    final button = tester.getRect(find.byType(BaseRoundButton));
    expect(button.height, 44);
    await tester.tapAt(Offset(button.center.dx, button.top + 1));
    await tester.tapAt(Offset(button.center.dx, button.bottom - 1));
    expect(closes, 2);
  });
}

void _noop() {}
