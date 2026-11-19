import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  Widget host(VoidCallback onTap) => materialAppFor(
    Padding(
      padding: const EdgeInsets.all(20),
      child: BaseSlipNoteAdd(label: 'Anotar mais um', onTap: onTap),
    ),
    variant: AppThemeVariant.rose,
  );

  testWidgets('tap fires', (tester) async {
    var taps = 0;
    await tester.pumpWidget(host(() => taps++));

    await tester.tap(find.byType(BaseSlipNoteAdd));
    expect(taps, 1);
  });

  testWidgets('reads as one button with the label', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(host(() {}));

    expect(find.bySemanticsLabel('Anotar mais um'), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Anotar mais um')),
      matchesSemantics(
        label: 'Anotar mais um',
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

  testWidgets('is at least 96 px tall and shows the plus icon', (tester) async {
    await tester.pumpWidget(host(() {}));

    expect(tester.getSize(find.byType(CustomPaint).last).height, greaterThanOrEqualTo(96));
    expect(tester.widget<Icon>(find.byType(Icon)).icon, AppIcons.plus);
  });
}
