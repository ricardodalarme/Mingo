import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/accept_invite_code_field.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Opens the sheet where a signed-in person types the partner's code.
///
/// Resolves with whether the two connected.
Future<bool> showConnectCodeSheet(BuildContext context) async {
  final l10n = context.l10n.acceptInvite;

  return await BaseSheet.show<bool>(
        context: context,
        title: l10n.connectTitle,
        subtitle: l10n.subtitle,
        child: const ConnectCodeSheet(),
      ) ??
      false;
}

class const ConnectCodeSheet({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<AcceptInviteCubit>(),
      child: ConnectCodeContent(onConnected: () => Navigator.of(context).pop(true)),
    );
  }
}

/// The sheet body; reads the [AcceptInviteCubit] from the context.
class const ConnectCodeContent({required final VoidCallback onConnected, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite;
    final action = context.select((AcceptInviteCubit cubit) => cubit.state.acceptAction);
    final cubit = context.read<AcceptInviteCubit>();

    return BlocListener<AcceptInviteCubit, AcceptInviteState>(
      listenWhen: (previous, current) => previous.acceptAction != current.acceptAction,
      listener: (context, state) {
        switch (state.acceptAction) {
          case Success<AcceptOutcome>(value: AcceptOutcome.connected):
            BaseToast.show(context, l10n.connected.title);
            onConnected();
          case Failure(:final exception):
            BaseToast.show(
              context,
              l10n.errors.selectOrFallback(exception.l10nKey),
              variant: BaseToastVariant.error,
            );
          default:
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AcceptInviteCodeField(
            errorText: switch (action) {
              Success<AcceptOutcome>(value: AcceptOutcome.unusable) => l10n.unusable.text,
              Success<AcceptOutcome>(value: AcceptOutcome.ownCode) => l10n.ownCodeText,
              _ => null,
            },
          ),
          const SizedBox(height: AppSpace.s16),
          BaseButton(text: l10n.accept, isLoading: action.isLoading, onPressed: cubit.accept),
        ],
      ),
    );
  }
}
