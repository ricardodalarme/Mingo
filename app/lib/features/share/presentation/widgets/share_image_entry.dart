import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/sheet/share_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The quiet row that opens the share sheet, hidden when there is nothing to share.
class const ShareImageEntry({
  required final List<ShareCard> cards,
  required final String subtitle,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox.shrink();

    return BaseListGroup(
      children: [
        BaseListTile(
          icon: AppIcons.share,
          title: context.l10n.share.entryTitle,
          subtitle: subtitle,
          showsChevron: true,
          onTap: () => openShareSheet(context: context, cards: cards),
        ),
      ],
    );
  }
}
