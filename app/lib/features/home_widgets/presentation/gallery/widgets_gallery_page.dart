import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/gallery/cubit/widgets_gallery_cubit.dart';
import 'package:app/features/widgets/presentation/shared/how_to_add_sheet.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widgets gallery (`X-145`): the most-loved widgets, the medium ones, the
/// personal set and the two settings that decide what a widget may show.
@RoutePage()
class const WidgetsGalleryPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<WidgetsGalleryCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((WidgetsGalleryCubit cubit) => cubit.state.overview);
    final saveAction = context.select((WidgetsGalleryCubit cubit) => cubit.state.saveAction);
    final cubit = context.read<WidgetsGalleryCubit>();

    return BlocListener<WidgetsGalleryCubit, WidgetsGalleryState>(
      listenWhen: (previous, current) => previous.saveAction != current.saveAction,
      listener: (context, state) {
        final action = state.saveAction;
        if (action is Success) {
          BaseToast.show(context, l10n.settingsSaved);
        } else if (action is Failure) {
          BaseToast.show(
            context,
            l10n.errors.selectOrFallback(action.exception.l10nKey),
            variant: BaseToastVariant.error,
          );
        }
      },
      child: BaseView(
        appBar: BaseAppBar(title: l10n.galleryTitle),
        body: BaseStackedContent(
          body: SkeletonizerResourceWidget<WidgetOverview>(
            overviewResource,
            fakeValue: WidgetOverview.fake(),
            failureBuilder: (_) => BaseErrorState(
              title: l10n.loadErrorTitle,
              text: l10n.loadErrorBody,
              actionText: l10n.retryAction,
              onAction: cubit.load,
            ),
            successBuilder: (overview) => _GalleryBody(
              overview: overview,
              isSaving: saveAction is Loading,
              onOpenFamily: (family) => _openFamily(context, cubit, family),
              onOpenOwnSmall: () => _pushAndReload(context, cubit, const OwnSmallWidgetsRoute()),
              onOpenOwnMedium: () => _pushAndReload(context, cubit, const OwnMediumWidgetsRoute()),
              onSavePrivacy: cubit.savePrivacy,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openFamily(
    BuildContext context,
    WidgetsGalleryCubit cubit,
    WidgetFamily family,
  ) async {
    final route = switch (family) {
      .counter || .counterMedium => const CoupleCounterWidgetRoute() as PageRouteInfo<void>,
      .partnerMood || .longing => const MoodLongingWidgetRoute(),
      .ritual => const RitualsRoute(),
      .partnerNote => const PartnerNoteWidgetRoute(),
      .cardEncounter => const CardEncounterWidgetRoute(),
      .distance => const DistanceRoute(),
      .ownSlip || .ownNextDate || .ownRitual || .ownSundayCard => const OwnSmallWidgetsRoute(),
      .ownWeek || .ownIdea || .ownMediumDate => const OwnMediumWidgetsRoute(),
    };
    await _pushAndReload(context, cubit, route);
  }

  Future<void> _pushAndReload(
    BuildContext context,
    WidgetsGalleryCubit cubit,
    PageRouteInfo<void> route,
  ) async {
    await context.pushRoute(route);
    if (context.mounted) await cubit.load();
  }
}

class const _GalleryBody({
  required final WidgetOverview overview,
  required final bool isSaving,
  required final ValueChanged<WidgetFamily> onOpenFamily,
  required final VoidCallback onOpenOwnSmall,
  required final VoidCallback onOpenOwnMedium,
  required final void Function({required bool showNames, required bool allowPartnerNotes})
  onSavePrivacy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final payload = overview.payload;
    final isPaired = payload.isPaired && payload.isSignedIn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.gallerySubtitle,
          style: context.text.body.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpace.s16),
        if (payload.isOffline) ...[
          BaseNote(text: l10n.offlineBanner, icon: AppIcons.wifi_off),
          const SizedBox(height: AppSpace.s12),
        ],
        if (isPaired) ...[
          BaseSectionHeader(title: l10n.favoritesGroup, isLabel: true),
          const SizedBox(height: AppSpace.s8),
          _FamilyGrid(
            families: widgetFamilyFavorites,
            payload: payload,
            onOpenFamily: onOpenFamily,
          ),
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: l10n.mediumGroup, isLabel: true),
          const SizedBox(height: AppSpace.s8),
          _MediumList(families: widgetFamilyMedium, payload: payload, onOpenFamily: onOpenFamily),
          const SizedBox(height: AppSpace.s24),
        ] else ...[
          BaseNote(text: l10n.soloBanner, icon: AppIcons.heart),
          const SizedBox(height: AppSpace.s16),
        ],
        BaseSectionHeader(title: l10n.ownGroupTitle, isLabel: true),
        const SizedBox(height: AppSpace.s8),
        BaseListCard(
          categoryLabel: l10n.galleryTitle,
          title: l10n.ownSmallTitle,
          supportText: l10n.ownSmallEntryHint,
          icon: AppIcons.smartphone,
          onTap: onOpenOwnSmall,
        ),
        const SizedBox(height: AppSpace.s12),
        BaseListCard(
          categoryLabel: l10n.galleryTitle,
          title: l10n.ownMediumTitle,
          supportText: l10n.ownMediumEntryHint,
          icon: AppIcons.smartphone,
          onTap: onOpenOwnMedium,
        ),
        const SizedBox(height: AppSpace.s8),
        BaseNote(text: l10n.ownGroupHint),
        if (isPaired) ...[
          const SizedBox(height: AppSpace.s24),
          BaseSectionHeader(title: l10n.widgetPrivacyTitle, isLabel: true, showsLock: true),
          const SizedBox(height: AppSpace.s8),
          BaseListGroup(
            children: [
              BaseListTile(
                title: l10n.showNamesTitle,
                subtitle: l10n.showNamesHint,
                isEnabled: !isSaving,
                control: BaseSwitch(
                  value: overview.preferences.showNames,
                  semanticLabel: l10n.showNamesTitle,
                  onChanged: (value) => onSavePrivacy(
                    showNames: value,
                    allowPartnerNotes: overview.preferences.allowPartnerNotes,
                  ),
                ),
              ),
              BaseListTile(
                title: l10n.allowNotesTitle,
                subtitle: l10n.allowNotesHint,
                isEnabled: !isSaving,
                control: BaseSwitch(
                  value: overview.preferences.allowPartnerNotes,
                  semanticLabel: l10n.allowNotesTitle,
                  onChanged: (value) => onSavePrivacy(
                    showNames: overview.preferences.showNames,
                    allowPartnerNotes: value,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s8),
          BaseNote(text: l10n.privacySectionHint, icon: AppIcons.shield),
        ],
        const SizedBox(height: AppSpace.s24),
        BaseButton(
          text: l10n.howToAddAction,
          variant: BaseButtonVariant.secondary,
          onPressed: () => showHowToAddSheet(context),
        ),
      ],
    );
  }
}

class const _FamilyGrid({
  required final List<WidgetFamily> families,
  required final WidgetPayload payload,
  required final ValueChanged<WidgetFamily> onOpenFamily,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var index = 0; index < families.length; index += 2) {
      final first = families[index];
      final second = index + 1 < families.length ? families[index + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FamilyTile(family: first, payload: payload, onTap: onOpenFamily),
            ),
            const SizedBox(width: AppSpace.s12),
            Expanded(
              child: second == null
                  ? const SizedBox.shrink()
                  : _FamilyTile(family: second, payload: payload, onTap: onOpenFamily),
            ),
          ],
        ),
      );
      if (index + 2 < families.length) rows.add(const SizedBox(height: AppSpace.s16));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

class const _MediumList({
  required final List<WidgetFamily> families,
  required final WidgetPayload payload,
  required final ValueChanged<WidgetFamily> onOpenFamily,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < families.length; index++) ...[
          _FamilyTile(family: families[index], payload: payload, onTap: onOpenFamily),
          if (index < families.length - 1) const SizedBox(height: AppSpace.s16),
        ],
      ],
    );
  }
}

class const _FamilyTile({
  required final WidgetFamily family,
  required final WidgetPayload payload,
  required final ValueChanged<WidgetFamily> onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetFamilyPreview(family: family, payload: payload, onTap: () => onTap(family)),
        const SizedBox(height: AppSpace.s8),
        Text(
          l10n.familyLabels.selectOrFallback(family.name),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.text.caption.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
