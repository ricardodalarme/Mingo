import 'dart:math' as math;

import 'package:design_system/design_system.dart';

const double _itemHeight = 46;
const double _primaryActionSide = 46;
const double _labelGap = 3;
const double _sidePadding = 8;

/// Turns that rotate the plus by 45° into a cross.
const double _closeTurns = .125;

/// One item in a [BaseTabBar].
///
/// [isPrimaryAction] renders the centre plus circle instead of an icon and label.
class const BaseTabBarItem({
  required final String label,
  required final IconData icon,
  final IconData? selectedIcon,
  final bool isPrimaryAction = false,
  final String? semanticLabel,
});

/// The five-column tab bar fixed to the bottom of a tab screen.
///
/// Above 200% text scale labels drop and icons carry the meaning.
///
/// With two or more [menuItems] the primary action opens a [BaseMenu] above itself and reports the
/// chosen row to [onMenuSelected], after the menu has closed. With fewer, or while the keyboard is
/// up, it calls [onSelected] with its own index instead.
class const BaseTabBar({
  required final List<BaseTabBarItem> items,
  required final int currentIndex,
  required final ValueChanged<int> onSelected,
  final List<BaseMenuItem>? menuItems,
  final ValueChanged<BaseMenuItem>? onMenuSelected,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseTabBar> createState() => _BaseTabBarState();
}

class _BaseTabBarState() extends State<BaseTabBar> {
  final GlobalKey _primaryKey = GlobalKey();
  bool _isMenuOpen = false;

  Future<void> _onTap(int index) async {
    if (!widget.items[index].isPrimaryAction) return widget.onSelected(index);

    final menuItems = widget.menuItems;
    final box = _primaryKey.currentContext?.findRenderObject();
    final hasKeyboard = MediaQuery.viewInsetsOf(context).bottom > 0;
    if (_isMenuOpen ||
        menuItems == null ||
        menuItems.length < 2 ||
        hasKeyboard ||
        box is! RenderBox) {
      if (!_isMenuOpen) widget.onSelected(index);
      return;
    }

    _isMenuOpen = true;
    final item = await showBaseMenu(
      context,
      // The centre is stable while the button is still easing back from its press scale.
      anchor: Rect.fromCenter(
        center: box.localToGlobal(box.size.center(Offset.zero)),
        width: box.size.width,
        height: box.size.height,
      ),
      items: menuItems,
      anchorBuilder: (context, animation) => _PrimaryAction(rotation: animation),
    );
    _isMenuOpen = false;
    if (item != null && mounted) widget.onMenuSelected?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final items = widget.items;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final barHeight = math.max(AppSpace.tabBarHeight, _itemHeight + _sidePadding + bottomInset);

    return SizedBox(
      height: barHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.bgTabBar,
          border: Border(top: BorderSide(color: colors.borderDefault)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(_sidePadding, _sidePadding, _sidePadding, bottomInset),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < items.length; index++)
                Expanded(
                  child: _TabBarSlot(
                    item: items[index],
                    isSelected: index == widget.currentIndex,
                    onTap: () => _onTap(index),
                    primaryKey: _primaryKey,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _TabBarSlot({
  required final BaseTabBarItem item,
  required final bool isSelected,
  required final VoidCallback onTap,
  required final GlobalKey primaryKey,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppPressable(
      onTap: onTap,
      isSelected: isSelected,
      semanticLabel: item.semanticLabel ?? item.label,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      pressedScale: item.isPrimaryAction ? AppMotion.pressedActionScale : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _itemHeight),
        child: Center(
          child: item.isPrimaryAction
              ? _PrimaryAction(key: primaryKey)
              : _TabLabel(
                  item: item,
                  isSelected: isSelected,
                  tabFontSize: context.text.tab.fontSize,
                ),
        ),
      ),
    );
  }
}

class const _PrimaryAction({final Animation<double>? rotation, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final glyph = AppIcon(icon: AppIcons.plus, size: AppIconSize.lg, color: colors.textOnAction);
    final turns = rotation;

    return SizedBox(
      width: _primaryActionSide,
      height: _primaryActionSide,
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.actionPrimary, shape: BoxShape.circle),
        child: Center(
          child: turns == null
              ? glyph
              : RotationTransition(
                  key: const ValueKey('tabBarPlusRotation'),
                  turns: Tween<double>(
                    begin: 0,
                    end: _closeTurns,
                  ).animate(CurvedAnimation(parent: turns, curve: Curves.easeOut)),
                  child: glyph,
                ),
        ),
      ),
    );
  }
}

class const _TabLabel({
  required final BaseTabBarItem item,
  required final bool isSelected,
  required final double? tabFontSize,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Labels would clip above 200% text scale; the icon carries the meaning.
    final showsLabel = MediaQuery.textScalerOf(context).scale(tabFontSize ?? 10.5) <= 16;
    final ink = isSelected ? colors.accentLabel : colors.textSecondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(
          icon: isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
          size: AppIconSize.lg,
          color: isSelected ? colors.accentLabel : colors.iconMuted,
        ),
        if (showsLabel) ...[
          const SizedBox(height: _labelGap),
          Text(
            item.label,
            style: context.text.tab.copyWith(color: ink),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
