import 'package:app/features/slips/data/mappers/slip_note_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/presentation/quick_slip/cubit/quick_slip_cubit.dart';
import 'package:app/features/slips/presentation/slip_kind/cubit/slip_kind_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const QuickSlipForm({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quickSlip;
    final mode = context.select((QuickSlipCubit cubit) => cubit.state.mode);
    final forCardByDefault = context.select((QuickSlipCubit cubit) => cubit.state.forCardByDefault);
    final isAnnoyance = mode == QuickSlipMode.annoyance;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSegmented(
            segments: [l10n.polarityLiked, l10n.polarityBothered],
            selectedIndex: isAnnoyance ? 1 : 0,
            semanticLabel: l10n.polarityLabel,
            onSelectionChanged: (index) => context.read<QuickSlipCubit>().onModeChanged(
              index == 1 ? QuickSlipMode.annoyance : QuickSlipMode.liked,
            ),
          ),
          const SizedBox(height: AppSpace.s20),
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: isAnnoyance ? l10n.annoyanceTitle : l10n.title,
              highlight: isAnnoyance ? l10n.annoyanceTitleHighlight : l10n.titleHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            isAnnoyance ? l10n.annoyanceSubtitle : l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          const _TextField(),
          if (!isAnnoyance) ...[const SizedBox(height: AppSpace.s16), const _CategoryChips()],
          const SizedBox(height: AppSpace.s16),
          BaseNote(
            text: isAnnoyance
                ? l10n.annoyanceNote
                : forCardByDefault
                ? l10n.cardNote
                : l10n.privacyNote,
          ),
        ],
      ),
      footer: const _Footer(),
    );
  }
}

class const _TextField() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quickSlip;
    final text = context.select((QuickSlipCubit cubit) => cubit.state.text);
    final category = context.select((QuickSlipCubit cubit) => cubit.state.category);
    final isAnnoyance = context.select(
      (QuickSlipCubit cubit) => cubit.state.mode == QuickSlipMode.annoyance,
    );

    return BaseSlipNoteField(
      type: isAnnoyance ? SlipNoteType.annoyed : category.toNoteType(),
      typeLabel: isAnnoyance
          ? l10n.polarityBothered
          : category == null
          ? l10n.polarityLiked
          : l10n.categories.selectOrFallback(category.name),
      text: text.value,
      hint: isAnnoyance ? l10n.annoyanceHint : l10n.hint,
      tilt: slipNoteTilt('quick'),
      errorText: l10n.textErrors.selectOrNull(text.errorName),
      onChanged: context.read<QuickSlipCubit>().onTextChanged,
    );
  }
}

class const _CategoryChips() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = context.l10n.quickSlip.categories;
    final selected = context.select((QuickSlipCubit cubit) => cubit.state.category);

    return Wrap(
      spacing: AppSpace.s8,
      runSpacing: AppSpace.s8,
      children: [
        for (final category in SlipCategory.values)
          BaseChoiceChip(
            label: labels.selectOrFallback(category.name),
            isSelected: selected == category,
            slipNoteType: category.toNoteType(),
            onTap: () => context.read<QuickSlipCubit>().onCategoryToggled(category),
          ),
      ],
    );
  }
}

class const _Footer() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.quickSlip;
    final isLoading = context.select((QuickSlipCubit cubit) => cubit.state.saveAction.isLoading);
    final isAnnoyance = context.select(
      (QuickSlipCubit cubit) => cubit.state.mode == QuickSlipMode.annoyance,
    );
    final cubit = context.read<QuickSlipCubit>();

    return Row(
      spacing: AppSpace.s10,
      children: [
        BaseButton(
          text: isAnnoyance ? l10n.gentleRequest : l10n.addDetails,
          variant: .secondary,
          isFullWidth: false,
          onPressed: () => isAnnoyance ? _toRequest(context) : _openDetails(context),
        ),
        Expanded(
          child: BaseButton(
            text: isAnnoyance ? l10n.keep : l10n.save,
            isLoading: isLoading,
            onPressed: cubit.save,
          ),
        ),
      ],
    );
  }

  Future<void> _toRequest(BuildContext context) async {
    final cubit = context.read<QuickSlipCubit>();
    final router = context.router;
    final saved = await cubit.save();
    final annoyance = cubit.savedAnnoyance;
    if (saved && annoyance != null) {
      await router.replace(GentleRequestRoute(annoyanceId: annoyance.id));
    }
  }

  Future<void> _openDetails(BuildContext context) async {
    final l10n = context.l10n.slipKind;
    final text = context.read<QuickSlipCubit>().state.text.value;
    final router = context.router;
    final choice = await BaseSheet.show<Object>(
      context: context,
      title: l10n.switcherTitle,
      child: BaseListGroup(
        children: [
          for (final kind in slipKinds)
            BaseListTile(
              title: l10n.kinds.selectOrFallback(kind.name),
              showsChevron: true,
              onTap: () => Navigator.of(context).pop(kind),
            ),
          BaseListTile(
            title: l10n.needEntry,
            showsChevron: true,
            onTap: () => Navigator.of(context).pop(_needChoice),
          ),
        ],
      ),
    );
    switch (choice) {
      case SlipKind():
        await router.replace(SlipKindRoute(kind: choice, text: text));
      case _needChoice:
        await router.replace(const NeedRoute());
      default:
        return;
    }
  }
}

const Object _needChoice = 'need';
