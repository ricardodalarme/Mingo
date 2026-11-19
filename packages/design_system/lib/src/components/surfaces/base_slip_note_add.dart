import 'package:design_system/src/components/interaction/app_pressable.dart';
import 'package:design_system/src/components/surfaces/base_slip_note.dart';
import 'package:design_system/src/drawings/dashed_rounded_painter.dart';
import 'package:design_system/src/icons/app_icon.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';

const double _tilt = -.8;
const double _minHeight = 96;
const double _radius = 6;

/// The dashed card at the end of a note wall that opens a new slip.
class const BaseSlipNoteAdd({
  required final String label,
  required final VoidCallback onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: slipNoteRadians(_tilt),
      child: AppPressable(
        onTap: onTap,
        semanticLabel: label,
        borderRadius: BorderRadius.circular(_radius),
        child: ExcludeSemantics(
          child: CustomPaint(
            painter: const DashedRoundedPainter(
              color: AppSlipNoteColors.addBorder,
              radius: _radius,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _minHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpace.s12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppIcon(
                        icon: AppIcons.plus,
                        size: AppIconSize.xl,
                        color: AppSlipNoteColors.muted,
                      ),
                      const SizedBox(height: AppSpace.s4),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: context.text.body.copyWith(
                          color: AppSlipNoteColors.muted,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
