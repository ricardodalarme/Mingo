import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The words and the icon one notification kind shows in the list.
class const InboxCopy({
  required final String title,
  required final String subtitle,
  required final IconData icon,
});

/// Resolves the copy of [item]; [partnerName] falls back to a generic word.
InboxCopy inboxCopyFor(BuildContext context, InboxItem item, String? partnerName) {
  final l10n = context.l10n.inbox;
  final name = partnerName == null || partnerName.isEmpty ? l10n.partnerFallback : partnerName;

  return switch (item.kind) {
    NotificationKind.cardReady => InboxCopy(
      title: l10n.cardReadyTitle,
      subtitle: l10n.cardReadyText,
      icon: AppIcons.mail,
    ),
    NotificationKind.cardReceived => InboxCopy(
      title: l10n.cardReceivedTitle(name: name),
      subtitle: l10n.tapToSee,
      icon: AppIcons.mail,
    ),
    NotificationKind.cardReaction => InboxCopy(
      title: l10n.cardReactionTitle(name: name),
      subtitle: l10n.tapToSee,
      icon: AppIcons.heart,
    ),
    NotificationKind.partnerJoined => InboxCopy(
      title: l10n.partnerJoinedTitle(name: name),
      subtitle: l10n.partnerJoinedText,
      icon: AppIcons.users,
    ),
    NotificationKind.unpaired => InboxCopy(
      title: l10n.unpairedTitle,
      subtitle: l10n.unpairedText,
      icon: AppIcons.user,
    ),
    NotificationKind.partnerMessage => InboxCopy(
      title: l10n.partnerMessageTitle(name: name),
      subtitle: l10n.tapToSee,
      icon: AppIcons.message,
    ),
    NotificationKind.gameInvite => InboxCopy(
      title: l10n.gameInviteTitle(name: name),
      subtitle: l10n.gameInviteText,
      icon: AppIcons.gamepad,
    ),
    NotificationKind.signal => InboxCopy(
      title: l10n.signalTitle(name: name),
      subtitle: l10n.tapToSee,
      icon: AppIcons.heart,
    ),
    NotificationKind.dateComing => InboxCopy(
      title: l10n.dateComingTitle,
      subtitle: l10n.dateComingText,
      icon: AppIcons.calendar,
    ),
    NotificationKind.ritual => InboxCopy(
      title: l10n.ritualTitle,
      subtitle: l10n.tapToSee,
      icon: AppIcons.timer,
    ),
    NotificationKind.dailyIdea => InboxCopy(
      title: l10n.dailyIdeaTitle,
      subtitle: l10n.dailyIdeaText,
      icon: AppIcons.lightbulb,
    ),
    NotificationKind.gentleReturn => InboxCopy(
      title: l10n.gentleReturnTitle,
      subtitle: l10n.gentleReturnText,
      icon: AppIcons.sunrise,
    ),
    NotificationKind.capsuleOpened => InboxCopy(
      title: l10n.capsuleOpenedTitle,
      subtitle: l10n.capsuleOpenedText,
      icon: AppIcons.jar,
    ),
  };
}
