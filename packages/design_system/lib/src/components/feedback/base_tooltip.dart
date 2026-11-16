import 'dart:async';
import 'dart:math' as math;

import 'package:design_system/design_system.dart';
import 'package:flutter/gestures.dart';

/// How touch reveals a [BaseTooltip] message.
enum BaseTooltipTrigger() {
  /// A tap, for a non-tappable anchor such as an info icon.
  tap,

  /// A 400 ms long press, for a control that already reacts to taps.
  longPress,
}

const double _maxWidth = 240;
const double _arrowSize = 12;
const double _screenMargin = AppSpace.s16;
const double _gap = AppSpace.s4;
const Duration _longPress = Duration(milliseconds: 400);
const Duration _visible = Duration(seconds: 4);

/// A short explanation in a dark bubble with an arrow, anchored to [child].
///
/// Opens on a tap or a 400 ms long press (see [trigger]) and closes on a tap anywhere, a scroll or
/// after 4 seconds. Only one is open at a time, above the anchor unless there is no room (or
/// [preferBelow]), kept 16 points from the screen edge. Two lines at most: it is never the only place
/// for essential information and never an error. The text is also the accessibility hint of its anchor.
class const BaseTooltip({
  required final String message,
  required final Widget child,
  final BaseTooltipTrigger trigger = .longPress,
  final bool preferBelow = false,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseTooltip> createState() => _BaseTooltipState();
}

class _BaseTooltipState() extends State<BaseTooltip> {
  static _BaseTooltipState? _open;

  OverlayEntry? _entry;
  Timer? _closeTimer;
  Timer? _pressTimer;
  Offset? _downPosition;

  @override
  void dispose() {
    _pressTimer?.cancel();
    _hide();
    super.dispose();
  }

  void _show() {
    if (_entry != null || !mounted) return;
    _open?._hide();
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    final box = context.findRenderObject() as RenderBox?;
    if (overlay == null || box == null || !box.hasSize) return;

    final target = box.localToGlobal(Offset.zero) & box.size;
    final colors = context.colors;
    final style = context.text.caption.copyWith(color: AppPalette.white);
    final isBelow = widget.preferBelow;

    _entry = OverlayEntry(
      builder: (overlayContext) => _TooltipLayer(
        target: target,
        message: widget.message,
        style: style,
        color: AppPalette.neutral900,
        preferBelow: isBelow,
        onDismiss: _hide,
        isReduced: overlayContext.reduceMotion,
        scrim: colors.scrim,
      ),
    );
    overlay.insert(_entry!);
    _open = this;
    _closeTimer = Timer(_visible, _hide);
  }

  void _hide() {
    _closeTimer?.cancel();
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
    if (_open == this) _open = null;
  }

  void _handleDown(PointerDownEvent event) {
    _downPosition = event.position;
    if (widget.trigger == .longPress) {
      _pressTimer?.cancel();
      _pressTimer = Timer(_longPress, _show);
    }
  }

  void _handleUp(PointerUpEvent event) {
    _pressTimer?.cancel();
    final start = _downPosition;
    if (widget.trigger == .tap && start != null && (event.position - start).distance < kTouchSlop) {
      _show();
    }
    _downPosition = null;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      tooltip: widget.message,
      child: Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: _handleDown,
        onPointerUp: _handleUp,
        onPointerCancel: (_) => _pressTimer?.cancel(),
        child: widget.child,
      ),
    );
  }
}

class const _TooltipLayer({
  required final Rect target,
  required final String message,
  required final TextStyle style,
  required final Color color,
  required final bool preferBelow,
  required final VoidCallback onDismiss,
  required final bool isReduced,
  required final Color scrim,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: _maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s14, vertical: AppSpace.s10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppRadius.lg)),
      child: Text(message, maxLines: 2, overflow: TextOverflow.ellipsis, style: style),
    );

    final painter = TextPainter(
      text: TextSpan(text: message, style: style),
      textDirection: Directionality.of(context),
      maxLines: 2,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: _maxWidth - AppSpace.s14 * 2);
    final bubbleHeight = painter.height + AppSpace.s10 * 2;
    final hasRoomAbove =
        target.top - bubbleHeight - _arrowSize / 2 - _gap >= MediaQuery.paddingOf(context).top;
    final isBelow = preferBelow || !hasRoomAbove;

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => onDismiss(),
      child: IgnorePointer(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: isReduced ? AppMotion.reduced : AppMotion.fast,
          builder: (context, value, child) => Opacity(opacity: value, child: child),
          child: CustomMultiChildLayout(
            delegate: _TooltipDelegate(target: target, isBelow: isBelow),
            children: [
              LayoutId(id: _Slot.bubble, child: bubble),
              LayoutId(
                id: _Slot.arrow,
                child: CustomPaint(
                  size: const Size(_arrowSize, _arrowSize / 2),
                  painter: _ArrowPainter(color: color, isPointingUp: isBelow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Slot() {
  bubble,
  arrow,
}

class _TooltipDelegate({required final Rect target, required final bool isBelow})
    extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    final bubbleSize = layoutChild(
      _Slot.bubble,
      BoxConstraints.loose(Size(math.min(_maxWidth, size.width - _screenMargin * 2), size.height)),
    );
    final arrowSize = layoutChild(
      _Slot.arrow,
      BoxConstraints.tight(const Size(_arrowSize, _arrowSize / 2)),
    );
    final left = (target.center.dx - bubbleSize.width / 2)
        .clamp(
          _screenMargin,
          math.max(_screenMargin, size.width - _screenMargin - bubbleSize.width),
        )
        .toDouble();
    final top = isBelow
        ? target.bottom + _gap + arrowSize.height
        : target.top - _gap - arrowSize.height - bubbleSize.height;
    final arrowLeft = (target.center.dx - arrowSize.width / 2).clamp(
      left + AppRadius.lg,
      left + bubbleSize.width - AppRadius.lg - arrowSize.width,
    );
    final arrowTop = isBelow ? top - arrowSize.height : top + bubbleSize.height;

    positionChild(_Slot.bubble, Offset(left, top));
    positionChild(_Slot.arrow, Offset(arrowLeft, arrowTop));
  }

  @override
  bool shouldRelayout(_TooltipDelegate oldDelegate) =>
      oldDelegate.target != target || oldDelegate.isBelow != isBelow;
}

class const _ArrowPainter({required final Color color, required final bool isPointingUp})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (isPointingUp) {
      path
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2, 0)
        ..lineTo(size.width, size.height);
    } else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0);
    }
    canvas.drawPath(path..close(), Paint()..color = color);
  }

  @override
  bool shouldRepaint(_ArrowPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.isPointingUp != isPointingUp;
}
