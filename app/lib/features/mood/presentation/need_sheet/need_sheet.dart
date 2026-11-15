import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_grid.dart';
import 'package:app/features/mood/presentation/need_sheet/cubit/need_sheet_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Opens the "Preciso de…" menu and saves the choice on today's row.
///
/// It reads the mood, need and audience already on screen, so the person does not answer the
/// mood again; only a day without a mood asks for one, because the row cannot exist without it.
Future<void> showNeedSheet(BuildContext context) async {
  final cubit = context.read<MoodCubit>();
  final l10n = context.l10n.mood;
  final draft = await BaseSheet.show<NeedDraft>(
    context: context,
    title: l10n.needTitle,
    subtitle: l10n.needSheetSubtitle,
    child: NeedSheet(mood: cubit.state.mood, need: cubit.state.need, share: cubit.state.share),
  );
  if (draft == null) return;

  await cubit.saveNeed(mood: draft.mood, need: draft.need);
}

class const NeedSheet({
  required final MoodKind? mood,
  required final NeedKind? need,
  required final MoodShare share,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AppInjector.instance.get<NeedSheetCubit>()..start(mood: mood, need: need, share: share),
      child: const _NeedSheetContent(),
    );
  }
}

class const _NeedSheetContent() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final mood = context.select((NeedSheetCubit cubit) => cubit.state.mood);
    final need = context.select((NeedSheetCubit cubit) => cubit.state.need);
    final share = context.select((NeedSheetCubit cubit) => cubit.state.share);
    final canSave = context.select((NeedSheetCubit cubit) => cubit.state.canSave);
    final cubit = context.read<NeedSheetCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (mood == null) ...[
          Text(l10n.entryTitle, style: context.text.titleSm),
          const SizedBox(height: AppSpace.s10),
          MoodGrid(selected: mood, onSelected: cubit.selectMood),
          const SizedBox(height: AppSpace.s24),
        ],
        Wrap(
          spacing: AppSpace.s8,
          runSpacing: AppSpace.s8,
          children: [
            for (final option in NeedKind.values)
              BaseChoiceChip(
                label: l10n.needs.selectOrFallback(option.name),
                isSelected: need == option,
                onTap: () => cubit.selectNeed(option),
              ),
          ],
        ),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.shareSupport.selectOrFallback(share.name)),
        const SizedBox(height: AppSpace.s20),
        BaseButton(
          text: l10n.save,
          isEnabled: canSave,
          onPressed: () => Navigator.of(context).pop(cubit.submit()),
        ),
      ],
    );
  }
}
