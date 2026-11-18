import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/features/mood/presentation/mood/widgets/mood_row.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_hint.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hoje's first block: the person's own mood and the partner's shared mood.
class const TodayMoodBlock({final bool isFirstDay = false, super.key}) extends StatelessWidget {
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
    final audience = context.select((MoodCubit cubit) => cubit.state.savedAudience);
    final partnerMood = context.select((MoodCubit cubit) => cubit.state.partnerMood);
    final partnerName = context.select((MoodCubit cubit) => cubit.state.partnerName);
    final selectedIndex = mood == null ? null : _homeMoods.indexOf(mood);
    final hasName = partnerName != null && partnerName.isNotEmpty;
    final privacyLabel = switch (audience) {
      MoodShare.none => l10n.homePrivacy,
      MoodShare.mood || MoodShare.moodNeed =>
        hasName ? l10n.homePrivacyShared(name: partnerName) : l10n.homePrivacySharedNoName,
    };

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
          if (!isFirstDay)
            SkeletonizerResourceWidget<MoodEntry?>(
              entry,
              fakeValue: null,
              successBuilder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MoodRow(
                    title: l10n.homeTitle,
                    actionLabel: privacyLabel,
                    onAction: () => _openDetails(context),
                    longPressHint: l10n.homeHoldHint,
                    onLongPressed: (index) => _openDetails(context, mood: _homeMoods[index]),
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
                  const SizedBox(height: AppSpace.s12),
                  if (partnerMood != null && partnerMood.isVisible) ...[
                    PartnerMoodHint(
                      partnerMood: partnerMood,
                      partnerName: partnerName,
                      onReact: context.read<MoodCubit>().reactToPartner,
                      onAskToTalk: context.read<MoodCubit>().askToTalk,
                      onSendMessage: () =>
                          context.read<MoodCubit>().sendSweetMessage(helpL10n.sweetMessageBody),
                    ),
                    const SizedBox(height: AppSpace.s4),
                  ],
                  const SizedBox(height: AppSpace.s16),
                ],
              ),
              failureBuilder: (_) => BaseListTile(
                title: l10n.homeTitle,
                subtitle: l10n.homeLoadFailed,
                onTap: () => _openDetails(context),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _openDetails(BuildContext context, {MoodKind? mood}) async {
    await context.pushRoute(MoodRoute(initialMood: mood?.name));
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
