import 'package:app/features/share/data/models/moon_phase.dart';
import 'package:app/features/share/presentation/widgets/moon_phase_view.dart';
import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:app/features/share/presentation/widgets/share_date_format.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

const double _moonDiameter = 168;

/// The moon phase on the couple's special date.
class const MoonShareCard({required final DateTime date, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final phase = MoonPhase.forDate(date);
    final onDark = colors.textOnAction;

    return ShareCardFrame(
      eyebrow: l10n.share.moonEyebrow,
      isDark: true,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: MoonPhaseView(
                  phase: phase,
                  diameter: _moonDiameter,
                  lit: AppPalette.neutral25,
                  unlit: onDark.withValues(alpha: .08),
                  glow: colors.accentHighlight.withValues(alpha: .28),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          Text(
            l10n.share.phases.selectOrFallback(phase.name),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: context.text.titleLg.copyWith(color: onDark),
          ),
          const SizedBox(height: AppSpace.s10),
          Text(
            l10n.share.moonSupport,
            textAlign: TextAlign.center,
            style: context.text.hand.copyWith(color: onDark.withValues(alpha: .82)),
          ),
          const SizedBox(height: AppSpace.s14),
          Text(
            ShareDateFormat.long(l10n.share, date),
            style: context.text.caption.copyWith(color: onDark.withValues(alpha: .64)),
          ),
        ],
      ),
    );
  }
}
