import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';

extension EnumNotificationTypeMapper on EnumNotificationType_enum {
  /// Null for a kind this version does not know.
  NotificationKind? toModel() => switch (this) {
    EnumNotificationType_enum.card_ready => NotificationKind.cardReady,
    EnumNotificationType_enum.card_received => NotificationKind.cardReceived,
    EnumNotificationType_enum.card_reaction => NotificationKind.cardReaction,
    EnumNotificationType_enum.partner_joined => NotificationKind.partnerJoined,
    EnumNotificationType_enum.unpaired => NotificationKind.unpaired,
    EnumNotificationType_enum.partner_message => NotificationKind.partnerMessage,
    EnumNotificationType_enum.game_invite => NotificationKind.gameInvite,
    EnumNotificationType_enum.signal => NotificationKind.signal,
    EnumNotificationType_enum.date_coming => NotificationKind.dateComing,
    EnumNotificationType_enum.ritual => NotificationKind.ritual,
    EnumNotificationType_enum.daily_idea => NotificationKind.dailyIdea,
    EnumNotificationType_enum.gentle_return => NotificationKind.gentleReturn,
    EnumNotificationType_enum.capsule_opened => NotificationKind.capsuleOpened,
    EnumNotificationType_enum.$unknown => null,
  };
}
