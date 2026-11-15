import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/gallery/cubit/widgets_gallery_cubit.dart';
import 'package:app/features/widgets/presentation/gallery/widgets/gallery_preview_cards.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Widgets gallery (`X-145`): live previews for personal and couple widgets.
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
    final segment = context.select((WidgetsGalleryCubit cubit) => cubit.state.segment);
    final cubit = context.read<WidgetsGalleryCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.galleryTitle),
      body: BaseStackedContent(
        body: SkeletonizerResourceWidget<WidgetOverview>(
          overviewResource,
          fakeValue: WidgetOverview.fake(),
          failureBuilder: (_) => BaseEmptyState(
            title: l10n.loadErrorTitle,
            text: l10n.loadErrorBody,
            actionText: l10n.retryAction,
            onAction: cubit.load,
          ),
          successBuilder: (overview) {
            final payload = overview.payload;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseSegmented(
                  segments: [l10n.segmentOwn, l10n.segmentCouple],
                  selectedIndex: segment.index,
                  onSelectionChanged: (index) =>
                      cubit.selectSegment(WidgetGallerySegment.values[index]),
                ),
                const SizedBox(height: AppSpace.s16),
                if (payload.isOffline) ...[
                  BaseNote(text: l10n.offlineBanner, icon: AppIcons.wifi_off),
                  const SizedBox(height: AppSpace.s12),
                ],
                if (segment == WidgetGallerySegment.couple && !payload.isPaired) ...[
                  BaseNote(text: l10n.unpairedBanner, icon: AppIcons.heart),
                  const SizedBox(height: AppSpace.s12),
                ],
                GalleryPreviewSection(
                  segment: segment,
                  payload: payload,
                  onSelectFamily: (family) => _onSelectFamily(context, cubit, family),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _onSelectFamily(
    BuildContext context,
    WidgetsGalleryCubit cubit,
    WidgetFamilyKind family,
  ) async {
    final route = switch (family) {
      WidgetFamilyKind.ownSmall => const OwnSmallWidgetsRoute() as PageRouteInfo<void>,
      WidgetFamilyKind.ownMedium => const OwnMediumWidgetsRoute(),
      WidgetFamilyKind.lockScreen => const LockRouteWidgetRoute(),
      WidgetFamilyKind.coupleCounter => const CoupleCounterWidgetRoute(),
      WidgetFamilyKind.couplePhotos => const CouplePhotosWidgetRoute(),
      WidgetFamilyKind.cardEncounter => const CardEncounterWidgetRoute(),
      WidgetFamilyKind.partnerNote => null,
    };
    if (route == null) return;
    await context.pushRoute(route);
    if (context.mounted) await cubit.load();
  }
}
