import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/presentation/preferences/cubit/notification_preferences_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The reminder choices drawn the way the board draws them: the daily cap, the types and the rule.
///
/// The card's day and hour moved to the card settings, where they belong, and quiet hours are not
/// a server choice, so the screen keeps only what the backend enforces.
class const NotificationPreferencesContent({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPreferences;
    final isSystemOff = context.select(
      (NotificationPreferencesCubit cubit) => cubit.state.isSystemOff,
    );

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isSystemOff) ...[const _SystemOffBanner(), const SizedBox(height: AppSpace.s16)],
          const _DailyMax(),
          const SizedBox(height: AppSpace.s20),
          BaseSectionHeader(title: l10n.typesTitle),
          const SizedBox(height: AppSpace.s8),
          const _Types(),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.note, icon: AppIcons.info),
        ],
      ),
    );
  }
}

class const _SystemOffBanner() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPreferences;

    return BaseBanner(
      text: l10n.systemOff,
      icon: AppIcons.bell_off,
      actionLabel: l10n.openSystem,
      onAction: context.read<NotificationPreferencesCubit>().openSystemSettings,
    );
  }
}

class const _DailyMax() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPreferences;
    final dailyMax = context.select(
      (NotificationPreferencesCubit cubit) => cubit.state.current?.dailyMax ?? maxDailyMax,
    );

    return BaseListGroup(
      children: [
        BaseListTile(
          title: l10n.perDayTitle,
          subtitle: l10n.perDaySupport,
          value: l10n.perDayValue(count: dailyMax),
          showsChevron: true,
          onTap: () => _pick(context, dailyMax),
        ),
      ],
    );
  }

  Future<void> _pick(BuildContext context, int current) async {
    final l10n = context.l10n.notificationPreferences;
    final value = await BaseSheet.show<int>(
      context: context,
      title: l10n.perDaySheetTitle,
      child: Builder(
        builder: (sheetContext) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var count = minDailyMax; count <= maxDailyMax; count++) ...[
              BaseOptionTile(
                title: l10n.perDayValue(count: count),
                isSelected: count == current,
                onTap: () => Navigator.of(sheetContext).pop(count),
              ),
              if (count < maxDailyMax) const SizedBox(height: AppSpace.s10),
            ],
          ],
        ),
      ),
    );
    if (value == null || !context.mounted) return;
    await context.read<NotificationPreferencesCubit>().setDailyMax(value);
  }
}

class const _Types() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.notificationPreferences;
    final preferences = context.select((NotificationPreferencesCubit cubit) => cubit.state.current);
    if (preferences == null) return const SizedBox.shrink();
    final labels = {
      'daily_idea': l10n.types.dailyIdea,
      'date_coming': l10n.types.dateComing,
      'card_ready': l10n.types.cardReady,
    };

    return BaseListGroup(
      children: [
        for (final type in notificationTypes)
          BaseListTile(
            title: labels[type] ?? l10n.types.other,
            isEnabled: preferences.isEnabled,
            control: BaseSwitch(
              value: preferences.allows(type),
              semanticLabel: labels[type] ?? l10n.types.other,
              onChanged: (value) =>
                  context.read<NotificationPreferencesCubit>().setTypeEnabled(type, value: value),
            ),
          ),
      ],
    );
  }
}
