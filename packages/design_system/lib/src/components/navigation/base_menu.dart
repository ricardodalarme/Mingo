import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show SemanticsRole;

import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';
import 'package:flutter/services.dart';

const double _cardWidth = 250;
const double _screenMargin = 16;
const double _anchorGap = 32;
const double _rowMinHeight = 54;
const double _rowPadding = 18;
const double _iconGap = 12;
const double _tailSide = 16;
const double _tailRadius = 4;
const double _openScale = .92;
const Duration _openDuration = Duration(milliseconds: 160);
const Duration _closeDuration = Duration(milliseconds: 120);
const Duration _reducedDuration = Duration(milliseconds: 100);
const int _minItems = 2;
const int _maxItems = 4;

/// Builds the widget drawn over the scrim at the anchor rect; [animation] runs 0 to 1 while the
/// menu opens.
typedef BaseMenuAnchorBuilder = Widget Function(BuildContext context, Animation<double> animation);

/// One row of a [BaseMenu].
///
/// [id] is stable and identifies the row in tests and analytics; [isPrimary] sets the label weight
/// to 600.
class const BaseMenuItem({
  required final String id,
  required final IconData icon,
  required final String label,
  final bool isPrimary = false,
});

/// A short card anchored above the control that opened it, with a tail pointing at the control.
///
/// It is laid out over the whole screen: [anchor] is the global rect of that control. It takes two
/// to four [items]; with fewer, the caller should run the action directly.
class const BaseMenu({
  required final List<BaseMenuItem> items,
  required final Rect anchor,
  required final ValueChanged<BaseMenuItem> onSelect,
  required final VoidCallback onDismiss,
  final Animation<double> animation = kAlwaysCompleteAnimation,
  final BaseMenuAnchorBuilder? anchorBuilder,
  super.key,
}) extends StatefulWidget {
  this
    : assert(
        items.length >= _minItems && items.length <= _maxItems,
        'BaseMenu takes $_minItems to $_maxItems items',
      );

  @override
  State<BaseMenu> createState() => _BaseMenuState();
}

