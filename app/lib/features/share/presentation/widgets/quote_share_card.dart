import 'package:app/features/share/presentation/widgets/share_card_frame.dart';
import 'package:app/features/share/presentation/widgets/share_date_format.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// A line from a card the person already received.
class const QuoteShareCard({
  required final String quote,
  final String? authorName,
  final DateTime? date,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.share;
    final colors = context.colors;
    final author = authorName;
    final writtenOn = date;

    return ShareCardFrame(
      eyebrow: l10n.quoteEyebrow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: shareCardContentWidth,
                  child: Text(
                    l10n.quoteText(quote: quote),
                    style: context.text.question,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          const ShareCardDivider(),
          const SizedBox(height: AppSpace.s16),
          if (author != null)
            Text(
              l10n.quoteFromName(name: author),
              style: context.text.titleSm,
            ),
          if (writtenOn != null)
            Text(
              l10n.quoteDate(date: ShareDateFormat.short(l10n, writtenOn)),
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
        ],
      ),
    );
  }
}
