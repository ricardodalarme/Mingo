import 'package:app/features/questions/data/models/question_thread.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

class const QuestionsRevealView({required final QuestionThread thread, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.questions;
    final partnerName = thread.prompt.partnerName;
    final partnerLabel = partnerName == null || partnerName.isEmpty
        ? l10n.partnerFallback
        : partnerName;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.revealTitle,
              highlight: l10n.revealHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseSurfaceCard(
            title: l10n.you,
            child: Text(thread.ownAnswer?.body ?? '', style: context.text.body),
          ),
          const SizedBox(height: AppSpace.s12),
          BaseSurfaceCard(
            title: partnerLabel,
            child: Text(thread.partnerAnswer?.body ?? '', style: context.text.body),
          ),
          const SizedBox(height: AppSpace.s20),
          Text(
            l10n.keepPrompt,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton.primary(
            text: l10n.saveMilestone,
            onPressed: () => context.pushRoute(MilestoneRoute(initialTitle: thread.prompt.title)),
          ),
          const SizedBox(height: AppSpace.s6),
          BaseButton.text(
            text: l10n.notNow,
            onPressed: () => context.router.maybePop(),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
