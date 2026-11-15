import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/counter_share_card.dart';
import 'package:app/features/share/presentation/widgets/moon_share_card.dart';
import 'package:app/features/share/presentation/widgets/quote_share_card.dart';
import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:app/features/share/presentation/widgets/timeline_share_card.dart';
import 'package:design_system/design_system.dart';

/// The image for [card], laid out at its export size.
class const ShareCardCanvas({required final ShareCard card, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: shareCardWidth,
      height: shareCardHeight,
      child: switch (card) {
        ShareCounterCard(:final since) => CounterShareCard(since: since),
        ShareMoonCard(:final date) => MoonShareCard(date: date),
        ShareTimelineCard(:final entries) => TimelineShareCard(entries: entries),
        ShareQuoteCard(:final quote, :final authorName, :final date) => QuoteShareCard(
          quote: quote,
          authorName: authorName,
          date: date,
        ),
      },
    );
  }
}
