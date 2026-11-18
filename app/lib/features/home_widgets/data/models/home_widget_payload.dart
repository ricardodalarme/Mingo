import 'dart:convert';

import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart' show AppThemeVariant;
import 'package:equatable/equatable.dart';

/// A shared story event a home widget may show on the counter timeline.
final class const HomeWidgetMilestone({required final String title, required final String on})
    with Equatable {
  factory fromJson(Map<String, dynamic> json) =>
      HomeWidgetMilestone(title: json['title'] as String? ?? '', on: json['on'] as String? ?? '');

  Map<String, dynamic> toJson() => <String, dynamic>{'title': title, 'on': on};

  @override
  List<Object?> get props => [title, on];
}

/// The single JSON document the app writes for the iOS WidgetKit and Android Glance home widgets.
///
/// It carries facts, never display text: the native side formats dates, times, plurals and
/// moods in the system language. Every field is something the server already allowed this
/// person to read, so the home widgets add no privacy setting of their own.
final class const HomeWidgetPayload({
  required final bool isSignedIn,
  required final bool isPaired,
  required final String updatedAt,
  final AppThemeVariant theme = AppThemeVariant.rose,
  final String? ownName,
  final String? partnerName,
  final String? togetherSince,
  final List<HomeWidgetMilestone> milestones = const <HomeWidgetMilestone>[],
  final String? nextDateTitle,
  final String? nextDateOn,
  final HomeWidgetCardState cardState = HomeWidgetCardState.none,
  final int? cardSendDay,
  final int? cardSendHour,
  final String? partnerNote,
  final String? partnerNoteAt,
  final MoodKind? partnerMood,
  final String? partnerMoodAt,
  final String? partnerMissedAt,
  final String? ritualTitle,
  final int? ritualWeekday,
  final String? ritualTime,
  final String? dailyIdeaTitle,
  final int slipsThisWeek = 0,
  final List<String> slipDays = const <String>[],
  final String? ownZone,
  final String? partnerZone,
  final String? reunionTitle,
  final String? reunionOn,
}) with Equatable {
  /// The neutral payload written on sign-out so no earlier account data remains.
  factory signedOut({DateTime? now}) => HomeWidgetPayload(
    isSignedIn: false,
    isPaired: false,
    updatedAt: (now ?? clock.now()).toUtc().toIso8601String(),
  );

  /// Placeholder used only behind a skeleton while the real payload loads.
  factory fake() => const HomeWidgetPayload(
    isSignedIn: true,
    isPaired: true,
    updatedAt: '2026-11-11T12:00:00.000Z',
    ownName: 'Alex',
    partnerName: 'Sam',
    togetherSince: '2024-02-14',
    nextDateTitle: 'Aniversário',
    nextDateOn: '2026-11-23',
    cardState: HomeWidgetCardState.ready,
    partnerNote: 'Jantar hoje? Eu cozinho.',
    partnerNoteAt: '2026-11-11T09:00:00.000Z',
    partnerMood: MoodKind.loving,
    partnerMoodAt: '2026-11-11T10:00:00.000Z',
    ritualTitle: 'Caminhada de domingo',
    ritualWeekday: 7,
    ritualTime: '10:00',
    dailyIdeaTitle: 'Deixe um bilhete na mochila',
    slipsThisWeek: 3,
    slipDays: ['2026-11-09', '2026-11-10', '2026-11-11'],
    ownZone: 'America/Sao_Paulo',
    partnerZone: 'Europe/Lisbon',
    reunionOn: '2026-12-23',
  );

  factory fromJson(Map<String, dynamic> json) => HomeWidgetPayload(
    isSignedIn: json['isSignedIn'] as bool? ?? false,
    isPaired: json['isPaired'] as bool? ?? false,
    updatedAt: json['updatedAt'] as String? ?? '',
    theme: AppThemeVariant.values.asNameMap()[json['theme']] ?? AppThemeVariant.rose,
    ownName: json['ownName'] as String?,
    partnerName: json['partnerName'] as String?,
    togetherSince: json['togetherSince'] as String?,
    milestones:
        (json['milestones'] as List<dynamic>?)
            ?.whereType<Map<String, dynamic>>()
            .map(HomeWidgetMilestone.fromJson)
            .toList() ??
        const <HomeWidgetMilestone>[],
    nextDateTitle: json['nextDateTitle'] as String?,
    nextDateOn: json['nextDateOn'] as String?,
    cardState:
        HomeWidgetCardState.values.asNameMap()[json['cardState']] ?? HomeWidgetCardState.none,
    cardSendDay: json['cardSendDay'] as int?,
    cardSendHour: json['cardSendHour'] as int?,
    partnerNote: json['partnerNote'] as String?,
    partnerNoteAt: json['partnerNoteAt'] as String?,
    partnerMood: MoodKind.values.asNameMap()[json['partnerMood']],
    partnerMoodAt: json['partnerMoodAt'] as String?,
    partnerMissedAt: json['partnerMissedAt'] as String?,
    ritualTitle: json['ritualTitle'] as String?,
    ritualWeekday: json['ritualWeekday'] as int?,
    ritualTime: json['ritualTime'] as String?,
    dailyIdeaTitle: json['dailyIdeaTitle'] as String?,
    slipsThisWeek: json['slipsThisWeek'] as int? ?? 0,
    slipDays: (json['slipDays'] as List<dynamic>?)?.whereType<String>().toList() ?? const [],
    ownZone: json['ownZone'] as String?,
    partnerZone: json['partnerZone'] as String?,
    reunionTitle: json['reunionTitle'] as String?,
    reunionOn: json['reunionOn'] as String?,
  );

  factory fromJsonString(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return HomeWidgetPayload.fromJson(decoded);

    return HomeWidgetPayload.signedOut();
  }

  /// Drops what the person is not entitled to see: partner data without a partner and dates
  /// that already passed.
  HomeWidgetPayload sanitized({DateTime? referenceNow}) {
    final now = referenceNow ?? clock.now();
    if (!isSignedIn) return HomeWidgetPayload.signedOut(now: now);

    final validNextDate = _isUpcoming(nextDateOn, now);
    final validReunion = isPaired && _isUpcoming(reunionOn, now);
    final partnerZoneValue = isPaired ? _nonEmpty(partnerZone) : null;

    return HomeWidgetPayload(
      isSignedIn: true,
      isPaired: isPaired,
      updatedAt: now.toUtc().toIso8601String(),
      theme: theme,
      ownName: _nonEmpty(ownName),
      partnerName: isPaired ? _nonEmpty(partnerName) : null,
      togetherSince: _nonEmpty(togetherSince),
      milestones: milestones.where((milestone) => milestone.title.trim().isNotEmpty).toList(),
      nextDateTitle: validNextDate ? _nonEmpty(nextDateTitle) : null,
      nextDateOn: validNextDate ? nextDateOn : null,
      cardState: cardState,
      cardSendDay: cardSendDay,
      cardSendHour: cardSendHour,
      partnerNote: isPaired ? _nonEmpty(partnerNote) : null,
      partnerNoteAt: isPaired && _nonEmpty(partnerNote) != null ? partnerNoteAt : null,
      partnerMood: isPaired ? partnerMood : null,
      partnerMoodAt: isPaired && partnerMood != null ? partnerMoodAt : null,
      partnerMissedAt: isPaired ? _nonEmpty(partnerMissedAt) : null,
      ritualTitle: _nonEmpty(ritualTitle),
      ritualWeekday: ritualWeekday,
      ritualTime: _nonEmpty(ritualTime),
      dailyIdeaTitle: _nonEmpty(dailyIdeaTitle),
      slipsThisWeek: slipsThisWeek,
      slipDays: slipDays,
      ownZone: _nonEmpty(ownZone),
      partnerZone: partnerZoneValue != null && partnerZoneValue != _nonEmpty(ownZone)
          ? partnerZoneValue
          : null,
      reunionTitle: validReunion ? _nonEmpty(reunionTitle) : null,
      reunionOn: validReunion ? reunionOn : null,
    );
  }

  /// Whether the two people are on different clocks.
  bool get hasDistance => partnerZone != null && ownZone != null;

  /// Whole days together at local midnight of [localNow], or `null` when no date is set.
  int? daysTogetherOn(DateTime localNow) {
    final start = _parseDate(togetherSince);
    if (!isSignedIn || start == null) return null;
    final days = _midnightUtc(localNow).difference(start).inDays;

    return days < 0 ? 0 : days;
  }

  /// Calendar days until [nextDateOn] at local midnight of [localNow].
  int? daysUntilNextDateOn(DateTime localNow) => _daysUntil(nextDateOn, localNow);

  /// Calendar days until [reunionOn] at local midnight of [localNow].
  int? daysUntilReunionOn(DateTime localNow) => _daysUntil(reunionOn, localNow);

  /// Years, months and days between [togetherSince] and [localNow].
  ({int years, int months, int days})? durationOn(DateTime localNow) {
    final start = _parseDate(togetherSince);
    if (start == null) return null;
    final today = DateTime(localNow.year, localNow.month, localNow.day);
    var years = today.year - start.year;
    var months = today.month - start.month;
    var days = today.day - start.day;
    if (days < 0) {
      days += DateTime(today.year, today.month, 0).day;
      months -= 1;
    }
    if (months < 0) {
      months += 12;
      years -= 1;
    }

    return years < 0 ? (years: 0, months: 0, days: 0) : (years: years, months: months, days: days);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'isSignedIn': isSignedIn,
    'isPaired': isPaired,
    'updatedAt': updatedAt,
    'theme': theme.name,
    'ownName': ownName,
    'partnerName': partnerName,
    'togetherSince': togetherSince,
    'milestones': milestones.map((milestone) => milestone.toJson()).toList(),
    'nextDateTitle': nextDateTitle,
    'nextDateOn': nextDateOn,
    'cardState': cardState.name,
    'cardSendDay': cardSendDay,
    'cardSendHour': cardSendHour,
    'partnerNote': partnerNote,
    'partnerNoteAt': partnerNoteAt,
    'partnerMood': partnerMood?.name,
    'partnerMoodAt': partnerMoodAt,
    'partnerMissedAt': partnerMissedAt,
    'ritualTitle': ritualTitle,
    'ritualWeekday': ritualWeekday,
    'ritualTime': ritualTime,
    'dailyIdeaTitle': dailyIdeaTitle,
    'slipsThisWeek': slipsThisWeek,
    'slipDays': slipDays,
    'ownZone': ownZone,
    'partnerZone': partnerZone,
    'reunionTitle': reunionTitle,
    'reunionOn': reunionOn,
  };

  String toJsonString() => jsonEncode(toJson());

  static bool _isUpcoming(String? raw, DateTime now) {
    final days = _daysUntil(raw, now);

    return days != null && days >= 0;
  }

  static int? _daysUntil(String? raw, DateTime localNow) {
    final target = _parseDate(raw);
    if (target == null) return null;
    final days = target.difference(_midnightUtc(localNow)).inDays;

    return days < 0 ? null : days;
  }

  static DateTime _midnightUtc(DateTime local) => DateTime.utc(local.year, local.month, local.day);

  static DateTime? _parseDate(String? raw) {
    final parts = raw?.split('T').first.split('-');
    if (parts == null || parts.length != 3) return null;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    return DateTime.utc(year, month, day);
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();

    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  @override
  List<Object?> get props => [
    isSignedIn,
    isPaired,
    updatedAt,
    theme,
    ownName,
    partnerName,
    togetherSince,
    milestones,
    nextDateTitle,
    nextDateOn,
    cardState,
    cardSendDay,
    cardSendHour,
    partnerNote,
    partnerNoteAt,
    partnerMood,
    partnerMoodAt,
    partnerMissedAt,
    ritualTitle,
    ritualWeekday,
    ritualTime,
    dailyIdeaTitle,
    slipsThisWeek,
    slipDays,
    ownZone,
    partnerZone,
    reunionTitle,
    reunionOn,
  ];
}
