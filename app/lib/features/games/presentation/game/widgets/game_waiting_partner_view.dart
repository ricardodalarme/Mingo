import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_cancel_dialog.dart';
import 'package:app/features/games/presentation/game/widgets/game_kind_l10n.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The turn of the partner, after this person answered everything.
class const GameWaitingPartnerView({required final GamePlay play, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.games;
    final cubit = context.read<GameCubit>();
    final isChecking = context.select((GameCubit cubit) => cubit.state.action.isLoading);
    final name = gamePartnerName(play.partnerName, '');

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BaseFace(kind: FaceKind.thinking, size: FaceSize.showcase),
          const SizedBox(height: AppSpace.s20),
          Semantics(
            header: true,
            child: Text(
              l10n.waitingPartner.title,
              textAlign: TextAlign.center,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s10),
          Text(
            name.isEmpty ? l10n.waitingPartner.textFallback : l10n.waitingPartner.text(name: name),
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.waitingPartner.note),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton.primary(
            text: l10n.waitingPartner.close,
            onPressed: () => context.router.maybePop(),
          ),
          const SizedBox(height: AppSpace.s6),
          BaseButton.text(
            text: l10n.waitingPartner.checkAgain,
            isEnabled: !isChecking,
            onPressed: () async {
              await cubit.checkAgain();
              if (!context.mounted) return;
              if (cubit.state.current?.stage(clock.now()) == GameStage.waitingForPartner) {
                BaseToast.show(context, l10n.waitingPartner.stillWaiting);
              }
            },
            isFullWidth: true,
          ),
          const SizedBox(height: AppSpace.s2),
          BaseButton.text(
            text: l10n.waitingPartner.cancel,
            onPressed: () => confirmCancelGame(context),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
