import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_content_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_kind_l10n.dart';
import 'package:app/features/games/presentation/game/widgets/game_result_l10n.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The question being answered in a running session.
class const GameActiveView({required final GamePlay play, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final step = context.select((GameCubit cubit) => cubit.state.step);
    final isLocked = context.select((GameCubit cubit) => cubit.state.isLocked);
    if (step < 0) return _IntroPlayView(play: play);
    if (isLocked) return _LockedPlayView(play: play, step: step);
    if (play.itemAt(step) == null) return GameNoContentView(play: play, canCancel: true);

    return switch (play.kind.flow) {
      GameFlow.pick => _PickPlayView(play: play, step: step),
      GameFlow.guess => _GuessPlayView(play: play, step: step),
      GameFlow.talk => _TalkPlayView(play: play, step: step),
      GameFlow.date => _DatePlayView(play: play, step: step),
    };
  }
}

/// The introduction to the round, before the first question.
class const _IntroPlayView({required final GamePlay play}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games;
    final cubit = context.read<GameCubit>();

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseFace(kind: FaceKind.smile, size: FaceSize.showcase),
          const SizedBox(height: AppSpace.s20),
          Semantics(
            header: true,
            child: Text(
              play.kind.title(context),
              textAlign: TextAlign.center,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s6),
          Text(
            gameKindMeta(context, play.kind),
            textAlign: TextAlign.center,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s10),
          Text(
            play.kind.intro(context),
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.start.noWinnerNote, icon: AppIcons.heart),
        ],
      ),
      footer: BaseButton.primary(text: l10n.playing.introCta, onPressed: cubit.begin),
    );
  }
}

/// The step the server no longer lets this person change.
class const _LockedPlayView({required final GamePlay play, required final int step})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games;
    final cubit = context.read<GameCubit>();
    final item = play.itemAt(step);

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.playing.progress(current: step + 1, total: play.totalSteps),
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s8),
          if (item != null)
            Semantics(header: true, child: Text(item.title, style: context.text.titleXl)),
          const SizedBox(height: AppSpace.s20),
          BaseNote(text: l10n.playing.lockedNote),
        ],
      ),
      footer: BaseButton.secondary(
        text: l10n.common.back,
        onPressed: cubit.previous,
        isFullWidth: true,
      ),
    );
  }
}

class const _PlayScaffold({
  required final String title,
  required final Widget content,
  final String? label,
  final String? subtitle,
  final Widget? note,
  final String? progress,
  final Widget? footer,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (progress != null) ...[
            Text(
              progress!,
              style: context.text.caption.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s8),
          ],
          if (label != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: BaseTag(text: label!),
            ),
            const SizedBox(height: AppSpace.s12),
          ],
          Semantics(header: true, child: Text(title, style: context.text.titleXl)),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpace.s8),
            Text(subtitle!, style: context.text.body.copyWith(color: context.colors.textSecondary)),
          ],
          const SizedBox(height: AppSpace.s20),
          content,
          if (note != null) ...[const SizedBox(height: AppSpace.s12), note!],
        ],
      ),
      footer: footer,
    );
  }
}

class const _PickPlayView({required final GamePlay play, required final int step})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.playing;
    final cubit = context.read<GameCubit>();
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);
    final draft = context.select((GameCubit cubit) => cubit.state.draft);
    final name = gamePartnerName(play.partnerName, l10n.partnerFallback);
    final item = play.itemAt(step)!;
    final isChanging = play.own.containsKey(step);

    return _PlayScaffold(
      progress: l10n.progress(current: step + 1, total: play.totalSteps),
      title: item.title,
      content: Column(
        children: [
          for (final option in [
            (label: l10n.me, key: pickSelf),
            (label: name, key: pickPartner),
            (label: l10n.both, key: pickBoth),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.s10),
              child: BaseOptionTile(
                title: option.label,
                isSelected: draft == option.key,
                isEnabled: !isBusy,
                onTap: isBusy ? null : () => cubit.choose(option.key),
              ),
            ),
        ],
      ),
      note: isChanging
          ? BaseNote(text: _changeNote(context, name))
          : BaseNote(text: l10n.privacyNote),
      footer: _AnswerFooter(
        canSubmit: draft.trim().isNotEmpty && !isBusy,
        isBusy: isBusy,
        actionText: l10n.next,
        onSubmit: cubit.submit,
        onSkip: cubit.skip,
      ),
    );
  }
}

