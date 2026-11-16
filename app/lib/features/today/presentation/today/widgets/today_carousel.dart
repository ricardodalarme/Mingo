import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/rendering.dart' show OverflowBoxFit;
import 'package:flutter_bloc/flutter_bloc.dart';

/// "Para hoje": the cards that fit the person's moment, swiped as a carousel.
///
/// A single card shows full width. The carousel runs edge to edge, past the screen margins.
class const TodayCarousel({
  required final TodayHome home,
  required final bool isSoloOnly,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final cards = _cards(context);
    if (cards.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpace.s24),
        BaseSectionHeader(title: l10n.forToday),
        const SizedBox(height: AppSpace.s10),
        LayoutBuilder(
          builder: (context, constraints) => OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            minWidth: constraints.maxWidth + AppSpace.screenMargin * 2,
            maxWidth: constraints.maxWidth + AppSpace.screenMargin * 2,
            child: BaseCarousel(children: cards),
          ),
        ),
      ],
    );
  }

  List<Widget> _cards(BuildContext context) {
    final l10n = context.l10n.today;
    final isAlone = !home.isPaired;
    final idea = home.idea;
    final name = home.partnerName;

    return [
      if (isAlone)
        BaseCarouselCard(
          tag: l10n.privateTag,
          title: l10n.privateQuestion,
          supportText: l10n.privateSupport,
          actionText: l10n.answer,
          onAction: () => context.router.root.push(const QuickSlipRoute()),
        ),
      if (isAlone && !isSoloOnly && !home.hasPendingInvite)
        BaseCarouselCard(
          tag: l10n.inviteCardLabel,
          title: l10n.inviteCardTitleNoName,
          supportText: l10n.inviteCardSupport,
          actionText: l10n.inviteCardAction,
          onAction: () => openInvite(context),
        ),
      if (home.unopenedCards > 0)
        BaseCarouselCard(
          tag: l10n.carouselCardTag,
          title: name == null ? l10n.cardReceived : l10n.cardReceivedNamed(name: name),
          supportText: l10n.carouselCardSupport,
          actionText: l10n.carouselCardAction,
          onAction: () async {
            await context.pushRoute(const CardsListRoute());
            if (context.mounted) await context.read<TodayCubit>().load();
          },
        ),
      if (home.slipsThisWeek > 0)
        BaseCarouselCard(
          tag: l10n.weekTag,
          title: l10n.weekReadyTitle,
          supportText: isAlone ? l10n.weekReadySupportPrivate : l10n.weekReadySupport,
          actionText: l10n.weekReadyAction,
          onAction: () => context.pushRoute(const SundayCardRoute()),
        ),
      if (idea != null)
        BaseCarouselCard(
          tag: l10n.ideaLabel,
          title: idea.title,
          supportText: idea.body,
          actionText: l10n.weekReadyAction,
          onAction: () => context.pushRoute(IdeaDetailRoute(slug: idea.slug)),
        ),
    ];
  }
}
