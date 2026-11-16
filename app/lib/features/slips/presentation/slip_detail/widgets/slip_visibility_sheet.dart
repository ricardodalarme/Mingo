import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Who sees a slip.
enum SlipVisibility() {
  /// Only the author; it stays in their week.
  onlyMe,

  /// It goes into the author's weekly card.
  weeklyCard,

  /// It goes to the partner now, on its own.
  sendNow,
}

/// Asks who sees [slip]; resolves with the choice, or null when the sheet is dismissed.
Future<SlipVisibility?> showSlipVisibilitySheet(BuildContext context, SlipDetail slip) {
  final l10n = context.l10n.slipDetail.visibility;

  return BaseSheet.show<SlipVisibility>(
    context: context,
    title: l10n.title,
    subtitle: l10n.subtitle,
    hasCloseButton: false,
    child: _Choices(slip: slip),
  );
}

class const _Choices({required final SlipDetail slip}) extends StatefulWidget {
  @override
  State<_Choices> createState() => _ChoicesState();
}

class _ChoicesState() extends State<_Choices> {
  late SlipVisibility _selected = widget.slip.forCard
      ? SlipVisibility.weeklyCard
      : SlipVisibility.onlyMe;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipDetail.visibility;
    final canShare = widget.slip.canGoInCard;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseOptionTile(
          title: l10n.onlyMe,
          support: l10n.onlyMeText,
          leading: const BaseIconTile(icon: AppIcons.lock),
          isSelected: _selected == SlipVisibility.onlyMe,
          onTap: () => setState(() => _selected = SlipVisibility.onlyMe),
        ),
        if (canShare) ...[
          const SizedBox(height: AppSpace.s10),
          BaseOptionTile(
            title: l10n.weeklyCard,
            leading: const BaseIconTile(icon: AppIcons.mail_filled),
            isSelected: _selected == SlipVisibility.weeklyCard,
            onTap: () => setState(() => _selected = SlipVisibility.weeklyCard),
          ),
          const SizedBox(height: AppSpace.s10),
          BaseOptionTile(
            title: l10n.sendNow,
            leading: const BaseIconTile(icon: AppIcons.send),
            isSelected: _selected == SlipVisibility.sendNow,
            onTap: () => setState(() => _selected = SlipVisibility.sendNow),
          ),
        ],
        const SizedBox(height: AppSpace.s16),
        BaseButton(text: l10n.done, onPressed: () => Navigator.of(context).pop(_selected)),
      ],
    );
  }
}
