import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_hint.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/cubit/today_cubit.dart';
import 'package:app/features/today/presentation/today/widgets/open_invite.dart';
import 'package:app/features/today/presentation/today/widgets/today_cards.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/rendering.dart' show OverflowBoxFit;
import 'package:flutter_bloc/flutter_bloc.dart';

/// "Para hoje": the cards that fit the person's moment, in the board's fixed order.
///
/// One card shows as a row, full width. Two or more become a carousel that runs edge to edge,
/// past the screen margins.
class const TodaySection({
  required final TodayHome home,
  required final bool isSoloOnly,
  final bool isFirstDay = false,
  final String? partnerHint,
  final PartnerMood? partnerMood,
  final String? partnerName,
  final VoidCallback? onSeeIdeas,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.today;
    final kinds = todayCardsFor(
      home: home,
      isSoloOnly: isSoloOnly,
      partnerMoodVisible: partnerMood?.isVisible ?? false,
      isFirstDay: isFirstDay,
    );
    if (kinds.isEmpty) return const SizedBox.shrink();

    final isSingle = kinds.length == 1;
    final cards = [for (final kind in kinds) _card(context, kind, isSingle: isSingle)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseSectionHeader(title: l10n.forToday),
        const SizedBox(height: AppSpace.s10),
        if (cards.length == 1)
          cards.first
        else
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

  Widget _card(BuildContext context, TodayCardKind kind, {required bool isSingle}) {
    final copy = _copyFor(context, kind);
    final action = _actionFor(context, kind);

    if (isSingle) {
      return BaseListCard(
        categoryLabel: copy.tag,
        category: copy.category,
        title: copy.title,
        supportText: copy.support,
        face: copy.face,
        onTap: action,
      );
    }

    return BaseCarouselCard(
      tag: copy.tag,
      title: copy.title,
      supportText: copy.support,
      actionText: copy.action,
      onAction: action,
    );
  }

  ({String tag, String title, String? support, String action, AppCategory category, FaceKind? face})
  _copyFor(BuildContext context, TodayCardKind kind) {
    final l10n = context.l10n.today;
    final name = home.partnerName;
    final mood = partnerMood?.mood;

    return switch (kind) {
      TodayCardKind.receivedCard => (
        tag: l10n.carouselCardTag,
        title: name == null ? l10n.cardReceived : l10n.cardReceivedNamed(name: name),
        support: l10n.carouselCardSupport,
        action: l10n.carouselCardAction,
        category: AppCategory.card,
        face: FaceKind.smile,
      ),
      TodayCardKind.ownCard => (
        tag: l10n.sundayCardLabel,
        title: l10n.sundayCardTitle,
        support: context.l10n.sundayCard.openFromToday,
        action: l10n.weekReadyAction,
        category: AppCategory.card,
        face: FaceKind.smile,
      ),
      TodayCardKind.partnerMoment => (
        tag: l10n.partnerMomentTag,
        title: mood == null ? '' : partnerMoodLine(context, mood, partnerName: partnerName),
        support: l10n.partnerMomentSupport,
        action: l10n.partnerMomentAction,
        category: AppCategory.card,
        face: FaceKind.smile,
      ),
      TodayCardKind.invite => (
        tag: l10n.inviteCardLabel,
        title: partnerHint == null
            ? l10n.inviteCardTitleNoName
            : l10n.inviteCardTitle(name: partnerHint!),
        support: l10n.inviteCardSupport,
        action: l10n.inviteCardAction,
        category: AppCategory.invite,
        face: null,
      ),
      TodayCardKind.idea => (
        tag: l10n.ideaLabel,
        title: home.idea?.title ?? '',
        support: home.idea?.body,
        action: l10n.weekReadyAction,
        category: AppCategory.idea,
        face: FaceKind.smile,
      ),
    };
  }

  VoidCallback? _actionFor(BuildContext context, TodayCardKind kind) {
    switch (kind) {
      case TodayCardKind.partnerMoment:
        return onSeeIdeas;
      case TodayCardKind.invite:
        return () => openInvite(context);
      case TodayCardKind.receivedCard:
        return () async {
          await context.pushRoute(const CardsListRoute());
          if (context.mounted) await context.read<TodayCubit>().load();
        };
      case TodayCardKind.ownCard:
      case TodayCardKind.idea:
        final route = todayCardRoute(kind, home: home);
        if (route == null) return null;

        return () => context.pushRoute(route);
    }
  }
}
