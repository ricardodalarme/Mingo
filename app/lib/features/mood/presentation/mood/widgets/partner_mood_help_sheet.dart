import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The four things that can help today, ordered for the partner's mood.
class const PartnerMoodHelpSheet({required final MoodKind mood, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.moodHelp;
    final ask = (
      label: l10n.talkLabel,
      title: l10n.askListenOrSpace,
      support: l10n.askListenOrSpaceSupport,
    );
    final chore = (label: l10n.choreLabel, title: l10n.takeChore, support: l10n.takeChoreSupport);
    final message = (
      label: l10n.careLabel,
      title: l10n.sendSweetMessage,
      support: l10n.sendSweetMessageSupport,
    );
    final food = (
      label: l10n.homeLabel,
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
          BaseListCard(
            categoryLabel: options[index].label,
            title: options[index].title,
            supportText: options[index].support,
          ),
        ],
      ],
    );
  }
}
