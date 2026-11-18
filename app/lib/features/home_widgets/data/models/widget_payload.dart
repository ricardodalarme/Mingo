import 'dart:convert';

import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart' show Skeletonizer;
import 'package:equatable/equatable.dart';

/// Breakdown of the relationship duration at local midnight.
typedef TogetherDurationBreakdown = ({int years, int months, int days, int totalDays});

/// Compact JSON payload stored in the shared native store for iOS WidgetKit and Android AppWidgets.
final class const WidgetPayload({
  required final bool isSignedIn,
  required final bool isPaired,
  required final bool hasPlus,
  required final bool showNames,
  required final bool allowPartnerNotes,
  required final bool onLockScreen,
  required final bool isOffline,
  required final int unopenedCards,
  required final String cardState,
  required final int slipsCount,
  required final String updatedAt,
  final String? togetherSince,
  final RelationshipPhase? relationshipPhase,
  final String? partnerName,
  final String? nextDateTitle,
  final String? nextDateOn,
  final String? partnerNote,
  final String? partnerNoteMedia,
  final String? partnerNoteAt,
  final String? partnerMood,
  final String? partnerMoodAt,
  final String? partnerMissedAt,
  final String? myMood,
  final String? ritualTitle,
  final String? ritualSchedule,
  final String? dailyIdeaTitle,
  final String? suggestionKey,
  final String? cachedPhotoPath,
  final String? ownName,
  final int slipsThisWeek = 0,
  final List<String> slipDays = const <String>[],
  final int? cardSendDay,
  final int? cardSendHour,
  final String? ownZone,
  final String? partnerZone,
  final String? ownLocalTime,
  final String? partnerLocalTime,
  final String? reunionTitle,
  final String? reunionOn,
  final int? reunionDays,
}) with Equatable {
  /// Neutral payload written when the user is signed out so no previous account data remains.
  factory signedOut({DateTime? now}) => WidgetPayload(
    isSignedIn: false,
    isPaired: false,
    hasPlus: false,
    showNames: false,
    allowPartnerNotes: false,
    onLockScreen: false,
    isOffline: false,
    unopenedCards: 0,
    cardState: 'none',
    slipsCount: 0,
    updatedAt: (now ?? clock.now().toUtc()).toUtc().toIso8601String(),
  );

  /// Placeholder payload used only by [Skeletonizer] while loading.
  factory fake() => const WidgetPayload(
    isSignedIn: true,
    isPaired: true,
    hasPlus: true,
    showNames: true,
    allowPartnerNotes: true,
    onLockScreen: false,
    isOffline: false,
    togetherSince: '2024-02-14',
    relationshipPhase: RelationshipPhase.dating,
    partnerName: 'Marina',
    nextDateTitle: 'Aniversário',
    nextDateOn: '2026-11-23',
    unopenedCards: 1,
    cardState: 'ready',
    slipsCount: 4,
    partnerNote: 'Boa sorte na reunião!',
    partnerNoteAt: '2026-11-11T09:00:00.000Z',
    partnerMood: 'loving',
    partnerMoodAt: '2026-11-11T10:00:00.000Z',
    partnerMissedAt: '2026-11-10T22:00:00.000Z',
    myMood: 'happy',
    ritualTitle: 'Caminhada de domingo',
    ritualSchedule: 'Dom · 10:00',
    dailyIdeaTitle: 'Deixe um bilhete na marmita dele',
    suggestionKey: 'write_slip',
    ownName: 'Luanna',
    slipsThisWeek: 3,
    slipDays: ['2026-11-09', '2026-11-10', '2026-11-11'],
    cardSendDay: 6,
    cardSendHour: 18,
    ownZone: 'America/Sao_Paulo',
    partnerZone: 'Europe/Lisbon',
    ownLocalTime: '19:40',
    partnerLocalTime: '22:40',
    reunionTitle: 'Viagem',
    reunionOn: '2026-12-23',
    reunionDays: 42,
    updatedAt: '2026-11-11T12:00:00.000Z',
  );

  factory fromJson(Map<String, dynamic> json) => WidgetPayload(
    isSignedIn: json['isSignedIn'] as bool? ?? false,
    isPaired: json['isPaired'] as bool? ?? false,
    hasPlus: json['hasPlus'] as bool? ?? false,
    showNames: json['showNames'] as bool? ?? false,
    allowPartnerNotes: json['allowPartnerNotes'] as bool? ?? false,
    onLockScreen: json['onLockScreen'] as bool? ?? false,
    isOffline: json['isOffline'] as bool? ?? false,
    togetherSince: json['togetherSince'] as String?,
    relationshipPhase: RelationshipPhase.values.asNameMap()[json['relationshipPhase'] as String?],
    partnerName: json['partnerName'] as String?,
    nextDateTitle: json['nextDateTitle'] as String?,
    nextDateOn: json['nextDateOn'] as String?,
    unopenedCards: json['unopenedCards'] as int? ?? 0,
    cardState: json['cardState'] as String? ?? 'none',
    partnerNote: json['partnerNote'] as String?,
    partnerNoteMedia: json['partnerNoteMedia'] as String?,
    partnerNoteAt: json['partnerNoteAt'] as String?,
    partnerMood: json['partnerMood'] as String?,
    partnerMoodAt: json['partnerMoodAt'] as String?,
    partnerMissedAt: json['partnerMissedAt'] as String?,
    myMood: json['myMood'] as String?,
    ritualTitle: json['ritualTitle'] as String?,
    ritualSchedule: json['ritualSchedule'] as String?,
    dailyIdeaTitle: json['dailyIdeaTitle'] as String?,
    slipsCount: json['slipsCount'] as int? ?? 0,
    suggestionKey: json['suggestionKey'] as String?,
    cachedPhotoPath: json['cachedPhotoPath'] as String?,
    ownName: json['ownName'] as String?,
    slipsThisWeek: json['slipsThisWeek'] as int? ?? 0,
    slipDays:
        (json['slipDays'] as List<dynamic>?)?.whereType<String>().toList() ?? const <String>[],
    cardSendDay: json['cardSendDay'] as int?,
    cardSendHour: json['cardSendHour'] as int?,
    ownZone: json['ownZone'] as String?,
    partnerZone: json['partnerZone'] as String?,
    ownLocalTime: json['ownLocalTime'] as String?,
    partnerLocalTime: json['partnerLocalTime'] as String?,
    reunionTitle: json['reunionTitle'] as String?,
    reunionOn: json['reunionOn'] as String?,
    reunionDays: json['reunionDays'] as int?,
    updatedAt: json['updatedAt'] as String? ?? '',
  );

  factory fromJsonString(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return WidgetPayload.fromJson(decoded);
    }
    return WidgetPayload.signedOut();
  }

  /// Applies privacy, pairing, Plus, and date-expiration rules before persisting.
  WidgetPayload sanitized({DateTime? referenceNow}) {
    final now = referenceNow ?? clock.now();
    if (!isSignedIn) {
      return WidgetPayload.signedOut(now: now);
    }

    final rawDaysUntilDate = _daysUntilDateString(nextDateOn, now);
    final validDateOn = rawDaysUntilDate != null && rawDaysUntilDate >= 0 ? nextDateOn : null;
    final validDateTitle = validDateOn != null ? _nonEmpty(nextDateTitle) : null;

    final resolvedPartnerName = isPaired && showNames ? _nonEmpty(partnerName) : null;
    final resolvedOwnName = showNames ? _nonEmpty(ownName) : null;
    final resolvedNote = isPaired && allowPartnerNotes ? _nonEmpty(partnerNote) : null;
    final resolvedNoteMedia = isPaired && allowPartnerNotes ? _nonEmpty(partnerNoteMedia) : null;
    final resolvedNoteAt = (resolvedNote != null || resolvedNoteMedia != null)
        ? partnerNoteAt
        : null;
    final resolvedPhotoPath = isPaired && hasPlus ? _nonEmpty(cachedPhotoPath) : null;
    final resolvedUnopenedCards = isPaired ? unopenedCards : 0;
    final resolvedMood = isPaired ? _nonEmpty(partnerMood) : null;
    final resolvedPartnerZone = isPaired ? _nonEmpty(partnerZone) : null;
    final resolvedOwnZone = _nonEmpty(ownZone);
    final resolvedDistance =
        resolvedPartnerZone != null &&
            resolvedOwnZone != null &&
            resolvedPartnerZone != resolvedOwnZone
        ? (
            partnerZone: resolvedPartnerZone,
            ownZone: resolvedOwnZone,
            ownLocalTime: _nonEmpty(ownLocalTime),
            partnerLocalTime: _nonEmpty(partnerLocalTime),
            reunionTitle: _nonEmpty(reunionTitle),
            reunionOn: _futureDate(reunionOn, now),
            reunionDays: reunionDays != null && reunionDays! >= 0 ? reunionDays : null,
          )
        : null;

    final resolvedCardState = switch ((isPaired, cardState)) {
      (false, _) => 'none',
      (true, 'ready' || 'sent' || 'none') => resolvedUnopenedCards > 0 ? 'ready' : cardState,
      _ => resolvedUnopenedCards > 0 ? 'ready' : 'none',
    };

    return WidgetPayload(
      isSignedIn: true,
      isPaired: isPaired,
      hasPlus: hasPlus,
      showNames: showNames,
      allowPartnerNotes: allowPartnerNotes,
      onLockScreen: onLockScreen,
      isOffline: isOffline,
      togetherSince: _nonEmpty(togetherSince),
      relationshipPhase: relationshipPhase,
      partnerName: resolvedPartnerName,
      ownName: resolvedOwnName,
      nextDateTitle: validDateTitle,
      nextDateOn: validDateOn,
      unopenedCards: resolvedUnopenedCards,
      cardState: resolvedCardState,
      partnerNote: resolvedNote,
      partnerNoteMedia: resolvedNoteMedia,
      partnerNoteAt: resolvedNoteAt,
      partnerMood: resolvedMood,
      partnerMoodAt: resolvedMood != null ? partnerMoodAt : null,
      partnerMissedAt: isPaired ? _nonEmpty(partnerMissedAt) : null,
      myMood: _nonEmpty(myMood),
      ritualTitle: _nonEmpty(ritualTitle),
      ritualSchedule: _nonEmpty(ritualSchedule),
      dailyIdeaTitle: _nonEmpty(dailyIdeaTitle),
      slipsCount: slipsCount,
      slipsThisWeek: slipsThisWeek,
      slipDays: slipDays,
      suggestionKey: _nonEmpty(suggestionKey),
      cachedPhotoPath: resolvedPhotoPath,
      cardSendDay: isPaired ? cardSendDay : null,
      cardSendHour: isPaired ? cardSendHour : null,
      ownZone: resolvedOwnZone,
      partnerZone: resolvedDistance?.partnerZone,
      ownLocalTime: resolvedDistance?.ownLocalTime,
      partnerLocalTime: resolvedDistance?.partnerLocalTime,
      reunionTitle: resolvedDistance?.reunionTitle,
      reunionOn: resolvedDistance?.reunionOn,
      reunionDays: resolvedDistance?.reunionDays,
      updatedAt: now.toUtc().toIso8601String(),
    );
  }

  /// The partner name a widget may show, honoring the names setting.
  String? get visiblePartnerName {
    if (!isPaired || !showNames) return null;
    return _nonEmpty(partnerName);
  }

  /// The viewer's own name a widget may show, honoring the names setting.
  String? get visibleOwnName => showNames ? _nonEmpty(ownName) : null;

  /// The partner note a widget may show, honoring the notes setting.
  String? get visiblePartnerNote {
    if (!isPaired || !allowPartnerNotes) return null;
    return _nonEmpty(partnerNote);
  }

  /// The partner mood a widget may show; only a mood the partner shared arrives.
  MoodKind? get visiblePartnerMood {
    if (!isPaired) return null;
    return MoodKind.values.asNameMap()[partnerMood];
  }

  /// When the shared partner mood was last updated.
  DateTime? get partnerMoodAtTime => DateTime.tryParse(partnerMoodAt ?? '')?.toLocal();

  /// When the partner last sent a "miss us" signal.
  DateTime? get partnerMissedAtTime => DateTime.tryParse(partnerMissedAt ?? '')?.toLocal();

  /// When the partner note arrived.
  DateTime? get partnerNoteAtTime => DateTime.tryParse(partnerNoteAt ?? '')?.toLocal();

  /// Whether both people are on different clocks and a distance widget makes sense.
  bool get hasDistance => isPaired && _nonEmpty(partnerZone) != null && partnerZone != ownZone;

  /// Exact days together at local midnight for [localNow], or `null` when unset.
  int? daysTogetherOn(DateTime localNow) {
    if (!isSignedIn) return null;
    final start = _parseLocalDate(togetherSince);
    if (start == null) return null;
    final today = DateTime.utc(localNow.year, localNow.month, localNow.day);
    final startUtc = DateTime.utc(start.year, start.month, start.day);
    final diff = today.difference(startUtc).inDays;
    return diff < 0 ? 0 : diff;
  }

  /// Years, months, days, and total days together at local midnight for [localNow].
  TogetherDurationBreakdown? durationBreakdownOn(DateTime localNow) {
    final total = daysTogetherOn(localNow);
    final start = _parseLocalDate(togetherSince);
    if (total == null || start == null) return null;

    final today = DateTime(localNow.year, localNow.month, localNow.day);
    var years = today.year - start.year;
    var months = today.month - start.month;
    var days = today.day - start.day;

    if (days < 0) {
      final previousMonth = DateTime(today.year, today.month, 0);
      days += previousMonth.day;
      months -= 1;
    }
    if (months < 0) {
      months += 12;
      years -= 1;
    }
    if (years < 0) {
      return (years: 0, months: 0, days: 0, totalDays: 0);
    }
    return (years: years, months: months, days: days, totalDays: total);
  }

  /// Calendar days until [nextDateOn] at local midnight for [localNow].
  int? daysUntilNextDateOn(DateTime localNow) {
    if (!isSignedIn) return null;
    final days = _daysUntilDateString(nextDateOn, localNow);
    return days != null && days >= 0 ? days : null;
  }

  WidgetPayload copyWith({
    bool? isSignedIn,
    bool? isPaired,
    bool? hasPlus,
    bool? showNames,
    bool? allowPartnerNotes,
    bool? onLockScreen,
    bool? isOffline,
    String? togetherSince,
    RelationshipPhase? relationshipPhase,
    String? partnerName,
    String? nextDateTitle,
    String? nextDateOn,
    int? unopenedCards,
    String? cardState,
    String? partnerNote,
    String? partnerNoteMedia,
    String? partnerNoteAt,
    String? partnerMood,
    String? partnerMoodAt,
    String? partnerMissedAt,
    String? myMood,
    String? ritualTitle,
    String? ritualSchedule,
    String? dailyIdeaTitle,
    int? slipsCount,
    String? suggestionKey,
    String? cachedPhotoPath,
    String? ownName,
    int? slipsThisWeek,
    List<String>? slipDays,
    int? cardSendDay,
    int? cardSendHour,
    String? ownZone,
    String? partnerZone,
    String? ownLocalTime,
    String? partnerLocalTime,
    String? reunionTitle,
    String? reunionOn,
    int? reunionDays,
    String? updatedAt,
  }) => WidgetPayload(
    isSignedIn: isSignedIn ?? this.isSignedIn,
    isPaired: isPaired ?? this.isPaired,
    hasPlus: hasPlus ?? this.hasPlus,
    showNames: showNames ?? this.showNames,
    allowPartnerNotes: allowPartnerNotes ?? this.allowPartnerNotes,
    onLockScreen: onLockScreen ?? this.onLockScreen,
    isOffline: isOffline ?? this.isOffline,
    togetherSince: togetherSince ?? this.togetherSince,
    relationshipPhase: relationshipPhase ?? this.relationshipPhase,
    partnerName: partnerName ?? this.partnerName,
    nextDateTitle: nextDateTitle ?? this.nextDateTitle,
    nextDateOn: nextDateOn ?? this.nextDateOn,
    unopenedCards: unopenedCards ?? this.unopenedCards,
    cardState: cardState ?? this.cardState,
    partnerNote: partnerNote ?? this.partnerNote,
    partnerNoteMedia: partnerNoteMedia ?? this.partnerNoteMedia,
    partnerNoteAt: partnerNoteAt ?? this.partnerNoteAt,
    partnerMood: partnerMood ?? this.partnerMood,
    partnerMoodAt: partnerMoodAt ?? this.partnerMoodAt,
    partnerMissedAt: partnerMissedAt ?? this.partnerMissedAt,
    myMood: myMood ?? this.myMood,
    ritualTitle: ritualTitle ?? this.ritualTitle,
    ritualSchedule: ritualSchedule ?? this.ritualSchedule,
    dailyIdeaTitle: dailyIdeaTitle ?? this.dailyIdeaTitle,
    slipsCount: slipsCount ?? this.slipsCount,
    suggestionKey: suggestionKey ?? this.suggestionKey,
    cachedPhotoPath: cachedPhotoPath ?? this.cachedPhotoPath,
    ownName: ownName ?? this.ownName,
    slipsThisWeek: slipsThisWeek ?? this.slipsThisWeek,
    slipDays: slipDays ?? this.slipDays,
    cardSendDay: cardSendDay ?? this.cardSendDay,
    cardSendHour: cardSendHour ?? this.cardSendHour,
    ownZone: ownZone ?? this.ownZone,
    partnerZone: partnerZone ?? this.partnerZone,
    ownLocalTime: ownLocalTime ?? this.ownLocalTime,
    partnerLocalTime: partnerLocalTime ?? this.partnerLocalTime,
    reunionTitle: reunionTitle ?? this.reunionTitle,
    reunionOn: reunionOn ?? this.reunionOn,
    reunionDays: reunionDays ?? this.reunionDays,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'isSignedIn': isSignedIn,
    'isPaired': isPaired,
    'hasPlus': hasPlus,
    'showNames': showNames,
    'allowPartnerNotes': allowPartnerNotes,
    'onLockScreen': onLockScreen,
    'isOffline': isOffline,
    'togetherSince': togetherSince,
    'relationshipPhase': relationshipPhase?.name,
    'partnerName': partnerName,
    'nextDateTitle': nextDateTitle,
    'nextDateOn': nextDateOn,
    'unopenedCards': unopenedCards,
    'cardState': cardState,
    'partnerNote': partnerNote,
    'partnerNoteMedia': partnerNoteMedia,
    'partnerNoteAt': partnerNoteAt,
    'partnerMood': partnerMood,
    'partnerMoodAt': partnerMoodAt,
    'partnerMissedAt': partnerMissedAt,
    'myMood': myMood,
    'ritualTitle': ritualTitle,
    'ritualSchedule': ritualSchedule,
    'dailyIdeaTitle': dailyIdeaTitle,
    'slipsCount': slipsCount,
    'slipsThisWeek': slipsThisWeek,
    'slipDays': slipDays,
    'suggestionKey': suggestionKey,
    'cachedPhotoPath': cachedPhotoPath,
    'ownName': ownName,
    'cardSendDay': cardSendDay,
    'cardSendHour': cardSendHour,
    'ownZone': ownZone,
    'partnerZone': partnerZone,
    'ownLocalTime': ownLocalTime,
    'partnerLocalTime': partnerLocalTime,
    'reunionTitle': reunionTitle,
    'reunionOn': reunionOn,
    'reunionDays': reunionDays,
    'updatedAt': updatedAt,
  };

  String toJsonString() => jsonEncode(toJson());

  static int? _daysUntilDateString(String? rawDate, DateTime localNow) {
    final target = _parseLocalDate(rawDate);
    if (target == null) return null;
    final today = DateTime.utc(localNow.year, localNow.month, localNow.day);
    final targetUtc = DateTime.utc(target.year, target.month, target.day);
    return targetUtc.difference(today).inDays;
  }

  static String? _futureDate(String? rawDate, DateTime localNow) {
    final days = _daysUntilDateString(rawDate, localNow);
    return days != null && days >= 0 ? rawDate : null;
  }

  static DateTime? _parseLocalDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final datePart = raw.split('T').first;
    final parts = datePart.split('-');
    if (parts.length != 3) return null;
    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;
    return DateTime(year, month, day);
  }

  static String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }

  @override
  List<Object?> get props => [
    isSignedIn,
    isPaired,
    hasPlus,
    showNames,
    allowPartnerNotes,
    onLockScreen,
    isOffline,
    togetherSince,
    relationshipPhase,
    partnerName,
    nextDateTitle,
    nextDateOn,
    unopenedCards,
    cardState,
    partnerNote,
    partnerNoteMedia,
    partnerNoteAt,
    partnerMood,
    partnerMoodAt,
    partnerMissedAt,
    myMood,
    ritualTitle,
    ritualSchedule,
    dailyIdeaTitle,
    slipsCount,
    slipsThisWeek,
    slipDays,
    suggestionKey,
    cachedPhotoPath,
    ownName,
    cardSendDay,
    cardSendHour,
    ownZone,
    partnerZone,
    ownLocalTime,
    partnerLocalTime,
    reunionTitle,
    reunionOn,
    reunionDays,
    updatedAt,
  ];
}
