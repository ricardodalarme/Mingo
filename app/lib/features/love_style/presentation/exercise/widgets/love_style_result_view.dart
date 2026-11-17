import 'package:app/features/love_style/presentation/exercise/cubit/love_style_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The warm outcome of the quiz: what fits the person best, never a score.
class const LoveStyleResultView({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.loveStyle;
    final result = context.select((LoveStyleCubit cubit) => cubit.state.savedResult);
    final isInManual = context.select((LoveStyleCubit cubit) => cubit.state.isInManual);
    final isSavingManual = context.select((LoveStyleCubit cubit) => cubit.state.isSavingManual);
    final isSharing = context.select((LoveStyleCubit cubit) => cubit.state.isSharing);
    final isRevoking = context.select((LoveStyleCubit cubit) => cubit.state.isRevokingShare);
    final isShared = context.select((LoveStyleCubit cubit) => cubit.state.isShared);
    final hasPartner = context.select((LoveStyleCubit cubit) => cubit.state.hasPartner);
    final partnerName = context.select((LoveStyleCubit cubit) => cubit.state.partnerName);
    final pairingFailed = context.select((LoveStyleCubit cubit) => cubit.state.pairingFailed);
    final canCompare = context.select((LoveStyleCubit cubit) => cubit.state.canCompare);
    final cubit = context.read<LoveStyleCubit>();
    if (result == null) return const SizedBox.shrink();

    final name = partnerName ?? l10n.partnerFallback;
    final description = l10n.descriptions.selectOrFallback(result.topPattern);
    final top = result.ranked.take(2).toList();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.resultTitle,
              highlight: l10n.resultHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.resultSubtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              for (var index = 0; index < top.length; index++)
                BaseListTile(
                  leading: _RankBadge(number: index + 1),
                  title: l10n.labels.selectOrFallback(top[index]),
                ),
            ],
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.resultPrivacyNote),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton(
            text: isInManual ? l10n.savedManualAction : l10n.saveManualAction,
            isEnabled: !isInManual,
            isLoading: isSavingManual,
            onPressed: () => cubit.saveToManual(description),
          ),
          const SizedBox(height: AppSpace.s10),
          if (pairingFailed) ...[
            BaseNote(text: l10n.pairingErrorNote),
            BaseTextLink(text: l10n.retryPairing, onPressed: cubit.load),
          ] else if (!hasPartner) ...[
            BaseNote(text: l10n.shareSoloNote),
            BaseButton(
              text: l10n.inviteAction,
              variant: BaseButtonVariant.secondary,
              onPressed: () => context.pushRoute(const InviteRoute()),
            ),
          ] else if (canCompare) ...[
            BaseButton(
              text: l10n.compareAction,
              variant: BaseButtonVariant.secondary,
              onPressed: () => context.pushRoute(const LoveStyleCompareRoute()),
            ),
            const SizedBox(height: AppSpace.s6),
            BaseButton.text(
              text: l10n.revokeAction(name: name),
              isLoading: isRevoking,
              onPressed: cubit.revokeShare,
              isFullWidth: true,
            ),
          ] else if (isShared) ...[
            BaseButton(
              text: l10n.revokeAction(name: name),
              variant: BaseButtonVariant.secondary,
              isLoading: isRevoking,
              onPressed: cubit.revokeShare,
            ),
          ] else
            BaseButton(
              text: l10n.shareAction(name: name),
              variant: BaseButtonVariant.secondary,
              isLoading: isSharing,
              onPressed: () => _confirmShare(context, cubit, name),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmShare(BuildContext context, LoveStyleCubit cubit, String name) async {
    final l10n = context.l10n.loveStyle;
    final confirmed = await BaseSheet.show<bool>(
      context: context,
      title: l10n.shareConfirmTitle(name: name),
      subtitle: l10n.shareConfirmText(name: name),
      hasCloseButton: false,
      child: Builder(
        builder: (sheetContext) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpace.s6,
          children: [
            BaseButton.primary(
              text: l10n.shareConfirm,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
            BaseButton.text(
              text: l10n.shareCancel,
              onPressed: () => Navigator.of(sheetContext).pop(false),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
    if (confirmed ?? false) await cubit.share();
  }
}

class const _RankBadge({required final int number}) extends StatelessWidget {
  static const double _size = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.bgScreen,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: AppBorders.hair(context.colors.borderDefault),
      ),
      child: Text(
        '$number',
        style: context.text.label.copyWith(color: context.colors.textSecondary),
      ),
    );
  }
}
