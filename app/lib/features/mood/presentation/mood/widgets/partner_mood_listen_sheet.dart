import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The action chosen in the listening-first sheet.
enum PartnerMoodListenAction() {
  askToTalk,
  sendLove,
  seeHowToHelp,
}

/// Listening-first ways to reach a partner who is feeling low.
class const PartnerMoodListenSheet({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.moodHelp;
    void pick(PartnerMoodListenAction action) => Navigator.of(context).pop(action);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseListCard(
          categoryLabel: l10n.talkLabel,
          title: l10n.askToTalk,
          supportText: l10n.askToTalkSupport,
          onTap: () => pick(PartnerMoodListenAction.askToTalk),
        ),
        const SizedBox(height: AppSpace.s10),
        BaseListCard(
          categoryLabel: l10n.careLabel,
          title: l10n.sendLove,
          supportText: l10n.sendLoveSupport,
          onTap: () => pick(PartnerMoodListenAction.sendLove),
        ),
        const SizedBox(height: AppSpace.s10),
        BaseListCard(
          categoryLabel: l10n.helpLabel,
          title: l10n.seeHowToHelp,
          supportText: l10n.seeHowToHelpSupport,
          onTap: () => pick(PartnerMoodListenAction.seeHowToHelp),
        ),
      ],
    );
  }
}
