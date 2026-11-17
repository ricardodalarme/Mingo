import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_send_outcome.dart';
import 'package:app/features/slips/presentation/slip_detail/cubit/slip_detail_cubit.dart';
import 'package:app/features/slips/presentation/slip_detail/widgets/slip_visibility_sheet.dart';
import 'package:app/features/slips/presentation/slip_kind/cubit/slip_kind_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const SlipDetailContent({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final slip = context.select((SlipDetailCubit cubit) => cubit.state.current);
    final isEditing = context.select((SlipDetailCubit cubit) => cubit.state.isEditing);
    if (slip == null) return const SizedBox.shrink();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isEditing)
            const _EditField()
          else
            Semantics(header: true, child: Text(slip.body, style: context.text.titleXl)),
          const SizedBox(height: AppSpace.s16),
          if (!isEditing) ...[
            _Facts(slip: slip),
            if (slip.feeling != null) ...[
              const SizedBox(height: AppSpace.s16),
              _Labelled(label: context.l10n.slipDetail.feeling, text: slip.feeling!),
            ],
            if (slip.planNote != null) ...[
              const SizedBox(height: AppSpace.s16),
              _Labelled(label: context.l10n.slipDetail.plan, text: slip.planNote!),
            ],
            const SizedBox(height: AppSpace.s12),
            BaseListGroup(
              children: [
                BaseListTile(
                  title: context.l10n.slipDetail.jarTitle,
                  subtitle: context.l10n.slipDetail.jarText,
                  control: BaseSwitch(
                    value: slip.isInJar,
                    semanticLabel: context.l10n.slipDetail.jarTitle,
                    onChanged: (value) => context.read<SlipDetailCubit>().setInJar(value: value),
                  ),
                ),
              ],
            ),
            if (slip.wasInCard) ...[
              const SizedBox(height: AppSpace.s12),
              BaseNote(text: context.l10n.slipDetail.sentNote),
            ],
          ],
        ],
      ),
      footer: isEditing ? const _EditActions() : const _Actions(),
    );
  }
}

class const _Facts({required final SlipDetail slip}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipDetail;
    final date = slip.createdAt.toLocal();
    final dateLine = l10n.factDate(
      weekday: l10n.weekdaysShort[date.weekday - 1],
      day: date.day,
      month: l10n.monthsShort[date.month - 1],
    );
    final category = slip.category;
    final type = category != null
        ? l10n.categories.selectOrFallback(category.name)
        : l10n.kinds.selectOrFallback(slip.kind.name);
    final visibility = slip.wasInCard
        ? l10n.visibilitySent
        : slip.forCard
        ? l10n.visibilityCard
        : l10n.visibilityPrivate;
    final isInCard = slip.wasInCard || (slip.forCard && slip.canGoInCard);

    return BaseListGroup(
      children: [
        BaseListTile(title: l10n.factDateLabel, value: dateLine, showsDivider: true),
        BaseListTile(title: l10n.factType, value: type, showsDivider: true),
        BaseListTile(
          leading: BaseIconTile(
            icon: slip.forCard || slip.wasInCard ? AppIcons.mail_filled : AppIcons.lock,
          ),
          title: l10n.factVisibility,
          value: visibility,
          showsChevron: true,
          showsDivider: true,
          onTap: () => _chooseVisibility(context, slip),
        ),
        BaseListTile(title: l10n.factInCard, value: isInCard ? l10n.yes : l10n.no),
      ],
    );
  }

  Future<void> _chooseVisibility(BuildContext context, SlipDetail slip) async {
    final l10n = context.l10n.slipDetail.visibility;
    final cubit = context.read<SlipDetailCubit>();
    final choice = await showSlipVisibilitySheet(context, slip);
    if (choice == null || !context.mounted) return;

    switch (choice) {
      case SlipVisibility.onlyMe:
        await cubit.setForCard(value: false);
      case SlipVisibility.weeklyCard:
        await cubit.setForCard(value: true);
      case SlipVisibility.sendNow:
        final outcome = await cubit.sendNow();
        if (!context.mounted || outcome == null) return;
        BaseToast.show(context, switch (outcome) {
          SlipSendOutcome.sent => l10n.sentToast,
          SlipSendOutcome.held => l10n.heldToast,
          SlipSendOutcome.notSent => l10n.notSentToast,
        });
    }
  }
}

class const _Labelled({required final String label, required final String text})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.label.copyWith(color: context.colors.textSecondary)),
        const SizedBox(height: AppSpace.s4),
        Text(text, style: context.text.body),
      ],
    );
  }
}

class const _EditField() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = context.select((SlipDetailCubit cubit) => cubit.state.draftBody);

    return BaseTextArea(
      text: text.value,
      maxLength: slipKindMaxLength,
      errorText: context.l10n.slipDetail.draftBodyErrors.selectOrNull(text.errorName),
      onChanged: context.read<SlipDetailCubit>().onBodyChanged,
    );
  }
}

class const _Actions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipDetail;
    final cubit = context.read<SlipDetailCubit>();
    final isDeleting = context.select(
      (SlipDetailCubit cubit) => cubit.state.deleteAction.isLoading,
    );

    return Row(
      spacing: AppSpace.s10,
      children: [
        BaseButton(
          text: l10n.delete,
          variant: .secondary,
          isFullWidth: false,
          isLoading: isDeleting,
          onPressed: () => _confirmDelete(context),
        ),
        Expanded(
          child: BaseButton(text: l10n.edit, onPressed: cubit.startEditing),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = context.l10n.slipDetail;
    final cubit = context.read<SlipDetailCubit>();
    final confirmed = await BaseConfirmSheet.show(
      context: context,
      title: l10n.deleteTitle,
      text: l10n.deleteText,
      confirmText: l10n.deleteConfirm,
      isDestructive: true,
    );
    if (confirmed) await cubit.delete();
  }
}

class const _EditActions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipDetail;
    final cubit = context.read<SlipDetailCubit>();
    final isLoading = context.select((SlipDetailCubit cubit) => cubit.state.saveAction.isLoading);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseButton(text: l10n.editSave, isLoading: isLoading, onPressed: cubit.saveEdit),
        const SizedBox(height: AppSpace.s10),
        BaseButton(text: l10n.editCancel, variant: .secondary, onPressed: cubit.cancelEditing),
      ],
    );
  }
}
