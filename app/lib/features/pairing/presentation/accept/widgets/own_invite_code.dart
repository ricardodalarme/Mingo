import 'package:app/features/pairing/data/models/active_invite.dart';
import 'package:app/features/pairing/presentation/invite/cubit/invite_cubit.dart';
import 'package:app/features/pairing/presentation/invite/widgets/invite_compose.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The person's own invite code with the action that sends it.
class const OwnInviteCode({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite;
    final invite = context.select((InviteCubit cubit) => cubit.state.invite);

    return switch (invite) {
      Success<ActiveInvite>(:final value) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseCodeField(text: value.code, isEnabled: false, semanticLabel: l10n.ownCodeLabel),
          const SizedBox(height: AppSpace.s14),
          BaseNote(text: l10n.ownCodeNote),
          const SizedBox(height: AppSpace.s16),
          BaseButton(
            text: context.l10n.invite.share,
            icon: AppIcons.share,
            onPressed: () => context.read<InviteCubit>().share(inviteMessage(context, value)),
          ),
        ],
      ),
      Failure(:final exception) => BaseErrorState(
        title: context.l10n.invite.errorTitle,
        text: context.l10n.invite.errors.selectOrFallback(exception.l10nKey),
        actionText: context.l10n.common.retry,
        onAction: context.read<InviteCubit>().start,
      ),
      _ => const Center(child: BaseLoadingDots()),
    };
  }
}
