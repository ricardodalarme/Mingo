import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/accept_invite_code_field.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const AcceptInviteForm({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.acceptInvite;
    final isLoading = context.select(
      (AcceptInviteCubit cubit) => cubit.state.acceptAction.isLoading,
    );

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.titleHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s24),
          const AcceptInviteCodeField(),
        ],
      ),
      footer: BaseButton(
        text: l10n.accept,
        isLoading: isLoading,
        onPressed: context.read<AcceptInviteCubit>().accept,
      ),
    );
  }
}
