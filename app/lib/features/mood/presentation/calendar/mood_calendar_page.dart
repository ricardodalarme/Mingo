import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/presentation/calendar/cubit/mood_calendar_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A month of the person's own moods, one mark per day, private by default.
@RoutePage()
class const MoodCalendarPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<MoodCalendarCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;
    final entries = context.select((MoodCalendarCubit cubit) => cubit.state.entries);
    final month = context.select((MoodCalendarCubit cubit) => cubit.state.month);
    final cubit = context.read<MoodCalendarCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.calendarTitle),
      body: SkeletonizerResourceWidget<List<MoodEntry>>(
        entries,
        fakeValue: const [],
        successBuilder: (items) => BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BaseSectionHeader(
                title: l10n.calendarMonth(
                  month: l10n.monthNames[_monthOf(month).month - 1],
                  year: _monthOf(month).year,
                ),
              ),
              const SizedBox(height: AppSpace.s12),
              BaseSurfaceCard(
                padding: const EdgeInsets.all(AppSpace.s12),
                child: BaseCompactCalendar(
                  month: _monthOf(month),
                  marked: {
                    for (final entry in items)
                      if (entry.mood != null)
                        DateTime(entry.day.year, entry.day.month, entry.day.day),
                  },
                  today: clock.now(),
                ),
              ),
              if (items.isEmpty) ...[
                const SizedBox(height: AppSpace.s16),
                BaseNote(text: l10n.calendarEmpty, icon: AppIcons.info),
              ],
              const SizedBox(height: AppSpace.s16),
              BaseNote(text: l10n.calendarPrivacyNote),
            ],
          ),
          footer: BaseButton(
            text: l10n.calendarAction,
            onPressed: () async {
              await context.pushRoute(MoodRoute());
              if (context.mounted) await cubit.load();
            },
          ),
        ),
        failureBuilder: (_) => BaseEmptyState(
          title: l10n.calendarErrorTitle,
          text: l10n.calendarErrorText,
          actionText: context.l10n.common.retry,
          onAction: cubit.load,
        ),
      ),
    );
  }

  DateTime _monthOf(DateTime? month) {
    final now = month ?? clock.now();

    return DateTime(now.year, now.month);
  }
}
