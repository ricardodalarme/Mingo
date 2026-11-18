import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/cubit/home_widgets_gallery_cubit.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_preview.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/how_to_add_sheet.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows every home widget the app ships and teaches how to add one; there is nothing to configure.
@RoutePage()
class const HomeWidgetsGalleryPage({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<HomeWidgetsGalleryCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final payload = context.select((HomeWidgetsGalleryCubit cubit) => cubit.state.payload);
    final cubit = context.read<HomeWidgetsGalleryCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.galleryTitle),
      body: BaseStackedContent(
        body: SkeletonizerResourceWidget<HomeWidgetPayload>(
          payload,
          fakeValue: HomeWidgetPayload.fake(),
          failureBuilder: (_) => BaseErrorState(
            title: l10n.loadErrorTitle,
            text: l10n.loadErrorBody,
            actionText: l10n.retryAction,
            onAction: cubit.load,
          ),
          successBuilder: (payload) => _GalleryBody(payload: payload),
        ),
      ),
    );
  }
}

class const _GalleryBody({required final HomeWidgetPayload payload}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.gallerySubtitle,
          style: context.text.body.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpace.s16),
        if (!payload.isPaired) ...[
          BaseNote(text: l10n.soloBanner, icon: AppIcons.heart),
          const SizedBox(height: AppSpace.s16),
        ],
        for (final group in HomeWidgetGalleryGroup.values) _Group(group: group, payload: payload),
        BaseNote(text: payload.isPaired ? l10n.coupleNote : l10n.ownNote),
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

class const _Group({
  required final HomeWidgetGalleryGroup group,
  required final HomeWidgetPayload payload,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final variants = [
      for (final variant in group.variants)
        if (payload.isPaired || !variant.kind.needsPartner) variant,
    ];
    if (variants.isEmpty) return const SizedBox.shrink();

    final title = switch (group) {
      .favorites => l10n.favoritesGroup,
      .small => l10n.smallGroup,
      .medium => l10n.mediumGroup,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.s24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSectionHeader(title: title, isLabel: true),
          const SizedBox(height: AppSpace.s8),
          if (group == HomeWidgetGalleryGroup.medium)
            for (final variant in variants) ...[
              _Tile(variant: variant, payload: payload),
              const SizedBox(height: AppSpace.s16),
            ]
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final width = (constraints.maxWidth - AppSpace.s12) / 2;

                return Wrap(
                  spacing: AppSpace.s12,
                  runSpacing: AppSpace.s16,
                  children: [
                    for (final variant in variants)
                      SizedBox(
                        width: width,
                        child: _Tile(variant: variant, payload: payload),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class const _Tile({
  required final HomeWidgetVariant variant,
  required final HomeWidgetPayload payload,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeWidgetPreview(variant: variant, payload: payload),
        const SizedBox(height: AppSpace.s8),
        Text(
          l10n.variantLabels.selectOrFallback(variant.labelKey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.caption.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
