import 'package:app/features/today/data/models/today_home.dart';

/// The blocks Hoje stacks below the header and the one band, in render order.
enum TodayBlock() {
  conflict,
  firstDayCard,
  privateCard,
  mood,
  questionCard,
  nothingReceived,
  weekCard,
  emptyWeekCard,
  inviteCard,
  forToday,
  shareEntry,
}

/// One notice at a time on Hoje, in priority order.
enum TodayBandKind() {
  pendingInvite,
  offline,
  notificationsOff,
}

/// The band Hoje shows: a pending invite, then no connection, then reminders switched off.
TodayBandKind todayBandFor({required TodayHome home, required bool isOffline}) {
  if (home.hasPendingInvite) return TodayBandKind.pendingInvite;
  if (isOffline) return TodayBandKind.offline;

  return TodayBandKind.notificationsOff;
}

/// The blocks Hoje shows for [home], in order and only where there is content to fill them.
///
/// The greeting and the band are not blocks: they always come first. On the first day and while
/// an invite waits, the screen keeps to what the person can do alone; after a fight answer only
/// the repair and the conversation remain.
List<TodayBlock> todayBlocksFor({
  required TodayHome home,
  required bool isFirstDay,
  required bool isInConflict,
  required bool isSoloOnly,
}) {
  if (isInConflict) return const [TodayBlock.conflict];
  if (home.hasPendingInvite) return const [TodayBlock.privateCard];
  if (isFirstDay) {
    return const [TodayBlock.firstDayCard, TodayBlock.weekCard, TodayBlock.forToday];
  }

  final isAlone = !home.isPaired;
  if (isAlone) {
    final canInvite = !isSoloOnly;

    return [
      TodayBlock.mood,
      TodayBlock.weekCard,
      if (canInvite) TodayBlock.inviteCard,
      TodayBlock.forToday,
      if (home.togetherSince != null) TodayBlock.shareEntry,
    ];
  }

  if (home.slipsThisWeek == 0) {
    return const [TodayBlock.mood, TodayBlock.weekCard, TodayBlock.emptyWeekCard];
  }

  return [
    TodayBlock.mood,
    if (home.question != null) TodayBlock.questionCard,
    if (home.question != null && home.unopenedCards == 0 && home.unseenSignals == 0)
      TodayBlock.nothingReceived,
    TodayBlock.weekCard,
    TodayBlock.forToday,
    if (home.togetherSince != null) TodayBlock.shareEntry,
  ];
}
