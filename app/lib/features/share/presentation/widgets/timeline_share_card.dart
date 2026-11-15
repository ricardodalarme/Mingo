import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:app/features/share/presentation/widgets/share_date_format.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

const double _dot = 7;
const double _railWidth = 14;

/// A handful of real moments, newest first.
class const TimelineShareCard({required final List<ShareTimelineEntry> entries, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.share;

    return ShareCardFrame(
      eyebrow: l10n.timelineEyebrow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.timelineTitle, style: context.text.titleMd),
          const SizedBox(height: AppSpace.s20),
          Expanded(
            child: Column(
              children: [
                for (var index = 0; index < entries.length; index++)
                  Expanded(
                    child: _Entry(entry: entries[index], isLast: index == entries.length - 1),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _Entry({required final ShareTimelineEntry entry, required final bool isLast})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n.share;
    final place = entry.place?.trim();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _railWidth,
            child: Column(
              children: [
                const SizedBox(height: AppSpace.s6),
                Container(
                  width: _dot,
                  height: _dot,
                  decoration: BoxDecoration(color: colors.accentHighlight, shape: BoxShape.circle),
                ),
                if (!isLast)
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: AppBorder.hair,
                        height: double.infinity,
                        child: ColoredBox(color: colors.borderDefault),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.s14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpace.s10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    [
                      ShareDateFormat.long(l10n, entry.date),
                      if (place != null && place.isNotEmpty) place,
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.micro.copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpace.s2),
                  Text(entry.title, maxLines: 2, style: context.text.titleSm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
