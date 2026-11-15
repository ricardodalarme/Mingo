import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_active_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_content_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_finished_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_invitation_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_review_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_start_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_waiting_partner_view.dart';
import 'package:app/features/games/presentation/game/widgets/game_waiting_view.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Picks the screen for where the game stands.
class const GamePlayView({required final GamePlay play, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stage = play.stage(clock.now());
    final isReviewing = context.select((GameCubit cubit) => cubit.state.isReviewing);
    final step = context.select((GameCubit cubit) => cubit.state.step);
    if (isReviewing && stage != GameStage.finished) return GameReviewView(play: play);
    if (stage == GameStage.waitingForPartner && step < play.totalSteps) {
      return GameActiveView(play: play);
    }

    return switch (stage) {
      GameStage.noPartner => GameNoPartnerView(play: play),
      GameStage.noContent => GameNoContentView(play: play),
      GameStage.start => GameStartView(play: play),
      GameStage.waiting => GameWaitingView(play: play),
      GameStage.invitation => GameInvitationView(play: play),
      GameStage.contentMissing => GameNoContentView(play: play, canCancel: true),
      GameStage.playing => GameActiveView(play: play),
      GameStage.waitingForPartner => GameWaitingPartnerView(play: play),
      GameStage.finished => GameFinishedView(play: play),
    };
  }
}
