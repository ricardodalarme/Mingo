import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Extends the area that receives touches beyond the layout box.
///
/// A touch inside the extended area is delivered to the child at the nearest point inside the box, so
/// small visual controls keep a larger touch target without changing layout. The ancestors must give
/// the extra area room (padding around the box), otherwise they never forward the touch.
class const HitSlop({required final EdgeInsets slop, super.child, super.key})
    extends SingleChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) => _RenderHitSlop(slop);

  @override
  void updateRenderObject(BuildContext context, _RenderHitSlop renderObject) {
    renderObject.slop = slop;
  }
}

class _RenderHitSlop(var EdgeInsets slop) extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    final area = slop.inflateRect(Offset.zero & size);
    if (!area.contains(position)) return false;
    final inside = Offset(
      position.dx.clamp(0, size.width - .01),
      position.dy.clamp(0, size.height - .01),
    );

    return super.hitTest(result, position: inside);
  }
}
