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

const _slip = BaseMenuItem(id: 'slip', icon: AppIcons.note, label: 'Write a slip', isPrimary: true);
const _need = BaseMenuItem(id: 'need', icon: AppIcons.heart, label: 'I need…');

class const _TabGallery({
  final ValueChanged<int>? onSelected,
  final List<BaseMenuItem>? menuItems,
  final ValueChanged<BaseMenuItem>? onMenuSelected,
}) extends StatelessWidget {
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
        menuItems: menuItems,
        onMenuSelected: onMenuSelected,
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

  group('plus menu', () {
    Future<void> pump(
      WidgetTester tester, {
      List<BaseMenuItem>? menuItems,
      ValueChanged<int>? onSelected,
      ValueChanged<BaseMenuItem>? onMenuSelected,
    }) async {
      setSurface(tester);
      await tester.pumpWidget(
        appFor(
          variant: AppThemeVariant.rose,
          home: _TabGallery(
            menuItems: menuItems,
            onSelected: onSelected,
            onMenuSelected: onMenuSelected,
          ),
        ),
      );
    }

    testWidgets('a single item runs the action directly', (tester) async {
      final selected = <int>[];
      await pump(tester, menuItems: const [_slip], onSelected: selected.add);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();

      expect(selected, [2]);
      expect(find.byType(BaseMenu), findsNothing);
    });

    testWidgets('no items runs the action directly', (tester) async {
      final selected = <int>[];
      await pump(tester, onSelected: selected.add);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();

      expect(selected, [2]);
      expect(find.byType(BaseMenu), findsNothing);
    });

    testWidgets('two items open the menu and the plus turns into a cross', (tester) async {
      final selected = <int>[];
      await pump(tester, menuItems: const [_slip, _need], onSelected: selected.add);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();

      expect(find.byType(BaseMenu), findsOneWidget);
      expect(selected, isEmpty);
      final rotation = tester.widget<RotationTransition>(
        find.byKey(const ValueKey('tabBarPlusRotation')),
      );
      expect(rotation.turns.value, closeTo(.125, .001));
    });

    testWidgets('the plus stays above the scrim and closes the menu', (tester) async {
      final chosen = <BaseMenuItem>[];
      await pump(tester, menuItems: const [_slip, _need], onMenuSelected: chosen.add);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('tabBarPlusRotation')));
      await tester.pumpAndSettle();

      expect(find.byType(BaseMenu), findsNothing);
      expect(chosen, isEmpty);
    });

    testWidgets('a row closes the menu, then reports the item', (tester) async {
      final chosen = <BaseMenuItem>[];
      await pump(tester, menuItems: const [_slip, _need], onMenuSelected: chosen.add);

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('baseMenuItem-need')));
      await tester.pumpAndSettle();

      expect(find.byType(BaseMenu), findsNothing);
      expect(chosen, [_need]);
    });

    testWidgets('the menu points at the plus', (tester) async {
      await pump(tester, menuItems: const [_slip, _need]);
      final plus = tester.getCenter(find.byIcon(AppIcons.plus));

      await tester.tap(find.byIcon(AppIcons.plus));
      await tester.pumpAndSettle();

      expect(tester.getCenter(find.byKey(const ValueKey('baseMenuTail'))).dx, closeTo(plus.dx, .5));
    });

    testWidgets('the keyboard keeps the menu closed', (tester) async {
      final selected = <int>[];
      setSurface(tester);
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      addTearDown(tester.view.resetViewInsets);
      await tester.pumpWidget(
        appFor(
          variant: AppThemeVariant.rose,
          home: _TabGallery(menuItems: const [_slip, _need], onSelected: selected.add),
        ),
      );

      await tester.tap(find.byIcon(AppIcons.plus), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(selected, [2]);
      expect(find.byType(BaseMenu), findsNothing);
    });
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
