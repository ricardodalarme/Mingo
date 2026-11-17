import 'package:app/features/cards/presentation/settings/cubit/card_settings_cubit.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// When the weekly card is made and whether new slips go on it by default.
@RoutePage()
class const CardSettingsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<CardSettingsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.cardSettings;
    final preferences = context.select((CardSettingsCubit cubit) => cubit.state.preferences);
    final cubit = context.read<CardSettingsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<CardSettingsCubit, CardSettingsState>(
        listenWhen: (previous, current) => !previous.saveFailed && current.saveFailed,
        listener: (context, state) => BaseToast.show(context, l10n.saveError),
        child: SkeletonizerResourceWidget<NotificationPreferences>(
          preferences,
          fakeValue: const NotificationPreferences(),
          successBuilder: (value) => _Content(preferences: value),
          failureBuilder: (failure) => BaseEmptyState(
            face: FaceKind.sad,
            title: l10n.errorTitle,
            text: l10n.errors.selectOrFallback(failure.l10nKey),
            actionText: context.l10n.common.retry,
            onAction: cubit.load,
          ),
        ),
      ),
    );
  }
}

class const _Content({required final NotificationPreferences preferences}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.cardSettings;
    final notifications = context.l10n.notificationPreferences;
    final slipsDefault = context.select(
      (CardSettingsCubit cubit) => cubit.state.slipsDefaultForCard,
    );
    final cubit = context.read<CardSettingsCubit>();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSelect<int>(
            label: l10n.day,
            options: [
              for (var day = 0; day < notifications.days.length; day++)
                BaseSelectOption(value: day, label: notifications.days[day]),
            ],
            value: preferences.cardDay,
            onChanged: cubit.setDay,
          ),
          const SizedBox(height: AppSpace.s12),
          BaseSelect<int>(
            label: l10n.hour,
            options: [
              for (var hour = 0; hour < 24; hour++)
                BaseSelectOption(
                  value: hour,
                  label: notifications.hourFormat(hour: hour.toString().padLeft(2, '0')),
                ),
            ],
            value: preferences.cardHour,
            onChanged: cubit.setHour,
          ),
          const SizedBox(height: AppSpace.s16),
          BaseListGroup(
            children: [
              BaseListTile(
                title: l10n.defaultTitle,
                subtitle: l10n.defaultSubtitle,
                control: BaseSwitch(
                  value: slipsDefault,
                  semanticLabel: l10n.defaultTitle,
                  onChanged: (value) => cubit.setSlipsDefaultForCard(value: value),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.note),
        ],
      ),
    );
  }
}
