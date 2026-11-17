import 'package:app/features/cards/presentation/shared/widgets/week_card.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_help_sheet.dart';
import 'package:app/features/mood/presentation/mood/widgets/today_mood_block.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/conflict_section.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/features/today/presentation/today/widgets/today_band.dart';
import 'package:app/features/today/presentation/today/widgets/today_blocks.dart';
import 'package:app/features/today/presentation/today/widgets/today_header.dart';
import 'package:app/features/today/presentation/today/widgets/today_section.dart';
import 'package:app/features/today/presentation/today/widgets/today_share_entry.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The body of Hoje: the header and one band, then the mood, the question, the week and "Para hoje".
///
/// Each block is only built when the state has content for it, and the state decides what the
/// person can see: alone, waiting for an invite, on the first day, after a fight or with no slips
/// this week.
class const TodayContent({
  required final TodayHome home,
  final String? selfName,
  final String? partnerHint,
  final bool isFirstDay = false,
  final bool isSoloOnly = false,
  final bool isInConflict = false,
  final bool isOffline = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blocks = todayBlocksFor(
      home: home,
      isFirstDay: isFirstDay,
      isInConflict: isInConflict,
      isSoloOnly: isSoloOnly,
    );
    final partnerMood = context.select((MoodCubit cubit) => cubit.state.partnerMood);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final mood = partnerMood?.mood;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TodayHeader(home: home, selfName: selfName, isFirstDay: isFirstDay),
        const SizedBox(height: AppSpace.s20),
        TodayBand(home: home, isOffline: isOffline),
        for (var index = 0; index < blocks.length; index++) ...[
          if (index > 0) SizedBox(height: _gapBefore(blocks[index], previous: blocks[index - 1])),
          _block(
            context,
            blocks[index],
            partnerMood: partnerMood,
            partnerName: partnerName,
            mood: mood,
          ),
        ],
      ],
    );
  }

  double _gapBefore(TodayBlock block, {required TodayBlock previous}) {
    if (previous == TodayBlock.mood) return 0;

    return switch (block) {
      TodayBlock.conflict || TodayBlock.firstDayCard || TodayBlock.mood => 0,
      TodayBlock.nothingReceived ||
      TodayBlock.questionCard ||
      TodayBlock.weekCard ||
      TodayBlock.emptyWeekCard ||
      TodayBlock.inviteCard => AppSpace.s12,
      TodayBlock.forToday => AppSpace.s24,
      TodayBlock.shareEntry => AppSpace.s24,
    };
  }

  Widget _block(
    BuildContext context,
    TodayBlock block, {
    required PartnerMood? partnerMood,
    required String? partnerName,
    required MoodKind? mood,
  }) {
    final l10n = context.l10n.today;

    return switch (block) {
      TodayBlock.conflict => const ConflictSection(),
      TodayBlock.firstDayCard => _MainCard(home: home, isFirstDay: true),
      TodayBlock.mood => TodayMoodBlock(isFirstDay: isFirstDay),
      TodayBlock.questionCard => _MainCard(home: home, isFirstDay: false),
      TodayBlock.nothingReceived => BaseNote(text: l10n.nothingReceived, icon: AppIcons.info),
      TodayBlock.emptyWeekCard => BaseFeatureCard(
        tag: l10n.emptyWeekTag,
        question: l10n.emptyWeekQuestion,
        highlightedWord: l10n.emptyWeekHighlight,
        face: FaceKind.thinking,
        actionText: l10n.emptyWeekAction,
        onAction: () => _openCapture(context),
      ),
      TodayBlock.weekCard => _Week(
        home: home,
        title: _countsCard ? l10n.slipsThisWeek(count: home.slipsThisWeek) : l10n.privateWeekTitle,
        supportText: _countsCard ? _weekSupport(context) : _privateWeekSupport(context),
      ),
      TodayBlock.inviteCard => BaseListCard(
        categoryLabel: l10n.inviteCardLabel,
        category: AppCategory.invite,
        title: partnerHint == null
            ? l10n.inviteCardTitleNoName
            : l10n.inviteCardTitle(name: partnerHint!),
        supportText: l10n.inviteCardSupport,
        onTap: () => openInvite(context),
      ),
      TodayBlock.forToday => TodaySection(
        home: home,
        isSoloOnly: isSoloOnly,
        isFirstDay: isFirstDay,
        partnerHint: partnerHint,
        partnerMood: partnerMood,
        partnerName: partnerName,
        onSeeIdeas: mood == null
            ? null
            : () => openPartnerMoodHelp(
                context,
                mood: mood,
                onSendMessage: () => context.read<MoodCubit>().sendSweetMessage(
                  context.l10n.moodHelp.sweetMessageBody,
                ),
              ),
      ),
      TodayBlock.shareEntry => TodayShareEntry(home: home),
    };
  }

  /// The first day draws the shared week even alone: the card explains what a slip becomes.
  bool get _countsCard => home.isPaired || isFirstDay;

  String _weekSupport(BuildContext context) {
    final l10n = context.l10n.today;
    if (home.slipsThisWeek == 0) return l10n.weekHintEmpty;

    return l10n.weekHint;
  }

  String _privateWeekSupport(BuildContext context) {
    final l10n = context.l10n.today;
    if (home.slipsThisWeek == 0) return l10n.weekHintEmpty;

    return l10n.privateWeekCount(count: home.slipsThisWeek);
  }

  void _openCapture(BuildContext context) => context.router.root.push(const QuickSlipRoute());
}

class const _MainCard({required final TodayHome home, required final bool isFirstDay})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;

    if (isFirstDay) {
      return BaseFeatureCard(
        tag: l10n.firstDayTag,
        question: l10n.firstDayTitle(count: home.slipsTotal),
        highlightedWord: l10n.firstDayHighlight(count: home.slipsTotal),
        supportText: l10n.firstDayText,
        actionText: l10n.firstDayAction,
        face: FaceKind.smile,
        onAction: () => context.router.root.push(const QuickSlipRoute()),
      );
    }
    final question = home.question;
    if (question == null) return const SizedBox.shrink();

    return BaseFeatureCard(
      tag: l10n.questionTag,
      question: question.title,
      highlightedWord: _longestWord(question.title),
      face: FaceKind.smile,
      actionText: l10n.answer,
      onAction: () => context.router.root.push(const QuickSlipRoute()),
    );
  }

  String _longestWord(String text) {
    final words = text.replaceAll(RegExp('[?.!,]'), '').split(' ');

    return words.reduce((a, b) => b.length > a.length ? b : a);
  }
}

class const _Week({
  required final TodayHome home,
  required final String title,
  required final String supportText,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final today = home.localDate ?? clock.now();
    final day = DateTime(today.year, today.month, today.day);
    final weekStart = day.subtract(Duration(days: today.weekday - DateTime.monday));
    final dayCounts = List<int>.filled(7, 0);
    for (final slipDay in home.slipDays) {
      final index = DateTime(slipDay.year, slipDay.month, slipDay.day).difference(weekStart).inDays;
      if (index >= 0 && index < 7) dayCounts[index]++;
    }

    return WeekCard(
      title: title,
      supportText: supportText,
      dayCounts: dayCounts,
      dayLabels: [for (final weekday in l10n.weekdays) weekday.substring(0, 3)],
      todayIndex: today.weekday - 1,
    );
  }
}
