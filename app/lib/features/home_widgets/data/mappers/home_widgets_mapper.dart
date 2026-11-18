import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/queries/generated/HomeWidgetOverview.graphql.dart';
import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/mood/data/mappers/mood_enum_mapper.dart';
import 'package:app/features/profile/data/mappers/account_settings_mapper.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart' show AppThemeVariant;

extension QueryHomeWidgetOverviewMapper on QueryHomeWidgetOverview {
  HomeWidgetPayload toPayload({String? cardStatus, DistanceInfo? distance, DateTime? now}) {
    final referenceNow = now ?? clock.now();
    final todayState = today.firstOrNull;
    final ritual = rituals.firstOrNull;
    final note = partnerNote.firstOrNull;
    final mood = partnerMood.firstOrNull;
    final nextDate = todayState?.nextDateOn;
    final togetherSince = todayState?.togetherSince ?? settings?.togetherSince;
    final reunion = distance?.nextReunion;

    return HomeWidgetPayload(
      isSignedIn: true,
      isPaired: todayState?.coupleId != null,
      updatedAt: referenceNow.toUtc().toIso8601String(),
      theme: settings?.theme.toVariant() ?? AppThemeVariant.rose,
      ownName: me?.displayName,
      partnerName: todayState?.partnerName,
      togetherSince: togetherSince == null ? null : _formatDate(togetherSince),
      milestones: [
        for (final event in milestones.reversed)
          if (event.title case final title?)
            HomeWidgetMilestone(title: title, on: _formatDate(event.happenedOn)),
      ],
      nextDateTitle: todayState?.nextDate?.title,
      nextDateOn: nextDate == null ? null : _formatDate(nextDate),
      cardState: _cardState(unopenedCards: todayState?.unopenedCards ?? 0, status: cardStatus),
      cardSendDay: notificationSettingsByPk?.cardDay,
      cardSendHour: notificationSettingsByPk?.cardHour,
      partnerNote: note?.body,
      partnerNoteAt: note?.createdAt.toUtc().toIso8601String(),
      partnerMood: mood?.mood.toModel(),
      partnerMoodAt: mood?.updatedAt.toUtc().toIso8601String(),
      partnerMissedAt: partnerMiss.firstOrNull?.createdAt.toUtc().toIso8601String(),
      ritualTitle: ritual?.title,
      ritualWeekday: ritual?.weekday,
      ritualTime: _formatTime(ritual?.atTime),
      dailyIdeaTitle: idea.firstOrNull?.title,
      slipsThisWeek: todayState?.slipsThisWeek ?? 0,
      slipDays: todayState?.slipDays?.map(_formatDate).toList() ?? const <String>[],
      ownZone: distance?.own.zone,
      partnerZone: distance?.partner?.zone,
      reunionTitle: distance?.reunionTitle,
      reunionOn: reunion == null ? null : _formatDate(reunion),
    ).sanitized(referenceNow: referenceNow);
  }
}

HomeWidgetCardState _cardState({required int unopenedCards, String? status}) =>
    switch ((unopenedCards > 0, status)) {
      (true, _) => HomeWidgetCardState.ready,
      (false, 'sent') => HomeWidgetCardState.sent,
      (false, 'draft' || 'held') => HomeWidgetCardState.ready,
      _ => HomeWidgetCardState.none,
    };

String _formatDate(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}

String? _formatTime(String? time) {
  if (time == null || time.length < 5) return null;

  return time.substring(0, 5);
}
