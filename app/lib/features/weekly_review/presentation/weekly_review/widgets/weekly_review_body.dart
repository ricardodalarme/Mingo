import 'package:app/features/weekly_review/data/models/weekly_review.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

class const WeeklyReviewBody({required final WeeklyReview review, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.weeklyReview;
    final range = l10n.range(
      start: review.weekStart.day,
      end: review.weekEnd.day,
      month: l10n.months[review.weekEnd.month - 1],
    );

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: review.isQuiet ? l10n.quietTitle : l10n.title,
              highlight: review.isQuiet ? l10n.quietHighlight : l10n.titleHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(range, style: context.text.body.copyWith(color: context.colors.textSecondary)),
          const SizedBox(height: AppSpace.s20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: AppSpace.s10,
              children: [
                Expanded(
                  child: _Stat(
                    value: review.slips,
                    label: l10n.slips(count: review.slips),
                  ),
                ),
                Expanded(
                  child: _Stat(
                    value: review.moodDays,
                    label: l10n.moodDays(count: review.moodDays),
                  ),
                ),
                Expanded(
                  child: _Stat(
                    value: review.rituals,
                    label: l10n.rituals(count: review.rituals),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.s20),
          if (review.isQuiet) ...[
            BaseSurfaceCard(title: l10n.quietCardTitle, supportText: l10n.quietCardText),
            const SizedBox(height: AppSpace.s16),
          ],
          BaseNote(text: review.isQuiet ? l10n.quietNote : l10n.note),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (review.isQuiet)
            BaseButton(
              text: l10n.writeSlip,
              onPressed: () => context.router.root.push(const QuickSlipRoute()),
            )
          else
            BaseButton(text: l10n.talk, onPressed: () => context.router.replace(ChatRoute())),
          const SizedBox(height: AppSpace.s10),
          BaseButton(
            text: l10n.close,
            variant: .secondary,
            onPressed: () => context.router.maybePop(),
          ),
        ],
      ),
    );
  }
}

class const _Stat({required final int value, required final String label}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseSurfaceCard(
      padding: const EdgeInsets.all(AppSpace.s14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$value', style: context.text.titleLg),
          const SizedBox(height: AppSpace.s4),
          Text(label, style: context.text.caption.copyWith(color: context.colors.textSecondary)),
        ],
      ),
    );
  }
}
