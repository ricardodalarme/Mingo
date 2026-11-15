import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The code field, its error and the note about what accepting shares.
///
/// [errorText] replaces the field's own error with the outcome of the last attempt.
class const AcceptInviteCodeField({final String? errorText, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite;
    final code = context.select((AcceptInviteCubit cubit) => cubit.state.code);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseTextField(
          type: BaseTextFieldType.inviteCode,
          text: code.value,
          label: l10n.codeLabel,
          hint: l10n.codeHint,
          errorText: errorText ?? l10n.codeErrors.selectOrNull(code.errorName),
          onChanged: context.read<AcceptInviteCubit>().onCodeChanged,
        ),
        const SizedBox(height: AppSpace.s14),
        BaseNote(text: l10n.privacyNote),
      ],
    );
  }
}
