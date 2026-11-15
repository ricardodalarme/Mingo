import 'package:app/features/cards/data/models/card_detail.dart';
import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The share entry on a card detail, quoting the card the person received.
///
/// Hidden for a card the person sent and for a card with nothing to quote.
class const CardShareEntry({required final CardDetail detail, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final note = detail.card.note?.trim();
    final items = detail.card.items;
    final quote = note != null && note.isNotEmpty
        ? note
        : items.isEmpty
        ? null
        : items.first.body;
    if (detail.isMine || quote == null || quote.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.s24),
      child: ShareImageEntry(
        cards: [
          ShareQuoteCard(quote: quote, authorName: detail.authorName, date: detail.card.weekStart),
        ],
        subtitle: context.l10n.share.entrySubtitleCard,
      ),
    );
  }
}
