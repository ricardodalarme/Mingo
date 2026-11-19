import 'package:design_system/design_system.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Space between the two columns and between notes in a column.
const double wallGap = AppSpace.s14;

/// How far the second column starts below the first.
const double wallColumnOffset = AppSpace.s18;

/// A lazy two-column wall: each item goes to the shorter column and the second column starts lower.
///
/// Items are built only when they scroll near the viewport.
class const SliverWall({
  required final int itemCount,
  required final IndexedWidgetBuilder itemBuilder,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: wallGap,
      crossAxisSpacing: wallGap,
      childCount: itemCount,
      itemBuilder: (context, index) {
        final child = itemBuilder(context, index);

        return index == 1
            ? Padding(
                padding: const EdgeInsets.only(top: wallColumnOffset),
                child: child,
              )
            : child;
      },
    );
  }
}
