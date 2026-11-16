import 'package:design_system/src/components/surfaces/base_face.dart';
import 'package:design_system/src/components/surfaces/face_animations.dart';
import 'package:flutter/widgets.dart';

/// Builds the widget that plays [request] in place of the real animation player.
typedef FacePlayerBuilder = Widget Function(BuildContext context, FacePlayerRequest request);

/// What a face asks its player to show.
class const FacePlayerRequest({
  required final FaceKind kind,
  required final FaceClip clip,
  required final Color tint,
  required final double startOffset,
  required final bool isPaused,
  required final VoidCallback onCompleted,
});

/// Switches face animation off for a subtree and lets tests replace the player.
class const FaceMotionScope({
  required super.child,
  final bool enabled = true,
  final FacePlayerBuilder? playerBuilder,
  super.key,
}) extends InheritedWidget {
  /// The nearest scope, or `null` when there is none.
  static FaceMotionScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<FaceMotionScope>();

  @override
  bool updateShouldNotify(FaceMotionScope oldWidget) =>
      enabled != oldWidget.enabled || playerBuilder != oldWidget.playerBuilder;
}