class _BaseMenuState() extends State<BaseMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).nextFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final anchor = widget.anchor;
    final items = widget.items;
    final textScaler = MediaQuery.textScalerOf(context);

    return CallbackShortcuts(
      bindings: {const SingleActivator(LogicalKeyboardKey.escape): widget.onDismiss},
      child: FocusTraversalGroup(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.biggest;
            final maxWidth = math.max(_cardWidth, size.width - _screenMargin * 2);
            final cardWidth = math.min(
              maxWidth,
              math.max(
                _cardWidth,
                items.map((item) => _rowWidth(context, item, textScaler)).reduce(math.max),
              ),
            );
            final left = math.max(
              _screenMargin,
              math.min(anchor.center.dx - cardWidth / 2, size.width - _screenMargin - cardWidth),
            );
            const tailInset = AppRadius.menu + _tailSide;
            final tailX = math.max(
              tailInset,
              math.min(anchor.center.dx - left, cardWidth - tailInset),
            );
            final bottom = size.height - (anchor.top - _anchorGap);
            final anchorBuilder = widget.anchorBuilder;
            final reduceMotion = context.reduceMotion;
            final scale = Tween<double>(
              begin: _openScale,
              end: 1,
            ).animate(CurvedAnimation(parent: widget.animation, curve: Curves.easeOut));

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Semantics(
                    label: context.designSystemL10nOrBase.navigation.closeMenu,
                    button: true,
                    onTap: widget.onDismiss,
                    excludeSemantics: true,
                    child: GestureDetector(
                      key: const ValueKey('baseMenuScrim'),
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onDismiss,
                      child: FadeTransition(
                        opacity: widget.animation,
                        child: const ColoredBox(color: AppPalette.menuScrim),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: left,
                  bottom: bottom,
                  width: cardWidth,
                  child: FadeTransition(
                    opacity: widget.animation,
                    child: reduceMotion
                        ? _card(colors, tailX)
                        : ScaleTransition(
                            key: const ValueKey('baseMenuScale'),
                            scale: scale,
                            alignment: FractionalOffset(tailX / cardWidth, 1),
                            child: _card(colors, tailX),
                          ),
                  ),
                ),
                if (anchorBuilder != null)
                  Positioned.fromRect(
                    rect: anchor,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onDismiss,
                      child: anchorBuilder(context, widget.animation),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _rowWidth(BuildContext context, BaseMenuItem item, TextScaler textScaler) {
    final painter = TextPainter(
      text: TextSpan(text: item.label, style: _labelStyle(context, item)),
      textDirection: TextDirection.ltr,
      textScaler: textScaler,
    )..layout();
    final width = painter.width;
    painter.dispose();

    return _rowPadding * 2 + AppIconSize.md + _iconGap + width.ceilToDouble();
  }

  Widget _card(AppColors colors, double tailX) {
    final items = widget.items;

    return Semantics(
      role: SemanticsRole.menu,
      container: true,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.bgSurface,
              borderRadius: BorderRadius.circular(AppRadius.menu),
              boxShadow: AppShadows.menu,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.menu),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int index = 0; index < items.length; index++) ...[
                    if (index > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: _rowPadding),
                        child: SizedBox(
                          key: const ValueKey('baseMenuDivider'),
                          height: AppBorder.hair,
                          child: ColoredBox(color: colors.borderDefault),
                        ),
                      ),
                    _MenuRow(
                      item: items[index],
                      style: _labelStyle(context, items[index]),
                      onTap: () => widget.onSelect(items[index]),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            left: tailX - _tailSide / 2,
            bottom: -_tailSide / 2,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: SizedBox(
                key: const ValueKey('baseMenuTail'),
                width: _tailSide,
                height: _tailSide,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.bgSurface,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(_tailRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle(BuildContext context, BaseMenuItem item) {
    return context.text.body.copyWith(
      color: context.colors.textPrimary,
      fontWeight: item.isPrimary ? FontWeight.w600 : FontWeight.w500,
    );
  }
}

class const _MenuRow({
  required final BaseMenuItem item,
  required final TextStyle style,
  required final VoidCallback onTap,
}) extends StatefulWidget {
  @override
  State<_MenuRow> createState() => _MenuRowState();
}

class _MenuRowState() extends State<_MenuRow> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed != value) setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final item = widget.item;

    return Listener(
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AppPressable(
        key: ValueKey('baseMenuItem-${item.id}'),
        onTap: widget.onTap,
        semanticLabel: item.label,
        scaleOnPress: false,
        child: ColoredBox(
          color: _isPressed ? colors.washLight : const Color(0x00000000),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _rowMinHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: _rowPadding, vertical: AppSpace.s12),
              child: Row(
                children: [
                  AppIcon(icon: item.icon, color: colors.accentLabel),
                  const SizedBox(width: _iconGap),
                  Expanded(child: Text(item.label, style: widget.style)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens a [BaseMenu] over the screen and resolves to the chosen item, or null when dismissed.
///
/// The menu is closed before the future completes, so the caller can open the next screen
/// straight away. [anchorBuilder] draws the control itself above the scrim.
Future<BaseMenuItem?> showBaseMenu(
  BuildContext context, {
  required Rect anchor,
  required List<BaseMenuItem> items,
  BaseMenuAnchorBuilder? anchorBuilder,
}) async {
  final route = _BaseMenuRoute(
    items: items,
    anchor: anchor,
    anchorBuilder: anchorBuilder,
    isReduced: context.reduceMotion,
  );
  unawaited(AppHaptics.light());
  final result = await Navigator.of(context, rootNavigator: true).push(route);
  await route.completed;

  return result;
}

class _BaseMenuRoute({
  required final List<BaseMenuItem> items,
  required final Rect anchor,
  required final BaseMenuAnchorBuilder? anchorBuilder,
  required final bool isReduced,
}) extends PopupRoute<BaseMenuItem> {
  @override
  Duration get transitionDuration => isReduced ? _reducedDuration : _openDuration;

  @override
  Duration get reverseTransitionDuration => isReduced ? _reducedDuration : _closeDuration;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return BaseMenu(
      items: items,
      anchor: anchor,
      animation: animation,
      anchorBuilder: anchorBuilder,
      onSelect: (item) {
        if (isCurrent) navigator?.pop(item);
      },
      onDismiss: () {
        if (isCurrent) navigator?.pop();
      },
    );
  }
}
