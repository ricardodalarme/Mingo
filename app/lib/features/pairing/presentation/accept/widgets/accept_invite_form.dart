import 'package:app/features/pairing/presentation/accept/cubit/accept_invite_cubit.dart';
import 'package:app/features/pairing/presentation/accept/widgets/accept_invite_code_field.dart';
import 'package:app/features/pairing/presentation/accept/widgets/own_invite_code.dart';
import 'package:app/features/pairing/presentation/invite/cubit/invite_cubit.dart';
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
    final isInviting = context.select((AcceptInviteCubit cubit) => cubit.state.isInviting);
    final hint = context.select((AcceptInviteCubit cubit) => cubit.state.partnerHint);
    final headline = hint == null ? l10n.headlineNoName : l10n.headline(name: hint);
    final highlight = hint ?? l10n.headlineNoNameHighlight;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: headline,
              highlight: highlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.pageSubtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseSegmented(
            segments: [l10n.segmentHaveCode, l10n.segmentInvite],
            selectedIndex: isInviting ? 1 : 0,
            onSelectionChanged: (index) {
              context.read<AcceptInviteCubit>().showInviting(isInviting: index == 1);
              if (index == 1) context.read<InviteCubit>().ensureStarted();
            },
          ),
          const SizedBox(height: AppSpace.s24),
          if (isInviting) const OwnInviteCode() else const AcceptInviteCodeField(),
        ],
      ),
      footer: isInviting
          ? null
          : BaseButton(
              text: l10n.connectAction,
              isLoading: isLoading,
              onPressed: context.read<AcceptInviteCubit>().accept,
            ),
    );
  }
}
