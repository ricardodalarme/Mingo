import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/cards/presentation/draft/cubit/sunday_card_cubit.dart';
import 'package:app/features/cards/presentation/draft/widgets/sunday_card_status_views.dart';
import 'package:app/features/cards/presentation/shared/widgets/card_view.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The draft card, either to read or to change.
class const SundayCardBody({required final SundayCard card, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.sundayCard;
    final draft = context.select((SundayCardCubit cubit) => cubit.state.draft);
    final selfName = context.select((SundayCardCubit cubit) => cubit.state.selfName);
    final partnerName = context.select((SundayCardCubit cubit) => cubit.state.partnerName);
    final isSaving = context.select((SundayCardCubit cubit) => cubit.state.saveAction.isLoading);
    final isPaired = context.select((SundayCardCubit cubit) => cubit.state.isPaired);
    final isDelivering = context.select(
      (SundayCardCubit cubit) => cubit.state.deliverAction.isLoading,
    );
    final sendDay = context.select((SundayCardCubit cubit) => cubit.state.sendDay);
    final cubit = context.read<SundayCardCubit>();
    final shown = draft ?? card;
    final excluded = context.select((SundayCardCubit cubit) => cubit.state.excludedIds);

    if (card.isHeldByRule && draft == null) return SundayCardHeldByRule(reason: card.heldReason!);
    if (card.isHeld && draft == null) return const SundayCardHeld();
    if (card.isSent) return const SundayCardSent();
    if (shown.items.isEmpty && draft == null) {
      return BaseEmptyState(
        title: l10n.emptyTitle,
        text: l10n.emptyText,
        actionText: l10n.emptyAction,
        onAction: () => context.router.root.push(const QuickSlipRoute()),
      );
    }

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (draft == null)
            CardView(card: shown, fromName: selfName, toName: partnerName)
          else ...[
            Semantics(header: true, child: Text(l10n.editTitle, style: context.text.titleXl)),
            const SizedBox(height: AppSpace.s4),
            Text(
              l10n.editSubtitle,
              style: context.text.body.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s16),
            BaseListGroup(
              children: [
                for (final item in draft.items)
                  BaseListTile(
                    title: item.body,
                    subtitle: excluded.contains(item.id) ? l10n.notIncluded : l10n.included,
                    control: BaseSwitch(
                      value: !excluded.contains(item.id),
                      semanticLabel: item.body,
                      onChanged: (_) => cubit.toggleItem(item.id),
                    ),
                  ),
              ],
            ),
          ],
          if (draft == null && sendDay != null) ...[
            const SizedBox(height: AppSpace.s12),
            BaseListGroup(
              footer: l10n.dayNote,
              children: [
                BaseListTile(
                  icon: AppIcons.calendar,
                  title: l10n.dayTitle,
                  trailing: Text(
                    context.l10n.notificationPreferences.days[sendDay],
                    style: context.text.body.copyWith(color: context.colors.textSecondary),
                  ),
                  showsChevron: true,
                  onTap: () => _chooseDay(context, sendDay),
                ),
              ],
            ),
          ],
          if (draft != null) ...[
            const SizedBox(height: AppSpace.s16),
            BaseTextArea(
              text: draft.note,
              hint: l10n.noteHint,
              maxLength: cardNoteMaxLength,
              maxLines: 3,
              onChanged: cubit.onNoteChanged,
            ),
            const SizedBox(height: AppSpace.s12),
            BaseButton.secondary(
              text: l10n.preview,
              isFullWidth: true,
              onPressed: () => _preview(context, draft, excluded, selfName, partnerName),
            ),
          ],
        ],
      ),
      footer: draft == null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isPaired) ...[
                  BaseNote(text: l10n.send.needsPartner),
                  const SizedBox(height: AppSpace.s12),
                ],
                Row(
                  children: [
                    BaseButton(
                      text: l10n.edit,
                      variant: .secondary,
                      isFullWidth: false,
                      onPressed: cubit.startEditing,
                    ),
                    const SizedBox(width: AppSpace.s12),
                    Expanded(
                      child: isPaired
                          ? BaseButton(
                              text: l10n.send.action,
                              isLoading: isDelivering,
                              onPressed: () => confirmSend(context),
                            )
                          : BaseButton(
                              text: l10n.send.invite,
                              onPressed: () => context.pushRoute(const InviteRoute()),
                            ),
                    ),
                  ],
                ),
                BaseTextLink(text: l10n.hold.action, onPressed: () => confirmHold(context)),
              ],
            )
          : Row(
              children: [
                BaseButton(
                  text: l10n.cancel,
                  variant: .text,
                  isFullWidth: false,
                  onPressed: cubit.cancelEditing,
                ),
                const SizedBox(width: AppSpace.s12),
                Expanded(
                  child: BaseButton(text: l10n.save, isLoading: isSaving, onPressed: cubit.save),
                ),
              ],
            ),
    );
  }
}

Future<void> _chooseDay(BuildContext context, int current) async {
  final cubit = context.read<SundayCardCubit>();
  final days = context.l10n.notificationPreferences.days;

  final chosen = await BaseSheet.show<int>(
    context: context,
    title: context.l10n.sundayCard.dayTitle,
    child: BaseListGroup(
      children: [
        for (var day = 0; day < days.length; day++)
          BaseListTile(
            title: days[day],
            trailing: day == current ? const Icon(AppIcons.check) : null,
            onTap: () => Navigator.pop(context, day),
          ),
      ],
    ),
  );
  if (chosen != null) await cubit.setSendDay(chosen);
}

Future<void> _preview(
  BuildContext context,
  SundayCard draft,
  Set<String> excluded,
  String? selfName,
  String? partnerName,
) {
  final included = draft.copyWith(
    items: [
      for (final item in draft.items)
        if (!excluded.contains(item.id)) item,
    ],
  );

  return BaseSheet.show<void>(
    context: context,
    title: context.l10n.sundayCard.preview,
    child: CardView(card: included, fromName: selfName, toName: partnerName),
  );
}
