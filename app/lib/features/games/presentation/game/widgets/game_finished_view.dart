import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_kind_l10n.dart';
import 'package:app/features/games/presentation/game/widgets/game_result_l10n.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The warm reveal of a finished game and the invitation to a new round.
class const GameFinishedView({required final GamePlay play, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games;
    final cubit = context.read<GameCubit>();
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);
    final name = gamePartnerName(play.partnerName, l10n.playing.partnerFallback);
    final canReplay = play.available.isNotEmpty;

    if (!play.hasAllItems) {
      return BaseStackedContent(
        body: BaseEmptyState(title: l10n.finished.missingTitle, text: l10n.finished.missingText),
        footer: BaseButton.primary(
          text: l10n.finished.chooseAnother,
          onPressed: () => context.router.maybePop(),
        ),
      );
    }

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BaseFace(kind: FaceKind.affectionate, size: FaceSize.showcase),
          const SizedBox(height: AppSpace.s20),
          ..._headline(context, play, name),
          const SizedBox(height: AppSpace.s20),
          ..._results(context, play, name),
          if (canReplay) ...[const SizedBox(height: AppSpace.s20), _ReplayCard(play: play)],
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (canReplay) ...[
            BaseButton.primary(
              text: l10n.finished.playAgain,
              isLoading: isBusy,
              onPressed: cubit.invite,
            ),
            const SizedBox(height: AppSpace.s6),
          ],
          BaseButton.text(
            text: canReplay ? l10n.finished.chooseAnother : l10n.common.back,
            onPressed: () => context.router.maybePop(),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  List<Widget> _headline(BuildContext context, GamePlay play, String name) {
    final l10n = context.l10n.games.finished;

    return switch (play.kind.flow) {
      GameFlow.pick => [
        Semantics(
          header: true,
          child: AppHighlightedText(
            text: l10n.pickTitle(agreed: play.pickAgreementCount, total: play.totalSteps),
            highlight: l10n.pickHighlight(agreed: play.pickAgreementCount, total: play.totalSteps),
            style: context.text.titleXl,
          ),
        ),
        const SizedBox(height: AppSpace.s10),
        Text(l10n.pickNote, style: context.text.body.copyWith(color: context.colors.textSecondary)),
      ],
      GameFlow.guess => [
        Semantics(
          header: true,
          child: AppHighlightedText(
            text: l10n.discoveriesTitle,
            highlight: l10n.discoveriesTitle,
            style: context.text.titleXl,
          ),
        ),
        const SizedBox(height: AppSpace.s10),
        Text(
          l10n.discoveriesText,
          style: context.text.body.copyWith(color: context.colors.textSecondary),
        ),
      ],
      GameFlow.talk => [
        Semantics(
          header: true,
          child: AppHighlightedText(
            text: l10n.doneTitle,
            highlight: l10n.doneTitle,
            style: context.text.titleXl,
          ),
        ),
        const SizedBox(height: AppSpace.s10),
        Text(
          l10n.doneText(count: play.totalSteps),
          style: context.text.body.copyWith(color: context.colors.textSecondary),
        ),
      ],
      GameFlow.date => [
        Semantics(
          header: true,
          child: AppHighlightedText(
            text: l10n.doneTitle,
            highlight: l10n.doneTitle,
            style: context.text.titleXl,
          ),
        ),
        const SizedBox(height: AppSpace.s10),
        Text(l10n.dateText, style: context.text.body.copyWith(color: context.colors.textSecondary)),
      ],
    };
  }

  List<Widget> _results(BuildContext context, GamePlay play, String name) {
    final l10n = context.l10n.games;

    return switch (play.kind.flow) {
      GameFlow.pick => [
        BaseListGroup(
          children: [
            for (final result in play.pickResults)
              BaseListTile(
                title: result.item.title,
                subtitle: result.agree
                    ? l10n.finished.bothSaid(
                        value: gamePersonLabel(context, result.mine, partnerName: play.partnerName),
                      )
                    : l10n.finished.eachSaid(
                        you: gamePersonLabel(context, result.mine, partnerName: play.partnerName),
                        name: name,
                        partner: gamePersonLabel(
                          context,
                          result.theirs,
                          partnerName: play.partnerName,
                        ),
                      ),
                subtitleMaxLines: 2,
                trailing: _MatchMark(isMatch: result.agree),
              ),
          ],
        ),
      ],
      GameFlow.guess => _discoveries(context, play, name),
      GameFlow.talk => [
        for (final result in play.talkResults)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.s12),
            child: BaseSurfaceCard(
              title: result.item.title,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AnswerLine(
                    label: l10n.finished.you,
                    value: gameAnswerLabel(context, result.mine),
                  ),
                  const SizedBox(height: AppSpace.s6),
                  _AnswerLine(label: name, value: gameAnswerLabel(context, result.theirs)),
                ],
              ),
            ),
          ),
      ],
      GameFlow.date => [
        BaseSurfaceCard(
          title: play.items.isEmpty ? l10n.date.reflectionTitle : play.items.first.title,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AnswerLine(
                label: l10n.finished.you,
                value: gameReflectionLabel(context, play.ownReflection),
              ),
              const SizedBox(height: AppSpace.s6),
              _AnswerLine(label: name, value: gameReflectionLabel(context, play.partnerReflection)),
            ],
          ),
        ),
      ],
    };
  }

  List<Widget> _discoveries(BuildContext context, GamePlay play, String name) {
    final l10n = context.l10n.games.finished;
    final aboutPartner = play.discoveriesAboutPartner;
    final aboutSelf = play.discoveriesAboutSelf;
    if (aboutPartner.isEmpty && aboutSelf.isEmpty) {
      return [BaseNote(text: l10n.noDiscoveries, icon: AppIcons.heart)];
    }

    return [
      if (aboutPartner.isNotEmpty) ...[
        BaseSectionHeader(title: l10n.youDidNotKnow, isLabel: true),
        const SizedBox(height: AppSpace.s8),
        BaseListGroup(
          children: [
            for (final result in aboutPartner)
              BaseListTile(
                title: result.item.title,
                subtitle: l10n.partnerAnswered(
                  name: name,
                  value: gameAnswerLabel(context, result.partnerAnswer),
                ),
                subtitleMaxLines: 2,
              ),
          ],
        ),
        const SizedBox(height: AppSpace.s16),
      ],
      if (aboutSelf.isNotEmpty) ...[
        BaseSectionHeader(title: l10n.partnerDidNotKnow(name: name), isLabel: true),
        const SizedBox(height: AppSpace.s8),
        BaseListGroup(
          children: [
            for (final result in aboutSelf)
              BaseListTile(
                title: result.item.title,
                subtitle: l10n.youAnswered(value: gameAnswerLabel(context, result.ownAnswer)),
                subtitleMaxLines: 2,
              ),
          ],
        ),
      ],
    ];
  }
}

class const _ReplayCard({required final GamePlay play}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.finished;
    final count = play.kind.itemCount;
    final title = switch (play.kind.flow) {
      GameFlow.pick || GameFlow.talk => l10n.replayQuestions(count: count),
      GameFlow.guess => l10n.replayGuesses(count: count),
      GameFlow.date => l10n.replayMission,
    };

    return BaseSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BaseTag(text: l10n.replayTag),
          ),
          const SizedBox(height: AppSpace.s12),
          Text(title, style: context.text.titleSm),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.replayText,
            style: context.text.bodySm.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class const _MatchMark({required final bool isMatch}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.finished;

    return Semantics(
      label: isMatch ? l10n.matchedLabel : l10n.differentLabel,
      child: ExcludeSemantics(
        child: Text(
          isMatch ? '✓' : '≠',
          style: context.text.titleSm.copyWith(
            color: isMatch ? context.colors.accentHighlight : context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class const _AnswerLine({required final String label, required final String value})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.caption.copyWith(color: context.colors.textSecondary)),
        const SizedBox(height: AppSpace.s2),
        Text(value, style: context.text.body),
      ],
    );
  }
}
