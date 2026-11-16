import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_grid.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const MoodForm({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isChoosingShare = context.select((MoodCubit cubit) => cubit.state.isChoosingShare);

    return isChoosingShare ? const _ShareStep() : const _MoodStep();
  }
}

class const _MoodStep() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final mood = context.select((MoodCubit cubit) => cubit.state.mood);
    final need = context.select((MoodCubit cubit) => cubit.state.need);
    final isSaving = context.select((MoodCubit cubit) => cubit.state.saveAction.isLoading);
    final cubit = context.read<MoodCubit>();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.titleHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          MoodGrid(selected: mood, isEnabled: !isSaving, onSelected: cubit.selectMood),
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: l10n.needTitle, isLabel: true),
          const SizedBox(height: AppSpace.s12),
          Wrap(
            spacing: AppSpace.s8,
            runSpacing: AppSpace.s8,
            children: [
              for (final option in NeedKind.values)
                BaseChoiceChip(
                  label: l10n.needs.selectOrFallback(option.name),
                  isSelected: need == option,
                  onTap: isSaving ? null : () => cubit.toggleNeed(option),
                ),
            ],
          ),
        ],
      ),
      footer: BaseButton(text: l10n.next, isEnabled: mood != null, onPressed: cubit.next),
    );
  }
}

class const _ShareStep() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final need = context.select((MoodCubit cubit) => cubit.state.need);
    final share = context.select((MoodCubit cubit) => cubit.state.share);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final canSave = context.select((MoodCubit cubit) => cubit.state.canSave);
    final isSaving = context.select((MoodCubit cubit) => cubit.state.saveAction.isLoading);
    final cubit = context.read<MoodCubit>();
    final hasName = partnerName != null && partnerName.isNotEmpty;
    const icons = {
      MoodShare.mood: AppIcons.eye,
      MoodShare.moodNeed: AppIcons.users,
      MoodShare.none: AppIcons.lock,
    };

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: hasName ? l10n.shareHeadline(name: partnerName) : l10n.shareHeadlineNoName,
              highlight: hasName ? partnerName : l10n.shareHeadlineNoNameHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.shareSubtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          Column(
            spacing: AppSpace.s10,
            children: [
              for (final option in [MoodShare.mood, MoodShare.moodNeed, MoodShare.none])
                BaseOptionTile(
                  title: l10n.share.selectOrFallback(option.name),
                  leading: BaseIconTile(icon: icons[option]!),
                  isSelected: share == option,
                  isEnabled: !isSaving && (option != MoodShare.moodNeed || need != null),
                  onTap: isSaving ? null : () => cubit.selectShare(option),
                ),
            ],
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.privacyNote),
        ],
      ),
      footer: BaseButton(
        text: share == MoodShare.none ? l10n.save : l10n.shareAction,
        isEnabled: canSave,
        isLoading: isSaving,
        onPressed: cubit.save,
      ),
    );
  }
}
