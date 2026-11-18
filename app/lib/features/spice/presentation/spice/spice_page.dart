import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/presentation/spice/cubit/spice_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Spice, an adult mode that exists only while both people switched it on.
@RoutePage()
class const SpicePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<SpiceCubit>()..load(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice;
    final status = context.select((SpiceCubit cubit) => cubit.state.status);
    final cubit = context.read<SpiceCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<SpiceCubit, SpiceState>(
        listenWhen: (previous, current) => previous.changeAction != current.changeAction,
        listener: (context, state) {
          if (state.changeAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: BaseRefreshable(
          onRefresh: cubit.load,
          child: SkeletonizerResourceWidget<SpiceStatus>(
            status,
            fakeValue: const SpiceStatus(stage: SpiceStage.off, myLevel: SpiceLevel.soft),
            successBuilder: (value) => switch (value.stage) {
              SpiceStage.on => const _Home(),
              SpiceStage.waitingPartner => const _Waiting(),
              SpiceStage.off || SpiceStage.partnerWants => _Intro(
                partnerWants: value.stage == SpiceStage.partnerWants,
              ),
            },
            failureBuilder: (exception) => AppErrorView(exception: exception, onRetry: cubit.load),
          ),
        ),
      ),
    );
  }
}

class const _Intro({required final bool partnerWants}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice;
    final hasPartner = context.select((SpiceCubit cubit) => cubit.state.hasPartner);
    final isAdult = context.select((SpiceCubit cubit) => cubit.state.isAdult);
    final showError = context.select((SpiceCubit cubit) => cubit.state.showAdultError);
    final isLoading = context.select((SpiceCubit cubit) => cubit.state.changeAction.isLoading);
    final cubit = context.read<SpiceCubit>();

    if (!hasPartner) {
      return BaseStackedContent(
        body: BaseEmptyState(title: l10n.soloTitle, text: l10n.soloText),
        footer: BaseButton(
          text: l10n.soloAction,
          variant: .secondary,
          onPressed: () => context.router.maybePop(),
        ),
      );
    }

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.introTitle,
              highlight: l10n.introHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            partnerWants ? l10n.partnerWantsText : l10n.introText,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              for (final promise in l10n.promises)
                BaseListTile(icon: AppIcons.check, title: promise, titleMaxLines: 3),
            ],
          ),
          const SizedBox(height: AppSpace.s20),
          BaseCheckbox(
            value: isAdult,
            label: l10n.adultLabel,
            onChanged: (value) => cubit.onAdultChanged(isAdult: value),
          ),
          if (showError) ...[
            const SizedBox(height: AppSpace.s8),
            Text(
              l10n.adultError,
              style: context.text.caption.copyWith(color: context.colors.accentLabel),
            ),
          ],
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseButton(text: l10n.turnOn, isLoading: isLoading, onPressed: cubit.turnOn),
          const SizedBox(height: AppSpace.s10),
          BaseButton(
            text: l10n.notNow,
            variant: .secondary,
            onPressed: () => context.router.maybePop(),
          ),
        ],
      ),
    );
  }
}

class const _Waiting() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice;
    final isLoading = context.select((SpiceCubit cubit) => cubit.state.changeAction.isLoading);

    return BaseStackedContent(
      body: BaseEmptyState(title: l10n.waitingTitle, text: l10n.waitingText),
      footer: BaseButton(
        text: l10n.turnOff,
        variant: .secondary,
        isLoading: isLoading,
        onPressed: context.read<SpiceCubit>().turnOff,
      ),
    );
  }
}

class const _Home() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.home;
    final cubit = context.read<SpiceCubit>();

    Future<void> open(PageRouteInfo route) async {
      await context.pushRoute(route);
      if (context.mounted) await cubit.load();
    }

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              BaseListTile(
                icon: AppIcons.moon,
                title: l10n.cards,
                subtitle: l10n.cardsText,
                showsChevron: true,
                onTap: () => open(const SpiceCardsRoute()),
              ),
              BaseListTile(
                icon: AppIcons.heart,
                title: l10n.desires,
                subtitle: l10n.desiresText,
                showsChevron: true,
                onTap: () => open(const SpiceDesiresRoute()),
              ),
              BaseListTile(
                icon: AppIcons.sparkle,
                title: l10n.challenge,
                subtitle: l10n.challengeText,
                showsChevron: true,
                onTap: () => open(const SpiceChallengeRoute()),
              ),
              BaseListTile(
                icon: AppIcons.settings,
                title: l10n.settings,
                subtitle: l10n.settingsText,
                showsChevron: true,
                onTap: () => open(const SpiceSettingsRoute()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
