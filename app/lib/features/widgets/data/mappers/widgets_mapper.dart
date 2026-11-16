import 'package:app/features/mood/data/mappers/mood_enum_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';

extension QueryWidgetOverviewMapper on QueryWidgetOverview {
  WidgetOverview toModel({
    required WidgetContentSource contentSource,
    required WidgetRotationCadence rotationCadence,
    String? cardStatus,
    String? cachedPhotoPath,
    bool hasPhoto = false,
    String? localeCode,
    DateTime? now,
  }) {
    final todayState = today.firstOrNull;
    final settingsState = settings;
    final resolvedLocale = localeCode ?? LocaleSettings.currentLocale.languageCode;

    final profileId = settingsState?.userId ?? todayState?.userId ?? '';
    final showNames = settingsState?.widgetShowNames ?? false;
    final allowPartnerNotes = settingsState?.widgetAllowPartnerNotes ?? false;
    final onLockScreen = settingsState?.widgetOnLockScreen ?? false;
    final isPaired = todayState?.coupleId != null;
    final hasPlus = plusStates.firstOrNull?.hasPlus ?? false;

    final togetherSinceDate = todayState?.togetherSince ?? settingsState?.togetherSince;
    final togetherSince = togetherSinceDate != null ? _formatDateOnly(togetherSinceDate) : null;

    final nextDate = todayState?.nextDateOn;
    final nextDateOn = nextDate != null ? _formatDateOnly(nextDate) : null;
    final nextDateTitle = todayState?.nextDate?.title;

    final unopenedCards = todayState?.unopenedCards ?? 0;
    final cardState = switch ((unopenedCards > 0, cardStatus)) {
      (true, _) => 'ready',
      (false, 'sent') => 'sent',
      (false, 'draft' || 'held') => 'ready',
      _ => 'none',
    };

    final ritualNode = rituals.firstOrNull;
    final ritualSchedule = ritualNode != null
        ? _formatRitualSchedule(
            weekday: ritualNode.weekday,
            atTime: ritualNode.atTime,
            locale: resolvedLocale,
          )
        : null;

    final moodNode = myMood.firstOrNull;
    final partnerNoteNode = partnerNote.firstOrNull;
    final referenceNow = now ?? clock.now();

    final rawPayload = WidgetPayload(
      isSignedIn: true,
      isPaired: isPaired,
      hasPlus: hasPlus,
      showNames: showNames,
      allowPartnerNotes: allowPartnerNotes,
      onLockScreen: onLockScreen,
      isOffline: false,
      togetherSince: togetherSince,
      relationshipPhase: settingsState?.phase?.toModel(),
      partnerName: todayState?.partnerName,
      nextDateTitle: nextDateTitle,
      nextDateOn: nextDateOn,
      unopenedCards: unopenedCards,
      cardState: cardState,
      partnerNote: partnerNoteNode?.body,
      partnerNoteMedia: partnerNoteNode?.mediaFileId,
      partnerNoteAt: partnerNoteNode?.createdAt.toUtc().toIso8601String(),
      partnerMood: partnerMood.firstOrNull?.mood.toModel()?.name,
      myMood: moodNode?.mood.toModel()?.name,
      ritualTitle: ritualNode?.title,
      ritualSchedule: ritualSchedule,
      dailyIdeaTitle: idea.firstOrNull?.title,
      slipsCount: todayState?.slipsTotal ?? todayState?.slipsThisWeek ?? 0,
      cachedPhotoPath: cachedPhotoPath,
      updatedAt: referenceNow.toUtc().toIso8601String(),
    ).sanitized(referenceNow: referenceNow);

    final preferences = WidgetPreferences(
      profileId: profileId,
      showNames: showNames,
      allowPartnerNotes: allowPartnerNotes,
      onLockScreen: onLockScreen,
      contentSource: contentSource,
      rotationCadence: rotationCadence,
    );

    return WidgetOverview(payload: rawPayload, preferences: preferences, hasPhoto: hasPhoto);
  }
}

String _formatDateOnly(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

String? _formatRitualSchedule({required String locale, int? weekday, String? atTime}) {
  const weekdayLabelsPt = <int, String>{
    1: 'Seg',
    2: 'Ter',
    3: 'Qua',
    4: 'Qui',
    5: 'Sex',
    6: 'Sáb',
    7: 'Dom',
  };
  const weekdayLabelsEn = <int, String>{
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };
  final labels = locale.toLowerCase().startsWith('en') ? weekdayLabelsEn : weekdayLabelsPt;
  final dayLabel = weekday != null ? labels[weekday] : null;
  final timeLabel = atTime != null && atTime.length >= 5 ? atTime.substring(0, 5) : atTime;
  return switch ((dayLabel, timeLabel)) {
    (final d?, final t?) when t.isNotEmpty => '$d · $t',
    (final d?, _) => d,
    (null, final t?) when t.isNotEmpty => t,
    _ => null,
  };
}
