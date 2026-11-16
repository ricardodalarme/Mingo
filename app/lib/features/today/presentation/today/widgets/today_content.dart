import 'package:app/features/cards/presentation/shared/widgets/week_card.dart';
import 'package:app/features/mood/presentation/mood/widgets/today_mood_block.dart';
import 'package:app/features/notifications/presentation/off_banner/widgets/notifications_off_banner.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/features/today/presentation/today/widgets/today_carousel.dart';
import 'package:app/features/today/presentation/today/widgets/today_header.dart';
import 'package:app/features/today/presentation/today/widgets/today_share_entry.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The home-driven body of Hoje: header, mood, the main card, the week so far and "Para hoje".
///
/// The main card follows the person's state: the question when connected and a welcome on the
/// first day. On their own the person sees the invite entry and a code shortcut instead.
class const TodayContent({
  required final TodayHome home,
  final String? selfName,
  final String? partnerHint,
  final bool isFirstDay = false,
  final bool isSoloOnly = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAlone = !home.isPaired;
    final canInvite = isAlone && !isSoloOnly;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _TopSection(home: home, selfName: selfName, isFirstDay: isFirstDay),
        if (canInvite && !home.hasPendingInvite) ...[
          const SizedBox(height: AppSpace.s12),
          BaseListCard(
            categoryLabel: context.l10n.today.inviteCardLabel,
            category: AppCategory.invite,
            title: partnerHint == null
                ? context.l10n.today.inviteCardTitleNoName
                : context.l10n.today.inviteCardTitle(name: partnerHint!),
            supportText: context.l10n.today.inviteCardText,
            onTap: () => openInvite(context),
          ),
        ],
        if (isFirstDay)
          _FirstDayIdea(idea: home.idea)
        else
          TodayCarousel(home: home, isSoloOnly: isSoloOnly),
        if (canInvite) const _HaveCodeButton(),
        TodayShareEntry(home: home),
      ],
    );
  }
}

class const _TopSection({
  required final TodayHome home,
  required final String? selfName,
  required final bool isFirstDay,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final isAlone = !home.isPaired;
    final today = home.localDate ?? clock.now();
    final weekStart = DateTime(
      today.year,
      today.month,
      today.day,
    ).subtract(Duration(days: today.weekday - DateTime.monday));
    final weekCounts = List<int>.filled(7, 0);
    for (final day in home.slipDays) {
      final index = DateTime(day.year, day.month, day.day).difference(weekStart).inDays;
      if (index >= 0 && index < 7) weekCounts[index]++;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TodayHeader(home: home, selfName: selfName, isFirstDay: isFirstDay),
        const SizedBox(height: AppSpace.s20),
        const NotificationsOffBanner(),
        if (home.unseenSignals > 0) ...[
          BaseBanner(
            text: l10n.signalReceived,
            icon: AppIcons.mail,
            actionLabel: l10n.signalReceivedAction,
            onAction: () async {
              await context.pushRoute(const ReceivedSignalsRoute());
              if (context.mounted) await context.read<TodayCubit>().load();
            },
          ),
          const SizedBox(height: AppSpace.s12),
        ],
        if (home.hasPendingInvite) ...[
          BaseListCard(
            category: AppCategory.invite,
            categoryLabel: l10n.pendingInviteTitle,
            title: l10n.pendingInviteText,
            supportText: l10n.pendingInviteAction,
            onTap: () => openInvite(context),
          ),
          const SizedBox(height: AppSpace.s12),
        ],
        TodayMoodBlock(isFirstDay: isFirstDay, hasPendingInvite: home.hasPendingInvite),
        if (!isAlone || isFirstDay) _MainCard(home: home, isFirstDay: isFirstDay),
        if (!home.hasPendingInvite) ...[
          const SizedBox(height: AppSpace.s16),
          WeekCard(
            title: isAlone ? l10n.privateWeekTitle : l10n.slipsThisWeek(count: home.slipsThisWeek),
            supportText: isAlone
                ? l10n.privateWeekCount(count: home.slipsThisWeek)
                : home.slipsThisWeek == 0
                ? l10n.weekHintEmpty
                : today.weekday == DateTime.sunday
                ? l10n.weekHintToday
                : l10n.weekHint,
            dayCounts: weekCounts,
            dayLabels: [for (final day in l10n.weekdays) day.substring(0, 3)],
            todayIndex: today.weekday - 1,
          ),
        ],
        if (home.isPaired && home.unopenedCards == 0 && home.slipsThisWeek > 0) ...[
          const SizedBox(height: AppSpace.s10),
          Center(
            child: Text(
              l10n.nothingReceived,
              style: context.text.caption.copyWith(color: context.colors.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}

class const _FirstDayIdea({required final Suggestion? idea}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final suggestion = idea;
    if (suggestion == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpace.s24),
        BaseSectionHeader(title: l10n.forToday),
        const SizedBox(height: AppSpace.s10),
        BaseListCard(
          categoryLabel: l10n.ideaLabel,
          category: AppCategory.idea,
          title: suggestion.title,
          supportText: suggestion.body,
          face: FaceKind.smile,
          onTap: () => context.pushRoute(IdeaDetailRoute(slug: suggestion.slug)),
        ),
      ],
    );
  }
}

class const _HaveCodeButton() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.s16),
      child: BaseButton(
        text: context.l10n.today.haveCode,
        variant: .secondary,
        onPressed: () => context.pushRoute(AcceptInviteRoute()),
      ),
    );
  }
}

class const _MainCard({required final TodayHome home, required final bool isFirstDay})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    void openCapture() => context.router.root.push(const QuickSlipRoute());

    if (isFirstDay) {
      return BaseFeatureCard(
        tag: l10n.firstDayTag,
        question: l10n.firstDayTitle(count: home.slipsTotal),
        highlightedWord: l10n.firstDayHighlight(count: home.slipsTotal),
        supportText: l10n.firstDayText,
        actionText: l10n.firstDayAction,
        onAction: openCapture,
      );
    }
    if (home.slipsThisWeek == 0) {
      return BaseFeatureCard(
        tag: l10n.emptyWeekTag,
        question: l10n.emptyWeekQuestion,
        highlightedWord: l10n.emptyWeekHighlight,
        face: FaceKind.thinking,
        actionText: l10n.emptyWeekAction,
        onAction: openCapture,
      );
    }
    final question = home.question;
    if (question == null) return const SizedBox.shrink();

    return BaseFeatureCard(
      tag: question.tags.isEmpty ? l10n.forToday : question.tags.first,
      question: question.title,
      highlightedWord: _longestWord(question.title),
      face: FaceKind.smile,
      actionText: l10n.answer,
      onAction: openCapture,
    );
  }

  String _longestWord(String text) {
    final words = text.replaceAll(RegExp('[?.!,]'), '').split(' ');

    return words.reduce((a, b) => b.length > a.length ? b : a);
  }
}
