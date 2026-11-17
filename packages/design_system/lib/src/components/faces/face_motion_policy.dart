import 'package:design_system/src/components/faces/base_face.dart';
import 'package:flutter/widgets.dart';

/// Picks how a face moves when the caller did not choose.
FaceMotion resolveFaceMotion({
  required FaceMotion? motion,
  required bool selected,
  required FaceSize size,
}) {
  if (motion != null) return motion;
  if (selected) return .idle;
  if (size == .showcase) return .enter;

  return .still;
}

/// Caps how many faces animate at once, because each one is a native view.
abstract final class FaceMotionBudget() {
  static const int limit = 4;
  static int _active = 0;

  /// Takes one slot; `false` when [limit] faces already animate.
  static bool tryAcquire() {
    if (_active >= limit) return false;
    _active++;

    return true;
  }

  /// Gives back a slot taken by [tryAcquire].
  static void release() {
    if (_active > 0) _active--;
  }

  /// Gives back every slot.
  @visibleForTesting
  static void reset() => _active = 0;
}

/// Whether [context] is inside an item of a lazy list, where native views scroll badly.
bool isInListItem(BuildContext context) =>
    context.findAncestorWidgetOfExactType<IndexedSemantics>() != null;
