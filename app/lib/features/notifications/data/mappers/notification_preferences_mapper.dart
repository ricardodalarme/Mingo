import 'package:app/features/notifications/data/data_sources/remote/notifications_data_source.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';

extension NotificationPreferencesMapper on NotificationSettingsRow {
  NotificationPreferences toModel() => NotificationPreferences(
    isEnabled: isEnabled,
    mutedTypes: mutedTypes,
    cardDay: cardDay,
    cardHour: cardHour,
    dailyMax: dailyMax,
  );
}