class const _GuessPlayView({required final GamePlay play, required final int step})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.playing;
    final cubit = context.read<GameCubit>();
    final draft = context.select((GameCubit cubit) => cubit.state.draft);
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);
    final name = gamePartnerName(play.partnerName, '');
    final isGuess = play.phaseAt(step) == GamePhase.guess;
    final item = play.itemAt(step)!;
    final half = play.totalSteps ~/ 2;
    final question = isGuess ? step - half + 1 : step + 1;
    final label = isGuess
        ? name.isEmpty
              ? l10n.guessAboutPartnerFallback
              : l10n.guessAboutPartner(name: name)
        : l10n.guessAboutYou;
    final prompt = isGuess
        ? name.isEmpty
              ? l10n.guessPromptFallback
              : l10n.guessPrompt(name: name)
        : null;
    final hint = isGuess ? l10n.guessHint : l10n.answerHint;
    final options = item.options;
    final isChanging = play.own.containsKey(step);

    return _PlayScaffold(
      progress: isGuess
          ? l10n.guessProgress(current: question, total: play.questionCount)
          : l10n.progress(current: question, total: play.questionCount),
      label: label,
      title: item.title,
      subtitle: prompt,
      content: options.isEmpty
          ? BaseTextArea(
              text: draft,
              hint: hint,
              maxLength: gameAnswerMaxLength,
              onChanged: cubit.onDraftChanged,
            )
          : Column(
              children: [
                for (final option in options)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpace.s10),
                    child: BaseOptionTile(
                      title: option,
                      isSelected: draft == option,
                      isEnabled: !isBusy,
                      onTap: isBusy ? null : () => cubit.choose(option),
                    ),
                  ),
              ],
            ),
      note: isChanging ? BaseNote(text: _changeNote(context, name)) : null,
      footer: _AnswerFooter(
        canSubmit: draft.trim().isNotEmpty && !isBusy,
        isBusy: isBusy,
        actionText: isGuess ? l10n.nextGuess : l10n.next,
        onSubmit: cubit.submit,
        onSkip: cubit.skip,
      ),
    );
  }
}

class const _TalkPlayView({required final GamePlay play, required final int step})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.playing;
    final cubit = context.read<GameCubit>();
    final draft = context.select((GameCubit cubit) => cubit.state.draft);
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);
    final item = play.itemAt(step)!;
    final name = gamePartnerName(play.partnerName, '');
    final isChanging = play.own.containsKey(step);

    return _PlayScaffold(
      progress: l10n.progress(current: step + 1, total: play.totalSteps),
      title: item.title,
      subtitle: l10n.talkSubtitle,
      content: BaseTextArea(
        text: draft,
        hint: l10n.talkHint,
        maxLength: gameAnswerMaxLength,
        onChanged: cubit.onDraftChanged,
      ),
      note: BaseNote(text: isChanging ? _changeNote(context, name) : l10n.talkNote),
      footer: _AnswerFooter(
        canSubmit: draft.trim().isNotEmpty && !isBusy,
        isBusy: isBusy,
        actionText: l10n.next,
        onSubmit: cubit.submit,
        onSkip: cubit.skip,
      ),
    );
  }
}

class const _DatePlayView({required final GamePlay play, required final int step})
    extends StatefulWidget {
  @override
  State<_DatePlayView> createState() => _DatePlayViewState();
}

class _DatePlayViewState() extends State<_DatePlayView> {
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games;
    final cubit = context.read<GameCubit>();
    final draft = context.select((GameCubit cubit) => cubit.state.draft);
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);
    final answers = context.select((GameCubit cubit) => cubit.state.answers);
    final item = widget.play.itemAt(widget.step)!;

    if (!_started && !answers.containsKey(widget.step)) {
      return _PlayScaffold(
        label: l10n.date.missionTag,
        title: item.title,
        subtitle: item.body,
        content: BaseNote(text: l10n.date.startNote, icon: AppIcons.heart),
        footer: BaseButton.primary(
          text: l10n.date.start,
          onPressed: () => setState(() => _started = true),
        ),
      );
    }

    final canSubmit = draft.isNotEmpty && !isBusy;

    return _PlayScaffold(
      title: l10n.date.reflectionTitle,
      content: Column(
        children: [
          for (final reflection in dateReflections)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.s10),
              child: BaseOptionTile(
                title: gameReflectionLabel(context, reflection),
                isSelected: draft == reflection,
                isEnabled: !isBusy,
                onTap: isBusy ? null : () => cubit.choose(reflection),
              ),
            ),
        ],
      ),
      note: BaseNote(text: l10n.date.reflectionText),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton.primary(
            text: l10n.date.save,
            isEnabled: canSubmit,
            isLoading: isBusy,
            onPressed: canSubmit ? cubit.submit : null,
          ),
          const SizedBox(height: AppSpace.s6),
          BaseButton.text(
            text: l10n.playing.skip,
            isEnabled: !isBusy,
            onPressed: isBusy ? null : cubit.skip,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

class const _AnswerFooter({
  required final bool canSubmit,
  required final bool isBusy,
  required final String actionText,
  required final VoidCallback onSubmit,
  required final VoidCallback onSkip,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.playing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseButton.primary(
          text: actionText,
          isEnabled: canSubmit,
          isLoading: isBusy,
          onPressed: canSubmit ? onSubmit : null,
        ),
        const SizedBox(height: AppSpace.s6),
        BaseButton.text(
          text: l10n.skip,
          isEnabled: !isBusy,
          onPressed: isBusy ? null : onSkip,
          isFullWidth: true,
        ),
      ],
    );
  }
}

String _changeNote(BuildContext context, String name) {
  final l10n = context.l10n.games.playing;

  return name.isEmpty ? l10n.changeNoteFallback : l10n.changeNote(name: name);
}
