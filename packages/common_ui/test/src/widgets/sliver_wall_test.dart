import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host({required int count, required List<double> heights, ScrollController? controller}) {
  return BaseApp(
    theme: AppTheme.light(AppThemeVariant.rose),
    home: SizedBox(
      width: 390,
      height: 600,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverWall(
            itemCount: count,
            itemBuilder: (context, index) => SizedBox(
              key: ValueKey('item-$index'),
              height: heights[index % heights.length],
              child: Text('Item $index'),
            ),
          ),
        ],
      ),
    ),
  );
}

void main() {
  testWidgets('puts the first two items side by side with the second one lower', (tester) async {
    await tester.pumpWidget(_host(count: 2, heights: [100]));

    final first = tester.getTopLeft(find.byKey(const ValueKey('item-0')));
    final second = tester.getTopLeft(find.byKey(const ValueKey('item-1')));
    expect(second.dx, greaterThan(first.dx));
    expect(second.dy - first.dy, wallColumnOffset);
  });

  testWidgets('places each new item in the shorter column', (tester) async {
    await tester.pumpWidget(_host(count: 4, heights: [200, 60, 60, 60]));

    final left = tester.getTopLeft(find.byKey(const ValueKey('item-0'))).dx;
    final right = tester.getTopLeft(find.byKey(const ValueKey('item-1'))).dx;
    expect(tester.getTopLeft(find.byKey(const ValueKey('item-2'))).dx, right);
    expect(tester.getTopLeft(find.byKey(const ValueKey('item-3'))).dx, right);
    expect(left, lessThan(right));
  });

  testWidgets('builds only the items near the viewport', (tester) async {
    await tester.pumpWidget(_host(count: 200, heights: [150]));

    expect(find.byKey(const ValueKey('item-0')), findsOneWidget);
    expect(find.byKey(const ValueKey('item-199')), findsNothing);
    expect(find.byType(SizedBox).evaluate().length, lessThan(60));
  });

  testWidgets('scrolls to the last item', (tester) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(_host(count: 30, heights: [150], controller: controller));

    controller.jumpTo(controller.position.maxScrollExtent);
    await tester.pump();

    expect(find.byKey(const ValueKey('item-29')), findsOneWidget);
  });
}
