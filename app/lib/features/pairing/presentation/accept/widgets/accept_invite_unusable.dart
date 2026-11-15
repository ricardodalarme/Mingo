import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const AcceptInviteUnusable({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite;
    final unusable = l10n.unusable;
    final isOwnCode = context.select((AcceptInviteCubit cubit) {
      final action = cubit.state.acceptAction;

      return action is Success<AcceptOutcome> && action.value == AcceptOutcome.ownCode;
    });

    return BaseMomentContent(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Semantics(
            header: true,
            liveRegion: true,
            child: AppHighlightedText(
              text: isOwnCode ? l10n.ownCodeTitle : unusable.title,
              highlight: isOwnCode ? l10n.ownCodeHighlight : unusable.titleHighlight,
              style: context.text.display,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpace.s12),
          Text(
            isOwnCode ? l10n.ownCodeText : unusable.text,
            textAlign: TextAlign.center,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton(
            text: unusable.tryAgain,
            onPressed: context.read<AcceptInviteCubit>().tryAgain,
          ),
          const SizedBox(height: AppSpace.s10),
          BaseButton(
            text: unusable.close,
            variant: .secondary,
            onPressed: () => context.router.maybePop(),
          ),
        ],
      ),
    );
  }
}
