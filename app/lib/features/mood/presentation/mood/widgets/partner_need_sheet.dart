import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The one-tap answer to a need that can be sent.
enum PartnerNeedAnswer() {
  hug,
  chat,
}

/// What the partner asked for today, with the one concrete thing that answers it.
///
/// A need that sends something is tappable; guidance is not.
class const PartnerNeedSheet({required final NeedKind need, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.moodHelp;
    final answer = switch (need) {
      NeedKind.hug => PartnerNeedAnswer.hug,
      NeedKind.cuteMessage => PartnerNeedAnswer.chat,
      _ => null,
    };
    final sends = answer != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BaseTag(text: context.l10n.mood.needs.selectOrFallback(need.name)),
        ),
        const SizedBox(height: AppSpace.s16),
        BaseListCard(
          categoryLabel: sends ? l10n.careLabel : l10n.helpLabel,
          title: l10n.partnerNeedActions.selectOrFallback(need.name),
          supportText: l10n.partnerNeedSupports.selectOrFallback(need.name),
          trailing: sends ? const AppIcon(icon: AppIcons.chevron_right) : null,
          onTap: answer == null ? null : () => Navigator.of(context).pop(answer),
        ),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.partnerNeedNote),
      ],
    );
  }
}
