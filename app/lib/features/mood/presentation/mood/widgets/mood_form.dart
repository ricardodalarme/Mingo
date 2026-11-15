import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_grid.dart';
import 'package:app/features/mood/presentation/need_sheet/need_sheet.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class const MoodForm({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final mood = context.select((MoodCubit cubit) => cubit.state.mood);
    final need = context.select((MoodCubit cubit) => cubit.state.need);
    final share = context.select((MoodCubit cubit) => cubit.state.share);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final canSave = context.select((MoodCubit cubit) => cubit.state.canSave);
    final isSaving = context.select((MoodCubit cubit) => cubit.state.saveAction.isLoading);
    final cubit = context.read<MoodCubit>();
    final shareTitle = partnerName == null || partnerName.isEmpty
        ? l10n.shareTitle
        : l10n.shareTitleNamed(name: partnerName);

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
          const SizedBox(height: AppSpace.s20),
          MoodGrid(selected: mood, isEnabled: !isSaving, onSelected: cubit.selectMood),
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: l10n.needTitle),
          const SizedBox(height: AppSpace.s8),
          BaseListGroup(
            children: [
              BaseListTile(
                title: need == null ? l10n.needMenuEmpty : l10n.needs.selectOrFallback(need.name),
                subtitle: l10n.needMenuSupport,
                icon: AppIcons.heart,
                showsChevron: true,
                onTap: isSaving ? null : () => showNeedSheet(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: shareTitle),
          const SizedBox(height: AppSpace.s4),
          Text(
            l10n.shareSubtitle,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s12),
          Column(
            spacing: AppSpace.s8,
            children: [
              for (final option in MoodShare.values)
                BaseOptionTile(
                  title: l10n.share.selectOrFallback(option.name),
                  support: l10n.shareSupport.selectOrFallback(option.name),
                  isSelected: share == option,
                  isEnabled: !isSaving && (option != MoodShare.moodNeed || need != null),
                  onTap: isSaving ? null : () => cubit.selectShare(option),
                ),
            ],
          ),
          const SizedBox(height: AppSpace.s20),
          BaseNote(text: l10n.privacyNote),
          const SizedBox(height: AppSpace.s16),
          Align(
            alignment: Alignment.centerLeft,
            child: BaseButton.text(
              text: context.l10n.sensitiveDays.entryTitle,
              icon: AppIcons.calendar,
              onPressed: () => context.pushRoute(const SensitiveDaysRoute()),
            ),
          ),
        ],
      ),
      footer: BaseButton(
        text: l10n.save,
        isEnabled: canSave,
        isLoading: isSaving,
        onPressed: cubit.save,
      ),
    );
  }
}
