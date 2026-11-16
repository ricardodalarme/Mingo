import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('a root section bar shows a left aligned large title for ${variant.name}', (
      tester,
    ) async {
      setSurface(tester);
      await tester.pumpWidget(
        appFor(
          variant: variant,
          home: Scaffold(
            body: Column(
              children: [
                BaseAppBar(
                  isRoot: true,
                  title: 'Slips',
                  trailing: BaseRoundButton(icon: AppIcons.plus, onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      );

      final title = tester.widget<Text>(find.text('Slips'));
      expect(title.style!.fontSize, 30);
      expect(tester.getTopLeft(find.text('Slips')).dx, lessThan(40));
      expect(find.byType(BaseRoundButton), findsOneWidget);
      expect(
        tester
            .getSize(
              find
                  .descendant(of: find.byType(BaseAppBar), matching: find.byType(AnimatedContainer))
                  .first,
            )
            .height,
        greaterThanOrEqualTo(40),
      );
    });
  }

  testWidgets('home passes free slots on both sides and shows no back button', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: const Scaffold(
          body: Column(
            children: [
              BaseAppBar(
                isRoot: true,
                leading: BaseAvatarPair(selfInitials: 'M', partnerInitials: 'R'),
                trailing: Text('chip'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(BaseAvatarPair), findsOneWidget);
    expect(find.text('chip'), findsOneWidget);
    expect(find.byIcon(AppIcons.chevron_left), findsNothing);
  });

  testWidgets('a custom leading replaces the back button', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      appFor(
        variant: AppThemeVariant.rose,
        home: const Scaffold(
          body: Column(
            children: [BaseAppBar(title: 'Chat', leading: Text('lead'))],
          ),
        ),
      ),
    );

    expect(find.text('lead'), findsOneWidget);
    expect(find.byType(BaseRoundButton), findsNothing);
  });
}
