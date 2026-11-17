import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The action chosen in the help sheet.
enum PartnerMoodHelpAction() {
  sendMessage,
}

/// What can help a partner whose mood is low, ordered for that mood.
///
/// An option that sends something to the partner is a card, like the ones in the listening sheet.
/// A real-world act is a suggestion with no surface and no press, so nothing looks tappable
/// unless it is.
class const PartnerMoodHelpSheet({required final MoodKind mood, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.moodHelp;
    void pick(PartnerMoodHelpAction action) => Navigator.of(context).pop(action);

    final ask = _Suggestion(title: l10n.askListenOrSpace, support: l10n.askListenOrSpaceSupport);
    final chore = _Suggestion(title: l10n.takeChore, support: l10n.takeChoreSupport);
    final message = BaseListCard(
      categoryLabel: l10n.careLabel,
      title: l10n.sendSweetMessage,
      supportText: l10n.sweetMessagePreview(body: l10n.sweetMessageBody),
      onTap: () => pick(PartnerMoodHelpAction.sendMessage),
    );
    final food = _Suggestion(
      title: l10n.makeCoffeeOrDinner,
      support: l10n.makeCoffeeOrDinnerSupport,
    );
    // A stressed partner needs the question first; a tired one needs the chore off their plate.
    final options = mood == MoodKind.stressed
        ? [ask, chore, message, food]
        : [chore, ask, message, food];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < options.length; index++) ...[
          if (index > 0) const SizedBox(height: AppSpace.s10),
          options[index],
        ],
        const SizedBox(height: AppSpace.s20),
        BaseNote(text: l10n.noDiagnosisNote, icon: AppIcons.info),
      ],
    );
  }
}

/// A real-world act, drawn as advice rather than as a button.
class const _Suggestion({required final String title, required final String support})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseCategoryLabel(text: context.l10n.moodHelp.suggestionLabel, category: AppCategory.idea),
        const SizedBox(height: AppSpace.s6),
        Text(title, style: context.text.body),
        const SizedBox(height: AppSpace.s4),
        Text(support, style: context.text.caption.copyWith(color: colors.textSecondary)),
      ],
    );
  }
}
