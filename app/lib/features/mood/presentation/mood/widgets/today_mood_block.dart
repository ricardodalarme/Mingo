import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_row.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_hint.dart';
import 'package:app/features/mood/presentation/need_sheet/need_sheet.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hoje's first block: the person's own mood and the partner's shared mood.
///
/// It reads [MoodCubit], so it paints as soon as the mood read returns instead of waiting for
/// Hoje's home query.
class const TodayMoodBlock({
  required final bool isDiscreet,
  final bool isFirstDay = false,
  final bool hasPendingInvite = false,
  final bool isPaused = false,
  super.key,
}) extends StatelessWidget {
  static const _homeMoods = <MoodKind>[
    // Hoje shows the board's five-mood subset; the Mood screen keeps all six.
    MoodKind.happy,
    MoodKind.loving,
    MoodKind.tired,
    MoodKind.stressed,
    MoodKind.sad,
  ];

  @override
  Widget build(BuildContext context) {
    if (isPaused) return const SizedBox.shrink();

    final l10n = context.l10n.mood;
    final entry = context.select((MoodCubit cubit) => cubit.state.entry);
    final mood = context.select((MoodCubit cubit) => cubit.state.mood);
    final partnerMood = context.select((MoodCubit cubit) => cubit.state.partnerMood);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final selectedIndex = mood == null ? null : _homeMoods.indexOf(mood);

    return BlocListener<MoodCubit, MoodState>(
      listenWhen: (previous, current) => previous.needAction != current.needAction,
      listener: _onNeedChanged,
      child: BlocListener<MoodCubit, MoodState>(
        listenWhen: (previous, current) => previous.reactAction != current.reactAction,
        listener: _onReactionChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isDiscreet && partnerMood != null && partnerMood.isVisible) ...[
              PartnerMoodHint(
                partnerMood: partnerMood,
                partnerName: partnerName,
                isDiscreet: isDiscreet,
                onReact: context.read<MoodCubit>().reactToPartner,
              ),
              const SizedBox(height: AppSpace.s24),
            ],
            if (!isFirstDay && !hasPendingInvite)
              SkeletonizerResourceWidget<MoodEntry?>(
                entry,
                fakeValue: null,
                successBuilder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MoodRow(
                      title: l10n.homeTitle,
                      actionLabel: l10n.homePrivacy,
                      options: [
                        for (final option in _homeMoods)
                          MoodRowOption(
                            face: option.face,
                            label: l10n.homeMoods.selectOrFallback(option.name),
                          ),
                      ],
                      selectedIndex: selectedIndex == null || selectedIndex < 0
                          ? null
                          : selectedIndex,
                      onSelected: (index) async {
                        await context.pushRoute(MoodRoute(initialMood: _homeMoods[index].name));
                        if (context.mounted) await context.read<MoodCubit>().load();
                      },
                    ),
                    const SizedBox(height: AppSpace.s8),
                    const _NeedEntry(),
                  ],
                ),
                failureBuilder: (_) => const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }

  void _onNeedChanged(BuildContext context, MoodState state) {
    final action = state.needAction;
    final l10n = context.l10n.mood;
    if (action is Failure) {
      BaseToast.show(
        context,
        l10n.errors.selectOrFallback(action.exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    if (action is Success) BaseToast.show(context, l10n.needSaved);
  }

  void _onReactionChanged(BuildContext context, MoodState state) {
    final action = state.reactAction;
    final l10n = context.l10n.moodHelp;
    if (action is Failure) {
      BaseToast.show(
        context,
        l10n.errors.selectOrFallback(action.exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    if (action is Success) BaseToast.show(context, l10n.sent);
  }
}

/// The quiet entry into the "Preciso de…" menu, showing what is already asked for.
class const _NeedEntry() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final need = context.select((MoodCubit cubit) => cubit.state.need);
    final isSaving = context.select((MoodCubit cubit) => cubit.state.needAction.isLoading);
    final label = need == null
        ? l10n.needMenuAction
        : l10n.needMenuActionSelected(need: l10n.needs.selectOrFallback(need.name));

    return Align(
      alignment: Alignment.centerLeft,
      child: BaseButton.text(
        text: label,
        icon: AppIcons.heart,
        onPressed: isSaving ? null : () => showNeedSheet(context),
      ),
    );
  }
}
