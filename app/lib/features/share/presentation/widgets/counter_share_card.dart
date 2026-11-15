import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/presentation/history/widgets/history_date_formatter.dart';
import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:app/features/share/presentation/widgets/share_date_format.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';

/// How long the couple has been together, from [since] until today.
class const CounterShareCard({required final DateTime since, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final numbers = HistoryNumbers.compute(
      togetherSince: since,
      now: clock.now(),
      places: const [],
    );
    final duration = HistoryDateFormatter.formatDurationHeadline(
      l10n.history,
      numbers,
      inline: true,
    );

    return ShareCardFrame(
      eyebrow: l10n.share.counterEyebrow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: AppSpace.s120,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text('${numbers.daysTogether}', style: context.text.display),
            ),
          ),
          Text(
            l10n.share.counterDays(count: numbers.daysTogether),
            style: context.text.titleSm.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          const ShareCardDivider(),
          const SizedBox(height: AppSpace.s16),
          Text(duration, style: context.text.hand),
          const SizedBox(height: AppSpace.s4),
          Text(
            l10n.share.counterSince(date: ShareDateFormat.long(l10n.share, since)),
            style: context.text.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
