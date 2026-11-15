import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/widget_host.dart';

void _ignore(int index) {}

double _captureScale(WidgetTester tester, Finder slot) {
  return tester
      .widget<ScaleTransition>(find.descendant(of: slot, matching: find.byType(ScaleTransition)))
      .scale
      .value;
}

class const _TabGallery({final ValueChanged<int>? onSelected}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox.shrink(),
      bottomNavigationBar: BaseTabBar(
        items: const [
          BaseTabBarItem(
            label: 'Today',
            icon: AppIcons.home,
            selectedIcon: AppIcons.home,
            semanticLabel: 'Today tab',
          ),
          BaseTabBarItem(label: 'Slips', icon: AppIcons.note),
          BaseTabBarItem(label: 'Write', icon: AppIcons.plus, isPrimaryAction: true),
          BaseTabBarItem(label: 'Together', icon: AppIcons.rings),
          BaseTabBarItem(label: 'Memories', icon: AppIcons.bookmark),
        ],
        currentIndex: 0,
        onSelected: onSelected ?? _ignore,
      ),
    );
  }
}

void main() {
  testWidgets('the capture button compresses under the finger', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(appFor(variant: AppThemeVariant.rose, home: const _TabGallery()));

    final capture = find.byType(AppPressable).at(2);

    expect(_captureScale(tester, capture), 1);

    final gesture = await tester.startGesture(tester.getCenter(find.byIcon(AppIcons.plus)));
    await tester.pump();
    await tester.pump(AppMotion.fast);

    expect(_captureScale(tester, capture), closeTo(AppMotion.pressedActionScale, .001));

    await gesture.up();
    await tester.pump();
    await tester.pump(AppMotion.fast);

    expect(_captureScale(tester, capture), 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion leaves the capture button still', (tester) async {
    setSurface(tester);
    await tester.pumpWidget(
      appFor(variant: AppThemeVariant.rose, home: const _TabGallery(), disableAnimations: true),
    );

    final capture = find.byType(AppPressable).at(2);
    final gesture = await tester.startGesture(tester.getCenter(find.byIcon(AppIcons.plus)));
    await tester.pump();
    await tester.pump(AppMotion.fast);

    expect(_captureScale(tester, capture), 1);

    await gesture.up();
    expect(tester.takeException(), isNull);
  });

  for (final variant in AppThemeVariant.values) {
    final colors = colorsOf(variant);

    testWidgets('tab bar carries the plus and the active item for ${variant.name}', (tester) async {
      setSurface(tester);
      var selected = 0;

      await tester.pumpWidget(
        appFor(
          variant: variant,
          home: _TabGallery(onSelected: (index) => selected = index),
        ),
      );

      expect(tester.getSize(find.byType(BaseTabBar)).height, AppSpace.tabBarHeight);
      expect(find.byType(AppPressable), findsNWidgets(5));
      expect(find.byIcon(AppIcons.plus), findsOneWidget);
      expect(find.byIcon(AppIcons.home), findsOneWidget);
      expect(tester.widget<Text>(find.text('Today')).style?.color, colors.accentLabel);
      expect(tester.widget<Text>(find.text('Slips')).style?.color, colors.textSecondary);

      await tester.tap(find.text('Slips'));
      expect(selected, 1);
      expect(tester.takeException(), isNull);
    });

    testWidgets('tab bar drops labels at 200% text for ${variant.name}', (tester) async {
      setSurface(tester);
      await tester.pumpWidget(appFor(variant: variant, home: atTextScale(2, const _TabGallery())));

      expect(find.text('Today'), findsNothing);
      expect(find.byIcon(AppIcons.home), findsOneWidget);
      expect(find.byIcon(AppIcons.plus), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
