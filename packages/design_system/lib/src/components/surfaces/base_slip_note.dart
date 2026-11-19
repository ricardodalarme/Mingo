import 'dart:math' as math;

import 'package:design_system/src/components/interaction/app_pressable.dart';
import 'package:design_system/src/components/surfaces/slip_note_paper.dart';
import 'package:design_system/src/icons/app_icon.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';

const double _maxTextScale = 1.3;
const int _wallMaxLines = 5;
const Duration _entranceDuration = Duration(milliseconds: 200);
const double _entranceRise = 8;

/// The icon that marks [type].
IconData slipNoteIcon(SlipNoteType type) => switch (type) {
  .good => AppIcons.check,
  .help => AppIcons.heart,
  .notice => AppIcons.eye,
  .said => AppIcons.message,
  .annoyed => AppIcons.cloud,
};

/// Converts [degrees] to the radians a [Transform.rotate] takes.
double slipNoteRadians(double degrees) => degrees * math.pi / 180;

/// Handwriting style of a note body.
TextStyle slipNoteTextStyle(BuildContext context, {required double fontSize}) =>
    context.text.hand.copyWith(
      color: AppSlipNoteColors.text,
      fontSize: fontSize,
      height: 1.05,
      fontWeight: FontWeight.w600,
    );

/// Footer of a note: the type icon and name, and an optional trailing widget.
class const SlipNoteFooter({
  required final SlipNoteType type,
  required final String typeLabel,
  required final Widget trailing,
  required final SlipNoteSize size,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ink = context.slipNote.of(type).ink;
    final padding = slipNotePadding(size);
    final foldGap = slipNoteFold(size) - padding.end;

    return Padding(
      padding: EdgeInsetsDirectional.only(end: foldGap),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                AppIcon(icon: slipNoteIcon(type), size: AppIconSize.xs, color: ink),
                const SizedBox(width: AppSpace.s4),
                Flexible(
                  child: Text(
                    typeLabel.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.micro.copyWith(
                      color: ink,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 11.5 * .05,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.s8),
          trailing,
        ],
      ),
    );
  }
}

/// A slip drawn as a small taped, tilted paper note.
///
/// [typeLabel] and [dayLabel] arrive already localized. [tilt] is in degrees; callers
/// derive it from the slip id with [slipNoteTilt]. The text clamps to five lines at
/// [SlipNoteSize.wall] and shows whole at [SlipNoteSize.large]. A note fades in and
/// rises once when [animatesEntrance] is set, unless reduced motion is on.
class const BaseSlipNote({
  required final String text,
  required final SlipNoteType type,
  required final String typeLabel,
  required final String dayLabel,
  final double tilt = 0,
  final SlipNoteSize size = SlipNoteSize.wall,
  final VoidCallback? onTap,
  final String? semanticLabel,
  final bool animatesEntrance = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tone = context.slipNote.of(type);
    final isLarge = size == .large;
    final scaler = MediaQuery.textScalerOf(context).clamp(maxScaleFactor: _maxTextScale);

    final paper = SlipNotePaper(
      background: tone.background,
      size: size,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              maxLines: isLarge ? null : _wallMaxLines,
              overflow: isLarge ? TextOverflow.clip : TextOverflow.ellipsis,
              textScaler: scaler,
              style: slipNoteTextStyle(context, fontSize: isLarge ? 34 : 23),
            ),
            const SizedBox(height: AppSpace.s12),
            SlipNoteFooter(
              type: type,
              typeLabel: typeLabel,
              size: size,
              trailing: Text(
                dayLabel,
                maxLines: 1,
                softWrap: false,
                style: context.text.micro.copyWith(
                  color: AppSlipNoteColors.dayLabel,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final tappable = AppPressable(
      onTap: onTap,
      isSemanticButton: onTap != null,
      semanticLabel: semanticLabel ?? '$text, $typeLabel, $dayLabel',
      borderRadius: BorderRadius.circular(AppRadius.xs * 2),
      child: paper,
    );

    return _Entrance(
      isEnabled: animatesEntrance,
      child: Transform.rotate(angle: slipNoteRadians(tilt), child: tappable),
    );
  }
}

class const _Entrance({required final bool isEnabled, required final Widget child})
    extends StatefulWidget {
  @override
  State<_Entrance> createState() => _EntranceState();
}

class _EntranceState() extends State<_Entrance> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _entranceDuration,
    value: 1,
  );
  bool _hasStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;
    if (widget.isEnabled && !context.reduceMotion) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final progress = AppMotion.baseCurve.transform(_controller.value);

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, _entranceRise * (1 - progress)),
            child: child,
          ),
        );
      },
    );
  }
}
