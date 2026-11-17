import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('error state shows a sad face and its retry at 200% text for ${variant.name}', (
      tester,
    ) async {
      await tester.pumpWidget(
        scaffoldHost(
          const SingleChildScrollView(
            padding: EdgeInsets.all(AppSpace.s20),
            child: BaseErrorState(
              title: 'That did not load',
              text: 'Check your connection and try again.',
              actionText: 'Try again',
            ),
          ),
          variant: variant,
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('That did not load'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
      expect(tester.widget<BaseFace>(find.byType(BaseFace)).kind, FaceKind.sad);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets('error state calls the retry', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      scaffoldHost(
        BaseErrorState(
          title: 'That did not load',
          text: 'Try again.',
          actionText: 'Retry',
          onAction: () => retried = true,
        ),
        variant: AppThemeVariant.rose,
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.text('Retry'));

    expect(retried, isTrue);
    await tester.pumpWidget(const SizedBox());
  });
}
