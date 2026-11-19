import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:app/features/gifts/presentation/gift_sheet/gift_sheet.dart';
import 'package:app/features/gifts/presentation/gifts/cubit/gifts_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_launcher_service/link_launcher_service.dart';

/// The wishes a person shares with their partner, and the partner's wishes.
@RoutePage()
class const GiftsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<GiftsCubit>()..load(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gifts;
    final gifts = context.select((GiftsCubit cubit) => cubit.state.gifts);
    final hasPartner = context.select((GiftsCubit cubit) => cubit.state.hasPartner);
    final cubit = context.read<GiftsCubit>();
    final loaded = gifts is Success<List<GiftIdea>>;

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<GiftsCubit, GiftsState>(
        listenWhen: (previous, current) => previous.saveAction != current.saveAction,
        listener: (context, state) {
          final action = state.saveAction;
          if (action is Failure) {
            BaseToast.show(context, l10n.errors.selectOrFallback(action.exception.l10nKey));
          }
        },
        child: BaseRefreshable(
          onRefresh: cubit.load,
          child: BaseStackedContent(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseNote(text: l10n.subtitle, icon: AppIcons.gift),
                const SizedBox(height: AppSpace.s16),
                SkeletonizerResourceWidget<List<GiftIdea>>(
                  gifts,
                  fakeValue: [GiftIdea.fake(), GiftIdea.fake()],
                  successBuilder: (values) => values.isEmpty
                      ? BaseEmptyState(
                          title: l10n.emptyPageTitle,
                          text: hasPartner ? l10n.emptyPageTextShared : l10n.emptyPageTextSolo,
                        )
                      : _GiftSections(gifts: values, hasPartner: hasPartner),
                  failureBuilder: (exception) =>
                      AppErrorView(exception: exception, onRetry: cubit.load),
                ),
              ],
            ),
            footer: loaded
                ? BaseButton(
                    text: l10n.add,
                    icon: AppIcons.plus,
                    onPressed: () => _addGift(context),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class const _GiftSections({required final List<GiftIdea> gifts, required final bool hasPartner})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gifts;
    final myGifts = [
      for (final gift in gifts)
        if (gift.isMine) gift,
    ];
    final partnerGifts = [
      for (final gift in gifts)
        if (!gift.isMine) gift,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(text: l10n.myTitle),
        const SizedBox(height: AppSpace.s8),
        if (myGifts.isEmpty)
          BaseEmptyState(title: l10n.emptyMineTitle, text: l10n.emptyMineText)
        else
          BaseListGroup(children: [for (final gift in myGifts) _GiftTile(gift: gift)]),
        if (hasPartner) ...[
          const SizedBox(height: AppSpace.s24),
          _SectionTitle(text: l10n.partnerTitle),
          const SizedBox(height: AppSpace.s8),
          if (partnerGifts.isEmpty)
            BaseEmptyState(title: l10n.emptyPartnerTitle, text: l10n.emptyPartnerText)
          else
            BaseListGroup(
              children: [for (final gift in partnerGifts) _PartnerGiftTile(gift: gift)],
            ),
        ],
      ],
    );
  }
}

class const _SectionTitle({required final String text}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(header: true, child: Text(text, style: context.text.titleSm));
  }
}

class const _GiftTile({required final GiftIdea gift}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseListTile(
      title: gift.title,
      titleMaxLines: 1,
      subtitle: gift.note,
      subtitleMaxLines: 2,
      trailing: gift.link == null ? null : _BuyLink(link: gift.link!),
      onTap: () => _editGift(context, gift),
    );
  }
}

class const _PartnerGiftTile({required final GiftIdea gift}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseListTile(
      icon: AppIcons.gift,
      title: gift.title,
      titleMaxLines: 1,
      subtitle: gift.note,
      subtitleMaxLines: 2,
      trailing: gift.link == null ? null : _BuyLink(link: gift.link!),
    );
  }
}

class const _BuyLink({required final String link}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.gifts;

    return AppPressable(
      onTap: () => _openLink(context, link),
      semanticLabel: l10n.openLink,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      enforceMinTapTarget: true,
      child: AppIcon(icon: AppIcons.link, color: context.colors.iconMuted),
    );
  }
}

Future<void> _openLink(BuildContext context, String link) async {
  final l10n = context.l10n.gifts;
  final opened = await AppInjector.instance.get<LinkLauncherService>().openExternal(
    Uri.parse(link),
  );
  if (!opened && context.mounted) BaseToast.show(context, l10n.openFailed);
}

Future<void> _addGift(BuildContext context) async {
  final l10n = context.l10n.gifts;
  final cubit = context.read<GiftsCubit>();
  final draft = await BaseSheet.show<GiftDraft>(
    context: context,
    title: l10n.addTitle,
    child: const GiftSheet(),
  );
  if (draft == null || draft.isDelete || !context.mounted) return;

  await cubit.add(title: draft.title, note: draft.note, link: draft.link);
}

Future<void> _editGift(BuildContext context, GiftIdea gift) async {
  final l10n = context.l10n.gifts;
  final cubit = context.read<GiftsCubit>();
  final draft = await BaseSheet.show<GiftDraft>(
    context: context,
    title: l10n.editTitle,
    child: GiftSheet(gift: gift),
  );
  if (draft == null || !context.mounted) return;

  if (draft.isDelete) {
    await _deleteGift(context, gift);

    return;
  }
  await cubit.edit(gift, title: draft.title, note: draft.note, link: draft.link);
}

Future<void> _deleteGift(BuildContext context, GiftIdea gift) async {
  final l10n = context.l10n.gifts;
  final confirmed = await BaseConfirmSheet.show(
    context: context,
    title: l10n.deleteTitle,
    text: l10n.deleteText,
    confirmText: l10n.deleteConfirm,
    isDestructive: true,
  );
  if (confirmed && context.mounted) await context.read<GiftsCubit>().delete(gift);
}
