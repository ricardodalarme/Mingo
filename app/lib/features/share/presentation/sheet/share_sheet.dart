import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:app/features/share/presentation/sheet/cubit/share_sheet_cubit.dart';
import 'package:app/features/share/presentation/widgets/share_image_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Opens the share sheet for [cards]; nothing happens when there is nothing to share.
Future<void> openShareSheet({required BuildContext context, required List<ShareCard> cards}) {
  if (cards.isEmpty) return Future.value();

  final l10n = context.l10n.share;

  return BaseSheet.show<void>(
    context: context,
    title: l10n.sheetTitle,
    subtitle: l10n.sheetSubtitle,
    child: ShareSheet(cards: cards),
  );
}

/// The preview of one card and the action that renders and shares it.
class const ShareSheet({required final List<ShareCard> cards, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShareSheetCubit(
        repository: AppInjector.instance.get<ShareImageRepository>(),
      ),
      child: _ShareSheetBody(cards: cards),
    );
  }
}

class const _ShareSheetBody({required final List<ShareCard> cards}) extends StatefulWidget {
  @override
  State<_ShareSheetBody> createState() => _ShareSheetBodyState();
}

class _ShareSheetBodyState() extends State<_ShareSheetBody> {
  final GlobalKey _boundaryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.share;
    final cards = widget.cards;
    if (cards.isEmpty) return const SizedBox.shrink();

    final selected = context.select((ShareSheetCubit cubit) => cubit.state.selectedIndex);
    final isSharing = context.select((ShareSheetCubit cubit) => cubit.state.shareAction.isLoading);
    final cubit = context.read<ShareSheetCubit>();
    final index = selected.clamp(0, cards.length - 1);

    return BlocListener<ShareSheetCubit, ShareSheetState>(
      listenWhen: (previous, current) => previous.shareAction != current.shareAction,
      listener: (context, state) {
        final action = state.shareAction;
        if (action is Failure) {
          BaseToast.show(context, l10n.errors.selectOrFallback(action.exception.l10nKey));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (cards.length > 1) ...[
            BaseSegmented(
              segments: [
                for (final card in cards) l10n.cardLabels.selectOrFallback(card.kind.name),
              ],
              selectedIndex: index,
              onSelectionChanged: cubit.onSelected,
            ),
            const SizedBox(height: AppSpace.s20),
          ],
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: sharePreviewMaxWidth),
              child: ShareImagePreview(card: cards[index], boundaryKey: _boundaryKey),
            ),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseButton(
            text: l10n.shareAction,
            icon: AppIcons.share,
            isLoading: isSharing,
            onPressed: () => cubit.share(() => captureShareImage(_boundaryKey)),
          ),
        ],
      ),
    );
  }
}
