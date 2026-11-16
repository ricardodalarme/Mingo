import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_help_sheet.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_mood_listen_sheet.dart';
import 'package:app/features/mood/presentation/mood/widgets/partner_need_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The partner's shared mood for today.
///
/// A shared need opens the sheet that answers it, before any mood routing. Otherwise a good mood
/// offers a one-tap reaction and a low one opens the help that fits it. The bad-day screen belongs
/// to the person's own jar and never opens from here.
class const PartnerMoodHint({
  required final PartnerMood partnerMood,
  final String? partnerName,
  final VoidCallback? onReact,
  final VoidCallback? onAskToTalk,
  final VoidCallback? onSendMessage,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mood = partnerMood.mood;
    if (mood == null) return const SizedBox.shrink();

    final l10n = context.l10n.mood;
    final helpL10n = context.l10n.moodHelp;
    final name = partnerName ?? l10n.partnerFallback;
    final line = switch (mood) {
      MoodKind.happy => l10n.partnerHappy(name: name),
      MoodKind.tired => l10n.partnerTired(name: name),
      MoodKind.sad => l10n.partnerSad(name: name),
      MoodKind.stressed => l10n.partnerStressed(name: name),
      MoodKind.loving => l10n.partnerLoving(name: name),
      MoodKind.playful => l10n.partnerPlayful(name: name),
    };
    final needLine = switch (partnerMood.need) {
      NeedKind.listen => l10n.partnerNeedListen,
      NeedKind.opinion => l10n.partnerNeedOpinion,
      NeedKind.hug => l10n.partnerNeedHug,
      NeedKind.space => l10n.partnerNeedSpace,
      NeedKind.chocolate => l10n.partnerNeedChocolate,
      NeedKind.cuteMessage => l10n.partnerNeedCuteMessage,
      NeedKind.foreheadKiss => l10n.partnerNeedForeheadKiss,
      NeedKind.company => l10n.partnerNeedCompany,
      NeedKind.rest => l10n.partnerNeedRest,
      null => null,
    };
    final need = partnerMood.need;
    final isGoodMood =
        mood == MoodKind.happy || mood == MoodKind.loving || mood == MoodKind.playful;

    return BaseListGroup(
      children: [
        BaseListTile(
          title: line,
          subtitle: needLine,
          leading: BaseFace(kind: mood.face, size: FaceSize.small),
          trailing: isGoodMood && onReact != null
              ? BaseRoundButton(
                  icon: AppIcons.heart_filled,
                  semanticLabel: helpL10n.reactionLabel,
                  onPressed: onReact,
                )
              : null,
          showsChevron: !(isGoodMood && onReact != null),
          onTap: need != null
              ? () => _openNeed(context, need)
              : switch (mood) {
                  MoodKind.happy || MoodKind.loving || MoodKind.playful => null,
                  MoodKind.tired || MoodKind.stressed => () => _openHelp(context, mood),
                  MoodKind.sad => () => _openListen(context),
                },
        ),
      ],
    );
  }

  Future<void> _openNeed(BuildContext context, NeedKind need) async {
    final l10n = context.l10n.moodHelp;
    final name = partnerName?.trim();
    final answer = await BaseSheet.show<PartnerNeedAnswer>(
      context: context,
      title: name == null || name.isEmpty
          ? l10n.partnerNeedTitleGeneric
          : l10n.partnerNeedTitle(name: name),
      subtitle: l10n.partnerNeedSubtitle,
      child: PartnerNeedSheet(need: need),
    );
    if (!context.mounted) return;

    switch (answer) {
      case PartnerNeedAnswer.hug:
        onReact?.call();
      case PartnerNeedAnswer.chat:
        await context.pushRoute(ChatRoute());
      case null:
        return;
    }
  }

  Future<void> _openHelp(BuildContext context, MoodKind mood) async {
    final l10n = context.l10n.moodHelp;
    final action = await BaseSheet.show<PartnerMoodHelpAction>(
      context: context,
      title: l10n.helpTitle,
      subtitle: l10n.helpSubtitle,
      child: PartnerMoodHelpSheet(mood: mood),
    );
    if (!context.mounted) return;

    switch (action) {
      case PartnerMoodHelpAction.sendMessage:
        onSendMessage?.call();
      case null:
        return;
    }
  }

  Future<void> _openListen(BuildContext context) async {
    final l10n = context.l10n.moodHelp;
    final action = await BaseSheet.show<PartnerMoodListenAction>(
      context: context,
      title: l10n.listenTitle,
      subtitle: l10n.listenSubtitle,
      child: const PartnerMoodListenSheet(),
    );
    if (!context.mounted) return;

    switch (action) {
      case PartnerMoodListenAction.sendLove:
        onReact?.call();
      case PartnerMoodListenAction.askToTalk:
        onAskToTalk?.call();
      case PartnerMoodListenAction.seeHowToHelp:
        await _openHelp(context, MoodKind.sad);
      case null:
        return;
    }
  }
}
