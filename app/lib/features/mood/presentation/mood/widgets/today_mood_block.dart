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
/// Hoje's home query. A face saves the mood on the tap; the need and the share choice have their
/// own entries under the strip.
class const TodayMoodBlock({
  final bool isFirstDay = false,
  final bool hasPendingInvite = false,
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
    final l10n = context.l10n.mood;
    final helpL10n = context.l10n.moodHelp;
    final entry = context.select((MoodCubit cubit) => cubit.state.entry);
    final mood = context.select((MoodCubit cubit) => cubit.state.mood);
    final partnerMood = context.select((MoodCubit cubit) => cubit.state.partnerMood);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final selectedIndex = mood == null ? null : _homeMoods.indexOf(mood);

    return BlocListener<MoodCubit, MoodState>(
      listenWhen: (previous, current) =>
          previous.saveAction != current.saveAction ||
          previous.needAction != current.needAction ||
          previous.reactAction != current.reactAction ||
          previous.talkAction != current.talkAction ||
          previous.messageAction != current.messageAction,
      listener: _onActionChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (partnerMood != null && partnerMood.isVisible) ...[
            PartnerMoodHint(
              partnerMood: partnerMood,
              partnerName: partnerName,
              onReact: context.read<MoodCubit>().reactToPartner,
              onAskToTalk: context.read<MoodCubit>().askToTalk,
              onSendMessage: () =>
                  context.read<MoodCubit>().sendSweetMessage(helpL10n.sweetMessageBody),
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
                    onSelected: (index) =>
                        context.read<MoodCubit>().saveTodayMood(_homeMoods[index]),
                  ),
                  const SizedBox(height: AppSpace.s8),
                  const _NeedEntry(),
                  const SizedBox(height: AppSpace.s8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BaseButton.text(
                      text: l10n.homeDetailsLink,
                      onPressed: () => _openDetails(context),
                    ),
                  ),
                  const SizedBox(height: AppSpace.s16),
                ],
              ),
              failureBuilder: (_) => const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }

  Future<void> _openDetails(BuildContext context) async {
    await context.pushRoute(MoodRoute());
    if (context.mounted) await context.read<MoodCubit>().load();
  }

  void _onActionChanged(BuildContext context, MoodState state) {
    final l10n = context.l10n;
    if (state.saveAction case Failure(:final exception)) {
      BaseToast.show(
        context,
        l10n.mood.errors.selectOrFallback(exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    if (state.needAction case Failure(:final exception)) {
      BaseToast.show(
        context,
        l10n.mood.errors.selectOrFallback(exception.l10nKey),
        variant: BaseToastVariant.error,
      );

      return;
    }
    for (final action in [state.reactAction, state.talkAction, state.messageAction]) {
      if (action case Failure(:final exception)) {
        BaseToast.show(
          context,
          l10n.moodHelp.errors.selectOrFallback(exception.l10nKey),
          variant: BaseToastVariant.error,
        );

        return;
      }
    }
    if (state.needAction is Success) BaseToast.show(context, l10n.mood.needSaved);
    if (state.reactAction is Success) BaseToast.show(context, l10n.moodHelp.sent);
    if (state.talkAction is Success) BaseToast.show(context, l10n.moodHelp.askSent);
    if (state.messageAction is Success) BaseToast.show(context, l10n.moodHelp.messageSent);
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
