import 'package:equatable/equatable.dart';

/// The notification types a person can switch off one by one, matching the server type keys.
const List<String> notificationTypes = [
  'card_ready',
  'card_received',
  'card_reaction',
  'daily_idea',
  'date_coming',
];

/// What the person chose for notifications, kept on the server so it applies to pushes.
final class const NotificationPreferences({
  final bool isEnabled = true,
  final Set<String> mutedTypes = const {},
  final int cardDay = 0,
  final int cardHour = 9,
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
  }) => NotificationPreferences(
    isEnabled: isEnabled ?? this.isEnabled,
    mutedTypes: mutedTypes ?? this.mutedTypes,
    cardDay: cardDay ?? this.cardDay,
    cardHour: cardHour ?? this.cardHour,
  );

  @override
  List<Object?> get props => [isEnabled, mutedTypes, cardDay, cardHour];
}
