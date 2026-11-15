import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_result_l10n.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Every answer of the round, each one editable, before anything is sent.
class const GameReviewView({required final GamePlay play, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.review;
    final cubit = context.read<GameCubit>();
    final answers = context.select((GameCubit cubit) => cubit.state.answers);
    final locked = context.select((GameCubit cubit) => cubit.state.lockedSteps);
    final isBusy = context.select((GameCubit cubit) => cubit.state.isBusy);

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(header: true, child: Text(l10n.title, style: context.text.titleXl)),
          const SizedBox(height: AppSpace.s8),
          Text(l10n.text, style: context.text.body.copyWith(color: context.colors.textSecondary)),
          if (locked.isNotEmpty) ...[
            const SizedBox(height: AppSpace.s16),
            BaseNote(text: l10n.lockedNote),
          ],
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              for (var step = 0; step < play.totalSteps; step++)
                _ReviewRow(
                  play: play,
                  step: step,
                  answer: answers[step],
                  isLocked: locked.contains(step),
                ),
            ],
          ),
        ],
      ),
      footer: BaseButton.primary(
        text: l10n.confirm,
        isLoading: isBusy,
        onPressed: isBusy ? null : cubit.send,
      ),
    );
  }
}

class const _ReviewRow({
  required final GamePlay play,
  required final int step,
  final String? answer,
  final bool isLocked = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games.review;
    final item = play.itemAt(step);
    if (item == null) return const SizedBox.shrink();

    return BaseListTile(
      title: item.title,
      subtitle: gameReviewAnswer(context, play, step, answer),
      subtitleMaxLines: 3,
      value: isLocked ? l10n.locked : null,
      isEnabled: !isLocked,
      showsChevron: !isLocked,
      onTap: isLocked ? null : () => context.read<GameCubit>().editStep(step),
    );
  }
}
