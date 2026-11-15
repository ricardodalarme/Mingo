import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';

/// The share entry on Hoje: the counter and the moon of the couple's date.
///
/// Hidden when the couple has no start date to count from.
class const TodayShareEntry({required final TodayHome home, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final since = home.togetherSince;
    if (since == null || since.isAfter(clock.now())) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.s24),
      child: ShareImageEntry(
        cards: [
          ShareCounterCard(since: since),
          ShareMoonCard(date: since),
        ],
        subtitle: context.l10n.share.entrySubtitleToday,
      ),
    );
  }
}
