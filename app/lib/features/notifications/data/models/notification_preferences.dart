import 'package:equatable/equatable.dart';

/// The reminders a person can switch off one by one, matching the server type keys.
///
/// Notifications started by the partner are not reminders: they always arrive and are not listed.
const List<String> notificationTypes = ['daily_idea', 'date_coming', 'card_ready'];

/// The fewest and the most reminders a day may bring.
const int minDailyMax = 1;
const int maxDailyMax = 2;

/// What the person chose for notifications, kept on the server so it applies to pushes.
final class const NotificationPreferences({
  final bool isEnabled = true,
  final Set<String> mutedTypes = const {},
  final int cardDay = 0,
  final int cardHour = 9,
  final int dailyMax = maxDailyMax,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => const NotificationPreferences();

  /// Whether [type] is switched on.
  bool allows(String type) => !mutedTypes.contains(type);

  NotificationPreferences copyWith({
    bool? isEnabled,
    Set<String>? mutedTypes,
    int? cardDay,
    int? cardHour,
    int? dailyMax,
  }) => NotificationPreferences(
    isEnabled: isEnabled ?? this.isEnabled,
    mutedTypes: mutedTypes ?? this.mutedTypes,
    cardDay: cardDay ?? this.cardDay,
    cardHour: cardHour ?? this.cardHour,
    dailyMax: (dailyMax ?? this.dailyMax).clamp(minDailyMax, maxDailyMax),
  );

  @override
  List<Object?> get props => [isEnabled, mutedTypes, cardDay, cardHour, dailyMax];
}
