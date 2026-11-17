import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/presentation/settings/cubit/spice_settings_cubit.dart';
import 'package:app/features/spice/presentation/spice/cubit/spice_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The person's own limits for Tempero, and the way to turn it off for both.
@RoutePage()
class const SpiceSettingsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppInjector.instance.get<SpiceSettingsCubit>()..load()),
        BlocProvider(create: (_) => AppInjector.instance.get<SpiceCubit>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.settingsPage;
    final settings = context.select((SpiceSettingsCubit cubit) => cubit.state.settings);
    final cubit = context.read<SpiceSettingsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SpiceSettingsCubit, SpiceSettingsState>(
            listenWhen: (previous, current) => previous.saveAction != current.saveAction,
            listener: (context, state) {
              if (state.saveAction case Failure(:final exception)) {
                BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
              }
            },
          ),
          BlocListener<SpiceCubit, SpiceState>(
            listenWhen: (previous, current) => previous.changeAction != current.changeAction,
            listener: (context, state) {
              switch (state.changeAction) {
                case Success():
                  context.router.maybePop();
                case Failure(:final exception):
                  BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
                case Initial() || Loading():
                  break;
              }
            },
          ),
        ],
        child: SkeletonizerResourceWidget<SpiceSettings>(
          settings,
          fakeValue: const SpiceSettings(maxLevel: SpiceLevel.soft, notifications: false),
          successBuilder: (value) => _Content(settings: value),
          failureBuilder: (exception) => AppErrorView(exception: exception, onRetry: cubit.load),
        ),
      ),
    );
  }
}

class const _Content({required final SpiceSettings settings}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.settingsPage;
    final cubit = context.read<SpiceSettingsCubit>();
    final isLoading = context.select((SpiceCubit cubit) => cubit.state.changeAction.isLoading);

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSectionHeader(title: l10n.levelTitle),
          const SizedBox(height: AppSpace.s8),
          BaseSegmented(
            segments: [
              for (final level in SpiceLevel.values) l10n.levels.selectOrFallback(level.name),
            ],
            selectedIndex: settings.maxLevel.index,
            onSelectionChanged: (index) => cubit.onLevelChosen(SpiceLevel.values[index]),
          ),
          const SizedBox(height: AppSpace.s8),
          Text(
            l10n.levelNote,
            style: context.text.caption.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseListGroup(
            children: [
              BaseListTile(
                title: l10n.notifications,
                subtitle: l10n.notificationsText,
                subtitleMaxLines: 3,
                trailing: BaseSwitch(
                  value: settings.notifications,
                  semanticLabel: l10n.notifications,
                  onChanged: (isOn) => cubit.onNotificationsChanged(isOn: isOn),
                ),
              ),
            ],
          ),
        ],
      ),
      footer: BaseButton(
        text: l10n.turnOff,
        variant: .destructive,
        isLoading: isLoading,
        onPressed: () => _confirmTurnOff(context),
      ),
    );
  }

  Future<void> _confirmTurnOff(BuildContext context) async {
    final l10n = context.l10n.spice.settingsPage;
    final spice = context.read<SpiceCubit>();
    final confirmed = await BaseConfirmSheet.show(
      context: context,
      title: l10n.turnOffTitle,
      text: l10n.turnOffText,
      confirmText: l10n.turnOffConfirm,
      isDestructive: true,
    );
    if (confirmed) await spice.turnOff();
  }
}
