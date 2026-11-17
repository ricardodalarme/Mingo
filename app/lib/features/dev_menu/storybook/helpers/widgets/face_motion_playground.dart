import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';

/// Values read from the face knobs of an example.
class const FaceKnobs({
  required final FaceMotion? motion,
  required final bool isReduced,
  required final FaceSize size,
  required final Color? tint,
});

/// Reads the motion, reduce motion, size and color knobs.
FaceKnobs readFaceKnobs(BuildContext context, {FaceSize size = FaceSize.large}) {
  final colors = context.colors;
  final motion = context.knobs.object.dropdown<FaceMotion?>(
    label: 'Motion',
    options: <FaceMotion?>[null, ...FaceMotion.values],
    labelBuilder: (value) => value?.name ?? 'auto',
  );
  final isReduced = context.knobs.boolean(label: 'Reduce motion');
  final faceSize = context.knobs.object.dropdown<FaceSize>(
    label: 'Size',
    options: FaceSize.values,
    initialOption: size,
    labelBuilder: (value) => value.name,
  );
  final tints = <(String, Color?)>[
    ('default', null),
    ('accent', colors.accentLabel),
    ('secondary', colors.textSecondary),
  ];
  final tint = context.knobs.object.dropdown<(String, Color?)>(
    label: 'Color',
    options: tints,
    labelBuilder: (value) => value.$1,
  );

  return FaceKnobs(motion: motion, isReduced: isReduced, size: faceSize, tint: tint.$2);
}

/// Applies reduce motion and shows a Pop button that hands a new pop token to [builder].
class const FaceMotionPlayground({
  required final bool isReduced,
  required final Widget Function(BuildContext context, int popToken) builder,
  super.key,
}) extends StatefulWidget {
  @override
  State<FaceMotionPlayground> createState() => _FaceMotionPlaygroundState();
}

class _FaceMotionPlaygroundState() extends State<FaceMotionPlayground> {
  int _popToken = 0;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: widget.isReduced),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpace.s16),
            child: BaseButton.secondary(text: 'Pop', onPressed: () => setState(() => _popToken++)),
          ),
          Expanded(child: widget.builder(context, _popToken)),
        ],
      ),
    );
  }
}

/// Wraps [child] with the reduce motion and animations knobs of a component that owns its faces.
Widget withFaceMotionKnobs(BuildContext context, Widget child) {
  final isReduced = context.knobs.boolean(label: 'Reduce motion');
  final isAnimated = context.knobs.boolean(label: 'Animate faces', initialValue: true);

  return FaceMotionScope(
    enabled: isAnimated,
    child: MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: isReduced),
      child: child,
    ),
  );
}
