import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

const double _plotHeight = 140;
const double _dotSize = 14;

/// One point per week, from the calmest level at the bottom to a fight at the top.
class const TemperatureChart({required final List<TemperatureWeek> weeks, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    const levels = Temperature.values;
    final l10n = context.l10n.temperature.history;

    return Semantics(
      label: l10n.chartLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: _plotHeight,
            child: Row(
              children: [
                for (final week in weeks)
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(width: AppBorder.hair, color: colors.borderDefault),
                        if (week.level case final level?)
                          Align(
                            alignment: Alignment(
                              0,
                              1 - 2 * levels.indexOf(level) / (levels.length - 1),
                            ),
                            child: Semantics(
                              label: context.l10n.temperature.levels.selectOrFallback(level.name),
                              child: Container(
                                width: _dotSize,
                                height: _dotSize,
                                decoration: BoxDecoration(
                                  color: level == Temperature.fight
                                      ? colors.accentHighlight
                                      : colors.actionPrimary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Row(
            children: [
              for (final week in weeks)
                Expanded(
                  child: Text(
                    '${week.start.day}/${week.start.month}',
                    textAlign: TextAlign.center,
                    style: context.text.caption.copyWith(color: colors.textSecondary),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
