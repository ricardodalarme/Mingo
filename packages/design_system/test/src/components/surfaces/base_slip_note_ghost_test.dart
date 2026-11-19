import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  testWidgets('draws three overlapping outlines and hides from semantics', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      materialAppFor(const BaseSlipNoteGhost(), variant: AppThemeVariant.rose),
    );

    final outlines = find.descendant(
      of: find.byType(BaseSlipNoteGhost),
      matching: find.byWidgetPredicate(
        (widget) => widget is CustomPaint && widget.painter is DashedRoundedPainter,
      ),
    );
    expect(outlines, findsNWidgets(3));
    expect(tester.getSize(outlines.first), const Size(64, 76));
    expect(tester.getTopLeft(outlines.at(1)).dx - tester.getTopLeft(outlines.first).dx, 50);
    expect(tester.getTopLeft(outlines.at(1)).dy - tester.getTopLeft(outlines.first).dy, 8);
    expect(
      find.descendant(of: find.byType(BaseSlipNoteGhost), matching: find.byType(ExcludeSemantics)),
      findsWidgets,
    );
    handle.dispose();
  });
}
